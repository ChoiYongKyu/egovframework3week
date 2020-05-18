package com.nos.mm.service.impl;

import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.nos.mm.controller.CodeController;
import com.nos.mm.mapper.CodeMapper;
import com.nos.mm.service.CodeService;

@Service
public class CodeServiceImpl implements CodeService {
	
	private final static Logger logger = Logger.getLogger(CodeController.class);

	@Autowired
	private CodeMapper mapper;

	@Override
	public List<Map<String, Object>> getCodeList() {
		return mapper.getCodeList();
	}

	@Override
	public List<Map<String, Object>> getResultList(String common_code) {
		return mapper.getResultList(common_code);
	}

	@Override
	public void deleteCode(int code_key, String code) {
		mapper.deleteCode(code_key, code);
	}

	@Override
	public void addCode(Map<String, Object> map) {
		mapper.addCode(map);
	}
	
	@Override
	public void insertCode(Map<String, Object> map) {
		mapper.insertCode(map);
	}
	
}
