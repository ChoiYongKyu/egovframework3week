package com.nos.mm.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nos.mm.util.NosMap;
import com.nos.mm.vo.MemberVO;

@Repository("MemberMapper")
public interface MemberMapper {

	public MemberVO login(String email);
	public String getAuth(int auth_no);
	public String emailDuplCheck(String email);
	public int join(MemberVO memberVO);
	public List<Map<String, Object>> groupByMem_no(int mem_no);
	public List<Map<String, Object>> memberByMn_group_no(int mn_group_no);
	public int modifyInfo(MemberVO memberVO);
	public String findEmail(MemberVO memberVO);
	public String findPW(MemberVO memberVO);
	public int modifyPW(MemberVO memberVO);
	
	public NosMap memberInfo(MemberVO memberVO);
	public List<NosMap> memberList();
	
	public void receiveToken(NosMap nosMap);
	public String getToken(String to);
}
