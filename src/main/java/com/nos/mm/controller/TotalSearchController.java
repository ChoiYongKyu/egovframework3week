package com.nos.mm.controller;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.TotalSearchService;

@Controller
@RequestMapping("/totalSearch")
public class TotalSearchController {

	private final static Logger logger = Logger.getLogger(TotalSearchController.class);

	@Autowired
	private TotalSearchService service;

//	@RequestMapping("/totalList")
//	public ModelAndView totalSearchView() {
//		ModelAndView mav = new ModelAndView("totalSearch/totalList");
//
//		return mav;
//	}
	
	@RequestMapping(value = "/totalList", method = RequestMethod.POST) // 통합 검색
																		// 데이터 넘기기
	public ModelAndView totalSearch(@RequestParam Map<String, Object> map) throws Exception {
		logger.debug(map.toString());
		
		ModelAndView mav = new ModelAndView("totalSearch/totalList");
		
		mav.addObject("list", service.totalSearch(map));
		
		return mav;
	}
}
