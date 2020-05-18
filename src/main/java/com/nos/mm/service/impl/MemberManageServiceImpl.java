package com.nos.mm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.MemberManageMapper;
import com.nos.mm.service.MemberManageService;
import com.nos.mm.util.EmailSender;
import com.nos.mm.util.RandomPW;
import com.nos.mm.util.SaltProduce;
import com.nos.mm.util.ShaPWEncoder;

@Service
public class MemberManageServiceImpl implements MemberManageService {
	
	private static final int list_size = 5;
	private static final int paging_size = 5;

	@Autowired
	private MemberManageMapper memberManageMapper;
	
	@Autowired
	private EmailSender emailSender;
	
	public Map<String, Object> list(int page, String keyword) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("keyword", keyword);
		map.put("list_size", list_size);
		
		List<Map<String, Object>> list = memberManageMapper.list(map);
		
		if(!list.isEmpty()) {
			
			for(int i = 0; i < list.size(); i++) {
				
				int mem_no = Integer.valueOf(String.valueOf(list.get(i).get("MEM_NO")));
				List<Map<String, Object>> groupList = memberManageMapper.getGroup(mem_no);

				String groups = "";
			
				for(int j = 0; j < groupList.size(); j++) {
					groups += String.valueOf(groupList.get(j).get("MN_GROUP_NAME")) + " ";
				}
				
				list.get(i).put("groups", groups);
			}
			
			map.put("list", list);
			
			int totalMember = Integer.valueOf(String.valueOf(list.get(0).get("COUNT")));
			int totalPage = (int)Math.ceil((double)totalMember / list_size);
			
			map.put("lastPage", totalPage);
			
			int prevPaging = page > ((double)paging_size / 2) + 1 ? page - (int)((double)paging_size / 2) - 1 : -1;
			int nextPaging = page < totalPage - ((double)paging_size / 2) ? page + (int)((double)paging_size / 2) + 1 : -1;
			
			map.put("half", paging_size / 2);
			map.put("prevPaging", prevPaging);
			map.put("nextPaging", nextPaging);

		} else {
			map.put("list", null);
			map.put("lastPage", 0);
			map.put("half", paging_size / 2);
			map.put("prevPaging", -1);
			map.put("nextPaging", -1);
		}
		
		return map;
	}
	
	public List<Map<String, Object>> auth() {
		
		return memberManageMapper.auth();
	}
	
	public int changeAuth(Map<String, Object> auth) {
		return memberManageMapper.changhAuth(auth);
	}
	
	public int reset(int mem_no) {
		
		// 랜덤 비밀번호 생성
		String randomPW = RandomPW.randomPW();
		
		// salt 생성
		SaltProduce saltProduce = new SaltProduce();
		String salt = saltProduce.generateSalt(32).toString();
		
		// 암호화
		ShaPWEncoder shaPWEncoder = new ShaPWEncoder();
		shaPWEncoder.setSalt(salt);
		String newPW = shaPWEncoder.encode(randomPW);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_no", mem_no);
		map.put("salt", salt);
		map.put("mem_pw", newPW);
		
//		System.out.println("Random PW : " + randomPW + ", salt : " + salt + ", EncryptedPW : " + newPW);

		int result = memberManageMapper.reset(map);
		
		try {
			
			emailSender.sendEmail(String.valueOf(map.get("mem_id")), randomPW);
			
		} catch (Exception e) {
			
//			System.out.println(e);
			
		}
		
		return result;
	}
	
	public int delete(int mem_no) {
		return memberManageMapper.delete(mem_no);
	}
	
	public List<Map<String, Object>> getAllGroup() {
		return memberManageMapper.getAllGroup();
	}
	
	public Map<String, Object> groupAdd(String mn_group_name) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mn_group_name", mn_group_name);
		memberManageMapper.groupAdd(map);
		
//		System.out.println(map.toString());
//		System.out.println(); // 셀력트키 쓰면 setter를 이용해서 map에도 알아서 넣어줌!!
//		System.out.println(map.toString());
		
		return map;
	}
	
	public int groupDelMem(int mem_no, int grp_no) {
		
		return memberManageMapper.groupDelMem(mem_no, grp_no);
	
	}
	
	public List<Map<String, Object>> groupCheckMem(String mem_id) {
		System.out.println("serv    : "+mem_id);
		
		return memberManageMapper.groupCheckMem(mem_id);
	}
	
	public Map<String, Object> groupAddMem(Map<String, Object> map) {
		
		int check = memberManageMapper.groupAddMem(map);
		
		if(check == 1) {
			return map;
		} else {
			return null;
		}
	}

	@Override
	public Map<String, Object> groupAddMemAfter(Map<String, Object> map) {
		return memberManageMapper.groupAddMemAfter(Integer.parseInt(map.get("mem_no").toString()));
	}

	@Override
	public void groupDel(Map<String, Object> value) {
		
		memberManageMapper.groupDel(value);
	}
	
	public List<Map<String, Object>> allList() {
		return memberManageMapper.allList();
	};
	
}
