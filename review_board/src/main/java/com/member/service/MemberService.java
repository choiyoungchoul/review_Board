package com.member.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.member.mapper.MemberMapper;
import com.member.vo.MemberVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberService {

    @Autowired
    MemberMapper memberMapper;
    
    @Autowired
    PasswordEncoder passwordEncoder;

	/**
	 * 상세 설명
	 * DB에 ID값을 확인하는 서비스
	 * @author 최영철
	 * @since 2023. 7. 23.
	 * @see
	 *
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
    public Optional<MemberVo> qryGetFindOne(String insertedUserId) {
    	
    	Optional<MemberVo> findId = memberMapper.qryGetFindOne(insertedUserId);

    	return findId;
    	
    }
    
	/**
	 * 상세 설명
	 * 회원가입 실행 서비스
	 * @author 최영철
	 * @since 2023. 7. 23.
	 * @see
	 *
	 *      <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 * 수정일           수정자          수정내용
	 * ------------ ----------- ---------------------------
	 *
	 *      </pre>
	 */
    public int insJoinMember(MemberVo memberVo) {
    	
    	//DB통신 결과 값.  성공(1) , 실패(0)
    	int result = 0;
    	
    	//spring  security에서 제공하는 패스워드 암호화 해주는 함수
    	memberVo.setPassword(passwordEncoder.encode(memberVo.getPassword()));
    	
    	//회원가입을 통해 들어오는 회원은 user로 ROLE 고정
    	memberVo.setRole("user");
    	
    	result = memberMapper.insJoinMember(memberVo);
    	
    	return result;
    	
    }

}
