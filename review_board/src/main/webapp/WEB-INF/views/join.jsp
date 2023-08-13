<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
 	<meta id="_csrf" name="_csrf" th:content="${_csrf.token}"/>
    <meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
    <title>회원가입</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
 	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>

<body>
	  
		<div class="row mt-5 pt-2">
			<div id="joinBox" class="box mt-2" style="width: 560px; margin: 0 auto;">
				<h3 id="joinHead" class="mb-3">회원가입</h3>
				<form id="join_form" class="needs-validation">
					<div class="form-group">
						<label class="col-form-label" for="id">ID</label> 
						<input type="text" class="form-control" placeholder="ID" id="id" name="id" maxlength="12" >
						<div class="invalid-feedback" id="idMsg">ID는 필수 입력사항입니다.</div>
					</div>
					
					<div class="form-group">
						<label class="col-form-label" for="password">Password</label>
						<input type="password" class="form-control" placeholder="Password" id="password" name="password" maxlength="16" >
						<div class="invalid-feedback" id="pwMsg">비밀번호는 영문 대소문자, 숫자, 특수문자 조합으로 입력 하셔야 합니다.</div>
					</div>
					
					<div class="form-group">
						<label class="col-form-label" for="passwordCk">Password Check</label>
						<input type="password" class="form-control" placeholder="Password" id="passwordCk" name="passwordCk" maxlength="16">
						<div class="invalid-feedback" id="pwckMsg">입력한 비밀번호와 다릅니다.</div>
					</div>
					
					<div class="form-group">
						<label class="col-form-label" for="name">이름</label>
						<input type="text" class="form-control" placeholder="Name" id="name" name="name" maxlength="10">
						<div class="invalid-feedback" id="nameMsg">이름은 필수 입력사항입니다.</div>
					</div>
					
					<div class="form-group">
						<label class="col-form-label" for="email">Email</label>
							<div>
								<input class="form-control" id="email" type="text" name="email" placeholder="Email" />
								<span>@</span>
								<input class="form-control" id="domain-txt" type="text" placeholder="" style="display:none" />
								<select class="form-control" id="domain-list">
								  <option value="">선택해 주세요.</option>
								  <option value="naver.com">naver.com</option>
								  <option value="google.com">google.com</option>
								  <option value="nate.com">nate.com</option>
								  <option value="daum.net">daum.net</option>
								  <option value="select">직접입력</option>
								</select>
							</div>
						<div class="invalid-feedback" id="emailMsg">Email은 필수 입력사항입니다.</div>
				    </div>			
					
					<div class="form-group">
						<label class="col-form-label" for="gender">성별</label>
						<div>
							<label class="btn btn-primary active">
								<input type="radio" name="gender" autocomplete="off" value="M" checked>남자
							</label>
							<label class="btn btn-danger">
								<input type="radio" name="gender" autocomplete="off" value="Y">여자
							</label>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-form-label" for="age">연령대</label>
						<div>
							<label class="btn btn-primary">
								<input type="radio" name="age" value="10" checked>10대
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="age" value="20">20대
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="age" value="30">30대
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="age" value="40">40대
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="age" value="50">50대
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="age" value="60">60대
							</label>
						</div>
					</div>
					
					
					<div class="d-grid gap-2 mt-3">
						<div class="d-flex p-2">
							<div class="me-auto  ">
								<a type="button" class="btn btn-danger" href="/board/main">취소</a>
							</div>
							<div>
								<input id="submit_UserInfo_Btn" class="btn btn-success" type="button" value="회원가입" onclick="joinSubmit()">
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		
		<!-- alert 레이어 팝업 영역 -->
		<div class="modal fade" id="alertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-sm" style="margin-top: 250px;">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">확인해 주세요.</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		         <span id="alertTxt"></span>
		      </div>
		      <div class="modal-footer">
		        <button id="alertConfmBtn" type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="">확인</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- alert 레이어 팝업 영역 END -->

</body>

<script>

//이메일 select 제어 함수
$("#domain-list").on("change", function() {
    
	var domainValue = $("#domain-list").val();
	
	if(domainValue == "select"){
	    $("#domain-txt").show();		
	}else {
		$("#domain-txt").hide();
	}
	
	$("#domain-text").text(domainValue);
	
});

//alert 팝업 제어 함수
var openPopup = function(text, pageMove) {
	
	if(pageMove == 'Y') {
		$('#alertConfmBtn').attr("onclick", "moveLoginPage()");
	}
	
	$('#alertTxt').text(text);
	$('#alertModal').modal('show');
		
}

//가입완료 시 로그인 페이지로 이동
var moveLoginPage = function() {
     window.location.href = "/board/login";    	
}

//영문, 특수문자, 숫자 조합 검증 validation
var valiPassword = function() {
	
	var flag = true;
	
	var password = $("#password").val();
	
	//패스워드 입력 값 검증(영문 대소문자 + 숫자 + 특수문자 조합 검증 validation)
	if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(password)) {
		flag = false;
	}
	
	return flag;
}
				

//유효성 체크
var validation = function() {
	
	var flag = "Y";
		
	//id 체크
	if($("#id").val() == "") {
		$('#idMsg').show();
		$("#id").focus();
		flag = "N";
	}else {
		$('#idMsg').hide();
	}
	
	//pw 체크
	if($("#password").val() == "") {
	    $('#pwMsg').show();
	    $("#password").focus();
	    flag = "N";
	}else {
		$('#pwMsg').hide();
	}

	//입력 값 검증
	if(valiPassword() == false) {
		$('#pwMsg').show();
		$("#password").focus();
		flag = "N";
	}else {
		$('#pwMsg').hide();
	}
	
	//pw ck 체크
	if($("#password").val() != $("#passwordCk").val()) {
		$('#pwckMsg').show();
		$("#passwordCk").focus();
		flag = "N";
	}else {
		$('#pwckMsg').hide();
	}

	//이름 체크
	if($("#name").val() == "") {
		$('#nameMsg').show();
		$("#name").focus();
		flag = "N";
	}else {
		$('#nameMsg').hide();
	}

	//이메일 체크
	if ($("#email").val() == "" || $("#domain-list").val() == "" || ($("#domain-list").val() == "select" && $("#domain-txt").val() == "")) {
		$('#emailMsg').show();
		$("#email").focus();
		flag = "N";
	}else {
		$('#emailMsg').hide();
	}
	
	
	if(flag == "N") {
		openPopup("입력 정보를 다시 확인 해주세요.");
		return false;
	}

	return true;
}


//가입 submit
var joinSubmit = function () {
	
	  var token = $("meta[name='_csrf']").attr("content");
	  var header = $("meta[name='_csrf_header']").attr("content");
		
	    //유효성 체크 후 가입처리 aJax 실행
		if(validation()) {  
			
		    //email 셋팅
            var email = $("#email").val();
		    var domain = $("#domain-list").val();
		  
		  //이메일 domain 직접 입력인 경우 포맷팅
		  if(domain == "select") {
			  
			  var domainTxt = $("#domain-txt").val();
			  email = email + "@" + domainTxt;
	      
			  //선택된 domain 주소 포맷팅  
		  }else {
			  email = email + "@" + domain;
		  }
		  
		  //포맷팅 된 email 셋팅
		  $("#email").val(email)
		  
		  //form data 직렬화
		  var data = $("#join_form").serializeArray();
			                                         
	      $.ajax({                                 
		      	url : "/member/joinProcess",         
		      	type : 'POST',                       
		      	async : false,                       
		      	data : data,                         
		      	dataType: 'json',                    
		      	success : function() {               
		      		openPopup("축하합니다 가입이 완료 되었습니다.", "Y");
		      	}, error : function(e){              
		      		openPopup("처리중 실패 했습니다.");                 
		      	}                                    
	      });                                      
	 }  
		
}
	
</script>

</html>