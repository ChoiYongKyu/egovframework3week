package com.nos.mm.test;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Component
public class Test2 {
	
//	@Scheduled( cron="0/10 * * * * *")
	public static void main(String[] agrs) {
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

			System.out.println(jsonObj.get("main").getAsJsonObject().get("temp").getAsDouble() - 273.15);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
