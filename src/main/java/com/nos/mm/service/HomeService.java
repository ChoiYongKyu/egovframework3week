package com.nos.mm.service;

import java.util.List;
import java.util.Map;

import com.nos.mm.util.NosMap;

public interface HomeService {
	
	public Object getChart(Map<String, String> map);

	public int memCount();

	public int clientCount();

	public int maintenanceCount();

	public List<Map<String, Object>> chartList();
	
	public Map<String, Object> getWeather(Map<String, Object> value);
	
	public void setWeather(Map<String, Object> value);

	public int receiveCount(NosMap member);
	
}
