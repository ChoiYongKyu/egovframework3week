package com.nos.mm.service.impl;

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

import com.nos.mm.mapper.ExcelMapper;
import com.nos.mm.service.ExcelService;
import com.nos.mm.util.FileUpload;

@Service
public class ExcelServiceImpl implements ExcelService {

	@Autowired
	private ExcelMapper excelMapper;
	
	@Override
	public XSSFWorkbook download() {
		
		// 워크북 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// 워크시트 생성
		XSSFSheet sheet = workbook.createSheet();
		// 스타일 생성 (row 1)
		XSSFCellStyle row1 = workbook.createCellStyle();
		row1.setFillForegroundColor(IndexedColors.GOLD.getIndex()); // 셀 색깔
		row1.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 패턴을 줘야 셀 색깔이 적용
		row1.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		// 스타일 생성 (row 2)
		XSSFCellStyle row2 = workbook.createCellStyle();
		row2.setFillForegroundColor(IndexedColors.AQUA.getIndex()); // 셀 색깔
		row2.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 패턴을 줘야 셀 색깔이 적용
		row2.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		// 스타일 생성 (row 3)
		XSSFCellStyle row3 = workbook.createCellStyle();
		row3.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); // 셀 색깔
		row3.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 패턴을 줘야 셀 색깔이 적용
		row3.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
		// 스타일 생성 (default row)
		XSSFCellStyle rowDefault = workbook.createCellStyle();
		rowDefault.setAlignment(HorizontalAlignment.CENTER);
		// 컬럼 사이즈 설정
		sheet.setColumnWidth(0, 3000);
		sheet.setDefaultColumnStyle(0, rowDefault);
		sheet.setColumnWidth(1, 3000);
		sheet.setDefaultColumnStyle(1, rowDefault);
		sheet.setColumnWidth(2, 3000);
		sheet.setDefaultColumnStyle(2, rowDefault);
		sheet.setColumnWidth(3, 3000);
		sheet.setDefaultColumnStyle(3, rowDefault);
		sheet.setColumnWidth(4, 3000);
		sheet.setDefaultColumnStyle(4, rowDefault);
		sheet.setColumnWidth(5, 3000);
		sheet.setDefaultColumnStyle(5, rowDefault);
		sheet.setColumnWidth(6, 5000);
		sheet.setDefaultColumnStyle(6, rowDefault);
		sheet.setColumnWidth(7, 5000);
		sheet.setDefaultColumnStyle(7, rowDefault);
		sheet.setColumnWidth(8, 2000);
		sheet.setDefaultColumnStyle(8, rowDefault);
		sheet.setColumnWidth(9, 10000);
		sheet.setDefaultColumnStyle(9, rowDefault);
		sheet.setColumnWidth(14, 10000);
		sheet.setDefaultColumnStyle(14, rowDefault);

		// 로우 생성
		XSSFRow row;
		// 셀 생성
		XSSFCell cell;
		
		// 컬럼숨기기
		sheet.setColumnHidden(10, true);
		sheet.setColumnHidden(11, true);
		sheet.setColumnHidden(12, true);
		sheet.setColumnHidden(13, true);
		
		// row 1 내용 입력
		row = sheet.createRow(0);
		
		cell = row.createCell(0);
		cell.setCellStyle(row1);
		cell.setCellValue("고객사");
		cell = row.createCell(1);
		cell.setCellStyle(row1);
		cell.setCellValue("업무구분");
		cell = row.createCell(2);
		cell.setCellStyle(row1);
		cell.setCellValue("지원형태");
		cell = row.createCell(3);
		cell.setCellStyle(row1);
		cell.setCellValue("지원요청일");
		cell = row.createCell(4);
		cell.setCellStyle(row1);
		cell.setCellValue("지원요청자");
		cell = row.createCell(5);
		cell.setCellStyle(row1);
		cell.setCellValue("작업담당자");
		cell = row.createCell(6);
		cell.setCellStyle(row1);
		cell.setCellValue("지원시작일");
		cell = row.createCell(7);
		cell.setCellStyle(row1);
		cell.setCellValue("지원종료일");
		cell = row.createCell(8);
		cell.setCellStyle(row1);
		cell.setCellValue("지원일수");
		cell = row.createCell(9);
		cell.setCellStyle(row1);
		cell.setCellValue("지원항목");
		cell = row.createCell(10); // client_no
		cell = row.createCell(11); // work_scope_no
		cell = row.createCell(12); // support_no
		cell = row.createCell(13); // requestor_no
		cell = row.createCell(14);
		cell.setCellStyle(row1);
		cell.setCellValue("참조사항");
		
		// row 2 내용 입력
		row = sheet.createRow(1);
		cell = row.createCell(0);
		cell.setCellStyle(row2);
		cell.setCellValue("나인원");
		cell = row.createCell(1);
		cell.setCellStyle(row2);
		cell.setCellValue("기술지원");
		cell = row.createCell(2);
		cell.setCellStyle(row2);
		cell.setCellValue("방문");
		cell = row.createCell(3);
		cell.setCellStyle(row2);
		cell.setCellValue("2018-04-21");
		cell = row.createCell(4);
		cell.setCellStyle(row2);
		cell.setCellValue("홍길동");
		cell = row.createCell(5);
		cell.setCellStyle(row2);
		cell.setCellValue("이순신");
		cell = row.createCell(6);
		cell.setCellStyle(row2);
		cell.setCellValue("2018-04-22 09:00");
		cell = row.createCell(7);
		cell.setCellStyle(row2);
		cell.setCellValue("2018-04-22 16:00");
		cell = row.createCell(8);
		cell.setCellStyle(row2);
		cell.setCellValue(1);
		cell = row.createCell(9);
		cell.setCellStyle(row2);
		cell.setCellValue("xxx 기능 추가");
		cell = row.createCell(14);
		cell.setCellStyle(row2);
		cell.setCellValue("에러사항 해결");
		
		// 카테고리 새로운 방식 데이터 추출
		List<Map<String, Object>> list = excelMapper.getClient(); // 유지보수 관련 데이터
		
		// 고객사 정보 저장용 sheet
		XSSFSheet category = workbook.createSheet("고객사"); 

		// 총 고객사
		XSSFCell clientCell = category.createRow(0).createCell(0); 
		clientCell.setCellStyle(row1);
		clientCell.setCellValue("고객사 목록");
		// 총 고객자 저장하는 row
		XSSFRow clientName = category.createRow(1); // 이름
		XSSFRow clientNo = category.createRow(2); // 번호

		// 총 업무
		XSSFCell allWSCell = category.createRow(4).createCell(0); 
		allWSCell.setCellStyle(row1);
		allWSCell.setCellValue("업무 목록");
		// 총 업무 저장하는 row
		XSSFRow allWSName = category.createRow(5); // 이름
		XSSFRow allWSNo = category.createRow(6); // 번호
		
		// 총 지원형태
		XSSFCell allSupCell = category.createRow(8).createCell(0); 
		allSupCell.setCellStyle(row1);
		allSupCell.setCellValue("지원형태 목록");
		// 총 지원형태 저장하는 row
		XSSFRow allSupName = category.createRow(9); // 이름
		XSSFRow allSupNo = category.createRow(10); // 번호
		
		// 총 지원요청자
		XSSFCell allReqCell = category.createRow(12).createCell(0); 
		allReqCell.setCellStyle(row1);
		allReqCell.setCellValue("지원요청자 목록");
		// 총 지원요청자 저장하는 row
		XSSFRow allReqName = category.createRow(13); // 이름
		XSSFRow allReqNo = category.createRow(14); // 번호

		// 이름 생성 (고객사)
		XSSFName nameClient = workbook.createName();
		nameClient.setNameName("고객사");
		nameClient.setRefersToFormula("고객사!$A$2:$" + ((char) (97 + list.size() - 1)) + "$2");
		
		for(int i = 0; i < list.size(); i++) {
			
			int client_no = Integer.valueOf(String.valueOf(list.get(i).get("CLIENT_NO")));
			
			List<Map<String, Object>> listReq = excelMapper.getRequestor(client_no);
			List<Map<String, Object>> listWS = excelMapper.getWorkScope(client_no);
			
			list.get(i).put("requestor", listReq);
			
			// 총 고객사 목록
			XSSFCell clientNameCell = clientName.createCell(i);
			XSSFCell clientNoCell = clientNo.createCell(i);
			clientNameCell.setCellStyle(row2);
			clientNameCell.setCellValue(String.valueOf(list.get(i).get("CLIENT_NAME")));
			clientNoCell.setCellStyle(row3);
			clientNoCell.setCellValue(String.valueOf(list.get(i).get("CLIENT_NO")));
			
			// 각 고객사별 sheet
			XSSFSheet clientSheet = workbook.createSheet(String.valueOf(list.get(i).get("CLIENT_NAME")));
			
			XSSFCell reqCell = clientSheet.createRow(0).createCell(0); // 지원요청자
			reqCell.setCellStyle(row1);
			reqCell.setCellValue("지원요청자");
			
			XSSFRow reqName = clientSheet.createRow(1); // 지원요청자 이름 저장하는 row
			XSSFRow reqNo = clientSheet.createRow(2); // 지원요청자 번호 저장하는 row
			
			XSSFCell WSCell = clientSheet.createRow(4).createCell(0); // 업무
			WSCell.setCellStyle(row1);
			WSCell.setCellValue("업무");
			
			XSSFRow WSName = clientSheet.createRow(5); // 업무 이름 저장하는 row
			XSSFRow WSNo = clientSheet.createRow(6); // 업무 번호 저장하는 row
			
			// 지원요청자 정보를 sheet에 저장
			for(int j = 0; j < listReq.size(); j++) {
				XSSFCell reqNameCell = reqName.createCell(j);
				XSSFCell reqNoCell = reqNo.createCell(j);
				reqNameCell.setCellStyle(row2);
				reqNameCell.setCellValue(String.valueOf(listReq.get(j).get("REQ_NAME")));
				reqNoCell.setCellStyle(row3);
				reqNoCell.setCellValue(String.valueOf(listReq.get(j).get("REQ_NO")));
			}
			
			// 업무 정보를 sheet에 저장
			for(int j = 0; j < listWS.size(); j++) {
				XSSFCell WSNameCell = WSName.createCell(j);
				XSSFCell WSNoCell = WSNo.createCell(j);
				WSNameCell.setCellStyle(row2);
				WSNameCell.setCellValue(String.valueOf(listWS.get(j).get("WORK_SCOPE_NAME")));
				WSNoCell.setCellStyle(row3);
				WSNoCell.setCellValue(String.valueOf(listWS.get(j).get("WORK_SCOPE_NO")));
			}
			
			// 이름 생성 (지원요청자)
			XSSFName nameReq = workbook.createName();
			nameReq.setNameName(list.get(i).get("CLIENT_NAME") + "_지원요청자");
			nameReq.setRefersToFormula(list.get(i).get("CLIENT_NAME") + "!$A$2:$" + ((char) (97 + listReq.size() - 1)) + "$2");
			
			// 이름 생성 (업무)
			XSSFName nameWS = workbook.createName();
			nameWS.setNameName(list.get(i).get("CLIENT_NAME") + "_업무");
			nameWS.setRefersToFormula(list.get(i).get("CLIENT_NAME") + "!$A$6:$" + ((char) (97 + listWS.size() - 1)) + "$6");
			
		}
		
		// 총 업무 목록
		List<Map<String, Object>> listAllWS = excelMapper.getAllWS();
		for(int i = 0; i < listAllWS.size(); i++) {
			XSSFCell allWSNameCell = allWSName.createCell(i);
			XSSFCell allWSNoCell = allWSNo.createCell(i);
			allWSNameCell.setCellStyle(row2);
			allWSNameCell.setCellValue(String.valueOf(listAllWS.get(i).get("WORK_SCOPE_NAME")));
			allWSNoCell.setCellStyle(row3);
			allWSNoCell.setCellValue(String.valueOf(listAllWS.get(i).get("WORK_SCOPE_NO")));
		}
		
		// 총 지원요청자 목록
		List<Map<String, Object>> listAllReq = excelMapper.getAllReq(); 
		for(int i = 0; i < listAllReq.size(); i++) {
			XSSFCell allReqNameCell = allReqName.createCell(i);
			XSSFCell allReqNoCell = allReqNo.createCell(i);
			allReqNameCell.setCellStyle(row2);
			allReqNameCell.setCellValue(String.valueOf(listAllReq.get(i).get("REQ_NAME")));
			allReqNoCell.setCellStyle(row3);
			allReqNoCell.setCellValue(String.valueOf(listAllReq.get(i).get("REQ_NO")));
		}
		
		// 총 지원형태 목록
		List<Map<String, Object>> listAllSup = excelMapper.getAllSup(); 
		for(int i = 0; i < listAllSup.size(); i++) {
			XSSFCell allSupNameCell = allSupName.createCell(i);
			XSSFCell allSupNoCell = allSupNo.createCell(i);
			allSupNameCell.setCellStyle(row2);
			allSupNameCell.setCellValue(String.valueOf(listAllSup.get(i).get("SUPPORT_NAME")));
			allSupNoCell.setCellStyle(row3);
			allSupNoCell.setCellValue(String.valueOf(listAllSup.get(i).get("SUPPORT_NO")));
		}
		
		// 이름 생성 (지원형태)
		XSSFName nameSup = workbook.createName();
		nameSup.setNameName("지원형태");
		nameSup.setRefersToFormula("고객사!$A$10:$" + ((char) (97 + listAllSup.size() - 1)) + "$10");
		
		// 대분류(고객사)
		XSSFDataValidationHelper helper = new XSSFDataValidationHelper(sheet);
		
		XSSFDataValidationConstraint constraint = (XSSFDataValidationConstraint) helper.createFormulaListConstraint("INDIRECT(\"고객사\")");
		CellRangeAddressList addressList = new CellRangeAddressList(2, 10, 0, 0);
		XSSFDataValidation vali = (XSSFDataValidation) helper.createValidation(constraint, addressList);
		vali.setSuppressDropDownArrow(true);
		vali.setShowErrorBox(true);
		sheet.addValidationData(vali);
		
		// 중분류(업무구분)
		constraint = (XSSFDataValidationConstraint) helper.createFormulaListConstraint("INDIRECT($A3&\"_업무\")");
		addressList = new CellRangeAddressList(2, 10, 1, 1);
		vali = (XSSFDataValidation) helper.createValidation(constraint, addressList);
		vali.setSuppressDropDownArrow(true);
		vali.setShowErrorBox(true);
		sheet.addValidationData(vali);

		// 중분류(지원요청자)
		constraint = (XSSFDataValidationConstraint) helper.createFormulaListConstraint("INDIRECT($A3&\"_지원요청자\")");
		addressList = new CellRangeAddressList(2, 10, 4, 4);
		vali = (XSSFDataValidation) helper.createValidation(constraint, addressList);
		vali.setSuppressDropDownArrow(true);
		vali.setShowErrorBox(true);
		sheet.addValidationData(vali);

		// 중분류(지원형태)
		constraint = (XSSFDataValidationConstraint) helper.createFormulaListConstraint("INDIRECT(\"지원형태\")");
		addressList = new CellRangeAddressList(2, 10, 2, 2);
		vali = (XSSFDataValidation) helper.createValidation(constraint, addressList);
		vali.setSuppressDropDownArrow(true);
		vali.setShowErrorBox(true);
		sheet.addValidationData(vali);
		
		// lookup
		for(int i = 2; i < 11; i++) {
			XSSFRow lookupRow = sheet.createRow(i);
			lookupRow.createCell(10).setCellFormula("hlookup($A" + (i + 1) + ", 고객사!$A$2:$" + ((char) (97 + list.size() - 1)) + "$3, 2, false)");
			lookupRow.createCell(11).setCellFormula("hlookup($B" + (i + 1) + ", 고객사!$A$6:$" + ((char) (97 + listAllWS.size() - 1)) + "$7, 2, false)");
			lookupRow.createCell(12).setCellFormula("hlookup($C" + (i + 1) + ", 고객사!$A$10:$" + ((char) (97 + listAllSup.size() - 1)) + "$11, 2, false)");
			
			String data = "";
			int maxNo = 0;

			for(Map<String, Object> j : list) {
				int client_no = Integer.valueOf(j.get("CLIENT_NO").toString());
				maxNo = maxNo > client_no ? maxNo : client_no;
			};
			
			for(int j = 0, k = 1; k <= maxNo; k++) {
				if(Integer.valueOf(String.valueOf(list.get(j).get("CLIENT_NO"))) == k) {
					data += "HLOOKUP($E, " + list.get(j).get("CLIENT_NAME") + "!$A$2:$" + ((char) (97 + ((List<?>)list.get(j).get("requestor")).size() - 1)) + "$3, 2),";
					j++;
				} else {
					data += ", ";
				}
			}
			
//			int k = 1;
//			while(true) {
//				if(Integer.valueOf(String.valueOf(list.get(j).get("CLIENT_NO"))) == k) {
//					data += "HLOOKUP($E, " + list.get(j).get("CLIENT_NAME") + "!$A$2:$" + ((char) (97 + ((List<?>)list.get(j).get("requestor")).size() - 1)) + "$3, 2),";
//					j++;
//					k++;
//				} else {
//					data += ", ";
//					k++;
//				}
//				if(list.size() == j) {
//					break;
//				}
//			}
			
			StringBuffer sb = new StringBuffer(data);
			for(int l = 0; l < list.size(); l ++) {
				int order = sb.indexOf("$E,") + 2;
				sb.insert(order, (i + 1));
			}
			lookupRow.createCell(13).setCellFormula("choose($K" + (i + 1) + ", " + sb + ")");
		}
		
//		// 카테고리 방식1 데이터 추출
//		List<Map<String, Object>> list = excelMapper.getClient(); // 유지보수 관련 데이터
//		
//		for(int i = 0; i < list.size(); i++) {
//			
//			int client_no = Integer.valueOf(String.valueOf(list.get(i).get("CLIENT_NO")));
//			
//			List<Map<String, Object>> listReq = excelMapper.getRequestor(client_no);
//			List<Map<String, Object>> listWorkScope = excelMapper.getWorkScope(client_no);
//			List<Map<String, Object>> listSupport = excelMapper.getSupport();
//			
//			list.get(i).put("requestor", listReq);
//			list.get(i).put("workScope", listWorkScope);
//			list.get(i).put("support", listSupport);
//		}
//		
//		// 카테고리 방식 1
//		int rowData = 200;
//		for(int i = 0; i < list.size(); i++) {
//
//			XSSFRow client = sheet.createRow(i + 100);
//			client.createCell(0).setCellValue(String.valueOf(list.get(i).get("CLIENT_NAME")) + "_" + String.valueOf(list.get(i).get("CLIENT_NO")));
//        	
//			// 중분류를 위한 것들
//			List<Map<String, Object>> listWS = (List<Map<String, Object>>) list.get(i).get("workScope");
//			List<Map<String, Object>> listReq = (List<Map<String, Object>>) list.get(i).get("requestor");
//			List<Map<String, Object>> listSup = (List<Map<String, Object>>) list.get(i).get("support");
//			
//			// 업무구분 출력
//			XSSFRow WS = sheet.createRow(rowData);
//			for(int j = 0; j < listWS.size(); j++) { // createRow하면 기존의 row의 데이터는 다 사라짐...
//				
//				WS.createCell(j).setCellValue(listWS.get(j).get("WORK_SCOPE_NAME") + "_" + listWS.get(j).get("WORK_SCOPE_NO"));
//			}
//			
//			// 지원요청자 충력
//			XSSFRow req = sheet.createRow(rowData + 1);
//			for(int j = 0; j < listReq.size(); j++) {
//				
//				req.createCell(j).setCellValue(listReq.get(j).get("REQ_NAME") + "_" + listReq.get(j).get("REQ_NO"));
//			}
//			
//			// 지원형태 출력
//			XSSFRow sup = sheet.createRow(rowData + 2);
//			for(int j = 0; j < listSup.size(); j++) {
//				
//				sup.createCell(j).setCellValue(listSup.get(j).get("SUPPORT_NAME") + "_" + listSup.get(j).get("SUPPORT_NO"));
//			}
//			
//			// 업무구분 이름 생성
//			XSSFName nameWS = workbook.createName();
//			nameWS.setNameName(String.valueOf(list.get(i).get("CLIENT_NAME")) + "_" + String.valueOf(list.get(i).get("CLIENT_NO")) + "_업무구분");
//			nameWS.setRefersToFormula("sheet0!$A$" + (rowData + 1) + ":$" + ((char) (97 + listWS.size() - 1)) + "$" + (rowData + 1));
//			
//			// 지원요청자 이름 생성
//			XSSFName nameReq = workbook.createName();
//			nameReq.setNameName(String.valueOf(list.get(i).get("CLIENT_NAME")) + "_" + String.valueOf(list.get(i).get("CLIENT_NO")) + "_지원요청자");
//			nameReq.setRefersToFormula("sheet0!$A$" + (rowData + 2) + ":$" + ((char) (97 + listReq.size() - 1)) + "$" + (rowData + 2));
//
//			// 지원형태 이름 생성
//			XSSFName nameSup = workbook.createName();
//			nameSup.setNameName(String.valueOf(list.get(i).get("CLIENT_NAME")) + "_" + String.valueOf(list.get(i).get("CLIENT_NO")) + "_지원형태");
//			nameSup.setRefersToFormula("sheet0!$A$" + (rowData + 3) + ":$" + ((char) (97 + listSup.size() - 1)) + "$" + (rowData + 3));
//        	
//			rowData += 3;
//        }
//	
//		// 대분류
//		XSSFDataValidationHelper helper = new XSSFDataValidationHelper(sheet);
//		XSSFDataValidationConstraint constraint = (XSSFDataValidationConstraint) helper.createFormulaListConstraint("$A$101:$A$" + (101 + list.size() - 1));
//		CellRangeAddressList addressList = new CellRangeAddressList(2, 99, 1, 1);
//		XSSFDataValidation vali = (XSSFDataValidation) helper.createValidation(constraint, addressList);
//		vali.setSuppressDropDownArrow(true);
//		vali.setShowErrorBox(true);
//		sheet.addValidationData(vali);
//		
//		// 중분류(업무구분)
//		constraint = (XSSFDataValidationConstraint) helper.createFormulaListConstraint("INDIRECT($B3&\"_업무구분\")");
//		addressList = new CellRangeAddressList(2, 99, 2, 2);
//		vali = (XSSFDataValidation) helper.createValidation(constraint, addressList);
//		vali.setSuppressDropDownArrow(true);
//		vali.setShowErrorBox(true);
//		sheet.addValidationData(vali);
//
//		// 중분류(지원요청자)
//		constraint = (XSSFDataValidationConstraint) helper.createFormulaListConstraint("INDIRECT($B3&\"_지원요청자\")");
//		addressList = new CellRangeAddressList(2, 99, 5, 5);
//		vali = (XSSFDataValidation) helper.createValidation(constraint, addressList);
//		vali.setSuppressDropDownArrow(true);
//		vali.setShowErrorBox(true);
//		sheet.addValidationData(vali);
//
//		// 중분류(지원형태)
//		constraint = (XSSFDataValidationConstraint) helper.createFormulaListConstraint("INDIRECT($B3&\"_지원형태\")");
//		addressList = new CellRangeAddressList(2, 99, 3, 3);
//		vali = (XSSFDataValidation) helper.createValidation(constraint, addressList);
//		vali.setSuppressDropDownArrow(true);
//		vali.setShowErrorBox(true);
//		sheet.addValidationData(vali);
		
		return workbook;
	
	}
	
	public void upload(MultipartFile file) {

		List<Map<String, Object>> list = FileUpload.extractData(file); // 엑셀 데이터 추출
		Map<String, Object> map = FileUpload.changeFileName(file); // 엑셀파일 하드디스크에 저장
		for(int i = 0; i < list.size(); i++) {
			Map<String, Object> excelMap = list.get(i);
			
			Integer mem_no = excelMapper.getMem_no(String.valueOf(excelMap.get("mem_name")));
			
			if(mem_no == null) { // 등록되지 않은 작업담당자를 입력했을 경우...
				continue;
			}
			excelMap.put("mem_no", mem_no);
			Integer MNNo = excelMapper.addMN(excelMap);
			if(MNNo != 1) { // 등록 실패시
				continue;
			}
			excelMapper.addReq_manage(excelMap.get("mn_no"), excelMap.get("reg_name_no"));
			map.put("mn_no", excelMap.get("mn_no"));
			excelMapper.addUpload(map);
		}
	}

	@Override
	public XSSFWorkbook export() {
		// TODO Auto-generated method stub
		
		// 워크북 생성
				XSSFWorkbook workbook = new XSSFWorkbook();
				// 워크시트 생성
				XSSFSheet sheet = workbook.createSheet("유지보수리스트");
				// 스타일 생성 (row 1)
				XSSFCellStyle row1 = workbook.createCellStyle();
				row1.setFillForegroundColor(IndexedColors.GOLD.getIndex()); // 셀 색깔
				row1.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 패턴을 줘야 셀 색깔이 적용
				row1.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
				// 스타일 생성 (row 2)
				XSSFCellStyle row2 = workbook.createCellStyle();
				row2.setFillForegroundColor(IndexedColors.AQUA.getIndex()); // 셀 색깔
				row2.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 패턴을 줘야 셀 색깔이 적용
				row2.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
				// 스타일 생성 (row 3)
				XSSFCellStyle row3 = workbook.createCellStyle();
				row3.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex()); // 셀 색깔
				row3.setFillPattern(FillPatternType.SOLID_FOREGROUND); // 패턴을 줘야 셀 색깔이 적용
				row3.setAlignment(HorizontalAlignment.CENTER); // 가운데 정렬
				// 스타일 생성 (default row)
				XSSFCellStyle rowDefault = workbook.createCellStyle();
				rowDefault.setAlignment(HorizontalAlignment.CENTER);
				// 컬럼 사이즈 설정
				sheet.setColumnWidth(0, 3000);
				sheet.setDefaultColumnStyle(0, rowDefault);
				sheet.setColumnWidth(1, 3000);
				sheet.setDefaultColumnStyle(1, rowDefault);
				sheet.setColumnWidth(2, 3000);
				sheet.setDefaultColumnStyle(2, rowDefault);
				sheet.setColumnWidth(3, 3000);
				sheet.setDefaultColumnStyle(3, rowDefault);
				sheet.setColumnWidth(4, 3000);
				sheet.setDefaultColumnStyle(4, rowDefault);
				sheet.setColumnWidth(5, 3000);
				sheet.setDefaultColumnStyle(5, rowDefault);
				sheet.setColumnWidth(6, 5000);
				sheet.setDefaultColumnStyle(6, rowDefault);
				sheet.setColumnWidth(7, 5000);
				sheet.setDefaultColumnStyle(7, rowDefault);
				sheet.setColumnWidth(8, 2000);
				sheet.setDefaultColumnStyle(8, rowDefault);
				sheet.setColumnWidth(9, 10000);
				sheet.setDefaultColumnStyle(9, rowDefault);
				sheet.setColumnWidth(14, 10000);
				sheet.setDefaultColumnStyle(14, rowDefault);

				// 로우 생성
				XSSFRow row;
				// 셀 생성
				XSSFCell cell;
				
				// 컬럼숨기기
				sheet.setColumnHidden(10, true);
				sheet.setColumnHidden(11, true);
				sheet.setColumnHidden(12, true);
				sheet.setColumnHidden(13, true);
				
				// row 1 내용 입력
				row = sheet.createRow(0);
				
				cell = row.createCell(0);
				cell.setCellStyle(row1);
				cell.setCellValue("유지보수번호");
				cell = row.createCell(1);
				cell.setCellStyle(row1);
				cell.setCellValue("고객사");
				cell = row.createCell(2);
				cell.setCellStyle(row1);
				cell.setCellValue("업무구분");
				cell = row.createCell(3);
				cell.setCellStyle(row1);
				cell.setCellValue("지원형태");
				cell = row.createCell(4);
				cell.setCellStyle(row1);
				cell.setCellValue("지원요청일");
				cell = row.createCell(5);
				cell.setCellStyle(row1);
				cell.setCellValue("지원요청자");
				cell = row.createCell(6);
				cell.setCellStyle(row1);
				cell.setCellValue("작업담당자");
				cell = row.createCell(7);
				cell.setCellStyle(row1);
				cell.setCellValue("지원시작일");
				cell = row.createCell(8);
				cell.setCellStyle(row1);
				cell.setCellValue("지원종료일");
				cell = row.createCell(9);
				cell.setCellStyle(row1);
				cell.setCellValue("지원일수");
				cell = row.createCell(10); // client_no
				cell = row.createCell(11); // work_scope_no
				cell = row.createCell(12); // support_no
				cell = row.createCell(13); // requestor_no
				cell = row.createCell(14);
				cell.setCellStyle(row1);
				cell.setCellValue("참조사항");
		
				
				//리스트 불러오기
				List<Map<String, Object>> listAll = excelMapper.getList();
				
				for(int i=0; i <listAll.size() ; i++) {
					//리스트
					row = sheet.createRow(i+1);
					
					cell = row.createCell(i);
					cell.setCellValue(String.valueOf(listAll.get(i).get("REQ_NAME")));
					
		
					//cell.setCellValue("나인원");
					
					cell = row.createCell(1);
					cell.setCellValue("기술지원");
					
					cell = row.createCell(2);
					cell.setCellValue("방문");
					
					cell = row.createCell(3);
					cell.setCellValue("2018-04-21");
					
					cell = row.createCell(4);
					cell.setCellValue("홍길동");
					
					cell = row.createCell(5);
					cell.setCellValue("이순신");
					
					cell = row.createCell(6);
					cell.setCellValue("2018-04-22 09:00");
					
					cell = row.createCell(7);
					cell.setCellValue("2018-04-22 16:00");
					
					cell = row.createCell(8);
					cell.setCellValue(1);
					
					cell = row.createCell(9);
					cell.setCellValue("xxx 기능 추가");
					
					cell = row.createCell(14);
					cell.setCellValue("에러사항 해결");
				}
			
				
				
		
		return workbook;
	}
}
