package com.nos.mm.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.ExpenseMapper;
import com.nos.mm.service.ExpenseService;
import com.nos.mm.util.NosMap;

@Service
public class ExpenseServiceImpl implements ExpenseService {

	private final int postPerPage = 10; // 페이지당 글 개수 
	private final int pagePerBlock = 5; // 블록당 페이지 개수 
	
	@Autowired
	private ExpenseMapper expenseMapper;
	
	@Override
	/**
	 * 비용처리 목록
	 * @param authentication
	 * @param param
	 * @return
	 */
	public NosMap selectList(Map<String, Object> param) {

		int page = Integer.parseInt(param.get("page") != null ? (String)param.get("page") : "1");
		NosMap nosMap = new NosMap(param);
		nosMap.put("page", page);
		nosMap.put("postPerPage", postPerPage);
		List<NosMap> list = expenseMapper.selectList(nosMap);
		
		if(list.size() > 0) {
			
			int totCnt = Integer.parseInt(String.valueOf(list.get(0).get("count")));
			int totPage = (int) Math.ceil(totCnt / (double)postPerPage);
			int blockFirst = (page / pagePerBlock) + 1;
			int blockLast = ((int) Math.ceil(page / (double)pagePerBlock)) * pagePerBlock;
			blockLast = blockLast < totPage ? blockLast : totPage;
			
			int prevPage = blockFirst > pagePerBlock ? blockFirst - 1 : 0;
			int nextPage = blockLast < totPage ? blockLast + 1 : 0;
			
			nosMap.put("list", list);
			nosMap.put("totCnt", totCnt);
			nosMap.put("blockFirst", blockFirst);
			nosMap.put("blockLast", blockLast);
			nosMap.put("prevPage", prevPage);
			nosMap.put("nextPage", nextPage);
		}
		
		return nosMap;
	}
	
	/**
	 * 비용처리 상세보기
	 * @param param
	 * @return
	 */
	public NosMap selectOne(Map<String, Object> param) {
		NosMap info = new NosMap();
		info.put("exDtl", expenseMapper.selectOne(param));
		info.put("exDtlList", expenseMapper.selectDtlList(param));
		
		return info;
	}
	
	/**
	 * 비용처리 등록
	 * @param nosMap
	 * @param request
	 * @return
	 */
	public int insert(NosMap nosMap, HttpServletRequest request) {
		
		int result = expenseMapper.insert(nosMap);
		
		String[] dtm = request.getParameterValues("dtm");
		String[] usage = request.getParameterValues("usage");
		String[] content = request.getParameterValues("content");
		String[] person = request.getParameterValues("person");
		String[] money = request.getParameterValues("money");
		String[] etc = request.getParameterValues("etc");
		String[] purpose = request.getParameterValues("purpose");
		String[] approver = request.getParameterValues("approver");
		
		for(int i = 0; i < dtm.length; i++) {
			NosMap dtlMap = new NosMap();
			dtlMap.put("dtm", dtm[i]);
			dtlMap.put("usage", usage[i]);
			dtlMap.put("content", content[i]);
			dtlMap.put("money", money[i]);
			dtlMap.put("etc", etc[i]);
			dtlMap.put("category", nosMap.getString("category"));
			dtlMap.put("exNo", nosMap.get("exNo"));
			
			if("EX01".equals(nosMap.get("category")) || "EX02".equals(nosMap.get("category"))) {
				dtlMap.put("person", person[i]);
			} else if("EX03".equals(nosMap.get("category"))){
				dtlMap.put("purpose", purpose[i]);
			}
			
			expenseMapper.insertDetail(dtlMap);
		}
		
		
		return result;
	}
	
	/**
	 * 비용처리 수정
	 * @param nosMap
	 * @param request
	 * @return
	 */
	public int update(NosMap nosMap, HttpServletRequest request) {
		
		String[] dtm = request.getParameterValues("dtm");
		String[] usage = request.getParameterValues("usage");
		String[] content = request.getParameterValues("content");
		String[] person = request.getParameterValues("person");
		String[] money = request.getParameterValues("money");
		String[] etc = request.getParameterValues("etc");
		String[] purpose = request.getParameterValues("purpose");
		String[] approver = request.getParameterValues("approver");
		
		expenseMapper.deleteDetail(nosMap);
		
		for(int i = 0; i < dtm.length; i++) {
			NosMap dtlMap = new NosMap();
			dtlMap.put("dtm", dtm[i]);
			dtlMap.put("usage", usage[i]);
			dtlMap.put("content", content[i]);
			dtlMap.put("money", money[i]);
			dtlMap.put("etc", etc[i]);
			dtlMap.put("category", nosMap.getString("category"));
			dtlMap.put("exNo", nosMap.get("exNo"));
			
			if("EX01".equals(nosMap.get("category")) || "EX02".equals(nosMap.get("category"))) {
				dtlMap.put("person", person[i]);
			} else if("EX03".equals(nosMap.get("category"))){
				dtlMap.put("purpose", purpose[i]);
			}
			
			expenseMapper.insertDetail(dtlMap);
		}
		
		int result = expenseMapper.update(nosMap);
		
		return result;
	}
	
	/**
	 * 비용처리 삭제
	 * @param param
	 * @return
	 */
	public int delete(Map<String, Object> param) {
		NosMap nosMap = new NosMap(param);
		return expenseMapper.delete(nosMap);
	};
}