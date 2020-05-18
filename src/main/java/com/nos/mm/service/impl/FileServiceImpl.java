package com.nos.mm.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.nos.mm.mapper.FileMapper;
import com.nos.mm.service.FileService;

@Service
public class FileServiceImpl implements FileService {

	@Autowired
	private FileMapper mapper;

	String filePath = "C:\\iw-ojt\\download\\";
	String fileBackPath = "C:\\iw-ojt\\download_back\\";

	@Override
	public void downloadFileMobile(int no, HttpServletResponse response) throws Exception {
		Map<String, Object> map = mapper.getMobileFile(no);
		String storedFileName = (String) map.get("UPLOAD_AFTER");
		String originalFileName = (String) map.get("UPLOAD_BEFORE");

		byte fileByte[] = FileUtils.readFileToByteArray(new File(filePath + storedFileName));
		
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	
	
	
	
	@Override
	public void downloadFile(int no, HttpServletResponse response) throws Exception {
		Map<String, Object> map = mapper.getFile(no);
		String storedFileName = (String) map.get("UPLOAD_AFTER");
		String originalFileName = (String) map.get("UPLOAD_BEFORE");

		byte fileByte[] = FileUtils.readFileToByteArray(new File(filePath + storedFileName));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

	@Override
	public void deleteFile(int no) throws Exception {
		Map<String, Object> map = mapper.getFile(no);
		String storedFileName = (String) map.get("UPLOAD_AFTER");

		String fileName = filePath + storedFileName;
		fileMove(fileName);
		mapper.deleteFile(no);
	}
	
	@Override
	public void uploadFile(int no, List<MultipartFile> files, String table) throws Exception{
		fileInsertFunction(no, files, table);
	}
	
	@Override
	public void uploadFileFromBinaryString(int no, String file, String table) throws Exception {
		
		System.out.println("__________________" + file);
		
		// 바이너리 스트링 to 파일로 변환 테스트중...
		String modifiedFileName = String.valueOf(System.currentTimeMillis()) + "s" + String.valueOf((int) (Math.random() * 300) + 1);
		FileUtils.writeByteArrayToFile(new File("C:\\iw-ojt\\download\\" + modifiedFileName + ".png"), Base64.decodeBase64(file));
		
		Map<String, Object> imgmap = new HashMap<>();
		imgmap.put("upload_before", "memNo_" + no + ".png");
		imgmap.put("upload_after", modifiedFileName + ".png");
		imgmap.put("upload_connect", no);
		imgmap.put("upload_table", table);
		mapper.insertFile(imgmap);
	}

	// 삭제시 백업폴더로 파일 이동
	public void fileMove(String inFileName) throws Exception {
		DateFormat df = new SimpleDateFormat("yyMM");
		Date dateToday = new Date();
		String todayMY = df.format(dateToday);
		String chkDir = fileBackPath + todayMY;
		File chkDirs = new File(chkDir);

		if (!chkDirs.isDirectory()) {
			chkDirs.mkdirs();
		}

		String outFileName = chkDir + "\\" + inFileName.split("\\\\")[inFileName.split("\\\\").length - 1];
		File file = new File(inFileName);
		File newFile = new File(outFileName);
		if (file.exists())
			file.renameTo(newFile);
	}
	
	// 파일 입력 함수
	public void fileInsertFunction(int no, List<MultipartFile> files, String table) throws Exception {
		if (files.get(0).getSize() == 0)
			return;
		for (MultipartFile file : files) {
			Map<String, Object> imgmap = new HashMap<>();
			String extension = file.getOriginalFilename()
					.split("\\.")[file.getOriginalFilename().split("\\.").length - 1];
			String modifiedFileName = String.valueOf(System.currentTimeMillis()) + "s"
					+ String.valueOf((int) (Math.random() * 300) + 1);
			// 파일이름과 확장자
			modifiedFileName += "." + extension;

			byte[] fileByte = file.getBytes();
			File name = new File("C:\\iw-ojt\\download\\" + modifiedFileName);
			FileOutputStream fos = new FileOutputStream(name);
			fos.write(fileByte);
			fos.close();

			imgmap.put("upload_before", file.getOriginalFilename());
			imgmap.put("upload_after", modifiedFileName);
			imgmap.put("upload_connect", no);
			imgmap.put("upload_table", table);
			mapper.insertFile(imgmap);
		}
	}

	// 서명 이미지 불러오기
	public Map<String, Object> getSignFile(int mem_no) {
		return mapper.getSignFile(mem_no);
	}
	
}
