package com.nos.mm.service;

import java.util.Map;

public interface ImprovementService {

	public Map<String, Object> getList(int page, String searchText);

	public void insert(Map<String, Object> value);

	public Map<String, Object> getDetail(int no);

	public void doDelete(int no);

	public void insertModify(Map<String, Object> value);
	
	public Map<String, Object> getNewImpNo();
}
