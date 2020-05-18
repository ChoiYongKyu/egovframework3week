package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nos.mm.util.NosMap;

@Repository("HomeMapper")
public interface HomeMapper {
	
	public List<Map<String, Object>> getPersonChart(Map<String, String> map);
	public List<Integer> getGroupNo(Map<String, String> map);
	public List<Map<String, Object>> getGroupChart(Map<String, String> map);
	public int memCount();
	public int clientCount();
	public int maintenanceCount();
	public List<Map<String, Object>> chartList();
	public Map<String, Object> getWeather();
	public void setWeather(Map<String, Object> value);
	public int receiveCount(NosMap member);
}
