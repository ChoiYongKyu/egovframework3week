package com.nos.mm.service;

import java.util.List;
import java.util.Map;

public interface ClientService {

	public Map<String, Object> getList(int page, int searchCategory, String searchText);

	// public List<Map<String, Object>> searchList(int searchCategory, String
	// searchText);

	public Map<String, Object> getDetail(int no);

	public void insert(Map<String, Object> value, List<Integer> chk) throws Exception;

	public Map<String, Object> modify(int no);

	public void clientUpdate(Map<String, Object> value);

	public void doDelete(int no);

	public void reqInfoInsert(Map<String, Object> value);

	public void wsUpdate(Map<String, Object> value, List<Integer> chk);

	public List<Map<String, Object>> getProductList();

	public List<Map<String, Object>> getVersion(int productNo);

	public void reqUpdate(Map<String, Object> value);

	public List<Map<String, Object>> getReqList(int no);

	public void rowDelete(int rNo);

	public void reqInfoModify(Map<String, Object> value);
	
	public List<Map<String, Object>> getWorkScope ();

	public void changeRep(Map<String, Object> map);

}
