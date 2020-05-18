package com.nos.mm.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.HomeMapper;
import com.nos.mm.service.HomeService;
import com.nos.mm.util.NosMap;

@Service
public class HomeServiceImpl implements HomeService {

	@Autowired
	private HomeMapper homeMapper;

	public Object getChart(Map<String, String> map) {

		// 현재 월수 구하기

		Calendar cal = Calendar.getInstance();
		// System.out.println(cal.get(Calendar.MONTH));

		cal.setTime(new Date());
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat format2 = new SimpleDateFormat("MM");
		String date1 = format1.format(cal.getTime());

		String year = date1.substring(0, 4);
		String month = date1.substring(5, 7);
		int month2 = Integer.valueOf(format2.format(cal.getTime()));

		// 월별, 분기별, 연별 체크
		int periodCheck = 0;
		String period = "";
		String periodQuarter = "";

		switch (Integer.valueOf(map.get("period"))) {

		case 0: // 월별
			periodCheck = 0;
			period = year + "-" + month;
			break;
		case 1: // 분기별
			periodCheck = 1;
			int mon = (int) ((Math.ceil(month2 / 3.0) - 1) * 3) + 1;
			int monQuarter = (int) ((Math.ceil(month2 / 3.0) - 1) * 3) + 4;
			if (mon == 10) {
				period = year + "-" + mon;
				periodQuarter = year + "-" + monQuarter;

			} else {
				period = year + "-0" + mon;
				periodQuarter = year + "-0" + monQuarter;
			}
			break;
		case 2: // 연별
			periodCheck = 2;
			period = String.valueOf(year);
			break;
		}

		map.put("periodCheck", String.valueOf(periodCheck));
		map.put("period", period);
		map.put("periodQuarter", periodQuarter);

		// 개인별, 그룹별 체크
		if (Integer.valueOf(map.get("grpchk")) == 0) { // 개인별
			return homeMapper.getPersonChart(map);
		} else { // 그룹별
			List<Integer> getGroupNoList = homeMapper.getGroupNo(map); // 자신이 속한
																		// 그룹
																		// 구하기

			List<List<Map<String, Object>>> getGroupInfoList = new ArrayList<List<Map<String, Object>>>();

			for (int i = 0; i < getGroupNoList.size(); i++) {
				map.put("mn_group_no", String.valueOf(getGroupNoList.get(i)));
				getGroupInfoList.add(homeMapper.getGroupChart(map));
			}

			return getGroupInfoList;
		}
	}
	
	
	@Override
	public int receiveCount(NosMap member) {
		// TODO Auto-generated method stub
		return homeMapper.receiveCount(member);
	}

	@Override
	public int memCount() {
		return homeMapper.memCount();
	}

	@Override
	public int clientCount() {
		return homeMapper.clientCount();
	}

	@Override
	public int maintenanceCount() {
		return homeMapper.maintenanceCount();
	}

	@Override
	public List<Map<String, Object>> chartList() {
		return homeMapper.chartList();
	}

	@Override
	public Map<String, Object> getWeather(Map<String, Object> value) {
		Map<String, Object> weather = homeMapper.getWeather();
		Map<String, Object> result = new HashMap<>();
		result.put("weatherModifyCode", weather.get("WEATHERMODIFYCODE"));
		result.put("weatherModifyDescription", weather.get("WEATHERMODIFYDESCRIPTION"));
		result.put("weatherStatusCode", weather.get("WEATHERSTATUSCODE"));
		result.put("weatherStatusDescription", weather.get("WEATHERSTATUSDESCRIPTION"));
		result.put("timestamp", weather.get("TIMESTAMP"));
		return result;
	}

	@Override
	public void setWeather(Map<String, Object> value) {
		homeMapper.setWeather(value);
	}

	

}
