package com.nos.mm.controller;

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
import com.nos.mm.service.TroubleService;

@Controller
@RequestMapping("/trouble")
public class TroubleController {

	private final static Logger logger = Logger.getLogger(TroubleController.class);

	@Autowired
	private TroubleService service;
	

	@RequestMapping("")
	public ModelAndView mainlist(){
		ModelAndView mav = new ModelAndView("redirect:/trouble/troubleList");
		return mav;
	}
	
	@RequestMapping("/troubleList")
	public ModelAndView troublelist(@RequestParam(value = "no", defaultValue = "1") int page,
			@RequestParam(value = "searchText", required = false) String searchText){
		logger.debug("searchText  = "+searchText);
		ModelAndView mav = new ModelAndView("/trouble/list");
		mav.addObject("list", service.getList(page, searchText));
		mav.addObject("searchText", searchText);
		logger.debug(service.getList(page, searchText));
		
		return mav;
	}
	

	@RequestMapping("/register") // 등록 페이지 띄우기
	public ModelAndView replyView() {
		ModelAndView mav = new ModelAndView("/trouble/register");

		mav.addObject("clientList", service.getClient());
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectClient", method = RequestMethod.POST) // 제품 목록 가져오기
	public List<Map<String, Object>> selectClient(@RequestParam Map<String, Object> value) {
		logger.debug(value.toString());
		List<Map<String, Object>> map = service.getProduct(value);

		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectProduct", method = RequestMethod.POST) // 버전 목록 가져오기
	public List<Map<String, Object>> selectProduct(@RequestParam Map<String, Object> value) {
		logger.debug(value.toString());
		List<Map<String, Object>> map = service.getVersion(value);

		return map;
	}
	
	@RequestMapping(value = "/insertTrouble", method = RequestMethod.POST) // 문제/해결 게시판 글 등록
	public ModelAndView insertBoard(@RequestParam Map<String, Object> value) throws Exception {
		logger.debug(value.toString());
		service.insert(value);
		ModelAndView mav = new ModelAndView("redirect:/trouble/troubleList");
		
		return mav;
	}
		
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET) // 자세히 보기
	public ModelAndView detailView(@RequestParam int no) { // 게시판 번호 가져오기(일단 만들어놓음)
		ModelAndView mav = new ModelAndView("/trouble/detail");
		logger.debug(no);
		Map<String, Object> map = service.getDetail(no);
		
		List<Map<String, Object>> replyMap = service.getReply(no);
		logger.debug( map.get("fileList").toString());
		mav.addObject("detail", map.get("detail"));
		mav.addObject("fileList", map.get("fileList"));
		mav.addObject("reply", replyMap);
		
		return mav;
	}
	
	@RequestMapping(value = "/insertReply", method = RequestMethod.POST) // 댓글 등록
	public ModelAndView insertReply(@RequestParam Map<String, Object> value) throws Exception {
		logger.debug(value.toString());
		service.insertReply(value);
		ModelAndView mav = new ModelAndView("redirect:/trouble/detail?no=" + value.get("trouble_no"));
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteTrouble", method = RequestMethod.GET) // 게시판 삭제하기
	public ModelAndView deleteTrouble(@RequestParam int no) {
		logger.debug(no);
		service.doDelete(no);
		ModelAndView mav = new ModelAndView("redirect:/trouble/troubleList");
		
		return mav;
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET) // 수정 페이지 띄우기
	public ModelAndView modifyView(@RequestParam int no) {
		ModelAndView mav = new ModelAndView("/trouble/modify");
		Map<String, Object> map = service.getModify(no);
		mav.addObject("modify", map);
		mav.addObject("clientList",service.getClient());
		logger.debug(map);
		return mav;
	}
	
	@RequestMapping(value = "/insertModify", method = RequestMethod.POST) // 수정 글 등록
	public ModelAndView insertModify(@RequestParam Map<String, Object> value) throws Exception {
		logger.debug(value.toString());
		service.insertModify(value);
		ModelAndView mav = new ModelAndView("redirect:/trouble/detail?no=" + value.get("trouble_no"));
		
		return mav;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "replyModify", method = RequestMethod.POST)
	public String replyModify(@RequestParam Map<String, Object> value) {
		logger.debug(value.toString());
		service.modifyReply(value);
		return "modifySuccess";
	}
	
	@ResponseBody
	@RequestMapping(value = "replyDelete", method = RequestMethod.POST)
	public String replyDelete(@RequestParam int no) {
		service.deleteReply(no);
		return "deleteSuccess"+no;
	}
	
}
