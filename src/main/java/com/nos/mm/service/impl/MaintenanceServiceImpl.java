package com.nos.mm.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nos.mm.mapper.MaintenanceMapper;
import com.nos.mm.service.MaintenanceService;
import com.nos.mm.util.EmailSender;
import com.nos.mm.vo.ClientVO;
import com.nos.mm.vo.MaintenanceVO;

@Service
public class MaintenanceServiceImpl implements MaintenanceService {

	 private static final int list_size = 10;
	 private static final int paging_size = 5;
	 final static Logger logger = Logger.getLogger(MaintenanceService.class);

	@Autowired
	private MaintenanceMapper mapper;
	@Autowired
	private EmailSender mailSender;
	
	public Map<String, Object> getList(int page, int searchCategory, String searchText, String sortName, String doneSort) {

		// Map<String, Object> map = new HashMap<String, Object>();
		// map.put("page", page);
		// map.put("list_size", list_size);
		//
		// List<MaintenanceVO> list = mapper.getList(map);
		//
		// map.put("list", list);
		// int totalMember =
		// Integer.valueOf(String.valueOf(list.get(0).get("COUNT")));
		// int totalPage = (int)Math.ceil((double)totalMember / list_size);
		//
		// map.put("lastPage", totalPage);
		//
		// int prevPaging = page > ((double)paging_size / 2) + 1 ? page -
		// (int)((double)paging_size / 2) - 1 : -1;
		// int nextPaging = page < totalPage - ((double)paging_size / 2) ? page
		// + (int)((double)paging_size / 2) + 1 : -1;
		//
		// map.put("half", paging_size / 2);
		// map.put("prevPaging", prevPaging);
		// map.put("nextPaging", nextPaging);
		// return list;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("list_size", list_size);
		map.put("searchCategory", searchCategory);
		map.put("searchText", searchText);
		map.put("sortName", sortName);
		map.put("doneSort", doneSort);
		
		System.out.println(map);
		// System.out.println(map.get("page"));
		// System.out.println(map.get("searchCategory"));
		// System.out.println(map.get("searchText"));
		List<Map<String, Object>> list = mapper.getList(map);

		map.put("list", list);
		int totalMaintenance = 0;
		if(!list.isEmpty()) {
			totalMaintenance = Integer.valueOf(list.get(0).get("COUNT").toString());
		}
		int totalPage = (int)Math.ceil((double)totalMaintenance / list_size);
		
		map.put("lastPage", totalPage);
		
		int prevPaging = page > ((double)paging_size / 2) + 1 ? page - (int)((double)paging_size / 2) - 1 : -1;
		int nextPaging = page < totalPage - ((double)paging_size / 2) ? page + (int)((double)paging_size / 2) + 1 : -1;
		
		map.put("half", paging_size / 2);
		map.put("prevPaging", prevPaging);
		map.put("nextPaging", nextPaging);
		
		return map;
	}

	public List<Map<String, Object>> searchList(int searchCategory, String searchText) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchCategory", searchCategory);
		map.put("searchText", searchText);
		// System.out.println(map.toString());
		return mapper.searchList(map);
	}

	public Map<String, Object> getDetail(int no) {
		Map<String, Object> result = new HashMap<>();
		result.put("detail", mapper.getDetail(no));
		result.put("fileList", mapper.getFileList(no));//list<map>
		logger.debug(result.get("detail").toString()+"++"+result.get("fileList").toString());
		return result;
	}

	public List<Map<String, Object>> getDetailImg(int no) {
		return mapper.getDetailImg(no);
	}

	public List<MaintenanceVO> modify(int no) {
		return mapper.modify(no);
	}

	public int insert(Map<String, Object> map) throws Exception {
		map.put("mem_no", map.get("mem_no"));
		map.put("req_no", map.get("req_no2"));
		Map<String, Object> email = new HashMap<>();
		mapper.insert(map);
		email = map;
//		mapper.registerMail(email);
		//		이미지 입력함수 안씀
//		imgInsertFunction(map, file);
		logger.debug(email.toString());
		mailSender.registerMail(email);
		return Integer.valueOf(String.valueOf(map.get("mn_no")));
	}

	public List<ClientVO> getClientList() {
		return mapper.getClientList();
	}

	public List<Map<String, Object>> getReq(int client) {
		return mapper.getReq(client);
	}

	public List<Map<String, Object>> getWorkScope(int client) {
		return mapper.getWorkScope(client);
	}

	public void pass(Map<String, Object> map) {
		String reqNo[] = ((String) map.get("req_no")).split(",");

		for (int i = 0; i < reqNo.length; i++) {
			// System.out.println(reqNo[i]);
			if (!reqNo[i].equals("")) {
				Map<String, Integer> splitMap = new HashMap<String, Integer>();
				splitMap.put("req_no", Integer.valueOf(reqNo[i]));
				splitMap.put("mn_no", Integer.valueOf(String.valueOf(map.get("mn_no"))));
				// System.out.println(splitMap.toString());

				mapper.pass(splitMap);
			}
		}

		// System.out.println(map);

		///////////
		// MultipartHttpServletRequest multipartHttpServletRequest =
		// (MultipartHttpServletRequest)request;
		// Iterator<String> iterator =
		// multipartHttpServletRequest.getFileNames();
		// MultipartFile multipartFile = null;
		// while(iterator.hasNext()){
		// multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		// if(!multipartFile.isEmpty()){
		// System.out.println("-------------------------------------file");
		// System.out.println("name : "+multipartFile.getName());
		// System.out.println("filename : " +
		// multipartFile.getOriginalFilename());
		// System.out.println("filesize : " + multipartFile.getSize());
		// System.out.println("-------------------------------------file end");
		// }

		// }

	}

	public int update(Map<String, Object> map, List<MultipartFile> file) throws Exception {

		mapper.update(map);
		// System.out.println("--------------------------" + file.size() +
		// "--------------------------" + file.isEmpty());
//이미지 입력함수 안씀
//		imgInsertFunction(map, file);

		return Integer.valueOf(String.valueOf(map.get("mn_no")));
	}

	public void updatePass(Map<String, Object> map) {
		String reqNo[] = ((String) map.get("req_no")).split(",");
		for (int i = 0; i < reqNo.length; i++) {
			// System.out.println(reqNo[i]);
			if (!reqNo[i].equals("")) {
				Map<String, Integer> splitMap = new HashMap<String, Integer>();
				splitMap.put("req_no", Integer.valueOf(reqNo[i]));
				splitMap.put("mn_no", Integer.valueOf(String.valueOf(map.get("mn_no"))));
				// System.out.println(splitMap.toString());

				mapper.updatePass(splitMap);
			}
		}

		// System.out.println(map);
	}

	public void doDelete(int no) throws Exception {
		mapper.doDelete(no);
		// 실제 이미지 파일 이동
		List<Map<String, Object>> list = mapper.imgSelectForDel(no);
		// 실제 파일 삭제
		String filePath = "C:\\iw-ojt\\download\\";
		for (int i = 0; i < list.size(); i++) {
			String fileName = filePath + (String) list.get(i).get("UPLOAD_AFTER");
			fileMove(fileName);
		}
		mapper.imgDelete(no);

	}

	public void deleteImg(String upload_after) throws Exception {

		mapper.imgDeleteOne(upload_after);

		// // 실제 파일 이동
		String filePath = "C:\\iw-ojt\\download\\" + upload_after;
		File file = new File(filePath);

		if (file.exists()) {
			fileMove(filePath);
		} else {
			logger.warn("file not found");
		}
		/// 실제 파일 이동 끝
		// 파일 데이터 베이스 삭제
	}

	// public int count() {
	// return 0;
	//
	// }
	public List<Map<String, Object>> selectListForCalendar(Map<String, Object> map) {
		List<Map<String, Object>> result;
		if (map.get("auth_no").toString().equals("1")) {
			result = mapper.allListForCalendar();
		} else {
			result = mapper.selectListForCalendar(map);
		}
		//
		for (int i = 0; i < result.size(); i++) {

			Object tempobj = "\"" + result.get(i).get("start_date") + "\"";
			result.get(i).remove("start_date");
			result.get(i).put("start_date", tempobj);

			tempobj = "\"" + result.get(i).get("end_date") + "\"";
			result.get(i).remove("end_date");
			result.get(i).put("end_date", tempobj);
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> getGroup(int mem_no) {
		return mapper.getGroup(mem_no);
	}

	@Override
	public int replyInsert(Map<String, Object> map, List<MultipartFile> file) throws Exception {
		// Map<String, Object> map = new HashMap<String, Object>();
		//
		// map.put("mn_no", vo.getMn_no());
		// map.put("mn_sup_item", vo.getMn_sup_item());
		// map.put("mn_reference", vo.getMn_reference());
		// map.put("mn_req_date", vo.getMn_req_date());
		// map.put("mn_sup_days", vo.getMn_sup_days());
		// map.put("mn_start_date", vo.getMn_start_date());
		// map.put("mn_end_date", vo.getMn_end_date());
		// map.put("del_yn", vo.getMn_del_yn());
		// map.put("mem_no", vo.getMem_no());
		// map.put("mn_group_no", vo.getMn_group_no());
		// map.put("client_no", vo.getClient_no());
		// map.put("support_no", vo.getSupport_no());
		// map.put("work_scope_no", vo.getWork_scope_no());
		// map.put("write_date", vo.getWrite_date());
		// map.put("parent_no", vo.getParent_no());
		//
		// map.put("chkVal", chkVal);
		// map.put("pathNo", Integer.valueOf(String.valueOf(pathNo)));
		// System.out.println("서비스 pathNo = " + pathNo);

		mapper.replyInsert(map);
//		이미지 입력
//		imgInsertFunction(map, file);
		return Integer.valueOf(String.valueOf(map.get("mn_no")));
	}

	@Override
	public void replyPass(Map<String, Object> map) {
		String reqNo[] = ((String) map.get("req_no")).split(",");
		for (int i = 0; i < reqNo.length; i++) {
			// System.out.println(reqNo[i]);
			if (!reqNo[i].equals("")) {
				Map<String, Integer> splitMap = new HashMap<String, Integer>();
				splitMap.put("mn_no", Integer.valueOf(String.valueOf(map.get("mn_no"))));
				splitMap.put("req_no", Integer.valueOf(reqNo[i]));
				splitMap.put("pathNo", Integer.valueOf(String.valueOf(map.get("pathNo"))));

				mapper.replyPass(splitMap);
			}
		}
	}

	// 삭제시 백업폴더로 파일 이동
	public void fileMove(String inFileName) throws Exception {

		DateFormat df = new SimpleDateFormat("yyMM");
		Date dateToday = new Date();
		String todayMY = df.format(dateToday);
		String chkDir = "C:\\iw-ojt\\download_back\\" + todayMY;
		File chkDirs = new File(chkDir);

		if (!chkDirs.isDirectory()) {
			chkDirs.mkdirs();
		}

		String outFileName = chkDir + "\\" + inFileName.split("\\\\")[inFileName.split("\\\\").length - 1];
		File file = new File(inFileName);
		File newFile = new File(outFileName);
		if (file.exists())
			file.renameTo(newFile);

	}

	// 이미지 입력 함수
	//	안씀
	public void imgInsertFunction(Map<String, Object> map, List<MultipartFile> file) throws Exception {
		if (file.get(0).getSize() == 0)
			return;
		for (int i = 0; i < file.size(); i++) {
			Map<String, Object> imgmap = new HashMap<>();
			String extension = file.get(i).getOriginalFilename()
					.split("\\.")[file.get(i).getOriginalFilename().split("\\.").length - 1];
			String modifiedFileName = String.valueOf(System.currentTimeMillis()) + "s"
					+ String.valueOf((int) (Math.random() * 300) + 1);
			// 파일이름과 확장자
			modifiedFileName += "." + extension;

			byte[] fileByte = file.get(i).getBytes();
			File name = new File("C:\\iw-ojt\\download\\" + modifiedFileName);
			FileOutputStream fos = new FileOutputStream(name);
			fos.write(fileByte);
			fos.close();

			imgmap.put("upload_before", file.get(i).getOriginalFilename());
			imgmap.put("upload_after", modifiedFileName);

			int mn_no = (int) map.get("mn_no");
			imgmap.put("mn_no", mn_no);
			mapper.imgInsert(imgmap);
		}
	}

	@Override
	public List<Map<String, Object>> getMemberList() {
		return mapper.getMemberList();
	}

	@Override
	public List<Map<String, Object>> getClient() {
		return mapper.getClient();
	}
	
//	@Override
//	public List<Map<String, Object>> getClientStats(int cNo, int page) {
//		return mapper.getClientStats(cNo, page);
//	}
	
	@Override
	public Map<String, Object> getClientStats(int cNo, int page, int workScope, int supportName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cNo", cNo);
		map.put("page", page);
		map.put("workScope", workScope);
		map.put("supportName", supportName);
		map.put("list_size", list_size);
		logger.debug("서비스 = " + map);
		List<Map<String, Object>> list = mapper.getClientStats(map);

		map.put("list", list);
		int totalMaintenance = 0;
		if(!list.isEmpty()) {
			totalMaintenance = Integer.valueOf(list.get(0).get("COUNT").toString());
		}
		int totalPage = (int)Math.ceil((double)totalMaintenance / list_size);
		
		map.put("lastPage", totalPage);
		
		int prevPaging = page > ((double)paging_size / 2) + 1 ? page - (int)((double)paging_size / 2) - 1 : -1;
		int nextPaging = page < totalPage - ((double)paging_size / 2) ? page + (int)((double)paging_size / 2) + 1 : -1;
		
		map.put("half", paging_size / 2);
		map.put("prevPaging", prevPaging);
		map.put("nextPaging", nextPaging);
		
		return map;
	}

	@Override
	public List<Map<String, Object>> getSupportName() {
		return mapper.getSupportName();
	}
	
	public Map<String, Object> gerProjectList(int page, Integer searchSort, String keyword) {
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("page", page);
		returnMap.put("list_size", list_size);
		returnMap.put("searchSort", searchSort);
		returnMap.put("keyword", keyword);
		
		List<Map<String, Object>> data = mapper.gerProjectList(returnMap);
		int total = data.size() != 0 ? Integer.parseInt(data.get(0).get("TOTAL").toString()) : 0; // 전체 프로젝트 수
		int lastPage = (int)Math.ceil((double)total / list_size); // 총 페이지 수
		int prevPaging = page > ((double)paging_size / 2) + 1 ? page - (int)((double)paging_size / 2) - 1 : -1; // <<버튼
		int nextPaging = page < lastPage - ((double)paging_size / 2) ? page + (int)((double)paging_size / 2) + 1 : -1; // >>버튼

		returnMap.put("pj_list", data);
		returnMap.put("prev_paging", prevPaging);
		returnMap.put("next_paging", nextPaging);
		returnMap.put("half", paging_size / 2);
		returnMap.put("lastPage", lastPage);
		
		return returnMap;
		
	}
	
	public List<Map<String, Object>> getProjectScope(int client) {
		return mapper.getProjectScope(client);
	}
	
	public void projectRegister(Map<String, Object> data, int[] pjScopeNo, int[] userNo, String[] userStartDate, String[] userEndDate) {

		mapper.projectRegister(data);

		Map<String, Object> joinData = new HashMap<String, Object>();
		for(int i = 0; i < userNo.length; i++) {
			joinData.put("pj_no", Integer.parseInt(data.get("pj_no").toString()));
			joinData.put("mem_no", userNo[i]);
			joinData.put("mem_start_date", userStartDate[i]);
			joinData.put("mem_end_date", userEndDate[i]);
			
			mapper.projectJoinRegister(joinData);
		}
		
		Map<String, Object> typeData = new HashMap<String, Object>();
		for(int scopeNo : pjScopeNo) {
			typeData.put("pj_no", Integer.parseInt(data.get("pj_no").toString()));
			typeData.put("pj_type", scopeNo);
			
			mapper.projectTypeRegister(typeData);
		}
	};
	
	public Map<String, Object> getProjectView(int no) {
		Map<String, Object> pjData = mapper.pjData(no); // 프로젝트 정보
		List<Map<String, Object>> pjType = mapper.pjType(no); // 프로젝트 구분
		List<Map<String, Object>> pjJoin = mapper.pjJoin(no); // 프로젝트 참가자
		
		pjData.put("pj_type", pjType);
		pjData.put("pj_join", pjJoin);
		
		return pjData;
	};
	
	public boolean projectDelete(int no) {
		if(mapper.pjDelete(no) > 0 && mapper.pjTypeDelete(no) > 0 && mapper.pjJoinDelete(no) > 0) 
			return true;
		else
			return false;
	};
	
	public void projectModify(int no, Map<String, Object> data, int[] pjScopeNo, int[] userNo, String[] userStartDate, String[] userEndDate) {
		
		// 기존 구분, 멤버 삭제
		mapper.pjTypeDelete(no);
		mapper.pjJoinDelete(no);
		
		data.put("no", no);
		mapper.projectModify(data);

		Map<String, Object> joinData = new HashMap<String, Object>();
		for(int i = 0; i < userNo.length; i++) {
			joinData.put("pj_no", no);
			joinData.put("mem_no", userNo[i]);
			joinData.put("mem_start_date", userStartDate[i]);
			joinData.put("mem_end_date", userEndDate[i]);
			
			mapper.projectJoinRegister(joinData);
		}
		
		Map<String, Object> typeData = new HashMap<String, Object>();
		for(int scopeNo : pjScopeNo) {
			typeData.put("pj_no", no);
			typeData.put("pj_type", scopeNo);
			
			mapper.projectTypeRegister(typeData);
		}
	}
	
	public String getMembers(int no) {
		ObjectMapper om = new ObjectMapper();
		try {
			String json = om.writeValueAsString(mapper.pjJoin(no));
			return json;
		} catch (JsonProcessingException e) {
			logger.error(e);
			return null;
		}
	}

	@Override
	public void uploadFile(int no, List<MultipartFile> files, String table) throws IOException {
		if (files.get(0).getSize() == 0)
			return;
		for (MultipartFile file : files) {
			Map<String, Object> imgmap = new HashMap<>();
			String extension = file.getOriginalFilename()
					.split("\\.")[file.getOriginalFilename().split("\\.").length - 1];
			String modifiedFileName = String.valueOf(System.currentTimeMillis()) + "s"
					+ String.valueOf((int) (Math.random() * 300) + 1);
			// 파일이름과 확장자
			modifiedFileName += "." + extension;

			byte[] fileByte = file.getBytes();
			File name = new File("C:\\iw-ojt\\download\\" + modifiedFileName);
			FileOutputStream fos = new FileOutputStream(name);
			fos.write(fileByte);
			fos.close();

			imgmap.put("upload_before", file.getOriginalFilename());
			imgmap.put("upload_after", modifiedFileName);
			imgmap.put("upload_connect", no);
			imgmap.put("upload_table", table);
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+file.getOriginalFilename());
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+modifiedFileName);
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+no);
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+table);
			
			mapper.insertFile(imgmap);
		}
	}
	
	
}
