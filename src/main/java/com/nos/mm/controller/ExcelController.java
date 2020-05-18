package com.nos.mm.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.nos.mm.service.ExcelService;

@Controller
@RequestMapping("/maintenance/excel")
public class ExcelController {

	private static Logger logger = LoggerFactory.getLogger(ExcelController.class);

	@Autowired
	private ExcelService excelService;

	@ResponseBody
	@RequestMapping("/download")
	public void download(HttpServletResponse response) throws Exception {

		XSSFWorkbook workbook = excelService.download();

		try {
			response.setHeader("Set-Cookie", "fileDownload=true; path=/"); // 없어도
																			// 되는데...
			String name = new String("유지보수작성양식.xlsx".getBytes("UTF-8"), "ISO-8859-1");
			response.setHeader("Content-Disposition", String.format("attachment; filename=\'" + name + "'"));
			workbook.write(response.getOutputStream());
		} catch (IOException e) {
			logger.info("error :::: IOException :::: " + e);
		} finally {
			try {
				workbook.close();
			} catch (IOException e) {
				logger.info("error :::: workbook close :::: " + e);
			}
		}

	}
	
	
	@ResponseBody
	@RequestMapping("/export")
	public void export(HttpServletResponse response) throws Exception {

		XSSFWorkbook workbook = excelService.download();

		try {
			response.setHeader("Set-Cookie", "fileDownload=true; path=/"); // 없어도
																			// 되는데...
			String name = new String("유지보수.xlsx".getBytes("UTF-8"), "ISO-8859-1");
			response.setHeader("Content-Disposition", String.format("attachment; filename=\'" + name + "'"));
			workbook.write(response.getOutputStream());
		} catch (IOException e) {
			logger.info("error :::: IOException :::: " + e);
		} finally {
			try {
				workbook.close();
			} catch (IOException e) {
				logger.info("error :::: workbook close :::: " + e);
			}
		}

	}
	
	
	
	

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public ModelAndView upload(@RequestParam("excelFile") MultipartFile file) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/maintenance/list");

		excelService.upload(file);

		return mav;
	}
}
