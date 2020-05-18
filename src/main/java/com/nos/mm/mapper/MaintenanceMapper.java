package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nos.mm.vo.ClientVO;
import com.nos.mm.vo.MaintenanceVO;

@Repository("MaintenanceMapper") // .xml 이름
public interface MaintenanceMapper {

	public List<Map<String, Object>> getList(Map<String, Object> map);

	public List<Map<String, Object>> searchList(Map<String, Object> map);
	
	public List<Map<String, Object>> getDetail(int no);
	
	public List<MaintenanceVO> modify(int no);
	
	public int insert(Map<String, Object> map);

	public List<ClientVO> getClientList();

	public List<Map<String, Object>> getReq(int client);

	public List<Map<String, Object>> getWorkScope(int client);

	public void pass(Map<String, Integer> splitMap);

	public int count();

	public void update(Map<String, Object> map);

	public void updatePass(Map<String, Integer> splitMap);

	public void doDelete(int no);
	
	public void imgDelete(int no);
	
	public void imgDeleteOne(String file_name);
	
	public List<Map<String, Object>> imgSelectForDel(int no);
	
	public List<Map<String, Object>> getFileList(int no);
	
	
	public List<Map<String, Object>> selectListForCalendar(Map<String, Object> map);

	public List<Map<String, Object>> allListForCalendar();

	public List<Map<String, Object>> getGroup(int mem_no);

	public int replyInsert(Map<String, Object> map);

	public void replyPass(Map<String, Integer> splitMap);

	public void imgInsert(Map<String, Object> imgmap);
	
	public List<Map<String, Object>> getDetailImg(int mem_no);

	public List<Map<String, Object>> getMemberList();

	public void registerMail(Map<String, Object> email);

	public List<Map<String, Object>> getClient();
	
	public List<Map<String, Object>> getClientStats(Map<String, Object> map);

	public List<Map<String, Object>> getSupportName();
	
	public List<Map<String, Object>> gerProjectList(Map<String, Object> map);
	
	public List<Map<String, Object>> getProjectScope(int client);

	public int projectRegister(Map<String, Object> data);
	
	public void projectJoinRegister(Map<String, Object> data);
	
	public void projectTypeRegister(Map<String, Object> data);
	
	// public List<Map<String, Object>> projectView(int project_no); // 무리
	
	public Map<String, Object> pjData(int no);
	
	public List<Map<String, Object>>pjType(int no);
	
	public List<Map<String, Object>> pjJoin(int no);

	public int pjDelete(int no);

	public int pjTypeDelete(int no);
	
	public int pjJoinDelete(int no);

	public void projectModify(Map<String, Object> data);

	public void insertFile(Map<String, Object> imgmap);

}
