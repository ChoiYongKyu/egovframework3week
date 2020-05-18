package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("ProductMapper") // .xml 이름
public interface ProductMapper {

	public List<Map<String, Object>> getList();
	
	public int insert(Map<String, Object> value);
	
	public List<Map<String, Object>> getChart(int client_no);
	
	public Map<String, Object> getDetail(int product_no);
	
	public List<Map<String, Object>> getVersion(int product_no);
	
	public int insertVersion(Map<String, Object> map);
	
	public int deleteVersion(int version_no);
	
	public List<Map<String, Object>> getProduct();
	
	public List<Map<String, Object>> getVersionList(Map<String, Object> value);
	
	public List<Map<String, Object>> getProductList(int no);
	
	public int updateVersion(Map<String, Object> value);

	public void licenseInsert(Map<String, Object> value);
	public void useProductInsert(Map<String, Object> value);

	public void deleteUseProduct(int pNo);

	public void deleteLicense(int lNo);

	public void dataModify(Map<String, Object> value);

	public List<Map<String, Object>> getClient();

	public List<Map<String, Object>> getUsingProductList(Map<String, Object> value);

	public List<Map<String, Object>> getUsingClientList(Map<String, Object> value);

	public List<Map<String, Object>> getUsingVersionList(Map<String, Object> value);

	public List<Map<String, Object>> getUsingCount(Map<String, Object> value);

	

}
