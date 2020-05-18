package com.nos.mm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.DecidingOfficerMapper;
import com.nos.mm.service.DecidingOfficerService;
import com.nos.mm.util.NosMap;

@Service
public class DecidingOfficerServiceImpl implements DecidingOfficerService {

	@Autowired
	private DecidingOfficerMapper decidingOfficerMapper;

	/** 결재자등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int insert(NosMap param) throws Exception {
		return decidingOfficerMapper.insert(param);
	}

	/** 결재자복사
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insertCopy(NosMap param) throws Exception {
		return decidingOfficerMapper.insertCopy(param);
	}

	/** 결재자목록조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<NosMap> selectList(NosMap param) throws Exception {
		return decidingOfficerMapper.selectList(param);
	}

	/** 결재자삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int delete(NosMap param) throws Exception {
		return decidingOfficerMapper.delete(param);
	}

	/** 결재자수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int update(NosMap param) throws Exception {
		return decidingOfficerMapper.update(param);
	}

	/** 모든 결재자 인원수 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int selectAllCnt(NosMap param) throws Exception {
		return decidingOfficerMapper.selectAllCnt(param);
	}

	/** 승인 결재자 인원수 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int selectAprvCnt(NosMap param) throws Exception {
		return decidingOfficerMapper.selectAprvCnt(param);
	}

	/** 현재 결재자 ID 조회
	 * @param aprvNo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String selectOneNowDecidingOfficerId(String aprvNo) throws Exception {
		return decidingOfficerMapper.selectOneNowDecidingOfficerId(aprvNo);
	}
	
	/** 결재한 결재자 ID 조회
	 * @param aprvNo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String[] selectListDecidingOfficerId(String aprvNo) throws Exception {
		return decidingOfficerMapper.selectListDecidingOfficerId(aprvNo);
	}

	/** 결재한 결재자 ID 조회(최종결제자 제외)
	 * @param aprvNo
	 * @return
	 * @throws Exception
	 */
	@Override
	public String[] selectListDecidingOfficerIdLastException(String aprvNo) throws Exception {
		return decidingOfficerMapper.selectListDecidingOfficerIdLastException(aprvNo);
	}
}