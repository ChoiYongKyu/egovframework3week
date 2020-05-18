package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("GroupMapper")
public interface GroupMapper {
	
	public List<Map<String, Object>> groupDetail(int mn_group_no);

}
