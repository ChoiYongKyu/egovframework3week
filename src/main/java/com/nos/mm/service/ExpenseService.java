package com.nos.mm.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.nos.mm.util.NosMap;

public interface ExpenseService {

	/**
	 * 비용처리 목록
	 * @param authentication
	 * @param param
	 * @return
	 */
	public NosMap selectList(Map<String, Object> param);
	
	/**
	 * 비용처리 상세보기
	 * @param param
	 * @return
	 */
	public NosMap selectOne(Map<String, Object> param);

	/**
	 * 비용처리 등록
	 * @param nosMap
	 * @param request
	 * @return
	 */
	public int insert(NosMap nosMap, HttpServletRequest request);
	
	/**
	 * 비용처리 수정
	 * @param nosMap
	 * @param request
	 * @return
	 */
	public int update(NosMap nosMap, HttpServletRequest request);
	
	/**
	 * 비용처리 삭제
	 * @param param
	 * @return
	 */
	public int delete(Map<String, Object> param);
}
