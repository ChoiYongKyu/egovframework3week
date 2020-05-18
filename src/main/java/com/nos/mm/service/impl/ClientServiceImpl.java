package com.nos.mm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.ClientMapper;
import com.nos.mm.service.ClientService;

@Service
public class ClientServiceImpl implements ClientService {
	
	private static final int list_size = 20;
	private static final int paging_size = 5;
	
	@Autowired
	private ClientMapper mapper;

	
	public Map<String, Object> getList(int page, int searchCategory, String searchText) {
		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("page", page);
//		map.put("list_size", list_size);
//		
//		List<Map<String, Object>> list = mapper.getList(map);
//		
//		map.put("list", list);
//		int totalMember = Integer.valueOf(String.valueOf(list.get(0).get("COUNT")));
//		int totalPage = (int)Math.ceil((double)totalMember / list_size);
//		
//		map.put("lastPage", totalPage);
//		
//		int prevPaging = page > ((double)paging_size / 2) + 1 ? page - (int)((double)paging_size / 2) - 1 : -1;
//		int nextPaging = page < totalPage - ((double)paging_size / 2) ? page + (int)((double)paging_size / 2) + 1 : -1;
//		
//		map.put("half", paging_size / 2);
//		map.put("prevPaging", prevPaging);
//		map.put("nextPaging", nextPaging);
//		
//		System.out.println(map);
//		return map;
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("list_size", list_size);
		map.put("searchCategory", searchCategory);
		map.put("searchText", searchText);
		
//		System.out.println(map.get("page"));
//		System.out.println(map.get("searchCategory"));
//		System.out.println(map.get("searchText"));
		List<Map<String, Object>> list = mapper.getList(map);
		
		map.put("list", list);
		
		int totalClient = 0;
		if(!list.isEmpty()) {
			totalClient = Integer.valueOf(list.get(0).get("COUNT").toString());
		}
		int totalPage = (int)Math.ceil((double)totalClient / list_size);
		
		map.put("lastPage", totalPage);
		
		int prevPaging = page > ((double)paging_size / 2) + 1 ? page - (int)((double)paging_size / 2) - 1 : -1;
		int nextPaging = page < totalPage - ((double)paging_size / 2) ? page + (int)((double)paging_size / 2) + 1 : -1;
		
		map.put("half", paging_size / 2);
		map.put("prevPaging", prevPaging);
		map.put("nextPaging", nextPaging);
		
		return map;
	}
	
//	public List<Map<String, Object>> searchList(int searchCategory, String searchText) {
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("searchCategory", searchCategory);
//		map.put("searchText", searchText);
//		System.out.println(map.toString());
//		return mapper.searchList(map);
//	}
	public Map<String, Object> getDetail(int no) {
		Map<String, Object> result = new HashMap<>();
		result.put("fileList", mapper.getFileList(no));//list<map>
		result.put("detail", mapper.getDetail(no));//list<map>
		result.put("workScope", mapper.getDetailWork(no));//list<map>
		return result;
	}
	
	public void insert(Map<String, Object> value, List<Integer> chk) throws Exception{
		mapper.insert(value); // 클라이언트 정보만
		
		for(int i = 0; i < chk.size(); i++) {
			int work_scope_no = chk.get(i);
//			System.out.println(work_scope_no);
			mapper.wsInsert(work_scope_no, Integer.valueOf(String.valueOf(value.get("client_no"))));
		}
		
		mapper.reqInsert(value);
		
		// 제품 등록 테스트 //
//		System.out.println("----------------------" + reqMap.toString() + "-----------------------");
//		mapper.useProductInsert(reqMap);
//		
//		reqMap.put("version_no", value.get("version_no"));
//		mapper.licenseInsert(reqMap);
	}
	
	public Map<String, Object> modify(int no) {
		Map<String, Object> result = new HashMap<>();
		result.put("work", mapper.getDetailWork(no));
		result.put("detail", mapper.getDetail(no));
		return result;	
	}
	
	public void clientUpdate(Map<String, Object> value) {
//		System.out.println(value.toString());
		mapper.clientUpdate(value);
	}
	
	public void doDelete(int no){
		mapper.doDelete(no);
	}
	
	public void reqInfoInsert(Map<String, Object> value) {
		mapper.reqInfoInsert(value);
	}
	
	public void wsUpdate(Map<String, Object> value, List<Integer> chk) {
		mapper.wsUpdate(Integer.valueOf(String.valueOf(value.get("client_no"))));
		for(int i = 0; i < chk.size(); i++) {
			int work_scope_no = chk.get(i);
			System.out.println("들어오나요~" + work_scope_no);
			mapper.wsInsert(work_scope_no, Integer.valueOf(String.valueOf(value.get("client_no"))));
		}
	}

	@Override
	public List<Map<String, Object>> getProductList() {
		
		return mapper.getProductList();
	}

	@Override
	public List<Map<String, Object>> getVersion(int productNo) {
		return mapper.getVersion(productNo);
	}

	@Override
	public void reqUpdate(Map<String, Object> value) {
		mapper.reqUpdate(value);
	}

	@Override
	public List<Map<String, Object>> getReqList(int no) {
		return mapper.getReqList(no);
	}

	@Override
	public void rowDelete(int rNo) {
		mapper.rowDelete(rNo);
	}

	@Override
	public void reqInfoModify(Map<String, Object> value) {
		mapper.reqInfoModify(value);
	}

	@Override
	public List<Map<String, Object>> getWorkScope() {
		return mapper.getWorkScope();
	}

	@Override
	public void changeRep(Map<String, Object> map) {
		mapper.initRep(map);
		mapper.changeRep(map);
	}
	
}
