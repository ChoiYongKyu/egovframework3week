package com.nos.mm.util;

import java.util.List;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.controller.HomeController;
import com.nos.mm.service.MenuService;
import com.nos.mm.vo.MemberVO;
import com.nos.mm.vo.MenuVO;

@Aspect
@Component
public class MenuAspect {

	@Autowired
	private MenuService menuService;
	private final static Logger logger = Logger.getLogger(MenuAspect.class);
	
	
	@Around("execution(* com.nos.mm.controller.*Controller.*(..))" 
			+ "&& !execution(* com.nos.mm.controller.MainController.*(..))"
			+ "&& !execution(* com.nos.mm.controller.MobileController.*(..))"
			+ "&& !@annotation(org.springframework.web.bind.annotation.ResponseBody)")
	public ModelAndView menu(ProceedingJoinPoint joinPoint) throws Throwable {
		ModelAndView mav = (ModelAndView) joinPoint.proceed(); // 컨트롤러의 메소드가 끝난 뒤 온 값!
		
		Authentication authentication = HomeController.authentication;
		
		NosMap member = new NosMap();
		List<MenuVO> menu;
		
		if(authentication == null) {
			 menu = menuService.getMenu();
			 
		} else {
			member.put("sesMemNo", getSesMemNo(HomeController.authentication));//수정자번호
			menu = menuService.getMenuCount(member);
			
		}
		mav.addObject("menu", menu);	
		return mav;
	}
	
	private String getSesMemNo(Authentication authentication) {
		MemberVO memberVO = (MemberVO) authentication.getPrincipal();
		return Integer.toString(memberVO.getMem_no());
	}
	
	
}
