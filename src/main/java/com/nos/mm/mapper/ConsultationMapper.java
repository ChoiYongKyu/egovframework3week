package com.nos.mm.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.nos.mm.util.NosMap;

@Repository("ConsultationMapper")
public interface ConsultationMapper {
	/** 품의등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insert(NosMap param) throws Exception;

	/** 품의목록조회
	 * @return
	 * @throws Exception
	 */
	public List<NosMap> selectList() throws Exception;

	/** 품의정보조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public NosMap selectOne(NosMap param) throws Exception;

	/** 품의수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int update(NosMap param) throws Exception;

	/** 품의삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int delete(NosMap param) throws Exception;
}