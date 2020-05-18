package com.nos.mm.mapper;

import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("FileMapper")
public interface FileMapper {
	
	public void insertFile(Map<String, Object> value);
	
	public Map<String, Object> getFile (int no);
	
	public void deleteFile(int no);
	
	public Map<String, Object> getMobileFile(int no);

	public Map<String, Object> getSignFile(int mem_no);
}
