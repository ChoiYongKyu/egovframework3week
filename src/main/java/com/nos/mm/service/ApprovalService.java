package com.nos.mm.service;

import java.util.List;

import com.nos.mm.util.NosMap;

public interface ApprovalService {
	/**
	 * 결재등록
	 * 
	 * @param param
	 * @throws Exception
	 */
	public int insert(NosMap param) throws Exception;

	/**
	 * 결재수신목록 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<NosMap> selectReceivedList(NosMap param) throws Exception;

	/**
	 * 결재상신목록 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<NosMap> selectReportedList(NosMap param) throws Exception;

	/**
	 * 결재보관목록 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<NosMap> selectStoredList(NosMap param) throws Exception;

	/**
	 * 휴가결재정보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public NosMap selectOneVacationApproval(NosMap param) throws Exception;

	/**
	 * 품의결재정보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public NosMap selectOneConsultationApproval(NosMap param) throws Exception;

	/**
	 * 비용처리결재정보 조회
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public NosMap selectOneExpenseApproval(NosMap param) throws Exception;

	/**
	 * 결재상태변경
	 * 
	 * @param param
	 * @param isPersonCheck
	 * @return
	 * @throws Exception
	 */
	public int updateAprvStat(NosMap param, boolean isPersonCheck) throws Exception;

	/**
	 * 결재알림
	 * 
	 * @param nosMap
	 * @param aprvStat
	 * @throws Exception
	 */

	public void approvalNitification(NosMap nosMap, String aprvStat) throws Exception;
}
