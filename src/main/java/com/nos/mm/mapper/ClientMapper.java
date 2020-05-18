package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("ClientMapper") // .xml 이름
public interface ClientMapper {
	// public List<Map<String, Object>> getList(Map<String, Object> map);
	// public List<Map<String, Object>> searchList(Map<String, Object> map);

	public int insert(Map<String, Object> value);

	public void reqInsert(Map<String, Object> reqMap);

	public void wsInsert(int work_scope_no, int client_no);

	public void reqInfoInsert(Map<String, Object> value);

	public void useProductInsert(Map<String, Object> productMap);

	public void licenseInsert(Map<String, Object> licenseMap);

	public List<Map<String, Object>> getList(Map<String, Object> map);

	public Map<String, Object> getDetail(int no);
	
	public List<Map<String, Object>> getDetailWork(int no);

	public List<Map<String, Object>> modify(int no);
	
	public List<Map<String, Object>> getFileList(int no);

	public void clientUpdate(Map<String, Object> value);

	public void doDelete(int no);

	public void wsUpdate(int client_no);

	public List<Map<String, Object>> getProductList();

	public List<Map<String, Object>> getVersion(int productNo);

	public void reqUpdate(Map<String, Object> value);

	public List<Map<String, Object>> getReqList(int no);

	public void rowDelete(int rNo);

	public void reqInfoModify(Map<String, Object> value);
	
	public List<Map<String, Object>> getWorkScope();

	public void changeRep(Map<String, Object> map);

	public void initRep(Map<String, Object> map);

}
