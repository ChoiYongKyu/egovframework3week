package com.nos.mm.service;

import java.util.List;
import java.util.Map;

public interface BugreportService {

	public List<Map<String, Object>> getClient();

	public List<Map<String, Object>> getProduct(Map<String, Object> value);

	public List<Map<String, Object>> getVersion(Map<String, Object> value);

	public void insert(Map<String, Object> value);

	public Map<String, Object> getList(int page, String searchText);

	public Map<String, Object> getDetail(int no);

	public void insertReply(Map<String, Object> value);

	public List<Map<String, Object>> getReply(int no);

	public void deleteReply(int no);

	public void modifyReply(Map<String, Object> value);

	public Map<String, Object> getModify(int no);

	public void insertModify(Map<String, Object> value);

	public void doDelete(int no);

}
