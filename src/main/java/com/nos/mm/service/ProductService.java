package com.nos.mm.service;

import java.util.List;
import java.util.Map;

public interface ProductService {

	public List<Map<String, Object>> getList();
	
	public void insert(Map<String, Object> value);
	
	public List<Map<String, Object>> getChart(int client_no);
	
	public Map<String, Object> getDetail(int product_no);
	
	public void insertVersion(Map<String, Object> value);
	
	public int deleteVersion(int version_no);

	public List<Map<String, Object>> getProduct();
	
	public List<Map<String, Object>> getVersionList(Map<String, Object> value);

	public List<Map<String, Object>> getProductList(int no);
	
	public int updateVersion(Map<String, Object> value);

	public void dataInsert(Map<String, Object> value);

	public void deleteRow(int pNo, int lNo);

	public void dataModify(Map<String, Object> value);

	public List<Map<String, Object>> getClient();

	public List<Map<String, Object>> getUsingProductList(Map<String, Object> value);

	public List<Map<String, Object>> getUsingClientList(Map<String, Object> value);

	public List<Map<String, Object>> getUsingVersionList(Map<String, Object> value);

	public List<Map<String, Object>> getUsingCount(Map<String, Object> value);

	
}
