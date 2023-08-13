
<%@ page contentType="text/html;charset=UTF-8" language="java" %><!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>로그인</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
    <link href="https://getbootstrap.com/docs/4.0/examples/signin/signin.css" rel="stylesheet" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>



<body>


<div class="container">
    <form class="form-signin" method="post" action="/login-process">
    
        <h2 class="form-signin-heading text-center mb-5">SPA_BOARD</h2>
	
	
        <p>
            <label for="username" class="sr-only">아이디</label>
            <input type="text" id="username" name="userid" class="form-control" placeholder="아이디" autofocus="true">
        </p>
        <p>
            <label for="password" class="sr-only">비밀번호</label>
            <input type="password" id="password" name="pw" class="form-control" placeholder="비밀번호" maxlength="16">
        </p>
        <button class="btn btn-lg btn-primary btn-block" type="submit" id="login_btn">로그인</button>
        <a class="btn btn-lg btn-warning btn-block" href="/board/join">회원가입하기</a>
	    <% String loginFailMsg = (String) request.getAttribute("loginFailMsg"); %>
	    <% if (loginFailMsg != null) { %>
	    	<p>
	        <p style="color: red;"><%= loginFailMsg %></p>
	    <% } %>
    </form>
    
        

</div>
</body>

</html>