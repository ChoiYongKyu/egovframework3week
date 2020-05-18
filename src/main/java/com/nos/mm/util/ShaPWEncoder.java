package com.nos.mm.util;

import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class ShaPWEncoder implements PasswordEncoder {
	
	private ShaPasswordEncoder shaPasswordEncoder;
	private static String salt = null;

	public ShaPWEncoder() { 
		shaPasswordEncoder = new ShaPasswordEncoder(256); 
	}
	
	public void setSalt(String salt) {
		this.salt = salt;
	}
	
	@Override
	public String encode(CharSequence rawPassword) {
		return shaPasswordEncoder.encodePassword(rawPassword.toString(), salt);
	}

	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
//		System.out.println("PW matches salt : " + salt + " PW : " + rawPassword + " DBPW : " + encodedPassword);
		return shaPasswordEncoder.isPasswordValid(encodedPassword, rawPassword.toString(), salt);
	}

}
