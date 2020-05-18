package com.nos.mm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.MemberManageService;
import com.nos.mm.vo.MemberVO;


@Controller
@RequestMapping("/member_manage")
public class MemberManageController {
	
	@Autowired
	private MemberManageService memberManageService;
	
	@RequestMapping("")
	public ModelAndView list() {
		ModelAndView mav = new ModelAndView("redirect:/member_manage/member");
		
		return mav;
	}
	
	// 멤버리스트
	@RequestMapping("/member")
	public ModelAndView memberList(@RequestParam(value = "no", defaultValue = "1") int page
							, @RequestParam(value = "keyword", required = false) String keyword) {
		ModelAndView mav = new ModelAndView("management/memberList");
		
		Map<String, Object> map = memberManageService.list(page, keyword);
		
		mav.addObject("member", map);
		
		return mav;
	}
	
	// 권한 종류 보기
	@RequestMapping(value = "/auth", method=RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> auth() {
		
		return memberManageService.auth();
	}
	
	// 권한 변경
	@ResponseBody
	@RequestMapping(value = "changeAuth", method=RequestMethod.POST)
	public int changeAuth(@RequestParam Map<String, Object> auth) {
		return memberManageService.changeAuth(auth);
	}
	
	// 멤버 비밀번호 리셋
	@RequestMapping("/reset")
	public ModelAndView reset(@RequestParam("no") int no) {
		
		ModelAndView mav = new ModelAndView("redirect:/member_manage");
		
		if(memberManageService.reset(no) == 0) {
			// DB error
		}
		
		return mav;
	}

	// 멤버 탈퇴
	@RequestMapping("/delete")
	public ModelAndView delete(@RequestParam("no") int no) {
		
		ModelAndView mav = new ModelAndView("redirect:/member_manage");
		
		if(memberManageService.delete(no) == 0) {
			// DB error
		}
		
		return mav;
	}
	
	// 그룹리스트
	@RequestMapping("/group")
	public ModelAndView group() {
		ModelAndView mav = new ModelAndView("management/groupList");
		
		mav.addObject("allGroup", memberManageService.getAllGroup());
		
		return mav;
	}
	
	// 그룹 추가
	@RequestMapping(value = "/group/add", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> groupAdd(@RequestParam("mn_group_name") String mn_group_name) {

		return memberManageService.groupAdd(mn_group_name);
		
	}
	
	// 그룹 삭제
		@RequestMapping(value = "/group/delete", method=RequestMethod.POST)
		@ResponseBody
		public void groupDel(@RequestParam Map<String, Object> value) {

			System.out.println(value.toString());
			memberManageService.groupDel(value);
		}
	
	// 그룹 멤버 삭제
	@RequestMapping(value = "/group/member/del", method=RequestMethod.POST)
	@ResponseBody
	public int groupDelMem(@RequestParam("mem_no") int mem_no
										, @RequestParam("grp_no") int grp_no) {

		return memberManageService.groupDelMem(mem_no, grp_no);
		
	}
	
	// 그룹 멤버 존재 확인 (ajax에서 text로 받았더니 한글이 깨져서  produces = "application/text; charset=utf8" 추가해서 문제 해결)
	@RequestMapping(value = "/group/member/check", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> groupCheckMem(@RequestParam("mem_id") String mem_id) {
		// ajax로 VO넘길때 VO의 값중에 null이 있으면 에러가 뜸!!!
//		MemberVO memberVO = memberManageService.groupCheckMem(mem_id);
////		System.out.println(memberVO);
////		memberVO.setMem_pw("1111");
////		memberVO.setMem_tel("1111");
////		memberVO.setMem_enc("1111");
////		memberVO.setAuthorities(new ArrayList<String>());
//
//		Map<String, Object> map = new HashMap<String, Object>();
//		if(memberVO != null) {
//			map.put("mem_no", memberVO.getMem_no());
//			map.put("mem_name", memberVO.getMem_name());
//			map.put("mem_id", memberVO.getMem_id());
//			
//			return map;
//		} else {
//			return null;
//		}
//		
//		return memberVO;
		System.out.println("cont   : "+mem_id);
		System.out.println(memberManageService.groupCheckMem(mem_id).toString());
		return memberManageService.groupCheckMem(mem_id);
	}

	// 그룹 멤버 확인후 추가
	@RequestMapping(value = "/group/member/add", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> groupAddMem(@RequestParam Map<String, Object> map) {

		return memberManageService.groupAddMem(map);
		
	}
	//그룹 멤버 추가후 확인
	@RequestMapping(value = "/group/member/add/after", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> groupAddMemAfter(@RequestParam Map<String, Object> map) {
		System.out.println("cont after"+ map.toString());
//		System.out.println(memberManageService.groupAddMemAfter(map));
		return memberManageService.groupAddMemAfter(map);
		
	}
}