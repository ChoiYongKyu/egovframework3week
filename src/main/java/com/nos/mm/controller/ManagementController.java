package com.nos.mm.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.ClientService;
import com.nos.mm.service.MaintenanceService;
import com.nos.mm.service.MemberManageService;
import com.nos.mm.vo.ClientVO;

@Controller
@RequestMapping("/management")
public class ManagementController {

	private final static Logger logger = Logger.getLogger(ManagementController.class);

	@Autowired
	private ClientService service;
	// REDIRECT:LIST_PAGE.DO

	@Autowired
	private MaintenanceService maintenanceService;

	@Autowired
	private MemberManageService memeberManageService;

	// 리스트 합치기 테스트
	@RequestMapping("")
	public ModelAndView management() {
		ModelAndView mav = new ModelAndView("redirect:/management/clientList");
		return mav;
	}

	// 리스트 합치기 테스트
	@RequestMapping("/clientList")
	public ModelAndView mClientManagement(@RequestParam(value = "no", defaultValue = "1") int page,
			@RequestParam(value = "searchCategory", required = false, defaultValue = "1") int searchCategory,
			@RequestParam(value = "searchText", required = false) String searchText) {
		ModelAndView mav = new ModelAndView("management/clientList");
		Map<String, Object> list = service.getList(page, searchCategory, searchText);
		list.put("searchText", searchText);
		list.put("searchCategory", searchCategory);
		mav.addObject("list", list);

		return mav;
	}

	// 리스트 합치기 테스트
	// @RequestMapping("/clientList")
	// public ModelAndView mClientManagement(@RequestParam(value="no",
	// defaultValue="1") int page) {
	// System.out.println(page);
	// ModelAndView mav = new ModelAndView("management/clientList");
	// List<Map<String, Object>> map = service.getList(page);
	// mav.addObject("list", map);
	//
	// return mav;
	// }
	//
	// @RequestMapping(value="/clientList", method=RequestMethod.POST) // 업체
	// 리스트에서 검색하기
	// public ModelAndView search(@RequestParam("searchCategory") int
	// searchCategory, @RequestParam("searchText") String searchText) {
	// ModelAndView mav = new ModelAndView("management/clientList");
	// System.out.println(searchCategory);
	// System.out.println(searchText);
	//
	// List<Map<String, Object>> list = service.searchList(searchCategory,
	// searchText);
	// mav.addObject("list", list);
	// return mav;
	// }

	@RequestMapping(value = "/clientDetail", method = RequestMethod.GET)
	public ModelAndView mClientDetail(@RequestParam int no) {
		ModelAndView mav = new ModelAndView("management/clientDetail");
		Map<String, Object> result = service.getDetail(no);

		mav.addObject("detail", result.get("detail"));
		mav.addObject("fileList", result.get("fileList"));
		mav.addObject("workScope", result.get("workScope"));
		mav.addObject("workScopeList", service.getWorkScope());

		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "deleteDetail", method = RequestMethod.GET) // 삭제하기
	public Map<String, Object> doDelete(@RequestParam int no) {
		Map<String, Object> map = new HashMap<String, Object>();
		// System.out.println(no);
		service.doDelete(no);
		map.put("success", no);
		return map;
	}

	@RequestMapping("/clientRegister")
	public ModelAndView registerVeiw() {
		ModelAndView mav = new ModelAndView("management/clientRegister");
		mav.addObject("productlist", service.getProductList());
		mav.addObject("workScope", service.getWorkScope());
		return mav;
	}

	@RequestMapping(value = "/clientRegister", method = RequestMethod.POST) // 글
																			// 데이터
																			// 넘기기
	public ModelAndView insert(@RequestParam Map<String, Object> value,
			@RequestParam("work_scope_no") List<Integer> chk) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/management/clientList");
		// System.out.println(value.get("client_name"));
		// System.out.println(value.get("client_addr"));
		// System.out.println(value.get("req_name"));
		// System.out.println(value.get("req_phone"));
		// System.out.println(value.get("req_email"));
		// System.out.println(value.get("client_start_date"));
		// System.out.println(value.get("client_end_date"));
		// System.out.println(value.get("client_sup_times"));
		// System.out.println(value.get("work_scope_no"));
		// System.out.println(value.get("client_note"));

		service.insert(value, chk);
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/selectVersion", method = RequestMethod.POST) // 제품
																			// 선택시
																			// 버전
																			// 가져오기
	public List<Map<String, Object>> selectVersion(@RequestParam int productNo) {
		List<Map<String, Object>> map = service.getVersion(productNo);

		return map;
	}

	@RequestMapping(value = "/clientModify", method = RequestMethod.GET)
	public ModelAndView modifyView(@RequestParam int no) {
		ModelAndView mav = new ModelAndView("management/clientModify");
		Map<String, Object> modify = service.modify(no);
		logger.debug(modify);
		logger.debug("detail");
		logger.debug(modify.get("detail"));
		logger.debug("work");
		logger.debug(modify.get("work"));
		mav.addObject("modify", modify.get("detail"));
		mav.addObject("work", modify.get("work"));
		mav.addObject("workScopeList", service.getWorkScope());
		return mav;
	}

	@RequestMapping(value = "/clientModify", method = RequestMethod.POST)
	public ModelAndView modifyInsert(@RequestParam Map<String, Object> value,
			@RequestParam("work_scope_no") List<Integer> chk) {
		ModelAndView mav = new ModelAndView("redirect:/management/clientList");
		System.out.println("밸류 = " + value);
		service.clientUpdate(value);
		service.wsUpdate(value, chk);
//		service.reqUpdate(value);

		return mav;
	}

	@RequestMapping("/memberList")
	public ModelAndView mMemberList() {
		ModelAndView mav = new ModelAndView("management/memberList");

		return mav;
	}

	@RequestMapping("/requestorRegister") // 지원 요청자만 관리하기
											// 지원 요청자 리스트
	public ModelAndView reqRegister(@RequestParam int no) {
		ModelAndView mav = new ModelAndView("management/requestorRegister");
		logger.debug(no);
		List<Map<String, Object>> list = service.getReqList(no);
		mav.addObject("list", list);
		return mav;
	}

	@RequestMapping(value = "/requestorRegister", method = RequestMethod.POST) // 지원
																				// 요청자
																				// 수정,
																				// 추가
																				// 하기
	public ModelAndView reqInfo(@RequestParam Map<String, Object> value) throws UnsupportedEncodingException {
		String client_name = URLEncoder.encode(value.get("client_name").toString(), "UTF-8"); // url에 한글 깨져서 바꿈
		ModelAndView mav = new ModelAndView(
				"redirect:/management/requestorRegister?no=" + value.get("client_no") + "&name=" + client_name);
		logger.debug(value);

		if (Integer.valueOf(value.get("add").toString()) == 0) {
			service.reqInfoInsert(value);
		} else {
			service.reqInfoModify(value);
		}

		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/rowDelete", method = RequestMethod.POST) // 지원 요청자
																		// 삭제
	public String deleteRow(@RequestParam int rNo) {
		logger.debug(rNo);
		service.rowDelete(rNo);
		return "success";
	}

	@RequestMapping("/jusoPopup") // 팝업창 띄우기
	public ModelAndView goPopUp() {
		ModelAndView mav = new ModelAndView("management/jusoPopup");

		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "/changeRep", method = RequestMethod.POST) // 지원 요청자
																		// 대표 변경
	public String changeRep(@RequestParam Map<String, Object> map) {
		System.out.println("넘어왔나");
		logger.debug("대표자 --------------------" + map.toString());
		service.changeRep(map);
		return "success";
	}

	// 프로젝트 리스트
	@RequestMapping(value = "/projectList", method = RequestMethod.GET)
	public ModelAndView projectList(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "searchSort", required = false) Integer searchSort,
			@RequestParam(value = "keyword", required = false) String keyword) {
		ModelAndView mav = new ModelAndView("management/projectList");

		mav.addObject("list", maintenanceService.gerProjectList(page, searchSort, keyword));

		return mav;
	}

	// 프로젝트 등록 페이지
	@RequestMapping(value = "/projectList/projectRegister", method = RequestMethod.GET)
	public ModelAndView projectRegister() {
		ModelAndView mav = new ModelAndView("management/projectRegister");

		List<ClientVO> clientList = maintenanceService.getClientList();
		List<Map<String, Object>> projectScope = maintenanceService.getProjectScope(0);
		List<Map<String, Object>> allList = memeberManageService.allList();

		mav.addObject("clientList", clientList);
		mav.addObject("projectScope", projectScope);
		mav.addObject("allList", allList);

		return mav;
	}

	// 프로젝트 등록
	@RequestMapping(value = "/projectList/projectRegister", method = RequestMethod.POST)
	public ModelAndView projectRegister(@RequestParam Map<String, Object> data,
			@RequestParam(value = "project_scope_no") int[] pjScopeNo, @RequestParam(value = "user_no") int[] userNo,
			@RequestParam(value = "user_start_date") String[] userStartDate,
			@RequestParam(value = "user_end_date") String[] userEndDate) {
		ModelAndView mav = new ModelAndView("redirect:/management/projectList");

		maintenanceService.projectRegister(data, pjScopeNo, userNo, userStartDate, userEndDate);

		return mav;
	}

	// 포르젝트 상세 보기
	@RequestMapping(value = "/projectList/{no}", method = RequestMethod.GET)
	public ModelAndView projectView(@PathVariable int no) {
		ModelAndView mav = new ModelAndView("management/projectView");

		mav.addObject("projectScope", maintenanceService.getProjectScope(0));
		mav.addObject("pj_view", maintenanceService.getProjectView(no));

		return mav;
	}

	// 프로젝트 삭제
	@ResponseBody
	@RequestMapping(value = "/projectList/{no}", method = RequestMethod.DELETE)
	public String projectDelete(@PathVariable int no) {
		if (maintenanceService.projectDelete(no))
			return "Success";
		else
			return "error";
	}

	// 프로젝트 수정 페이지
	@RequestMapping(value = "/projectList/{no}/modify", method = RequestMethod.GET)
	public ModelAndView projectModifyPage(@PathVariable int no) {
		ModelAndView mav = new ModelAndView("management/projectModify");

		List<ClientVO> clientList = maintenanceService.getClientList();
		List<Map<String, Object>> projectScope = maintenanceService.getProjectScope(0);
		List<Map<String, Object>> allList = memeberManageService.allList();

		mav.addObject("clientList", clientList);
		mav.addObject("projectScope", projectScope);
		mav.addObject("allList", allList);

		mav.addObject("pj_view", maintenanceService.getProjectView(no));

		return mav;
	}

	// 프로젝트 수정
	@RequestMapping(value = "/projectList/{no}/modify", method = RequestMethod.POST)
	public ModelAndView projectModify(@PathVariable int no, @RequestParam Map<String, Object> data,
			@RequestParam(value = "project_scope_no") int[] pjScopeNo, @RequestParam(value = "user_no") int[] userNo,
			@RequestParam(value = "user_start_date") String[] userStartDate,
			@RequestParam(value = "user_end_date") String[] userEndDate) {
		ModelAndView mav = new ModelAndView("redirect:/management/projectList");

		maintenanceService.projectModify(no, data, pjScopeNo, userNo, userStartDate, userEndDate);

		return mav;
	}

	// 리스트에서 멤버 보기
	@RequestMapping(value = "/projectList/getMembers", method = RequestMethod.POST)
	@ResponseBody
	public String getMembers(@RequestParam int no) {
		return maintenanceService.getMembers(no);
	}

	@RequestMapping(value = "/projectList2")
	public ModelAndView projectList2(@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "searchSort", required = false) Integer searchSort,
			@RequestParam(value = "keyword", required = false) String keyword) {
		ModelAndView mav = new ModelAndView("management/projectList2");
		mav.addObject("list", maintenanceService.gerProjectList(page, searchSort, keyword));
		return mav;
	}
}