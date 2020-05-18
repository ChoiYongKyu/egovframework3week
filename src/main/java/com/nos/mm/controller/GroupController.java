package com.nos.mm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.GroupService;
import com.nos.mm.service.MemberService;
import com.nos.mm.vo.MemberVO;

@Controller
@RequestMapping("/group")
public class GroupController {
	
	private final static Logger logger = Logger.getLogger(GroupController.class);
	
	@Resource
	MessageSource messageSource;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private GroupService groupService;

	@RequestMapping("")
	public ModelAndView main(Locale locale, Authentication authentication) throws Exception{
		ModelAndView mav = new ModelAndView("group/group");
		
		MemberVO memberVO = (MemberVO) authentication.getPrincipal();
		
		// 자신이 속한 그룹과 멤버들
		List<Map<String, Object>> groupByMem_no = memberService.groupByMem_no(memberVO.getMem_no(), locale); 
		
		mav.addObject("grp", groupByMem_no);
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/manage", method = RequestMethod.POST)
	public Map<String, Object> groupDetail(@RequestParam int mn_group_no) throws Exception{
		
		List<Map<String, Object>> list = groupService.groupDetail(mn_group_no);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_list", list);
		logger.debug(map.toString());
		return map;
		
	}
	
}