package com.nos.mm.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

public class FileUpload {
	
	final static Logger logger = Logger.getLogger(FileUpload.class);
	
	public static Map<String, Object> changeFileName(MultipartFile file) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		String originalName = file.getOriginalFilename();
		String newName = System.currentTimeMillis() + ".xlsx";
		
		map.put("upload_before", originalName);
		map.put("upload_after", newName);
		
		File filePath = new File("C:\\iw-ojt\\download\\" + newName);
		
		byte[] fileByte = null;
		FileOutputStream fos = null;
		
		try {
			fileByte = file.getBytes();
			fos = new FileOutputStream(filePath);
			fos.write(fileByte);
			fos.close();
		} catch (IOException e) {
			
		} 
	
		return map;
	}
	
	@SuppressWarnings("resource")
	public static List<Map<String, Object>> extractData(MultipartFile file) {
		
		File filePath = new File(file.getOriginalFilename());

		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>(); // 여러 row 데이터 저장
		
		try {
			filePath.createNewFile();
			FileOutputStream fos = new FileOutputStream(filePath);
			fos.write(file.getBytes());
			fos.close();
			
			XSSFWorkbook workbook = new XSSFWorkbook(filePath);
			XSSFSheet sheet = workbook.getSheetAt(0);
			
			int i = 2;
			// row 읽기
			while(sheet.getRow(i).getPhysicalNumberOfCells() > 8) {
				XSSFRow row = sheet.getRow(i);
				
				if(row == null) {
					break;
				}
				
				Map<String, Object> map = new HashMap<String, Object>(); // row 데이터 저장

				int columnTotal = row.getPhysicalNumberOfCells(); // 총 column의 수
				if(columnTotal < 12) {
					map.put("mn_reference", "");
				}
				
				// cell(column) 읽기
				for(int j = 0; j < columnTotal; j++) {
					XSSFCell cell = row.getCell(j);
					if(columnTotal < 15) {
						map.put("mn_reference", "");
					}
//					System.out.println("------------------------------" + columnTotal);
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					switch(j) {
					case 0:
						break;
					case 1:
						break;
					case 2:
						break;
					case 3:
						map.put("mn_req_date", format.format(cell.getDateCellValue()));
						break;
					case 4:
						break;
					case 5:
						map.put("mem_name", cell.getStringCellValue());
						break;
					case 6:
						map.put("mn_start_date", format.format(cell.getDateCellValue()));
						break;
					case 7:
						map.put("mn_end_date", format.format(cell.getDateCellValue()));
						break;
					case 8:
						map.put("mn_sup_days", cell.getNumericCellValue());
						break;
					case 9:
						map.put("mn_sup_item", cell.getStringCellValue());
						break;
					case 10:
						map.put("client_no", cell.getNumericCellValue());
						break;
					case 11:
						map.put("work_scope_no", cell.getNumericCellValue());
						break;
					case 12:
						map.put("support_no", cell.getNumericCellValue());
						break;
					case 13:
						map.put("reg_name_no", cell.getNumericCellValue());
						break;
					case 14:
						if(cell.getStringCellValue() == null) {
							map.put("mn_reference", ""); // map에는 null이 되지만 마이바티스에선 진짜 null을 인식 못함, ""처럼 가짜null로 해줘야 null로 인식
							break;
						} else {
							map.put("mn_reference", cell.getStringCellValue());
							break;
						}
					}
				}
				list.add(map);
				i++;
//				System.out.println(list.toString());
			}
		} catch (Exception e) {
			logger.warn("error =========== " + e);
		}
		
		return list;
		
	}

}
