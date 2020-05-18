package com.nos.mm.controller;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.HomeService;
import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MemberVO;

@Controller
@RequestMapping("/home")
public class HomeController {
	
	private final static Logger logger = Logger.getLogger(HomeController.class);
	
	@Autowired
	private HomeService homeService;
	
	@Autowired
	public static Authentication authentication = null;

	@RequestMapping("/chart")
	public ModelAndView drawChart(Authentication authentication) {
		HomeController.authentication = authentication;
		
		ModelAndView mav = new ModelAndView("home/chart");
		NosMap member = new NosMap();
		
		member.put("sesMemNo", getSesMemNo(authentication));//수정자번호
		
		
		int memCount = homeService.memCount();
		int clientCount = homeService.clientCount();
		int maintenanceCount = homeService.maintenanceCount();
		int receiveCount = homeService.receiveCount(member);

		List<Map<String, Object>> list = homeService.chartList();

		mav.addObject("receiveCount", receiveCount);
		mav.addObject("memCount", memCount);
		mav.addObject("clientCount", clientCount);
		mav.addObject("maintenanceCount", maintenanceCount);
		mav.addObject("chartList", list);
		

		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/chart", method = RequestMethod.POST)
	public Object getChart(@RequestParam Map<String, String> map) {
		Object getChart = homeService.getChart(map);
		return getChart;
	}

	@ResponseBody
	@RequestMapping(value = "/weather", method = RequestMethod.POST)
	public Map<String, Object> getWeather(Map<String, Object> value) {

		return homeService.getWeather(value);
	}

	@ResponseBody
	@RequestMapping(value = "/weatherUp", method = RequestMethod.POST)
	public String setWeather(@RequestParam Map<String, Object> value) {
		homeService.setWeather(value);
		logger.debug(value);
		return "successes";
	}
	
	private String getSesMemNo(Authentication authentication) {
		MemberVO memberVO = (MemberVO) authentication.getPrincipal();
		return Integer.toString(memberVO.getMem_no());
	}

}
