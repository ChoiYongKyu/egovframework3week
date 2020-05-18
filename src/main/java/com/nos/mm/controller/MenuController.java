package com.nos.mm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.MenuService;
import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MemberVO;
import com.nos.mm.vo.MenuVO;

@Controller
@RequestMapping("/menu")
public class MenuController {
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping("/menu")
	public ModelAndView menuManagement() {
		
		ModelAndView mav = new ModelAndView("menu/management");
	
		List<MenuVO> menuList = menuService.getMenu();
		
		mav.addObject("menuList", menuList);
		
		return mav;
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public MenuVO add(@ModelAttribute MenuVO menuVO) {
		
		int result = menuService.add(menuVO);

		if(result == 1) {
			return menuVO;
		} else {
			return null;
		}
	}
	
	@RequestMapping("/del")
	@ResponseBody
	public Integer del(@RequestParam("menu_no") int menu_no) {

		int result = menuService.del(menu_no);

		if(result == 1) {
			return menu_no;
		} else {
			return null;
		}
		
	}
	
	
}