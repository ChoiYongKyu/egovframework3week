package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MenuVO;

@Repository("MenuMapper")
public interface MenuMapper {

	public List<MenuVO> getMenu();
	public int add(MenuVO menuVO);
	public String getParentURL(int parent_no);
	public int del(int menu_no);
	public List<Map<String, Object>> getGroup(String id);
	public List<MenuVO> getMenuCount(NosMap nosMap);

}