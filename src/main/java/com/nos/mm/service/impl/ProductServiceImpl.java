package com.nos.mm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.ProductMapper;
import com.nos.mm.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper mapper;
	
	public List<Map<String, Object>> getList() {
		return mapper.getList();
	}
	
	@Override
	public void insert(Map<String, Object> value) {
		// TODO Auto-generated method stub
		mapper.insert(value);
	}

	@Override
	public List<Map<String, Object>> getChart(int client_no) {
		return mapper.getChart(client_no);
	}

	@Override
	public Map<String, Object> getDetail(int product_no) {
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("detail", mapper.getDetail(product_no));
		resultMap.put("version", mapper.getVersion(product_no));
		
		return resultMap;
	}

	@Override
	public void insertVersion(Map<String, Object> value) {
		mapper.insertVersion(value);
	}

	@Override
	public int deleteVersion(int version_no) {
		return mapper.deleteVersion(version_no);
	}

	@Override
	public List<Map<String, Object>> getProduct() {
		return mapper.getProduct();
	}
	
	@Override
	public List<Map<String, Object>> getVersionList(Map<String, Object> value) {
		return mapper.getVersionList(value);
	}

	@Override
	public List<Map<String, Object>> getProductList(int no) {
		return mapper.getProductList(no);
	}

	@Override
	public int updateVersion(Map<String, Object> value) {
		return mapper.updateVersion(value);
	}

	@Override
	public void dataInsert(Map<String, Object> value) {
		mapper.licenseInsert(value);
		mapper.useProductInsert(value);
	}

	@Override
	public void deleteRow(int pNo, int lNo) {
		mapper.deleteUseProduct(pNo);
		mapper.deleteLicense(lNo);
	}

	@Override
	public void dataModify(Map<String, Object> value) {
		mapper.dataModify(value);
	}

	@Override
	public List<Map<String, Object>> getClient() {
		return mapper.getClient();
	}

	@Override
	public List<Map<String, Object>> getUsingProductList(Map<String, Object> value) {
		return mapper.getUsingProductList(value);
	}

	@Override
	public List<Map<String, Object>> getUsingClientList(Map<String, Object> value) {
		return mapper.getUsingClientList(value);
	}

	@Override
	public List<Map<String, Object>> getUsingVersionList(Map<String, Object> value) {
		return mapper.getUsingVersionList(value);
	}

	@Override
	public List<Map<String, Object>> getUsingCount(Map<String, Object> value) {
		return mapper.getUsingCount(value);
	}

	
}
