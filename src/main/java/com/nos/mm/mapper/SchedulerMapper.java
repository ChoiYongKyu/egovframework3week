package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("SchedulerMapper")
public interface SchedulerMapper {
	public List<Map<String, Object>> selectSendEmail();
}
