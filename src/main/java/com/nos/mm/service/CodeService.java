package com.nos.mm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface CodeService {

	List<Map<String, Object>> getCodeList();

	List<Map<String, Object>> getResultList(String common_code);

	void deleteCode(int code_key, String code);

	void addCode(Map<String, Object> map);

	void insertCode(Map<String, Object> map);
	
}
