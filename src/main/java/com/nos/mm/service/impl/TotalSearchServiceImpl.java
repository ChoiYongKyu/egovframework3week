package com.nos.mm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.apache.poi.xssf.usermodel.XSSFDataValidationConstraint;
import org.apache.poi.xssf.usermodel.XSSFDataValidationHelper;
import org.apache.poi.xssf.usermodel.XSSFName;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.nos.mm.mapper.BugreportMapper;
import com.nos.mm.mapper.ClientMapper;
import com.nos.mm.mapper.ExcelMapper;
import com.nos.mm.mapper.MaintenanceMapper;
import com.nos.mm.mapper.TotalSearchMapper;
import com.nos.mm.mapper.TroubleMapper;
import com.nos.mm.service.ExcelService;
import com.nos.mm.service.TotalSearchService;
import com.nos.mm.util.FileUpload;

@Service
public class TotalSearchServiceImpl implements TotalSearchService {

	@Autowired
	private TotalSearchMapper mapper;

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> totalSearch(Map<String, Object> map) {
		Map<String, Object> result = new HashMap<>();
		result.put("trouble", mapper.troubleSearch(map));
		result.put("bugreport", mapper.bugReportSearch(map));
		result.put("client", mapper.clientSearch(map));
		result.put("maintenance", mapper.maintenanceSearch(map));

		System.out.println(result.get("trouble"));
		System.out.println(result.get("bugreport"));
		System.out.println(result.get("client"));
		System.out.println(result.get("maintenance"));

		Map<String, Object> countmap = new HashMap<>();
		List<Map<String, Object>> list = (List<Map<String, Object>>) result.get("trouble");
		try {	countmap.put("trCount", list.get(0).get("COUNT"));} catch (Exception e) {countmap.put("trCount",0);}
		
		
		list = (List<Map<String, Object>>) result.get("bugreport");
		try {	countmap.put("bgCount", list.get(0).get("COUNT"));} catch (Exception e) {countmap.put("bgCount",0);}
		
		
		list = (List<Map<String, Object>>) result.get("client");
		try {	countmap.put("clCount", list.get(0).get("COUNT"));} catch (Exception e) {countmap.put("clCount",0);}
		
		
		list = (List<Map<String, Object>>) result.get("maintenance");
		try {	countmap.put("mnCount", list.get(0).get("COUNT"));} catch (Exception e) {countmap.put("mnCount",0);}

		System.out.println(countmap.toString());

		result.put("count", countmap);
		return result;

	}

}
