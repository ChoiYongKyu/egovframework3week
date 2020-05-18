package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;


@Repository("ImprovementMapper")
public interface ImprovementMapper {
	
	public List<Map<String, Object>> getList(Map<String, Object> value);

	public void insert(Map<String, Object> value);

	public Map<String, Object> getDetail(int no);

	public void doDelete(int no);

	public void insertModify(Map<String, Object> value);

	public List<Map<String, Object>> getFileList(int no);
	
	public Map<String, Object> getNewImpNo();
}
