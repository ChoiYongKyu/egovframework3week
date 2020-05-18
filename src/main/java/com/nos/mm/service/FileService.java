package com.nos.mm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {

	public void downloadFile(int no, HttpServletResponse response) throws Exception;
	
	public void deleteFile(int no) throws Exception;
	
	public void uploadFile(int no, List<MultipartFile> files, String table) throws Exception;
	
	public void uploadFileFromBinaryString(int no, String file, String table) throws Exception;

	public void downloadFileMobile(int no, HttpServletResponse response) throws Exception;

	public Map<String, Object> getSignFile(int mem_no);

}
