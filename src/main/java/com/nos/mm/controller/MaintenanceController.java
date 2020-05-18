package com.nos.mm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nos.mm.service.MaintenanceService;
import com.nos.mm.vo.ClientVO;
import com.nos.mm.vo.MaintenanceVO;

@Controller
@RequestMapping("/maintenance")
public class MaintenanceController {
	
	private final static Logger logger = Logger.getLogger(MaintenanceController.class);
	
	HttpServletRequest request ;

	@Autowired
	private MaintenanceService service;

	@RequestMapping("")
	public ModelAndView mn() {
		ModelAndView mav = new ModelAndView("redirect:/maintenance/list");
		
		return mav;
	}

	// @RequestMapping("/list") // 리스트 페이지 이동
	// public ModelAndView mnList(@RequestParam(value = "no", defaultValue =
	// "1") int page) {
	// ModelAndView mav = new ModelAndView("maintenance/list");
	// List<MaintenanceVO> list = service.getList(page);
	//
	// mav.addObject("list", list);
	//
	// return mav;
	// }

	@RequestMapping("/list") // 리스트에서 검색하기
	public ModelAndView search(@RequestParam(value = "no", defaultValue = "1") int page,
			@RequestParam(value = "searchCategory", required = false, defaultValue = "1") int searchCategory,
			@RequestParam(value = "searchText", required = false) String searchText,
			@RequestParam(value = "doneSort", required = false, defaultValue = "desc") String doneSort,
			@RequestParam(value = "sortName", required = false, defaultValue = "write_date") String sortName) {
		ModelAndView mav = new ModelAndView("maintenance/list");
		logger.debug("page= " + page + "searchCategory =" + searchCategory + "searchText = " + searchText);
		logger.debug("sortName = " + sortName);
		logger.debug("doneSort = " + doneSort);
		
		Map<String, Object> list = service.getList(page, searchCategory, searchText, sortName, doneSort);
//		list.put("searchText", searchText);
//		list.put("searchCategory", searchCategory);		
		mav.addObject("list", list);
		logger.debug("리스트 = " + list);
		return mav;
	}

	// @RequestMapping("/list") // 리스트 페이지 이동
	// public ModelAndView mnList(@RequestParam(value = "no", defaultValue =
	// "1") int page) {
	// ModelAndView mav = new ModelAndView("maintenance/list");
	// List<MaintenanceVO> list = service.getList(page);
	//
	// mav.addObject("list", list);
	//
	// return mav;
	// }
	//
	// @RequestMapping(value = "/list", method = RequestMethod.POST) // 리스트에서
	// 검색하기
	// public ModelAndView search(@RequestParam("searchCategory") int
	// searchCategory,
	// @RequestParam("searchText") String searchText) {
	// ModelAndView mav = new ModelAndView("maintenance/list");
	//
	// List<Map<String, Object>> list = service.searchList(searchCategory,
	// searchText);
	// mav.addObject("list", list);
	// return mav;
	// }

	@RequestMapping(value = "/detail", method = RequestMethod.GET) // 상세 보기
	public ModelAndView mnDetail(@RequestParam int no, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("maintenance/detail");
//		List<Map<String, Object>> detail = service.getDetail(no).get("detail");
//		for (int i = 0; i < detail.size(); i++) {
//			List<Map<String, Object>> imgAttach = service.getDetailImg(Integer.parseInt(detail.get(i).get("MN_NO").toString()));
//			detail.get(i).put("imgAttach", imgAttach);
//		}
		mav.addObject("detail", service.getDetail(no).get("detail"));
		mav.addObject("fileList", service.getDetail(no).get("fileList"));
		
		HttpSession session;
		session = request.getSession();
	
		mav.addObject("myGroup", session.getAttribute("myGroup"));
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "deleteDetail", method = RequestMethod.GET) // 삭제하기
	public Map<String, Object> doDelete(@RequestParam int no) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		service.doDelete(no);
		map.put("success", no);
		return map;
	}

	@RequestMapping("/register") // 등록 페이지 이동
	public ModelAndView mnRegister() {
		ModelAndView mav = new ModelAndView("maintenance/register");

		List<ClientVO> list = service.getClientList();
		List<Map<String, Object>> memberList = service.getMemberList();
		mav.addObject("list", list);
		mav.addObject("memberList", memberList);

		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/register", method = RequestMethod.POST) // 등록 입력한
																		// 데이터
																		// 넘기기
	public void insert(@RequestParam Map<String, Object> map, @RequestParam("Files") List<MultipartFile> files)
			throws Exception {
		logger.debug(map.toString());
		
		int no = service.insert(map);
		service.pass(map);
		service.uploadFile(no, files, map.get("table").toString());
	} 

	@ResponseBody
	@RequestMapping(value = "/selectClientReq", method = RequestMethod.POST) // 고객사
																				// 선택시
																				// 요청자
																				// 값
																				// 변경
	public List<Map<String, Object>> selectClientReq(@RequestParam int client) {
		List<Map<String, Object>> map = service.getReq(client);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/selectClientWorkScope", method = RequestMethod.POST) // 고객사
																					// 선택시
																					// 업무구분
																					// 값
																					// 변경
	public List<Map<String, Object>> selectClientWorkScope(@RequestParam("client") int client) {
		logger.debug(client);
		List<Map<String, Object>> map2 = service.getWorkScope(client);
		
		return map2;
	}

	

	@ResponseBody
	@RequestMapping(value = "/getGroup", method = RequestMethod.POST) // 등록 입력한
																		// 데이터
																		// 넘기기
	public List<Map<String, Object>> viewGroup(@RequestParam("mem_no") int mem_no) {
//		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> list = service.getGroup(mem_no);
		// map.put("mem_no", mem_no);
		// service.getGroup(mem_no);
		return list;
	}

	// @RequestMapping("")
	// public ModelAndView modalData() {
	// ModelAndView mav = new ModelAndView();
	//
	// return mav;
	// }

	@RequestMapping(value = "/modify", method = RequestMethod.GET) // 수정 페이지 이동
	public ModelAndView mnModify(@RequestParam int no) {
		ModelAndView mav = new ModelAndView("/maintenance/modify");
		List<MaintenanceVO> modify = service.modify(no);
		List<Map<String, Object>> imgAttach = service.getDetailImg(no);
		List<Map<String, Object>> memberList = service.getMemberList();
		mav.addObject("imgAttach", imgAttach);
		mav.addObject("modify", modify);
		mav.addObject("memberList", memberList);

		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/modify", method = RequestMethod.POST) // 등록 입력한
																	// 데이터 넘기기
	public String update(@RequestParam Map<String, Object> map, @RequestParam("imgFile") List<MultipartFile> file)
			throws Exception {
		logger.debug("------------수정" + map);
		map.put("mem_no", map.get("mem_no")); // 수정한거
		map.put("req_no", map.get("req_no2"));
//		map.remove("mem_no"); // 수정한거
		map.remove("req_no2");
		service.update(map, file);

		service.updatePass(map);
		
		return "success";
	}

	@ResponseBody
	@RequestMapping(value = "/deleteImg", method = RequestMethod.POST) // 등록 입력한
																		// 데이터
																		// 넘기기
	public void deleteImg(@RequestParam("upload_after") String upload_after) throws Exception {

		service.deleteImg(upload_after);
	}

	@RequestMapping(value = "/reply", method = RequestMethod.GET) // 댓글 작성하기 페이지
																	// 이동
	public ModelAndView reply(@RequestParam int no) {
		ModelAndView mav = new ModelAndView("maintenance/reply");
		List<MaintenanceVO> reply = service.modify(no);
		List<Map<String, Object>> memberList = service.getMemberList();
		mav.addObject("reply", reply);
		mav.addObject("memberList", memberList);
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/reply", method = RequestMethod.POST) // 댓글 입력한
																	// 데이터 넘기기
	public void replyInsert(@RequestParam Map<String, Object> map, @RequestParam("imgFile") List<MultipartFile> file)
			throws Exception {
		
		map.put("mem_no", map.get("mem_no2"));
		map.put("req_no", map.get("req_no2"));
		map.remove("mem_no2");
		map.remove("req_no2");
		
		service.replyInsert(map, file);
		service.replyPass(map);
//		int mn_no = service.replyInsert(vo, chkVal, pathNo);
//
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("pathNo", pathNo);
//		map.put("req_no", req_no);
//		map.put("mn_no", mn_no);
//
//		
		
		
//		service.update(map, file);
//		service.updatePass(map);
	}

	@RequestMapping("/calendar") // 캘린더 페이지 이동
	public ModelAndView calendar(@RequestParam Map<String, Object> map) throws JsonProcessingException {
		ModelAndView mav = new ModelAndView("maintenance/calendar");

		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/calendarData") // 캘린더 페이지 이동
	public String calendarData(@RequestParam Map<String, Object> map) throws JsonProcessingException {
		logger.debug("캘린더 map ======" + map);
		
		List<Map<String, Object>> list = service.selectListForCalendar(map);
		logger.debug("캘린더 list ======" + list);
		
		ObjectMapper objmap = new ObjectMapper();
		String result = objmap.writeValueAsString(list);
		logger.debug("캘린더 result ======" + result);
		
		return result;
	}
	
	@RequestMapping(value = "/clientStats") // 고객사 통계
											// 페이지
	public ModelAndView clientStatsPage() {
	ModelAndView mav = new ModelAndView();
	mav.addObject("clientList", service.getClient());
	mav.addObject("getSupportName", service.getSupportName());
	return mav;
	}
	
	@RequestMapping("/getClientStats")
	public ModelAndView getClientStats(@RequestParam int cNo,
										@RequestParam int workScope,
										@RequestParam int supportName,
									  @RequestParam(value = "no", defaultValue = "1") int page){
		logger.debug("cNo  = "+cNo);
		logger.debug("workScope  = "+workScope);
		logger.debug("supportName  = "+supportName);
		ModelAndView mav = new ModelAndView("/maintenance/clientStats");
		mav.addObject("clientStats", service.getClientStats(cNo, page, workScope, supportName));
		mav.addObject("clientList", service.getClient());
		mav.addObject("getSupportName", service.getSupportName());
		logger.debug(service.getClientStats(cNo, page, workScope, supportName));
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getWorkScope", method = RequestMethod.POST) // 고객사
																			// 선택시
																			// 업무구분
																			// 값
																			// 변경
	public List<Map<String, Object>> getWorkScope(@RequestParam("client") int client) {
		logger.debug(client);
		List<Map<String, Object>> list = service.getWorkScope(client);
		
		return list;
	}

}
