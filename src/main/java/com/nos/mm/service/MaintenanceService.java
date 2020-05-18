package com.nos.mm.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.nos.mm.vo.ClientVO;
import com.nos.mm.vo.MaintenanceVO;

public interface MaintenanceService {

	public Map<String, Object> getList(int page, int searchCategory, String searchText, String sortName, String doneSort);

	public List<Map<String, Object>> searchList(int searchCategory, String searchText);

	public Map<String, Object> getDetail(int no);

	public List<MaintenanceVO> modify(int no);

	public int insert(Map<String, Object> map) throws Exception;

	public List<ClientVO> getClientList();

	public List<Map<String, Object>> getReq(int client);

	public List<Map<String, Object>> getWorkScope(int client);

	public void pass(Map<String, Object> map);

	public int update(Map<String, Object> map, List<MultipartFile> file) throws Exception;

	public void updatePass(Map<String, Object> map);

	public void doDelete(int no) throws Exception;
	
	public void deleteImg(String upload_after) throws Exception;

	public List<Map<String, Object>> selectListForCalendar(Map<String, Object> map);

	public List<Map<String, Object>> getGroup(int mem_no);

	public int replyInsert(Map<String, Object> map, List<MultipartFile> file) throws Exception;

	public void replyPass(Map<String, Object> map);
	
	public List<Map<String, Object>> getDetailImg(int mn_no);

	public List<Map<String, Object>> getMemberList();
	
	public List<Map<String, Object>> getClient();

	public Map<String, Object> getClientStats(int cNo, int page, int workScope, int supportName);

	public List<Map<String, Object>> getSupportName();
	
//	public Map<String, Object> getClientStats(int cNo, int page);
	
	public Map<String, Object> gerProjectList(int page, Integer searchSort, String keyword);
	
	public List<Map<String, Object>> getProjectScope(int client);

	public void projectRegister(Map<String, Object> data, int[] pjScopeNo, int[] userNo, String[] userStartDate, String[] userEndDate);

	public Map<String, Object> getProjectView(int no);

	public boolean projectDelete(int no);

	public void projectModify(int no, Map<String, Object> data, int[] pjScopeNo, int[] userNo, String[] userStartDate, String[] userEndDate);

	public String getMembers(int no);

	public void uploadFile(int no, List<MultipartFile> files, String table) throws IOException;

}
