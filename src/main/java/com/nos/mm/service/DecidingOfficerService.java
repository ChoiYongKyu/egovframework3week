package com.nos.mm.service;

import java.util.List;

import com.nos.mm.util.NosMap;

public interface DecidingOfficerService {
	/** 결재자등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insert(NosMap param) throws Exception;

	/** 결재자복사
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertCopy(NosMap param) throws Exception;

	/** 결재자목록조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<NosMap> selectList(NosMap param) throws Exception;

	/** 결재자삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int delete(NosMap param) throws Exception;

	/** 결재자수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int update(NosMap param) throws Exception;

	/** 모든 결재자 인원수 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int selectAllCnt(NosMap param) throws Exception;

	/** 승인 결재자 인원수 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int selectAprvCnt(NosMap param) throws Exception;

	/** 현재 결재자 ID 조회
	 * @param aprvNo
	 * @return
	 * @throws Exception
	 */
	public String selectOneNowDecidingOfficerId(String aprvNo) throws Exception;

	/** 결재한 결재자 ID 조회
	 * @param aprvNo
	 * @return
	 * @throws Exception
	 */
	public String[] selectListDecidingOfficerId(String aprvNo) throws Exception;

	/** 결재한 결재자 ID 조회(최종결제자 제외)
	 * @param aprvNo
	 * @return
	 * @throws Exception
	 */
	public String[] selectListDecidingOfficerIdLastException(String aprvNo) throws Exception;
}