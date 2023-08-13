package com.configuration;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.member.service.MemberService;
import com.member.vo.MemberVo;

@Component
public class SecurityUserService implements UserDetailsService {

	@Autowired
    MemberService memberService;

    @Override
    public UserDetails loadUserByUsername(String insertedUserId) throws UsernameNotFoundException {

    	//Optional 객체는 값이 있을 수도 있고 없을 수도 있는 객체를 감싸는 래퍼 클래스.
        Optional<MemberVo> findOne = memberService.qryGetFindOne(insertedUserId);
        MemberVo member = findOne.orElseThrow(() -> new UsernameNotFoundException("등록되지 않은 회원 입니다."));

        return User.builder()
                .username(member.getId())
                .password(member.getPassword())
                .roles(member.getRole())
                .build();
    }
    

}
