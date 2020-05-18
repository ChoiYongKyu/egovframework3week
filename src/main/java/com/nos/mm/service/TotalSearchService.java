package com.nos.mm.service;

import java.util.List;
import java.util.Map;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

public interface TotalSearchService {
	
	Map<String, Object> totalSearch(Map<String, Object> map);
}
