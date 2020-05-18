package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("ExcelMapper")
public interface ExcelMapper {
	
	public List<Map<String, Object>> getList();
	public List<Map<String, Object>> getClient();
	public List<Map<String, Object>> getRequestor(int client_no);
	public List<Map<String, Object>> getWorkScope(int client_no);
	
	public List<Map<String, Object>> getAllSup();
	public List<Map<String, Object>> getAllWS();
	public List<Map<String, Object>> getAllReq();
	
	public Integer getMem_no(String mem_name);
	public Integer addMN(Map<String, Object> map);
	public void addUpload(Map<String, Object> map);
	public void addReq_manage(Object object, Object object2);

}
