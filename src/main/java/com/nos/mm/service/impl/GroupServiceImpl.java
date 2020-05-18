package com.nos.mm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.GroupMapper;
import com.nos.mm.service.GroupService;

@Service
public class GroupServiceImpl implements GroupService {

	@Autowired
	private GroupMapper groupMapper;
	
	public List<Map<String, Object>> groupDetail(int mn_group_no) {
		
		return groupMapper.groupDetail(mn_group_no);
	}
}
