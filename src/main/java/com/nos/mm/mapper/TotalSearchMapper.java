package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("TotalSearchMapper")
public interface TotalSearchMapper {

	List<Map<String, Object>> maintenanceSearch(Map<String, Object> map);

	List<Map<String, Object>> clientSearch(Map<String, Object> map);

	List<Map<String, Object>> bugReportSearch(Map<String, Object> map);

	List<Map<String, Object>> troubleSearch(Map<String, Object> map);

}
