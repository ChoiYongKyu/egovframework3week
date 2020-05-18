package com.nos.mm.util;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import com.nos.mm.mapper.BugreportMapper;
import com.nos.mm.mapper.MaintenanceMapper;
import com.nos.mm.mapper.TroubleMapper;
import com.nos.mm.mapper.VacationMapper;

@Component
public class EmailSender {
	
	final static Logger logger = Logger.getLogger(EmailSender.class);
	
	@Autowired
    protected JavaMailSender mailSender;
	
	@Autowired
	protected MaintenanceMapper maintenanceMapper;
	
	@Autowired
	protected BugreportMapper bugreportMapper;
	
	@Autowired
	protected TroubleMapper troubleMapper;
	
	@Autowired
	protected VacationMapper vacationMapper;
	
	
	
    public void sendEmail(String email, String password) throws Exception {
        
    	/* 
    	  mailSender가 null이라서 에러가 났음.
    	   서비스에서 EmailSender를 autowired로 묶고 
    	  EmailSender에 @component 붙여주니 해결
    	  
    	   나중에 autowired와 component에 대해 알아봐야함!!
    	*/
    	MimeMessage msg = mailSender.createMimeMessage(); 

    	MimeMessageHelper msgHelper = new MimeMessageHelper(msg);
    	
    	try {
	        
	        msgHelper.setFrom("91softmanagement@gmail.com"); // 보내는 사람
            msgHelper.setSubject("비밀번호 찾기"); // 제목
            msgHelper.setText("새로운 패스워드는 " + password + " 입니다."); // 내용
            msgHelper.setTo(email); // 받는 사람
            
            mailSender.send(msg); // 보내기
           
        } catch(MessagingException e) {
        	
            logger.warn(e);
            
        }
    }
    
    public void sendMN(List<Map<String, Object>> list) {
    	
    	/* 
    	  mailSender가 null이라서 에러가 났음.
    	   서비스에서 EmailSender를 autowired로 묶고 
    	  EmailSender에 @component 붙여주니 해결
    	  
    	   나중에 autowired와 component에 대해 알아봐야함!!
    	 */
    	MimeMessage msg = mailSender.createMimeMessage(); 
    	
    	MimeMessageHelper msgHelper = new MimeMessageHelper(msg);
    	
    	try {
    		for(int i = 0; i < list.size(); i++) {
    			msgHelper.setFrom("91softmanagement@gmail.com"); // 보내는 사람
    			msgHelper.setSubject("오늘은 " + list.get(i).get("CLIENT_NAME") + "를 방문하는 날입니다."); // 제목
    			msgHelper.setText(list.get(i).get("NAME") + "님 " + list.get(i).get("TIME") + "에 " + list.get(i).get("CLIENT_NAME") + " 유지보수 예정입니다."); // 내용
    			msgHelper.setTo(list.get(i).get("EMAIL").toString()); // 받는 사람
    			
    			mailSender.send(msg); // 보내기
    			
    			//특정유저에게 보내려면 기기를 Firebase에 등록해 Token값을 받고 Token값을 서버에서 관리해서 아이디와 매칭시켜 알림을 보낸다. 
    			//FCMsender.SendFcm("오늘은 " + list.get(i).get("CLIENT_NAME") + "를 방문하는 날입니다.", list.get(i).get("NAME") + "님 " + list.get(i).get("TIME") + "에 " + list.get(i).get("CLIENT_NAME") + " 유지보수 예정입니다.", "Maintenance");
    			logger.debug(msgHelper.toString());
    		}
    		
    	} catch(MessagingException e) {
    		
    		logger.warn(e);
    		
    	}
    }
    
	public void registerMail(Map<String, Object> list) {
    	
    	/* 
    	  mailSender가 null이라서 에러가 났음.
    	   서비스에서 EmailSender를 autowired로 묶고 
    	  EmailSender에 @component 붙여주니 해결
    	  
    	   나중에 autowired와 component에 대해 알아봐야함!!
    	 */
    	logger.debug("여기");
    	logger.debug(list.toString());
    	MimeMessage msg = mailSender.createMimeMessage(); 
    	
    	MimeMessageHelper msgHelper = new MimeMessageHelper(msg);

    	Map<String, Object> mail = new HashMap<String, Object>();
    	String mailSubject = null;
    	String mailText = null;
    	String FCMSender_title = null;
    	String FCMSender_message = null;
    	String FCMSender_link = null;
    	
//    	if(list.containsKey("board_category"))
    	if(list.get("board_category") == "bugreport") {
    		mail = bugreportMapper.getDetail((int)list.get("bugreport_no"));
    		mailSubject = "버그리포트에 새로운 [" + mail.get("BUGREPORT_PROBLEM") + "] 글이 작성되었습니다. -작성자:" + mail.get("MEM_NAME");
    		mailText = mail.get("MEM_NAME") + " 님의  버그리포트 글이 작성되었습니다. \n\n" + list.get("BUGREPORT_ANSWER")
    				+ "\n\n\n\n 링크 http://nat.nineonesoft.com:7070/nos.mm/bugreport/detail?no=" + mail.get("BUGREPORT_NO")
    				+ "\n\n 안드로이드앱으로 보기 http://nat.nineonesoft.com:7070/nos.mm/app?url=bugreport/detail?no=" + mail.get("BUGREPORT_NO")
    				+ "\n\n 안드로이드앱 다운받기 https://nosmm.page.link/home";
    		
    		
    		//메시지와 제목, 링크를 JSON으로 보낸다. UTF-8로 설정필수!
    		FCMSender_message = mail.get("BUGREPORT_PROBLEM")+"";
    		FCMSender_title = "새로운 버그리포트 글이 작성되었습니다.";
    		FCMSender_link = "/bugreport/detail?no=" + mail.get("BUGREPORT_NO");
    		byte[] strs = null;
    		try {
				strs = FCMSender_title.getBytes("UTF-8");
				logger.debug("################ FCM sender로 보내기 전 strs ##################" + strs);
				FCMsender.SendFcm(new String(strs, "UTF-8"), FCMSender_message, "BugReport", FCMSender_link);
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    		
    		
    		
    	} else if(list.get("board_category") == "trouble") {
    		mail = troubleMapper.getDetail((int)list.get("trouble_no"));
    		mailSubject = "지식관리에 새로운 [" + mail.get("TROUBLE_PROBLEM") + "] 글이 작성되었습니다. -작성자:" + mail.get("MEM_NAME");
    		mailText = mail.get("MEM_NAME") + " 님의 지식관리 글이 작성되었습니다. \n\n" + list.get("TROUBLE_ANSWER")
    				+ "\n\n\n\n 링크 http://nat.nineonesoft.com:7070/nos.mm/trouble/detail?no=" + mail.get("TROUBLE_NO")
    				+ "\n\n 안드로이드앱으로 보기 http://nat.nineonesoft.com:7070/nos.mm/app?url=trouble/detail?no=" + mail.get("TROUBLE_NO")
    				+ "\n\n 안드로이드앱 다운받기 https://nosmm.page.link/home";
    	
    		
    		FCMSender_message = mail.get("TROUBLE_PROBLEM")+"";
    		FCMSender_title = "새로운 지식관리 글이 작성되었습니다.";
    		FCMSender_link = "/trouble/detail?no=" + mail.get("TROUBLE_NO");
    		byte[] strs = null;
    		try {
				strs = FCMSender_title.getBytes("UTF-8");
				FCMsender.SendFcm(new String(strs, "UTF-8"), FCMSender_message, "Trouble", FCMSender_link);
    		} catch (UnsupportedEncodingException e) {
    			e.printStackTrace();
    		}
    	
    	} else {
    		
    		
    		mail = maintenanceMapper.getDetail((int)list.get("mn_no")).get(0);
    		mailSubject = "새로운 [" + mail.get("CLIENT_NAME") + "] 유지보수 글이 작성되었습니다. -담당자:" + mail.get("MEM_NAME");
    		mailText = mail.get("MEM_NAME") + " 님의 " + mail.get("CLIENT_NAME") + " 유지보수 글이 작성되었습니다.\n 지원항목은 " + mail.get("MN_SUP_ITEM") 
    				+ "입니다.\n\n\n 링크  http://nat.nineonesoft.com:7070/nos.mm/maintenance/detail?no=" + mail.get("MN_NO")
    				+ "\n\n 안드로이드앱으로 보기 http://nat.nineonesoft.com:7070/nos.mm/app?url=maintenance/detail?no=" + mail.get("MN_NO")
    				+ "\n\n 안드로이드앱 다운받기 https://nosmm.page.link/home";
    		
    		String str_MN_DONE = null;
    		String temp = mail.get("MN_DONE")+"";
    		int i = Integer.valueOf(temp);
    	
    		
    		
    		if(i==1) {
    			str_MN_DONE = "작업 예정";
    		} else if(i==2) {
    			str_MN_DONE = "작업 진행 중";
    		} else if(i==3) {
    			str_MN_DONE = "작업 완료";
    		} else {
    			
    		}
    		
    		
    		
    		FCMSender_message = mail.get("CLIENT_NAME") + " / " + mail.get("WORK_SCOPE_NAME") + " / " + str_MN_DONE + " / 담당자: " + mail.get("MEM_NAME") +"                                            " +
    				"\n\n" + mail.get("MN_SUP_ITEM");
    		FCMSender_title = "새로운 유지보수 글이 작성되었습니다.";
    		FCMSender_link = "/maintenance/detail?no=" + mail.get("MN_NO");
    		byte[] strs = null;
    		try {
				strs = FCMSender_title.getBytes("UTF-8");
				FCMsender.SendFcm(new String(strs, "UTF-8"), FCMSender_message, "Maintenance", FCMSender_link);
    		} catch (UnsupportedEncodingException e) {
    			e.printStackTrace();
    		}
    		
    	}
    	
    	logger.debug("DB에서 가져온 데이터");
    	logger.debug(mail.toString());
    	logger.debug("WEB에서 가져온 데이터");
    	logger.debug(list.toString());
    	
    	try {
			if(list.get("board_category") == null || list.get("board_category") == "") {
				msgHelper.setFrom("91softmanagement@gmail.com"); // 보내는 사람
				msgHelper.setSubject(mailSubject); // 제목 
				msgHelper.setText(mailText); // 내용
				msgHelper.setTo("techsupport@nineonesoft.com"); // 받는 사람
				mailSender.send(msg); // 보내기
			}
    	 
    	} catch(MessagingException e) {
    		
    		logger.warn(e);
    		
    	}
    	
    }
	
	public void registerVacMail(Map<String, Object> list) {
		logger.debug("여기");
    	logger.debug(list.toString());
    	
    	MimeMessage msg = mailSender.createMimeMessage(); 
    	
    	MimeMessageHelper msgHelper = new MimeMessageHelper(msg);

    	Map<String, Object> mail = new HashMap<String, Object>();
    	
    	String mailSubject = null;
    	String mailText = null;
    	
    	NosMap nosMap = new NosMap();
    	nosMap.put("vacNo", list.get("vac_no"));
    	
		try {
			mail = vacationMapper.selectOne(nosMap);
			mailSubject = "휴가 게시판에 새로운 [" + mail.get("MEN_NAME") + " / " + mail.get("VAC_TYPE") + "] 글이 작성되었습니다. -작성자:" + mail.get("MEN_NAME");
			mailText = mail.get("MEN_NAME") + " 님의  휴가 게시판 글이 작성되었습니다. " + "\n\n 휴가 시작일: " + mail.get("VAC_START_DATE") + "\n 휴가 종료일: " + mail.get("VAC_END_DATE") + "\n 휴가 일수: " + mail.get("VAC_DAYS")
			+"\n\n\n 링크 http://nat.nineonesoft.com:7070/nos.mm/vacation/detail?no=" + list.get("vac_no")
			+ "\n\n 안드로이드앱으로 보기 http://nat.nineonesoft.com:7070/nos.mm/app?url=vacation/detail?no=" + list.get("vac_no")
			+ "\n\n 안드로이드앱 다운받기 https://nosmm.page.link/home";

			// 보내는 사람
			msgHelper.setFrom("91softmanagement@gmail.com");
			msgHelper.setSubject(mailSubject); // 제목 
			msgHelper.setText(mailText); // 내용
			//msgHelper.setTo("wony@nineonesoft.com"); // 받는 사람
			//msgHelper.addTo("swcho2@nineonesoft.com"); //추가적으로 받을사람 적기
			//mailSender.send(msg); // 보내기
		} catch (Exception e) {
			// TODO Auto-generated catch block
			logger.warn(e);
		} 
		
	
	}
	
	//알림테스트시 mailSender.send(msg) 설정을 수정할것!!!
	//
}
