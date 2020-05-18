package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nos.mm.util.NosMap;

@Repository("ExpenseMapper")
public interface ExpenseMapper {

	/**
	 * 비용처리 목록
	 * @param authentication
	 * @param param
	 * @return
	 */
	public List<NosMap> selectList(Map<String, Object> param);
	
	/**
	 * 비용처리 상세보기
	 * @param param
	 * @return
	 */
	public NosMap selectOne(Map<String, Object> param);
	
	/**
	 * 비용처리 내역 목록
	 * @param param
	 * @return
	 */
	public List<NosMap> selectDtlList(Map<String, Object> param);
	
	/**
	 * 비용처리 등록
	 * @param param
	 * @return
	 */
	public int insert(NosMap param);

	/**
	 * 비용처리 내역 등록
	 * @param param
	 * @return
	 */
	public int insertDetail(NosMap param);

	/**
	 * 비용처리 수정
	 * @param param
	 * @return
	 */
	public int update(NosMap param);
	
	/**
	 * 비용처리 내역 삭제
	 * @param param
	 * @return
	 */
	public int deleteDetail(NosMap param);
	
	/**
	 * 비용처리 삭제
	 * @param param
	 * @return
	 */
	public int delete(NosMap param);
}