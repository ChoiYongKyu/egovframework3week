package com.nos.mm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.FileService;
import com.nos.mm.service.MemberService;
import com.nos.mm.util.NosMap;


@Controller
public class MobileController {
	
	
	private final static Logger logger = Logger.getLogger(MobileController.class);

	@Autowired
	private FileService service;
	
	@Autowired
	private MemberService memberService;
	
	

	@RequestMapping("/mobile")
	public void fileDownload(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
		
		service.downloadFileMobile(49, httpServletResponse);
		logger.info("여기!");
		
	}
	
	@RequestMapping("/android")
	public ModelAndView androidPage() throws Exception {
		
		ModelAndView mav = new ModelAndView("mobile/m_android");
		mav.addObject("noNav", 0);
		
		logger.info("안드로이드!");
		return mav;
	}
	
	@RequestMapping("/app")
	public ModelAndView androidAppOpen(@RequestParam (value="url", required=false, defaultValue="") String url) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("noNav", 0);
		String str = "redirect:nma://action?";
		
		mav.setViewName(str + url);
		
		logger.info("안드로이드! ="+ str + "url=" + url);
		return mav;
	}

	
	/* 토큰 수신  */
	@RequestMapping("/sendToken")
	public ModelAndView receiveToken(
			@RequestParam (value="mem_id", required=false, defaultValue="") String email, 
			@RequestParam (value="mem_token", required=false, defaultValue="") String token,
			@RequestParam (value="mem_appver", required=false, defaultValue="") String ver
			) throws Exception {
		
		logger.info(email);
		NosMap nosMap = new NosMap();
		nosMap.put("memId", email);
		nosMap.put("memToken", token);
		nosMap.put("memAppVer", ver);
		
		memberService.receiveToken(nosMap);
		
		logger.info(nosMap);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		return mav;
	}
}
