package com.nos.mm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.xml.bind.annotation.adapters.NormalizedStringAdapter;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.nos.mm.mapper.MemberMapper;
import com.nos.mm.util.EmailSender;
import com.nos.mm.util.NosMap;
import com.nos.mm.util.RandomPW;
import com.nos.mm.util.SaltProduce;
import com.nos.mm.util.ShaPWEncoder;
import com.nos.mm.vo.MemberVO;

@Service
public class MemberService implements UserDetailsService {
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private EmailSender emailSender;
	
	@Resource
	MessageSource messageSource;
	
	// 스프링 시큐리티 로그인
	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

		// 이메일을 통해 정보 가져오기
		MemberVO memberVO = memberMapper.login(email);
		
		if(memberVO.getMem_del_yn() == 0) { // 탈퇴된 아이디
			return null;
		} 
		
		/* 5회 로그인 실패시 로그인 금지 추가하기 
		     컬럼 추가하거나 del_yn을 이용해서 실패시마다 +1 시켜라 몇 이상이면 로그인 안되게 하기
		     권한을 변경하거나 해야할듯...
		*/
		
		ShaPWEncoder shaPWEncoder = new ShaPWEncoder();
		
		shaPWEncoder.setSalt(memberVO.getMem_enc()); // salt 
		
//		System.out.println("DB salt : " + memberVO.getMem_enc());
		
		String auth = memberMapper.getAuth(memberVO.getAuth_no()); // 권한

		List<String> mem_auth = new ArrayList<String>(); // 권한 리스트로 만들기
		mem_auth.add(auth);
		
		memberVO.setAuthorities(mem_auth);
		
		System.out.println(memberVO);
		return memberVO;
	}
	
	// 아이디 중복 체크
	public String emailDuplCheck(String email) {
		
		return memberMapper.emailDuplCheck(email);
	}
	
	// 회원가입
	public int join(MemberVO memberVO) {
		return memberMapper.join(encryptionPW(memberVO));
	}
	
	// 이메일 찾기
	public String findEmail(MemberVO memberVO) {
		
		return memberMapper.findEmail(memberVO);
	}
	
	// 비밀번호 찾기
	public String findPW(MemberVO memberVO) {
		
		String mem_id = memberMapper.findPW(memberVO);
		
		if(mem_id != null) {

			String newPW = RandomPW.randomPW(); // 새로운 비밀번호 생성

			memberVO.setMem_pw(newPW); 

			memberMapper.modifyPW(encryptionPW(memberVO)); // 암호화하고 DB수정
			
			try {
				
				emailSender.sendEmail(mem_id, newPW);
				
			} catch (Exception e) {
				
//				System.out.println(e);
				
			}
		}
		
		return mem_id;
	}
	
	// 자신이 있는 그룹과 멤버들
	public List<Map<String, Object>> groupByMem_no(int mem_no, Locale locale) {
		
		// 다국어처리
		if(locale.getLanguage() == "en") {
			Locale.setDefault(Locale.ENGLISH);
		} else {
			Locale.setDefault(Locale.KOREA);
		}
		
		List<Map<String, Object>>groupList = memberMapper.groupByMem_no(mem_no);
		
		List<Map<String, Object>> groupByMem_no = new ArrayList<Map<String, Object>>();
		
		for(int i = 0; i < groupList.size(); i++) {
			
			List<Map<String, Object>> list = memberMapper.memberByMn_group_no(Integer.valueOf(String.valueOf(groupList.get(i).get("MN_GROUP_NO"))));
		
			Map<String, Object> map = new HashMap<String, Object>();
			String members = "";
			
			// 여러명인 경우 XX외 X명으로 표시
			if(list.size() > 1) {
				members = messageSource.getMessage("group.member.count", new Object[]{list.get(0).get("MEM_NAME"), (list.size() - 1)}, Locale.getDefault());
			} else {
				members = String.valueOf(list.get(0).get("MEM_NAME"));
			}
			
			map.put("group_name", groupList.get(i).get("MN_GROUP_NAME"));
			map.put("group_no", groupList.get(i).get("MN_GROUP_NO"));
			map.put("members_name", members);
			
			groupByMem_no.add(map);
		}
		
		return groupByMem_no;
		
	}
	
	// 개인정보 수정
	public int modifyInfo(MemberVO memberVO) {
		
		return memberMapper.modifyInfo(encryptionPW(memberVO));
		
	}
	
	// 암호화
	private static MemberVO encryptionPW(MemberVO memberVO) {
		System.out.println("==================================================");
		System.out.println(memberVO);
		System.out.println("google user".equals(memberVO.getMem_tel()));
		System.out.println(memberVO.getMem_tel().matches("(010)+.+"));
		System.out.println("==================================================");
		
		if(("google user".equals(memberVO.getMem_tel()) && memberVO.getMem_no() == 0) || memberVO.getMem_tel().matches("(010)+.+")) {
		
			// 암호화
			ShaPWEncoder shaPWEncoder = new ShaPWEncoder();
			
			// 암호화 salt 생성
			SaltProduce saltProduce = new SaltProduce();
			String salt = saltProduce.generateSalt(32).toString();
			
			// 암호화하기 위해 생성한 salt 삽입
			shaPWEncoder.setSalt(salt);
			
			// salt 삽입으로 만들어진 암호화된 비밀번호
			String newPW = shaPWEncoder.encode(memberVO.getMem_pw());
			
			// 새로운 비밀번호, salt 추가
			memberVO.setMem_pw(newPW);
			memberVO.setMem_enc(salt);
		}
		
		return memberVO;
	}
	
	public NosMap memberInfo(MemberVO memberVO) {
		return memberMapper.memberInfo(memberVO);
	}

	public List<NosMap> memberList() {
		return memberMapper.memberList();
	}
	
	public void receiveToken(NosMap nosMap) {
		memberMapper.receiveToken(nosMap);
	}
	
	public String getToken(String to) {
		return memberMapper.getToken(to);
	}
}