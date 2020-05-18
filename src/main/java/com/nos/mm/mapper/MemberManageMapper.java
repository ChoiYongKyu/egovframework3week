package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("MemberManageMapper")
public interface MemberManageMapper {

	public List<Map<String, Object>> list(Map<String, Object> map);
	public List<Map<String, Object>> getGroup(int mem_no);
	public List<Map<String, Object>> auth();
	public int reset(Map<String, Object> map);
	public int delete(int mem_no);
	public List<Map<String, Object>> getAllGroup();
	public int groupAdd(Map<String, Object> map);
	public int groupDelMem(int mem_no, int grp_no);
	public List<Map<String, Object>> groupCheckMem(String mem_id);
	public int groupAddMem(Map<String, Object> map);
	public int changhAuth(Map<String, Object> auth);
	public Map<String, Object> groupAddMemAfter(int mem_no);
	public void groupDel(Map<String, Object> value);
	public List<Map<String, Object>> allList();
	
}
