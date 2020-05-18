package com.nos.mm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.BugreportMapper;
import com.nos.mm.service.BugreportService;
import com.nos.mm.util.EmailSender;

@Service
public class BugreportServiceImpl implements BugreportService {

	private static final int list_size = 10;
	private static final int paging_size = 5;

	private final static Logger logger = Logger.getLogger(BugreportServiceImpl.class);

	@Autowired
	private BugreportMapper mapper;
	@Autowired
	private EmailSender emailSender;

	@Override
	public List<Map<String, Object>> getClient() {
		return mapper.getClient();
	}

	@Override
	public List<Map<String, Object>> getProduct(Map<String, Object> value) {
		return mapper.getProduct(value);
	}

	@Override
	public List<Map<String, Object>> getVersion(Map<String, Object> value) {
		return mapper.getVersion(value);
	}

	@Override
	public void insert(Map<String, Object> value) {
		mapper.insert(value);
		value.put("board_category", "bugreport");
		emailSender.registerMail(value);
	}

	@Override
	public Map<String, Object> getList(int page, String searchText) {
		Map<String, Object> result = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("list_size", list_size);
		map.put("searchText", searchText);
		logger.debug("map = " + map.toString());
		List<Map<String, Object>> list = mapper.getList(map);
		result.put("list", list);
		logger.debug("result = " + result.toString());
		int totalClient = 0;
		if (!list.isEmpty()) {
			totalClient = Integer.valueOf(list.get(0).get("COUNT").toString());
		}
		int totalPage = (int) Math.ceil((double) totalClient / list_size);

		result.put("lastPage", totalPage);

		int prevPaging = page > ((double) paging_size / 2) + 1 ? page - (int) ((double) paging_size / 2) - 1 : -1;
		int nextPaging = page < totalPage - ((double) paging_size / 2) ? page + (int) ((double) paging_size / 2) + 1
				: -1;

		result.put("half", paging_size / 2);
		result.put("prevPaging", prevPaging);
		result.put("nextPaging", nextPaging);
		return result;

	}

	@Override
	public Map<String, Object> getDetail(int no) {
		return mapper.getDetail(no);
	}

	@Override
	public void insertReply(Map<String, Object> value) {
		mapper.insertReply(value);
	}

	@Override
	public List<Map<String, Object>> getReply(int no) {
		return mapper.getReply(no);
	}

	@Override
	public void deleteReply(int no) {
		mapper.deleteReply(no);
	}

	@Override
	public void modifyReply(Map<String, Object> value) {
		logger.debug(value.toString());
		mapper.modifyReply(value);
	}

	@Override
	public Map<String, Object> getModify(int no) {
		logger.debug("bugreport getModify"+mapper.getModify(no));
		return mapper.getModify(no);
	}

	@Override
	public void insertModify(Map<String, Object> value) {
		mapper.insertModify(value);
	}

	@Override
	public void doDelete(int no) {
		mapper.doDelete(no);
	}

}
