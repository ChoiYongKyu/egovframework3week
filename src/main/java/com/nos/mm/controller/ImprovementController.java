package com.nos.mm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.FileService;
import com.nos.mm.service.ImprovementService;

@Controller
@RequestMapping("/improvement")
public class ImprovementController {

	private final static Logger logger = Logger.getLogger(ImprovementController.class);

	@Autowired
	private ImprovementService service;
	
	@Autowired
	private FileService fileservice;
	
	@RequestMapping("")
	public ModelAndView mainlist(){
		ModelAndView mav = new ModelAndView("redirect:/improvement/ImpList");
		return mav;
	}
	
	
	//모바일 떄문에 남겨둔다
	@RequestMapping("/list") // 개선요구 리스트 띄우기 
	public ModelAndView improvementlist(@RequestParam(value = "no", defaultValue = "1") int page,
			@RequestParam(value = "searchText", required = false) String searchText){
		logger.debug("searchText  = "+searchText);
		ModelAndView mav = new ModelAndView("/improvement/list");
		mav.addObject("list", service.getList(page, searchText));
		logger.debug(service.getList(page, searchText));
		
		return mav;
	}
	
	
	
	
	@RequestMapping("/ImpList") // 개선요구 리스트 띄우기 
	public ModelAndView improvementList(@RequestParam(value = "no", defaultValue = "1") int page,
			@RequestParam(value = "searchText", required = false) String searchText){
		logger.debug("searchText  = "+searchText);
		ModelAndView mav = new ModelAndView("/improvement/list");
		mav.addObject("list", service.getList(page, searchText));
		logger.debug(service.getList(page, searchText));
		
		return mav;
	}
	
	
	
	@RequestMapping("/register") // 등록 페이지 띄우기
	public ModelAndView register() {
		ModelAndView mav = new ModelAndView("/improvement/register");
		mav.addObject("register", service.getNewImpNo());
		return mav;
	}

	@RequestMapping(value = "/insertImprovement", method = RequestMethod.POST) // 글 등록
	public ModelAndView insertBoard(@RequestParam Map<String, Object> value, @RequestParam("Files") List<MultipartFile> files ) 
			throws Exception {
		logger.debug(value.toString());
		//logger.debug(value.toString());
		
		
		
		
		logger.debug(value.get("no") + " / " + value.get("table"));
		service.insert(value);
		fileservice.uploadFile(Integer.valueOf(value.get("no").toString()), files, value.get("table").toString());
		ModelAndView mav = new ModelAndView("redirect:/improvement/ImpList");
		
		return mav;
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET) // 자세히 보기
	public ModelAndView detailView(@RequestParam int no) { // 게시판 번호 가져오기(일단 만들어놓음)
		ModelAndView mav = new ModelAndView("/improvement/detail");
		logger.debug(no);
		Map<String, Object> map = service.getDetail(no);
		
//		List<Map<String, Object>> replyMap = service.getReply(no);
		logger.debug( map.get("fileList").toString());
		mav.addObject("detail", map.get("detail"));
		mav.addObject("fileList", map.get("fileList"));
//		mav.addObject("reply", replyMap);
		
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteImprovement", method = RequestMethod.GET) // 게시판 삭제하기
	public Map<String, Object> deleteImprovement(@RequestParam int no) {
		Map<String, Object> map = new HashMap<String, Object>();
		logger.debug(no);
		service.doDelete(no);
		map.put("success", no);
		return map;
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET) // 수정 페이지 띄우기
	public ModelAndView modifyView(@RequestParam int no) {
		ModelAndView mav = new ModelAndView("/improvement/modify");
		Map<String, Object> map = service.getDetail(no);
		mav.addObject("modify", map.get("detail"));
		logger.debug(map);
		return mav;
	}
	
	@RequestMapping(value = "/insertModify", method = RequestMethod.POST) // 수정 글 등록
	public ModelAndView insertModify(@RequestParam Map<String, Object> value) throws Exception {
		logger.debug(value.toString());
		service.insertModify(value);
		ModelAndView mav = new ModelAndView("redirect:/improvement/detail?no=" + value.get("improvement_no"));
		
		return mav;
	}
}
