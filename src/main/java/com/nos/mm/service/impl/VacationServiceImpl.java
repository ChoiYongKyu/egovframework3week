package com.nos.mm.service.impl;

import java.io.Console;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.VacationMapper;
import com.nos.mm.service.VacationService;
import com.nos.mm.util.NosMap;

@Service
public class VacationServiceImpl implements VacationService {
	@Autowired
	private VacationMapper vacationMapper;

	/** 휴가등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int insert(NosMap param) throws Exception {
		return vacationMapper.insert(param);
	}

	/** 휴가목록조회
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<NosMap> selectList() throws Exception {
		return vacationMapper.selectList();
	}

	/** 휴가정보조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public NosMap selectOne(NosMap param) throws Exception {
		return vacationMapper.selectOne(param);
	}

	/** 휴가수정
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int update(NosMap param) throws Exception {
		return vacationMapper.update(param);
	}
	
	/** 휴가삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public int delete(NosMap param) throws Exception {
		return vacationMapper.delete(param);
	}
	
	/** 휴가캘린더
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<NosMap> allListForCalendar() throws Exception {
		List<NosMap> result;
		result = vacationMapper.allListForCalendar();
		
		for (int i = 0; i < result.size(); i++) {

			Object tempobj = "\"" + result.get(i).getString("startdt") + "\"";
			result.get(i).remove("startdt");
			System.out.println(tempobj);
			result.get(i).put("startDate", tempobj);

			tempobj = "\"" + result.get(i).getString("enddt") + "\"";
			result.get(i).remove("enddt");
			result.get(i).put("endDate", tempobj);
			
		}
		System.out.println(result);
		return result;
		
	}
}