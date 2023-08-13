package com.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.member.service.MemberService;
import com.member.vo.MemberVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	
	@Autowired
	private MemberService memberService;
	
	/**
	 * 상세 설명
	 * 로그인 페이지 이동
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
    @RequestMapping("/login")
    public ModelAndView loginMethod(String str) {

    	ModelAndView mv = new ModelAndView();

        mv.setViewName("/login");

        return mv;

    }
	
	/**
	 * 상세 설명
	 * 회원가입 처리 프로세스
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
    @PostMapping("/joinProcess")
    @ResponseBody
    public int memberJoinMethod(MemberVo memberVo){
    	
        return memberService.insJoinMember(memberVo);
        
    }
    


	


}
