package com.nos.mm.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ExternalURLController {
	
	private final static Logger logger = Logger.getLogger(ExternalURLController.class);

	
	@RequestMapping(value = "/licenseAdd")
	public ModelAndView redirectAdd(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException {
		logger.info("licenseAdd");
		final String redirectUrl = "redirect:https://docs.google.com/a/nineonesoft.com/forms/d/e/1FAIpQLScd31Fz_BltmCDYg8lkszD2pEIs8Xd71bf69Gvo71T-TNpqWw/viewform";
		ModelAndView mav = new ModelAndView(redirectUrl);
		return mav;
	}
	
	
	@RequestMapping(value = "/licenseList")
	public ModelAndView redirectList(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException {
		logger.info("licenselist");
		final String redirectUrl = "redirect:https://docs.google.com/spreadsheets/d/1_I3dZVfZTjF0GcEU5b0uKZKvqXlYnHFV4zUURai7VZw/edit#gid=784807701";
		ModelAndView mav = new ModelAndView(redirectUrl);
		return mav;
	}
	
	//지우려면 안드로이드쪽 코드변경 후 앱업데이트를 권유해야한다.
	@RequestMapping(value = "/licenselist")
	public ModelAndView redirectlist(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws IOException {
		logger.info("licenselist");
		final String redirectUrl = "redirect:https://docs.google.com/spreadsheets/d/1_I3dZVfZTjF0GcEU5b0uKZKvqXlYnHFV4zUURai7VZw/edit#gid=784807701";
		ModelAndView mav = new ModelAndView(redirectUrl);
		return mav;
	}
}
