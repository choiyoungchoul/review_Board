package com.member.mapper;

import java.util.Optional;

import org.apache.ibatis.annotations.Mapper;

import com.member.vo.MemberVo;

@Mapper
public interface MemberMapper {

	//ID 조회 프로세스
	Optional<MemberVo> qryGetFindOne(String inputParamVo);
	
	//회원가입 프로세스
	int insJoinMember (MemberVo memberVo);

}
