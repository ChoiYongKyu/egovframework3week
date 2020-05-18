package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("CodeMapper")
public interface CodeMapper {

	List<Map<String, Object>> getCodeList();

	List<Map<String, Object>> getResultList(String common_code);

	void deleteCode(int code_key, String code);

	void addCode(Map<String, Object> map);

	void insertCode(Map<String, Object> map);
	
}
