package com.nos.mm.vo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.validation.constraints.Pattern;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;


public class MemberVO implements UserDetails {

private static final long serialVersionUID = 1L;
	
	private int mem_no;
	
	@NotEmpty
	@Email
	private String mem_id; 
	
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*\\d).{8,20}$")
	private String mem_pw;
	
	@Pattern(regexp = "^[가-힣]{2,10}|[a-zA-Z]{2,10}\\s[a-zA-Z]{2,10}$")
	private String mem_name;
	
	@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$")
	private String mem_tel;
	
	private String mem_enc;
	private int mem_del_yn;
	private int auth_no;
	
	private String mem_dept;
	private String mem_grade;

	private List<String> mem_auth; 
	private boolean accountNonExpired = true; 
	private boolean accountNonLocked = true; 
	private boolean credentialsNonExpired = true; 
	private boolean enabled = true; 

	public int getMem_no() {
		return mem_no;
	}

	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getMem_pw() {
		return mem_pw;
	}

	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public String getMem_tel() {
		return mem_tel;
	}

	public void setMem_tel(String mem_tel) {
		this.mem_tel = mem_tel;
	}

	public String getMem_enc() {
		return mem_enc;
	}

	public void setMem_enc(String mem_enc) {
		this.mem_enc = mem_enc;
	}

	public int getMem_del_yn() {
		return mem_del_yn;
	}

	public void setMem_del_yn(int mem_del_yn) {
		this.mem_del_yn = mem_del_yn;
	}

	public int getAuth_no() {
		return auth_no;
	}

	public void setAuth_no(int auth_no) {
		this.auth_no = auth_no;
	}

	@Override
	public String getPassword() {
		return mem_pw;
	}
	
	public void setPassword(String mem_pw) {
		this.mem_pw = mem_pw;
	}
	
	@Override
	public String getUsername() {
		return mem_id;
	}
	
	public void setUsername(String mem_id) {
		this.mem_id = mem_id;
	}
	
	public String getMem_dept() {
		return mem_dept;
	}

	public void setMem_dept(String mem_dept) {
		this.mem_dept = mem_dept;
	}

	public String getMem_grade() {
		return mem_grade;
	}

	public void setMem_grade(String mem_grade) {
		this.mem_grade = mem_grade;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<SimpleGrantedAuthority> auth = new ArrayList<SimpleGrantedAuthority>();
		for(String role : mem_auth) {
			auth.add(new SimpleGrantedAuthority(role));
		}
		return auth;
	}
	
	public void setAuthorities(List<String> mem_auth) { 
		this.mem_auth = mem_auth; 
	}

	
	@Override
	public boolean isAccountNonExpired() {
		return accountNonExpired;
	}
	
	public void setAccountNonExpired(boolean accountNonExpired) {
		this.accountNonExpired = accountNonExpired;
	}
	
	@Override
	public boolean isAccountNonLocked() {
		return accountNonLocked;
	}
	
	public void setAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		return credentialsNonExpired;
	}
	
	public void setCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}
	
	@Override
	public boolean isEnabled() {
		return enabled;
	}
	
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.MULTI_LINE_STYLE);
	}
}