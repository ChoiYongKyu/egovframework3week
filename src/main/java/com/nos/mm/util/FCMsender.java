package com.nos.mm.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.nos.mm.mapper.MemberManageMapper;
import com.nos.mm.mapper.MemberMapper;


@Component
public class FCMsender {


	
	
	public final static String AUTH_KEY_FCM = "AAAAiYE8zw4:APA91bExBlxbsCpUPBtalZTl5LsF04cK7xfW76EQhgWf2KeondlQ56MaUmaWdYgWxG0eDUyGd3XhP7bNW3vwJofEOMZNfRCXcgeiLtchqVPvtTEpxvNT0gog8reKyTrHlynCYHBu9foO";
	public final static String API_URL_FCM = "https://fcm.googleapis.com/fcm/send";
	static String authKey = AUTH_KEY_FCM;
	static String FCMurl = API_URL_FCM;
	
	final static Logger logger = Logger.getLogger(FCMsender.class);

	public static void SendFcm(String title, String message, String topic, String link) {
		try
		{
			String str_title = new String(title);
			String str_message = new String(message);
			String str_topic = topic;
			String str_link = link;
			
			URL url = new URL(FCMurl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setUseCaches(false);
			conn.setDoInput(true);
			conn.setDoOutput(true);

			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "key=" + authKey);
			conn.setRequestProperty("Content-Type", "application/json");

			JSONObject json = new JSONObject();
			JSONObject data = new JSONObject();
			JSONObject notify = new JSONObject();
			
			json.put("to", "/topics/" + str_topic );
			
			/*data.put("title", str_title); // Notification title
			data.put("body", str_message); // Notification body
*/			data.put("link", str_link);
			json.put("data", data);
			
			notify.put("title", str_title); // Notification title
			notify.put("body", str_message); // Notification body
			notify.put("sound", "default");
			json.put("notification", notify);
						
			try(OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream())){
				
				logger.debug("################ FCM에서 전송 직전 json ##################" + json);
				logger.debug("################ FCM에서 전송 직전 str_title ##################" + str_title);
				logger.debug("################ FCM에서 전송 직전 str_message ##################" + str_message);
				wr.write(json.toString()); 
				wr.flush(); 
			}catch(Exception e){
				

			}
			
			/*if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
				throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode()); 
			}*/

			BufferedReader br = new BufferedReader(new InputStreamReader(
					(conn.getInputStream()))); 
			System.out.println("TEST!!!" + json.toString());
			
			String output; 
			System.out.println("Output from Server .... \n"); 
			while ((output = br.readLine()) != null) { 
				System.out.println(output); 
				} 
			
			conn.disconnect(); 
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	

	}
	
	
	public static void SendFcm_Individual(String title, String message, String token, String link) {
		try
		{
	
			
			String str_title = new String(title);
			String str_message = new String(message);

			String str_to = token;
			String str_link = link;
			
			URL url = new URL(FCMurl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setUseCaches(false);
			conn.setDoInput(true);
			conn.setDoOutput(true);

			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "key=" + authKey);
			conn.setRequestProperty("Content-Type", "application/json");

			JSONObject json = new JSONObject();
			JSONObject data = new JSONObject();
			//JSONObject notify = new JSONObject();
			
			json.put("to", str_to );
			
			data.put("title", str_title); // Notification title
			data.put("body", str_message); // Notification body
			data.put("link", str_link);
			data.put("sound", "default");
			json.put("data", data);
			
			/*notify.put("title", str_title); // Notification title
			notify.put("body", str_message); // Notification body
			notify.put("sound", "default");
			json.put("notification", notify);*/
						
			try(OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream())){
				
				logger.debug("################ FCM에서 전송 직전 json ##################" + json);
				logger.debug("################ FCM에서 전송 직전 str_title ##################" + str_title);
				logger.debug("################ FCM에서 전송 직전 str_message ##################" + str_message);
				wr.write(json.toString()); 
				wr.flush(); 
			}catch(Exception e){
				

			}
			
			/*if (conn.getResponseCode() != HttpURLConnection.HTTP_OK) {
				throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode()); 
			}*/

			BufferedReader br = new BufferedReader(new InputStreamReader(
					(conn.getInputStream()))); 
			System.out.println("TEST!!!" + json.toString());
			
			String output; 
			System.out.println("Output from Server .... \n"); 
			while ((output = br.readLine()) != null) { 
				System.out.println(output); 
				} 
			
			conn.disconnect(); 
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	

	}
}
