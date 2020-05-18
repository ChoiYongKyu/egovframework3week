package com.nos.mm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.ConsultationMapper;
import com.nos.mm.service.ConsultationService;
import com.nos.mm.util.NosMap;

@Service
public class ConsultationServiceImpl implements ConsultationService {
	@Autowired
	private ConsultationMapper consultationMapper;

	/** 품의등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int insert(NosMap param) throws Exception {
		return consultationMapper.insert(param);
	}

	/** 품의목록조회
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<NosMap> selectList() throws Exception {
		return consultationMapper.selectList();
	}

	/** 품의정보조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public NosMap selectOne(NosMap param) throws Exception {
		return consultationMapper.selectOne(param);
	}

	/** 품의수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int update(NosMap param) throws Exception {
		return consultationMapper.update(param);
	}
	
	/** 품의삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int delete(NosMap param) throws Exception {
		return consultationMapper.delete(param);
	}
}