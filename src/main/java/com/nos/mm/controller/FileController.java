package com.nos.mm.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.FileService;

@Controller
@RequestMapping("/file")
public class FileController {

	private final static Logger logger = Logger.getLogger(FileController.class);

	@Autowired
	private FileService service;

	@RequestMapping("/download")
	public ModelAndView fileDownload(@RequestParam("no") int no, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView("etc/closeView");
		
		service.downloadFile(no, response);

		return mav;
	}

	@ResponseBody
	@RequestMapping("/delete")
	public void fileDelete(@RequestParam("no") int no) throws Exception {
		service.deleteFile(no);
	}
	
	
	
	
	@ResponseBody
	@RequestMapping("/upload")
	public void fileUpload(@RequestParam Map<String, Object> input, @RequestParam("Files") List<MultipartFile> files)
			throws Exception {
		System.out.println(input.toString());
		logger.debug(input.toString());
		logger.debug(input);
		logger.debug(files);
		
		service.uploadFile(Integer.valueOf(input.get("no").toString()), files, input.get("table").toString());
	}
}
