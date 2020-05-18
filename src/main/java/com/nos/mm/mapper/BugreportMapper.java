package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("BugreportMapper")
public interface BugreportMapper {

	public List<Map<String, Object>> getClient();

	public List<Map<String, Object>> getProduct(Map<String, Object> value);

	public List<Map<String, Object>> getVersion(Map<String, Object> value);

	public void insert(Map<String, Object> value);

	public Map<String, Object> getDetail(int no);
	// public Map<String, Object> getDetail();

	public List<Map<String, Object>> getList(Map<String, Object> value);

	public void insertReply(Map<String, Object> value);

	public List<Map<String, Object>> getReply(int no);

	public Map<String, Object> getModify(int no);

	public void insertModify(Map<String, Object> value);

	public void doDelete(int no);

	public void deleteReply(int no);

	public void modifyReply(Map<String, Object> value);

}
