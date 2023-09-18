package com.configuration;


import javax.servlet.DispatcherType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

@Configuration
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class SecurityConfiguration {
	

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Autowired
    private CustomAuthenticationFailureHandler failureHandler;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
        	.csrf().disable().cors().disable()
        	.authorizeRequests(request -> request
                .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                .antMatchers("/member/naver",
                			 "/member/login", 
                			 "/member/joinProcess",
                			 "/board/main", 
                			 "/board/join", 
                			 "/board/qryBoardList", 
                			 "/board/detailProcess",
                			 "/board/fileUpload",
                			 "/board/fileDownload",
                			 "/board/removeFile",
                			 "/static/**", 
                			 "/views/**", 
                			 "/resources/*/**", 
                			 "/errors/**").permitAll()
                .anyRequest().authenticated()
        )
        .formLogin(login -> login
                .loginPage("/board/main")                      //인증전 기본 페이지 설정
                .loginProcessingUrl("/login-process")          //로그인 처리를 하는 URL
                .usernameParameter("userid")                   //프로세스에 넘겨줄 ID
                .passwordParameter("pw")                       //프로세스에 넘겨주는 PW
                .defaultSuccessUrl("/board/main", true)        //인증 성공 시 진입하는 페이지
                .failureHandler(failureHandler)                //로그인 실패 헀을 때
                .permitAll()
        )
        .logout()
	        .logoutUrl("/logout")                               // 로그아웃 프로세스 처리 URL
	        .logoutSuccessUrl("/board/main")                    // 로그아웃 성공 시 이동 할 URL 
	        .invalidateHttpSession(true)                        // 세션 무효화(초기화)하는 역할
	        .deleteCookies("JSESSIONID")                        // 쿠키 삭제하는 역할
	        .and();

        return http.build();

    }
    
    
}
