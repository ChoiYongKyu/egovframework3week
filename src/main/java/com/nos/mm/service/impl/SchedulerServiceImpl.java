package com.nos.mm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.SchedulerMapper;
import com.nos.mm.service.SchedulerService;
import com.nos.mm.util.EmailSender;

@Service
public class SchedulerServiceImpl implements SchedulerService{
	@Autowired
	private SchedulerMapper schedulerMapper;
	@Autowired
	private EmailSender emailSender;
	
	public List<Map<String, Object>> selectSendEmail() {	
		emailSender.sendMN(schedulerMapper.selectSendEmail());
		
		return null;
	}
}
