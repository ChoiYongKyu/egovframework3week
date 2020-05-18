package com.nos.mm.util.scheduler;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.google.firebase.internal.Log;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.nos.mm.service.SchedulerService;

@Component
public class Scheduler {
	
	final static Logger logger = Logger.getLogger(Scheduler.class);

	@Autowired
	private SchedulerService schedulerService;

	// 매일 오전 7시에 그날의 할일을 메일로 보내줌.
	@Scheduled(cron = "0 0 7 * * *")
//	@Scheduled(cron = "0 50 * * * *") TEST
	public void sendTodayScheduleNoticeEmail() throws Exception {
//		 System.out.println("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- 실행중..");
		// String.valueOf(System.currentTimeMillis()));
		schedulerService.selectSendEmail();

	}

	// 매월 백업폴더에는 3개월 전까지의 이미지 파일만 저장.
	@Scheduled(cron = "44 44 4 4 * *")
	public void DeleteBackupFile() throws Exception {
		DateFormat df = new SimpleDateFormat("yyMM");
		Calendar calen = Calendar.getInstance();
		calen.setTime(new Date());
		calen.add(Calendar.MONTH, -3);
		int todayMY = Integer.valueOf(df.format(calen.getTime()));

		File dirFile = new File("C:\\iw-ojt\\download_back\\");
		File[] fileList = dirFile.listFiles();
		for (File tempFile : fileList) {
			if (tempFile.isDirectory()) {
				int fileNameInt = Integer.valueOf(tempFile.getName());

				if (fileNameInt < todayMY) {
					logger.debug("fileNameInt = " + fileNameInt);
					deleteDirectory(tempFile);
				}
			}
		}
	}

	// 재귀함수로 파일 본인과 그밑의 모든 디렉토리의 파일 제거.
	public void deleteDirectory(File path) {

		// path가 존재하지 않으면 return;
		if (!path.exists()) {
			return;
		}

		// 파일이 디렉토리면 재귀함수로 다시 호출, 파일이 디렉토리가 아니면 삭제.
		File[] files = path.listFiles();
		for (File file : files) {
			if (file.isDirectory()) {
				deleteDirectory(file);
			} else {
				file.delete();
			}
		}
		path.delete();
	}
	//최용규
	//10분마다 로그
	/*
	 * @Scheduled( cron="0/10 * * * * *") public void testLog() { //Log.info("10분");
	 * System.out.
	 * println("#####################-----------log 10min----------###################"
	 * );
	 * 
	 * }
	 */
	
	@Scheduled( cron="0 0/10 * * * *")
	public void weather() {
		URL url;
		try {
			url = new URL("http://api.openweathermap.org/data/2.5/weather?q=seoul&appid=796f399c049c2a4d99cb84916cc1b586");
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET"); 
			con.setRequestProperty("User-Agent", "Mozilla/5.0");
			int responseCode = con.getResponseCode(); 
			BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String inputLine; 
			StringBuffer response = new StringBuffer(); 
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine); 
			} 
			in.close();
			JsonParser parser = new JsonParser();
			JsonObject jsonObj = (JsonObject) parser.parse(response.toString());

			logger.debug(jsonObj.get("main").getAsJsonObject().get("temp").getAsDouble() - 273.15);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		

	}
	

}
