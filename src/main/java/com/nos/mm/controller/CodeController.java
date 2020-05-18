package com.nos.mm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.CodeService;
import com.nos.mm.service.FileService;

@Controller
@RequestMapping("/code")
public class CodeController {

	private final static Logger logger = Logger.getLogger(CodeController.class);

	@Autowired
	private CodeService service;

	@RequestMapping("/codeManagement")
	public ModelAndView view() {
		ModelAndView mav = new ModelAndView("code/codeManagement");
		List<Map<String, Object>> list = service.getCodeList();
		logger.debug(list);
		mav.addObject("list", list);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectCode", method = RequestMethod.POST)
	public List<Map<String, Object>> selectCode(@RequestParam String common_code) {
		logger.debug(common_code);
//		ModelAndView mav = new ModelAndView("redirect:/code/management");
		List<Map<String, Object>> list = service.getResultList(common_code);
		logger.debug("kmmk"+list);
		
		return list;
	}
	
	@RequestMapping(value= "/addCode", method = RequestMethod.POST) // 코드 내용 추가
	public ModelAndView addCode(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView("redirect:/code/codeManagement");
		logger.debug("뭐가들었나=" +map);
		service.addCode(map);
		return mav;
	}
	
	
	@RequestMapping(value = "/codeDelete", method = RequestMethod.GET) // 코드 
																		// 삭제
	public ModelAndView deleteRow(@RequestParam int code_key, @RequestParam String code) {
	ModelAndView mav = new ModelAndView("redirect:/code/codeManagement");
		logger.debug("코드 id = " + code_key);
		logger.debug("코드 = " + code);
		service.deleteCode(code_key,code);
		return mav;
	}
	
	@RequestMapping(value= "/insertCode", method = RequestMethod.POST)  // 코드 추가
	public ModelAndView insertCode(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView("redirect:/code/codeManagement");
		logger.debug("테스트!!!!!!!!!!!!!!!!!=" +map);
		service.insertCode(map);
		return mav;
	}
}
