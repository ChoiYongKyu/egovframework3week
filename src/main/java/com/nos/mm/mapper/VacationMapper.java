package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nos.mm.util.NosMap;

@Repository("VacationMapper")
public interface VacationMapper {
	/** 휴가등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int insert(NosMap param) throws Exception;

	/** 휴가목록조회
	 * @return
	 * @throws Exception
	 */
	public List<NosMap> selectList() throws Exception;

	/** 휴가정보조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public NosMap selectOne(NosMap param) throws Exception;

	/** 휴가수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int update(NosMap param) throws Exception;

	/** 휴가삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int delete(NosMap param) throws Exception;
	
	/** 휴가캘린더
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<NosMap> allListForCalendar() throws Exception;
}