package com.nos.mm.service;

import java.util.List;
import java.util.Map;

import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MenuVO;

public interface MenuService {
	
	public List<MenuVO> getMenu();
	public List<MenuVO> getMenuCount(NosMap nosMap);
	public int add(MenuVO menuVO);
	public int del(int menu_no);
	public List<Map<String, Object>> getGroup(String id);

}