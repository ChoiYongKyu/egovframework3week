package com.nos.mm.controller;

import java.security.Principal;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.CodeService;
import com.nos.mm.service.FileService;
import com.nos.mm.service.MemberService;
import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MemberVO;

@Controller
@RequestMapping("/mypage")
public class MemberController {
	
	final static Logger logger = Logger.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private FileService fileService;
	
	@RequestMapping("")
	public ModelAndView info(Locale locale, Principal principal, Authentication authentication) {
		
		ModelAndView mav = new ModelAndView("member/info");
		
//		MemberVO memberVO = (MemberVO) principal; // 얘는 캐스팅 실패!
		MemberVO memberVO = (MemberVO) authentication.getPrincipal();
		
		Map<String, Object> signInfo = fileService.getSignFile(memberVO.getMem_no());
		mav.addObject("signInfo", signInfo);

		// 자신이 속한 그룹과 멤버들
		List<Map<String, Object>> groupByMem_no = memberService.groupByMem_no(memberVO.getMem_no(), locale); 
		
		mav.addObject("grp", groupByMem_no);

		return mav;
	}
	
	@RequestMapping("/modify")
	public ModelAndView modify(Authentication authentication) {
		ModelAndView mav = new ModelAndView("member/modify");

		mav.addObject("deptList", codeService.getResultList("MEM_DEPT"));
		mav.addObject("gradeList", codeService.getResultList("MEM_GRADE"));

		NosMap memberInfo = memberService.memberInfo((MemberVO) authentication.getPrincipal());
		if(memberInfo != null) {
			Map<String, Object> signInfo = fileService.getSignFile(Integer.parseInt(memberInfo.getString("memNo")));
			
			mav.addObject("signInfo", signInfo);
			mav.addObject("memberInfo", memberInfo);
		}

		return mav;
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public ModelAndView modifyInfo(@RequestParam Map<String, Object> value, @ModelAttribute MemberVO memberVO) throws Exception {
		
		ModelAndView mav = new ModelAndView("redirect:/mypage");
		
		// 회원 정보 변경 실패시
		int result = memberService.modifyInfo(memberVO);
		
		if(result == 0) {
			mav.setViewName("mypage/modify");
		}
		  
		if(value.get("sign_upload") != null && !"".equals(value.get("sign_upload"))) { 

			int upload_no = "".equals(value.get("upload_no")) ? 0 : Integer.parseInt((String)value.get("upload_no")); 
			
			if(upload_no > 0) {		  
				fileService.deleteFile(upload_no); 
			}
			
			// 변경한 방식 (signature_pad.min.js로 즉시 서명하는 방식)
			fileService.uploadFileFromBinaryString(Integer.parseInt((String)value.get("mem_no")), ((String) value.get("sign_upload")).split(",")[1], (String)value.get("table"));
		    //fileService.uploadFile(Integer.parseInt((String)value.get("mem_no")), files, (String)value.get("table")); 
		}
		 
		// 세션 정보 업데이트 
		Authentication authentication = new UsernamePasswordAuthenticationToken(memberVO, memberVO.getPassword(),  SecurityContextHolder.getContext().getAuthentication().getAuthorities());
		 
		// 새로운 세션으로 세팅
		SecurityContextHolder.getContext().setAuthentication(authentication);

		return mav;
	}
}