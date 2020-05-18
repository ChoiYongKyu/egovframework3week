package com.nos.mm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.ImprovementMapper;
import com.nos.mm.mapper.TroubleMapper;
import com.nos.mm.service.ImprovementService;
import com.nos.mm.service.TroubleService;
import com.nos.mm.util.EmailSender;

@Service
public class ImprovementServiceImpl implements ImprovementService {
	
	private static final int list_size = 10;
	private static final int paging_size = 5;
	
	private final static Logger logger = Logger.getLogger(ImprovementServiceImpl.class);
	
	@Autowired
	private ImprovementMapper mapper;

	@Override
	public Map<String, Object> getList(int page, String searchText) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("list_size", list_size);
		map.put("searchText", searchText);
		logger.debug("map = "+map.toString());
		List<Map<String, Object>> list = mapper.getList(map);
		result.put("list", list);
		logger.debug("result = "+result.toString());
		int totalClient = 0;
		if(!list.isEmpty()) {
			totalClient = Integer.valueOf(list.get(0).get("COUNT").toString());
		}
		int totalPage = (int)Math.ceil((double)totalClient / list_size);
		
		result.put("lastPage", totalPage);
		
		int prevPaging = page > ((double)paging_size / 2) + 1 ? page - (int)((double)paging_size / 2) - 1 : -1;
		int nextPaging = page < totalPage - ((double)paging_size / 2) ? page + (int)((double)paging_size / 2) + 1 : -1;
		
		result.put("half", paging_size / 2);
		result.put("prevPaging", prevPaging);
		result.put("nextPaging", nextPaging);
		return result;
		
	}

	@Override
	public void insert(Map<String, Object> value) {
		mapper.insert(value);
	}

	@Override
	public Map<String, Object> getDetail(int no) {
		logger.debug("개선/요구 서비스 = " + no);
		Map<String, Object> result = new HashMap<>();
		result.put("fileList", mapper.getFileList(no));//list<map>
		result.put("detail", mapper.getDetail(no));//list<map>
		return result;
	}

	@Override
	public void doDelete(int no) {
		mapper.doDelete(no);
		
	}

	@Override
	public void insertModify(Map<String, Object> value) {
		mapper.insertModify(value);
	}

	@Override
	public Map<String, Object> getNewImpNo() {
		// TODO Auto-generated method stub
		return mapper.getNewImpNo();
	}

}
