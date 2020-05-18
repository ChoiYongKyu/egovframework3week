package com.nos.mm.service;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

public interface ExcelService {
	
	public XSSFWorkbook download();
	public XSSFWorkbook export();
	public void upload(MultipartFile file);

}
