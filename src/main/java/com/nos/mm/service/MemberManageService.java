package com.nos.mm.service;

import java.util.List;
import java.util.Map;

public interface MemberManageService {
	
	public Map<String, Object> list(int page, String keyword);
	public List<Map<String, Object>> auth();
	public int reset(int mem_no);
	public int delete(int mem_no);
	public List<Map<String, Object>> getAllGroup();
	public Map<String, Object> groupAdd(String mn_group_name);
	public int groupDelMem(int mem_no, int grp_no);
	public List<Map<String, Object>> groupCheckMem(String mem_id);
	public Map<String, Object> groupAddMem(Map<String, Object> map);
	public int changeAuth(Map<String, Object> auth);
	public Map<String, Object> groupAddMemAfter(Map<String, Object> map);
	public void groupDel(Map<String, Object> value);
	public List<Map<String, Object>> allList();
	
}
