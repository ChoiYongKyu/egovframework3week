package com.nos.mm.controller;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.MemberService;
import com.nos.mm.vo.MemberVO;

@Controller
@RequestMapping("")
public class MainController {
	
	private final static Logger logger = Logger.getLogger(MainController.class);

	@Autowired
	private MemberService memberService;
	
	// 첫페이지, 로그인 페이지
		@RequestMapping("")
		public ModelAndView main(@RequestParam(value="no", required=false, defaultValue="0") int noNav) {

			ModelAndView mav = new ModelAndView("main/login");
			
			mav.addObject("noNav", noNav); // 헤더, 사이드바 가리기 용

			return mav;
		}
		
		// form:form 태그사용시 commandName을 미리 보내줘야 해서...
		@ModelAttribute("memberVO")
		public Object form() {
			return new MemberVO();
		}
		
		// 회원가입 페이지
		@RequestMapping(value = "/join", method = RequestMethod.GET)
		public ModelAndView join(@RequestParam(value="no", required=false, defaultValue="0") int noNav) {
			
			ModelAndView mav = new ModelAndView("main/join");
			
			mav.addObject("noNav", noNav); // 헤더, 사이드바 가리기 용
			
			return mav;
		}
		
		// 이메일 중복체크
		@ResponseBody
		@RequestMapping(value = "/check", method = RequestMethod.POST)
		public String check(String email) {
			return memberService.emailDuplCheck(email);
		}
		
		// 회원가입 
		@RequestMapping(value = "/join", method = RequestMethod.POST)
		public ModelAndView join(@Valid @ModelAttribute MemberVO memberVO, BindingResult bindingResult) {

			ModelAndView mav = new ModelAndView();
			
			if(bindingResult.hasErrors()) {
				mav.setViewName("main/join");
				
				mav.addObject("noNav", 0); // 헤더, 사이드바 가리기 용
				
				// 다시 폼 작성해서 유효성 통과해도 에러메시지가 사라지지 않으므로 추가 바람
				
				return mav;
			} else { // DB 데이터 등록 성공시
				if(memberService.join(memberVO) == 1) {
					mav.setViewName("redirect:/");
					
					return mav;
				} else { // DB 데이터 등록 실패시
					mav.setViewName("main/join");
					
					return mav;
				}
			}
		}
		
		// 이메일, 비밀번호 찾기 페이지
		@RequestMapping("/find")
		public ModelAndView find(@RequestParam(value="no", required=false, defaultValue="0") int noNav) {
			
			ModelAndView mav = new ModelAndView("main/find");
			
			mav.addObject("noNav", noNav); // 헤더, 사이드바 가리기 용
			
			return mav;
		}
		
		// 이메일, 비밀번호 찾은 다음 띄울 페이지
		@RequestMapping(value = "/find", method = RequestMethod.POST)
		public ModelAndView findInfo(@ModelAttribute MemberVO memberVO) {
			
			ModelAndView mav = new ModelAndView("main/find_info");
			
			mav.addObject("noNav", 0); // 헤더, 사이드바 가리기 용
			
			// 이메일이 null일경우 이메일 찾기
			if(memberVO.getMem_id() == null) { 
				mav.addObject("find_info", "email");
				
				String mem_id = memberService.findEmail(memberVO);
				
				if(mem_id != null) { // 해당정보의 이메일이 존재할 경우
					mav.addObject("exist", true); 
					mav.addObject("name", memberVO.getMem_name());
					mav.addObject("email", mem_id);
				} else {
					mav.addObject("exist", false); // 해당정보의 이메일이 존재하지 않을 경우 
				}
			} else { // 비밀번호 찾기
				mav.addObject("find_info", "pw"); 
				
				String mem_id = memberService.findPW(memberVO);
				
				if(mem_id != null) {
					mav.addObject("exist", true); // 정보가 일치하는 경우
					mav.addObject("email", mem_id);
				} else {
					mav.addObject("exist", false); // 정보가 일치하지 않는 경우 
				}
			}
			
			return mav;
		}
		
		// 첫 구글 로그인시 회원가입
		@ResponseBody
		@RequestMapping(value = "/google", method = RequestMethod.POST)
		public Map<String, Object> googleLogin(@RequestParam Map<String, Object> data) {
			logger.debug(data.toString());

			String email = String.valueOf(data.get("U3"));//zu
			String password = String.valueOf(data.get("Eea")); // 비밀번호 대신 구글 id
			String name = String.valueOf(data.get("ig"));//Ad
			String phone = "google user";
			
			Map<String, Object> loginData = new HashMap<String, Object>(); // vo to json 라이브러리 없이 안되기 때문에...
			loginData.put("mem_id", email);
			loginData.put("mem_pw", password);
			
			if(memberService.emailDuplCheck(email) == null) {
				MemberVO memberVO = new MemberVO();
				memberVO.setMem_id(email);
				memberVO.setMem_pw(password);
				memberVO.setMem_name(name);
				memberVO.setMem_tel(phone);
				
				memberService.join(memberVO);
			} 
			
			return loginData;
		}
		
}