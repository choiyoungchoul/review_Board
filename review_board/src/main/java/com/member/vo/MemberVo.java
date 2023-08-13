package com.member.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


/**
 * 상세 설명
 * 회원가입 vo
 * @author 최영철
 * @since 2023. 7. 25.
 * @column
 * idx : 회원 번호
 * id : ID
 * password : 비밀번호
 * email : 이메일
 * name : 작성자 이름
 * regdate : 등록일
 * upddate : 수정일
 * role : 회원 등급
 * age : 나이
 *
 *      <pre>
 * << 개정이력(Modification Information) >>
 *
 * 수정일           수정자          수정내용
 * ------------ ----------- ---------------------------
 *
 *      </pre>
 */
@Getter
@Setter
@ToString
public class MemberVo {

	private int idx;
	private String id;         //회원 ID
	private String password;   //패스워드
	private String email;      //email
	private String name;       //이름
	private String regdate;    //등록일
	private String upddate;    //수정일
	private String role;       //회원등급
	private int age;           //연령

}
