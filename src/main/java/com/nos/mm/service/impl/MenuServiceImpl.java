package com.nos.mm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.MenuMapper;
import com.nos.mm.service.MenuService;
import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MenuVO;

@Service
public class MenuServiceImpl implements MenuService {
	
	@Autowired
	private MenuMapper menuMapper;
	
	public List<MenuVO> getMenu() {
		return menuMapper.getMenu();
		
	}
	
	public int add(MenuVO menuVO) {
		
		String parentURL = menuMapper.getParentURL(menuVO.getMenu_parent());
		String childURL = menuVO.getUrl();
		String newURL = parentURL + childURL;
		
		menuVO.setUrl(newURL);
		
		return menuMapper.add(menuVO);
		
	}
	
	public int del(int menu_no) {
		return menuMapper.del(menu_no);
	}

	@Override
	public List<Map<String, Object>> getGroup(String id) {
		
		return menuMapper.getGroup(id);
	}


	@Override
	public List<MenuVO> getMenuCount(NosMap nosMap) {
		// TODO Auto-generated method stub
		return menuMapper.getMenuCount(nosMap);
	}

}