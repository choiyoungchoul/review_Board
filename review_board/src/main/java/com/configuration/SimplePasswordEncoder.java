package com.configuration;

import org.springframework.security.crypto.password.PasswordEncoder;


import jdk.internal.org.jline.utils.Log;
import lombok.extern.slf4j.Slf4j;

public class SimplePasswordEncoder implements PasswordEncoder {
	
	
    @Override
    public String encode(CharSequence rawPassword) {
        return rawPassword.toString();
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
    	//rawPassword 는 로그인 시 입력한 비밀번호,  즉 DB에 있는 비밀번호랑 동일 한 지 확인 할 수 있음.
        return encodedPassword.equals(encode(rawPassword));
    }

}
