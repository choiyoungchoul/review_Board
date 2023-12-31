<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>메인페이지</title>
    <link href="https://getbootstrap.com/docs/4.0/examples/signin/signin.css" rel="stylesheet" crossorigin="anonymous">
 	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<link href="/resources/css/star.css" rel="stylesheet"/>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
  	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
  	<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
</head>


<body>

<div class="container">
		
    	<!-- 로그인 및 로그아웃 메뉴 영역-->
		<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
		  <div class="container-fluid">
		    <a href="/board/main" class="navbar-brand">넷플릭스 리뷰 게시판</a>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		      <span class="navbar-toggler-icon"></span>
		    </button>
		    <div class="collapse navbar-collapse" id="navbarSupportedContent">
		      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li>
					<a id="loginBtn" type="button" class="btn btn-primary" style="display:none" href="/member/login">로그인</a>
					<a id="joinBtn" type="button" class="btn btn-primary" style="display:none" href="/board/join">회원가입</a>
					<a id="memberTxt" type="button" class="btn btn-primary" style="display:none" href="/board/myPage" data-bs-toggle="tooltip" data-bs-placement="bottom" title="내가 작성한 리뷰를 볼 수 있습니다."></a>
			        <form id="logoutBtn" class="btn btn-danger"  method="post" action="/logout" style="display:none">로그아웃</form>
			        <button type="button" class="btn btn-success" onclick="chartPopup()" data-bs-toggle="tooltip" data-bs-placement="bottom" title="평점순으로 차트를 볼 수 있습니다.">평점랭크</button>
				</li>
		      </ul>
		      <div class="d-flex">
			     <select  id="srchSel" class="form-select" style="width:140px;">
			       <option value="" selected>선택</option>
			       <option value="conTit">컨텐츠 제목</option>
			       <option value="revTit">리뷰 제목</option>
			       <option value="writer">작성자</option>
			     </select>
		         <input id="srchTxt" class="form-control" type="search" placeholder="Search" style="width:300px;">
		      </div>
		    </div>
		  </div>
		</nav>
		<!-- 로그인 및 로그아웃 메뉴 영역 END -->
		
  	
	  	    <!-- 게시글 영역 -->
 		    <div id="boardTable" style="display:none">
			      <table class="table table-hover">                                                                                                           
					<thead>                                                                                                                      
						<tr>                                                                                                                     
							<th scope="col">NO</th>                                                                                              
							<th scope="col">제목</th>                                                                                     
							<th scope="col">별점</th>                                                                                            
							<th scope="col">컨텐츠 명</th>                                                                                       
							<th scope="col">작성자</th>                                                                                       
							<th scope="col">작성일</th>                                                                                       
						</tr>                                                                                                                    
					</thead>
					<tbody id="boardList">                                                                                                                      
						<c:forEach var="list" items="${boardList}" varStatus="status">
							<tr onclick="detailPopup('${list.idx}')" style="cursor: pointer">                                                                                                                     
								<th>${totalCount - status.index }</th>                                                                                  
								<td>${list.title}</td>
								<td class="starList">
								  <%-- DB에 저장되어 있던 별점 숫자로 별 개수 세팅 --%>
								  <c:forEach begin="1" end="${list.grades}">
								      <span>★</span>
								  </c:forEach>
								</td>                                                                                                           
								<td style="color:olive;"><b>${list.contents_title}</b></td>                                                                                          
								<td>${list.writer}</td>                                                                                                           
								<td>${list.regdate}</td>                                                                                                           
							</tr>                                                                                                                    
						</c:forEach>                                                                                                                     
					</tbody>                                                                                                                     
				  </table>
			
			
				<div style="text-align:center;">
					<div id="pagination" class="btn-group" role="group" aria-label="Basic example" data-value="${pageInfo.currentPageNum}" >
					
					  <c:if test="${boardList.size() > 0}">
					  		
					  		<c:if test="${pageInfo.isPrevExist == true && pageInfo.currentPageNum > 5}">
						  		<button type="button" class="btn btn-outline-primary" onclick="pageFn(this)" data-value="${1}">&lt;&lt;</button>
					  		</c:if>
						  
							<c:if test="${pageInfo.isPrevExist == true && pageInfo.currentPageNum > 5}">
								<button type="button" class="btn btn-outline-primary active" onclick="pageFn(this)" data-value="${pageInfo.blockFirstPageNum - 1}">&lt;</button>
							</c:if>	
							
					        <c:if test="${pageInfo.totalPostCount > 0 }">
					            <c:forEach var="list" items="${pageInfo.pageList}">
									<button type="button" class="btn btn-outline-primary ${list ==  pageInfo.currentPageNum ? "active" : ""}" onclick="pageFn(this)" data-value="${list}" ">
					                    ${list}
									</button>
					            </c:forEach>
					        </c:if>
					        
					        <c:if test="${pageInfo.isNextExist == true}">
								<button type="button" class="btn btn-outline-primary" onclick="pageFn(this)" data-value="${pageInfo.blockLastPageNum + 1}" >&gt;</button>
							</c:if>
							
							<c:if test="${pageInfo.isNextExist == true}">
								<button type="button" class="btn btn-outline-primary" onclick="pageFn(this)" data-value="${pageInfo.totalLastPageNum}">&gt;&gt;</button>
							</c:if>
							
				      </c:if>	
				      
				   </div>
				</div>
			</div>	
		
		    
		    <div id="noneList" style="display:none">
				<table class="table table-bordered">
						<tr>
							<br>
							<td><p align="center">현재 작성된 글이 없어요.</p></td>
						</tr>
				</table>
		    </div>
		<!-- 게시글 영역 END -->
		
		
		
       <div style="text-align:right;">
    	   <button type="button" class="btn btn-primary" onclick="writePopup()">리뷰작성</button>
	   </div>
	   
		
		<!--  게시글 작성 팝업 영역 -->
		<div class="modal fade" id="weriteModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">리뷰작성</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
					<form class="mb-3" name="writeForm" id="writeForm" method="post">
			            <div class="col-sm-12 pt-3">
				            <div class="card">
				                <div class="card-body">
				                    <div class="table-responsive">
				                        <table class="table">
				                            <tbody>
                    					        <tr style="line-height:32px;">
					                                <td style="font-weight: 800">컨텐츠 제목</td>
					                                <td>
													   <select id="contentsList" class="form-control">
														  <option value="">선택해 주세요.</option>
														  <c:forEach var="list" items="${itemList}">
														  	 <option value="${list}">${list}</option>
														  </c:forEach>
														  <option value="select">직접입력</option>
													    </select>
						                                <input id="contents-txt" type="text" name="contents_title" class="form-control" value="" style="display:none">
					                                </td>
					                            </tr>
					                            <tr>
					                            	<td style="font-weight: 800">컨텐츠 URL</td>
					                                <td>
					                                    <input id="insContentUrl" type="text" name="contents" class="form-control" value="">
					                                </td>
					                            </tr>
					                            <tr style="line-height:32px;">
					                                <td style="font-weight: 800">제목</td>
					                                <td>
					                                    <input id="insTitle" type="text" name="title" class="form-control" value="">
					                                </td>
					                            </tr>
					                            <tr>
					                                <td style="font-weight: 800">작성자</td>
					                                <td>
					                                    <input type="tel" name="id" class="form-control" value="" readonly>
					                                </td>
					                            </tr>
				                            </tbody>
				                        </table>
				                    </div>
									<div>
										<textarea class="col-auto form-control" id="insContent" name="contents" placeholder="내용" style="height:250px"></textarea>
									</div>
				                </div>
				            </div>
						    <div class="star">
								<fieldset>
									<span style="font-weight: 800">별점을 선택해주세요</span>
									<input type="radio" name="grades" value="5" id="rate1"><label for="rate1">★</label>
									<input type="radio" name="grades" value="4" id="rate2"><label for="rate2">★</label>
									<input type="radio" name="grades" value="3" id="rate3"><label for="rate3">★</label>
									<input type="radio" name="grades" value="2" id="rate4"><label for="rate4">★</label>
									<input type="radio" name="grades" value="1" id="rate5"><label for="rate5">★</label>
								</fieldset>
						    </div>
			           </div>
				  </form>
				  <form id="insFileUpload">
		  		      <div class="card">
	                     <input type="file" class="form-control-file" id="insFile" name="file">
	                  </div>
				  </form>	
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary" onclick="writeSubmit()">완료</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!--  게시글 작성 팝업 영역 END -->
		
		
		<!-- 게시글 상세 및 수정,삭제 영역 -->
		<div class="modal fade" id="detailModalBody" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">리뷰상세</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      
			      <!-- 상세 레이어 -->
			      <div class="modal-body" id="detailModal">
			          <div class="col-sm-12 pt-3">
				          <div class="card">
				              <div class="card-body">
				                  <div class="table-responsive">
				                      <table class="table">
				                          <tbody>
	                 					      <tr style="line-height:32px;">
					                              <td style="font-weight: 800">컨텐츠 제목</td>
					                              <td>
					                                  <span id="deCntTitle"></span>
					                              </td>
					                          </tr>
					                          <tr style="line-height:32px; display:none;">
					                              <td style="font-weight: 800">컨텐츠 URL</td>
					                              <td>
					                                  <a id="deCntUrl" target="_blank"></a>
					                              </td>
					                          </tr>
					                          <tr style="line-height:32px;">
					                              <td style="font-weight: 800">제목</td>
					                              <td>
					                                  <span id="deTitle"></span>
					                              </td>
					                          </tr>
	                     					  <tr style="line-height:32px;">
					                              <td style="font-weight: 800">작성자</td>
					                              <td>
					                                  <span id="deWriter"></span>
					                              </td>
					                          </tr>
	                     					  <tr style="line-height:32px;">
					                              <td style="font-weight: 800">조회수</td>
					                              <td>
					                                  <span id="deCount"></span>
					                              </td>
					                          </tr>
					                          <tr>
					                              <td style="font-weight: 800">별점</td>
					                              <td>
					 								<div class="starList"> 
					 									<span id="deStar"></span>
					 								</div>
					                              </td>
					                          </tr>
					                          
	                     					  <tr style="line-height:32px; display:none;">
					                              <td style="font-weight: 800">첨부파일</td>
					                              <td>
					                                  <a id="deFile" href=""></a>
					                              </td>
					                          </tr>
					                          
				                          </tbody>
				                      </table>
				                  </div>
					 			<div>
					 				<span id="deContent" class="col-auto form-control" style="height:250px" id="detailContent" placeholder="내용"></span>
					 			</div>
				              </div>
				          </div>
			         </div>
			      </div>
			      <!-- 상세 레이어 -->
			      
			     <!-- 수정 레이어 -->
	    		 <form class="modal-body" id="updateModal" method="post" style="display:none">
				      <div class="col-sm-12 pt-3">
					     <div class="card">
					         <div class="card-body">
					             <div class="table-responsive">
					                   <table class="table">
					                        <tbody>
	                     				        <tr style="line-height:32px;">
						                             <td style="font-weight: 800">컨텐츠 제목</td>
						                             <td>
						                                 <input id="updCntTitle" type="text" name="contents_title" class="form-control" value="">
						                             </td>
						                         </tr>
						                         <tr style="line-height:32px;">
						                         <td style="font-weight: 800">컨텐츠 URL</td>
						                             <td>
						                                 <input id="updCntUrl" type="text" name="contents_url" class="form-control" value="">
						                             </td>
						                         </tr>
						                         <tr style="line-height:32px;">
						                             <td style="font-weight: 800">제목</td>
						                             <td>
						                                 <input id="updTitle" type="text" name="title" class="form-control" value="">
						                             </td>
						                         </tr>
					                         </tbody>
					                     </table>
					                 </div>
						 			<div>
						 				<textarea class="col-auto form-control" id="updContent" name="contents" placeholder="내용" style="height:250px"></textarea>
						 			</div>
					             </div>
					         </div>
							  <div class="star">
								  <fieldset>
								  	   <span style="font-weight: 800">별점을 선택해주세요</span>
								  	   <input type="radio" name="grades" value="5" id="updRate1"><label for="updRate1">★</label>
								  	   <input type="radio" name="grades" value="4" id="updRate2"><label for="updRate2">★</label>
								  	   <input type="radio" name="grades" value="3" id="updRate3"><label for="updRate3">★</label>
								  	   <input type="radio" name="grades" value="2" id="updRate4"><label for="updRate4">★</label>
								  	   <input type="radio" name="grades" value="1" id="updRate5"><label for="updRate5">★</label>
								  </fieldset>
							  </div>
							  <input id="updIdx" type="hidden" name="idx" value="" />
				          </div>
					  </form>
		       	  	  <div id="inputFile" class="card-body" style="display:none">
						  <span id="fileName" ></span>				<button id="fileDelBtn" class="btn-danger" onclick="">삭제</button>
					  </div>
        			  <form id="updFileUpload" class="modal-body" style="display:none">
		  		          <div class="card">
	                         <input type="file" class="form-control-file" id="updFile" name="file">
	                      </div>
			      	  </form>
			       	  <!-- 수정 레이어 -->
		       	  
		      <div class="modal-footer">
		          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		          <button id="deDel" type="button" class="btn btn-danger" onclick="" style="display:none">삭제</button>
		          <button id="deUpd" type="button" class="btn btn-primary" onclick="" style="display:none">수정</button>
		          <button id="deUpdSub" type="button" class="btn btn-primary" onclick="" style="display:none">완료</button>
		          <button id="deConf" type="button" class="btn btn-primary" data-bs-dismiss="modal" data-bs-dismiss="modal">확인</button>
		      </div>
		      
		    </div>
		  </div>
		</div>
		<!-- 게시글 상세 및 수정,삭제 영역 END -->
		
		
		
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
		
		
		
		<!-- confirm 레이어 팝업 영역 -->
		<div class="modal" id="confirmModal" tabindex="-1">
		  <div class="modal-dialog modal-dialog-centered modal-sm">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">확인해 주세요.</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div id="confTxt" class="modal-body">
		        <p></p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button id="confirmBtn" type="button" class="btn btn-primary" onclick="" data-bs-dismiss="modal">완료</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- confirm 레이어 팝업 영역 END-->
		
		
		
		<!--  그래프 팝업 영역 -->
		<div class="modal fade" id="chartModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">리뷰평점</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
		         <div class="table table-hover" style="width: 450px; height: 200px;">
				    <!--차트가 그려질 부분-->
				   <canvas id="myChart"></canvas>
			     </div>	
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!--  그래프 팝업 영역 END -->
		
    
<script>

//로그인 ID
var loginId = "";

//공백 문자확인
var blank_pattern = /^\s+|\s+$/g;

//차트 데이터
var chartTitle = '${chartTitle}';
var chartGrade = '${chartGrade}';

var chartTitleArr = chartTitle.replace(/[\[\]]/g, '').split(',');
var chartGrade = chartGrade.replace(/[\[\]]/g, '').split(',');


$(document ).ready(function() {
	
	
	  $('#insContent').summernote({
		  
		  height: 350,
		  lang: "ko-KR"
		  
	   });
	  
	  $('#updContent').summernote({
		  
		  height: 350,
		  lang: "ko-KR"
		  
	   });
	  
	  //현재 로그인중인 아이디 확인
	  loginId = "${userName}";
	  var totCnt = "${totalCount}";
	  
	  //현재 세션에 로그인 정보 확인
	  //로그인이 안되어 있으면 회원가입 , 로그인 이동 페이지 버튼 노출
	  if(loginId != null && loginId != "") {
	  	
		//로그인 메뉴 show
	  	$("#memberTxt").show();
	  	$("#logoutBtn").show();
	  	
	  	var loginTxt = loginId + "님 환영 합니다.";
	  	
	  	$("#memberTxt").text(loginTxt);
	  	
	  }else {
		  
		//비로그인 메뉴 show
	  	$("#loginBtn").show();
	  	$("#joinBtn").show();
	  	
	  }

	  
	  //작성글 여부에 따라 display 처리
	  if(totCnt > 0) {
		  
		  $("#boardTable").show();
		  
	  }else {
		  
		  $("#noneList").show();
		  
	  }
	  
});

//로그아웃 이벤트
$("#logoutBtn").on("click", function() {
	
	$('#logoutBtn').submit();
	
});


//검색 enter 이벤트 제어
$(document).on("keypress", "#srchTxt", function(e) {
	
	
  if (e.which==13){
	  
	  if($("#srchTxt").val() == "" || $("#srchTxt").val() == null || $("#srchTxt").val().replace(blank_pattern, "" ) == "") {
		  
		  openPopup("검색어를 입력해 주세요.");
		  
	  }else if($("#srchSel").val() == "" || $("#srchSel").val() == null) {
		  
	  	  openPopup("검색 할 카테고리를 선택해 주세요.");
	  	  
	  }else {
		  
		  srchFn();
		  
	  }
  }
  
  
  
});


//컨텐츠 제목 select 제어 함수
$("#contentsList").on("change", function() {
    
	var selectValue = $("#contentsList").val();
	
	if(selectValue == "select"){
	    $("#contents-txt").show();		
	}else {
		$("#contents-txt").hide();
	}
	
});

//별점 선택시 동적 UI 이벤트 함수
$('.stars .fa').click(function() {
	
    $(this).addClass('active');

    // 클릭한 별을 기준으로 (.fa) 그 이전 별은 보이게 그 뒤에 별들은 안보이게
    $(this).prevAll().addClass('active');
    $(this).nextAll().removeClass('active');

    // 순서를 찾는 메서드 index 0 1 2 3 4
    // 텍스트내용을 출력 text, 태그+텍스트 html
    var num = $(this).index();
    
    $('.print').text(starRate);
    
    var starRate = num + 1
    
    if(starRate == 1) {
    	
        // $('.print').text('별로에요');
        $('.print').html('<img src="img/icon/star-lv1.png">' + '별로에요');
        
    } else if(starRate == 2) {
    	
        $('.print').html('<img src="img/icon/star-lv2.png">' + '보통 이에요');
        
    } else if(starRate == 3) {
    	
        $('.print').html('<img src="img/icon/star-lv3.png">' + '그냥 그래요');
        
    } else if(starRate == 4) {
    	
        $('.print').html('<img src="img/icon/star-lv4.png">' + '맘에 들어요');
        
    } else {
    	
        $('.print').html('<img src="img/icon/star-lv4.png">' + '아주 좋아요');
        
    }
    
});




//alert 팝업 제어 함수
var openPopup = function(text, reload) {
	
	if(reload == "Y") {
		//alert popup 텍스트
		$('#alertConfmBtn').attr("onclick", "reloadFn()");
	}
	
	$('#alertTxt').text(text);
	$('#alertModal').modal('show');
		
}


//confirm 함수(수정,삭제 시 필요) type 1. del(삭제 처리) , 2. upd(수정 처리) 3. Fdel(파일 삭제 처리)
var openConfPopup = function(text, type, idx) {
	
    $('#confTxt p').text(text);
    
    if(type == "upd") {
    	
    	$('#confirmBtn').attr("onclick", "updSubmit("+idx+")"); //수정처리
    
    }else if(type == "del") {
    	
	    $('#confirmBtn').attr("onclick", "delSubmit("+idx+")"); //삭제처리	
	  
    }else {
    	
    	$('#confirmBtn').attr("onclick", "delFileSubmit("+idx+")"); //파일삭제 처리  
    	
    }
    
    $('#confirmModal').modal('show');
	
}


//reload 처리 함수
var reloadFn = function() {
	
	location.reload();
	
}
	


//글 작성 레이어 팝업, 띄우는 이벤트
var writePopup = function () {
	
	 //비로그인 상태면 로그인 alert 노출
	 if(loginId == "" || loginId == null) {
		 
		 openPopup("로그인 후 작성해 주세요.");
		 
	 }else {
		 
		 //로그인 상태면  팝업 띄우기
	    $('#weriteModal').modal('show');
		$('input[name=id]').val(loginId); 
		
		//작성됐던 데이터 초기화
		$("#contentsList").prop("selectedIndex", 0);
		$("#contents-txt").val('');
		$("#insContentUrl").val('');
		$("#insTitle").val('');
		$("#insContent").summernote('code', '');
		$("input[name='grades']").prop("checked", false);
		
	 }
	 
}

//랭크 차트 팝업 띄우는 이벤트
var chartPopup = function () {
	
    $('#chartModal').modal('show');
    
}



//수정 팝업 이벤트
var updatePopup = function (idx, fileIdx) {
	
	$("#detailModal").hide();
	$("#updateModal").show();
	
	$("#deUpd").hide();
	$("#updFileUpload").show();
	
	if(fileIdx != '' && fileIdx != null) {
		$("#inputFile").show();
		$("#fileDelBtn").show();
	}
	
	
	$("#deUpdSub").show();
	$("#deUpdSub").attr("onclick", "updConfirm("+idx+")");
	
}

//수정 confirm 이벤트
var updConfirm = function (idx) {
	
	//validation 체크
	if(checkValidation('upd')) {
		
		openConfPopup("수정 하시겠습니까?", "upd" ,idx);
		
	}
	
}


//삭제 confirm 이벤트
var delConfirm = function (idx) {
	
	openConfPopup("삭제 하시겠습니까?", "del", idx);
	
}

// 파일 삭제 confirm 이벤트
var delFileConfirm = function (file_idx) {
	
	openConfPopup("파일을 삭제 하시겠습니까?", "Fdel", file_idx);
	
}


// 유효성 검사
var checkValidation = function (type) {

	
		var flag = true;
	
		
		//글 작성 유효성 검사
		if(type == 'ins') {
			
				//선택된 컨텐츠
		        var selectContents = $("#contentsList option:selected").text();
				var selType = "sel";
				
		        if(selectContents != "선택해 주세요.") {
		        	
		         	$("#contents-txt").val(selectContents);
		         	selType = "text";
		         	
		        }
		
				
				//컨텐츠 제목
				if(selType == 'sel' && selectContents == '선택해 주세요.') {
					
					openPopup("컨텐츠를 선택해 주세요.");
					flag = false;
					return false;
					
				} else if (selType == 'text' && $("#contents-txt").val() == '직접입력') {
					
					openPopup("컨텐츠명을 입력해 주세요.");
					flag = false;
					return false;
					
				} else {
					
					flag = true;
					
				}
				
				
				//제목
				if($("#insTitle").val() == '') {
					
					openPopup("제목을 작성해 주세요.");
					flag = false;
					return false;
					
				}
				
				//내용
				var summernoteContent = $("#insContent").summernote('code').replace(/<[^>]*>/g, '');
				
				if(summernoteContent == '') {
					
					openPopup("내용을 작성해 주세요.");
					flag = false;
					return false;
					
				}
				
				//별점
				if(!$("input[name='grades']:checked").val()) {
					
					openPopup("별점을 선택해 주세요.");
					flag = false;
					return false;
					
				}
			
			
		//글 수정 유효성 검사
		}else {
			
				//컨텐츠 제목
				if($("#updCntTitle").val() == '') {
					
					openPopup("컨텐츠 제목을 입력해 주세요.");
					flag = false;
					return false;
					
				}
				
				
				//제목
				if($("#updTitle").val() == '') {
					
					openPopup("제목을 작성해 주세요.");
					flag = false;
					return false;
					
				}
				
				//내용
				var summernoteContent = $("#updContent").summernote('code').replace(/<[^>]*>/g, '');
				
				if(summernoteContent == '') {
					
					openPopup("내용을 작성해 주세요.");
					flag = false;
					return false;
					
				}
			
			
		}
		
		
		return flag;
	
}


//글상세 내용 가져오는 aJax
var detailPopup = function (index) {
	
	var data = { idx: index };
	
	//글번호로 상세내용 가져오기
    $.ajax({                                      
     	url : "/board/detailProcess",                
     	type : 'GET',                              
     	async : false,                              
     	data : data,                                
     	dataType: 'json',                           
     	success : function(data) {
     		
     		//게시글 정보
     		var inputData = data.detailContent;
     		
     		//작성자 일치 여부
     		var writerYn = data.writerYn;
     		var star = "";
     		
     		for(var i=1; i<=inputData.grades; i++) {
     			star += "★";
     		}
     		
     		//data set
     		//상세 input
     		$("#deCntTitle").text(inputData.contents_title);
     		
     		//URL은 데이터가 있을때만 노출
     		if(inputData.contents_url != null) {
     			
     			$("#deCntUrl").closest("tr").show();
     			$("#deCntUrl").text(inputData.contents_url);
     			$("#deCntUrl").attr("href", inputData.contents_url);
     			
     		}else {
     			
     			$("#deCntUrl").closest("tr").hide();
     			
     		}
     		
     		
     		$("#deTitle").text(inputData.title);
     		$("#deContent").html(inputData.contents);
     		$("#deWriter").text(inputData.writer);
     		$("#deCount").text(inputData.count);
     		$("#deStar").text(star);
     		
     		//파일 정보 있을때만 파일 IDX 셋팅
     		if(inputData.file_idx != null) {
     			
     			$("#deFile").closest("tr").show();
     			$("#deFile").attr("href", "/board/fileDownload?boardNo="+inputData.file_idx);
     			$("#deFile").text(inputData.origin_name);
     			
     			//수정 팝업에도 셋팅
     			$("#fileName").text(inputData.origin_name);
     			$("#fileDelBtn").attr("onclick", "delFileConfirm("+inputData.file_idx+")");
     			
     			
     		}else {
     			
     			$("#deFile").closest("tr").hide();
     			
     		}
     		
     		//수정 input
     		$("#updCntTitle").val(inputData.contents_title);
     		$("#updCntUrl").val(inputData.contents_url);
     		$("#updTitle").val(inputData.title);
     		$('#updContent').summernote('code', inputData.contents);
     		$('input[name="grades"][value="' + inputData.grades + '"]').prop('checked', true);
     		
     		
            //현재 로그인 한 사용자가 글 작성자인지 확인.   
            //작성자 라면 수정,삭제 버튼 활성화
     		if(writerYn == "Y") {
     			
     			$("#deDel").show();
     			$("#deUpd").show();
     			$("#deConf").hide();
     			
         		//게시글 번호 data-value에 set
         		$("#deDel").attr("onclick", "delConfirm("+inputData.idx+")");
         		$("#deUpd").attr("onclick", "updatePopup("+inputData.idx+", "+inputData.file_idx+")");
     			
     		}else {
     			
     			$("#deDel").hide();
     			$("#deUpd").hide();
     			$("#deConf").show();
     			
     		}
	
     		//modal 띄우기
     		$('#detailModalBody').modal('show');
     		
     		//그밖의 보임/숨김 제어
     		$("#updateModal").hide();
     		$("#detailModal").show();
     		$("#deUpdSub").hide();
     		$("#updFileUpload").hide();
   			$("#inputFile").hide();
   			$("#fileDelBtn").hide();
     		
     		
     	}, error : function(e) {
     		openPopup("서버 오류가 발생 했습니다.");  
     	}                                           
     }); 
	
}

//글 작성 aJax
var writeSubmit = function() {
	
	  //select가 직접입력이 아닐 시 input에 셋팅
	  var selectContents = $("#contentsList").val();
	  
	  if(selectContents != "select") {
		  $("#contents-txt").val(selectContents);
	  }
	  
	  
	  //유효성 검사
	  if(checkValidation('ins')) {
		  
		  
		  var data = $("#writeForm").serializeArray();
		  
		  
	 	   	$.ajax({                                      
			   	url : "/board/writeProcess",                
			   	type : 'POST',                              
			   	async : false,                              
			   	data : data,                                
			   	dataType: 'json',   
			   	success : function(data) {
				
			   		if (data.result == 1) {
			   			
			   			//첨부된 파일이 있을경우 file 업로드 함수 실행
			   			if($("#insFile").val() != '') {
				   			fileUpload(data.idx, 'w');
			   			}else {
				   			openPopup("글작성이 완료 되었습니다.", "Y");
			   			}
			   			
			   		}else {
			   			openPopup("처리중 오류가 발생 했습니다."); 
			   		}
			   		
			   	}, error : function(e) {
			   		openPopup("서버 오류가 발생 했습니다.");  
			   	}                                           
		   });   
	 	
	  }
	  
}


//글 수정 aJax
var updSubmit = function(idx) {
	
	
	//변경 할 index set
	$("#updIdx").val(idx);
	
	//Form 직렬화
	var data = $("#updateModal").serializeArray();
	
	  $.ajax({                                      
		   	url : "/board/updateProcess",                
		   	type : 'POST',                              
		   	async : false,                              
		   	data : data,                                
		   	dataType: 'json',                           
		   	success : function(data) {
				
		   		if (data.result == 1) {
		   			
		   			//첨부된 파일이 있을경우 file 업로드 함수 실행
		   			if($("#updFile").val() != '') {
		   				
		   				fileUpload($("#updIdx").val(), 'u');
		   				
		   			}else {
		   				
			   			openPopup("수정이 완료 되었습니다.", "Y");	
			   			
		   			}
		   			
		   		}else {
		   			openPopup("처리중 오류가 발생 했습니다."); 
		   		}
		   		
		   	}, error : function(e) {
		   		openPopup("서버 오류가 발생 했습니다.");  
		   	}                                           
	   }); 
	
	
	
}


//글 삭제 aJax
var delSubmit = function(idx) {
	
	var data = { idx: idx };
	
  $.ajax({                                      
   	url : "/board/deleteProcess",                
   	type : 'GET',                              
   	async : false,                              
   	data : data,                                
   	dataType: 'json',                           
   	success : function(data) {
	
   		if (data.result == 1) {
   			openPopup("삭제가 완료 되었습니다.", "Y");	
   		}else {
   			openPopup("처리중 오류가 발생 했습니다."); 
   		}
   		
   	}, error : function(e) {
   		openPopup("서버 오류가 발생 했습니다.");  
   	}                                           
   }); 
  
}



//검색 처리 함수
var srchFn = function() {
	
	
	 var srchType = $('#srchSel').val();   //검색 타입
	 var srchTxt  = $("#srchTxt").val();   //검색 내용
	 
      
      var data = {
    		   srchType: srchType,
    		   srchTxt: srchTxt,
               page: 0,
               amount: 10,
               currentPage: 1
      };
       
      $.ajax({                                     
	       	url : "/board/qryBoardList",                
	       	type : 'POST',                              
	       	async : false,                              
	       	data : JSON.stringify(data),  
	       	contentType: "application/json; charset=utf-8",
	       	dataType: 'json',                           
	       	success : function(data) 
	       	{
	       		reloadList(data);
	       		
	       	}, error : function(e) {
	       		
	       		openPopup("서버 오류가 발생 했습니다.");
	       		
	       	}                                           
    });
};


//페이징 처리 함수
var pageFn = function(pageObj) {
	
    var page        = $(pageObj).data('value');
    var currentPage = $("#pagination").data('value');
    var amount = 10;
    
	var srchType = $('#srchSel').val();   //검색 타입
	var srchTxt  = $("#srchTxt").val();   //검색 내용 

    //현재 페이지 번호를 눌렀을 경우
    if(page == currentPage){
    	
        return false
        
    }else {
		
    	currentPage = page;
        page = (page -1) * amount;

        var data = {
     		   page: page,
     		   amount: amount,
     		   currentPage: currentPage,
    		   srchType: srchType,
    		   srchTxt: srchTxt
       		};

        $.ajax({                                     
	       	url : "/board/qryBoardList",                
	       	type : 'POST',                              
	       	async : false,                              
	       	data : JSON.stringify(data),  
	       	contentType: "application/json; charset=utf-8",
	       	dataType: 'json',                           
	       	success : function(data) {
	       		
	       		reloadList(data);
	       		
	       	}, error : function(e) {
	       		
	       		openPopup("서버 오류가 발생 했습니다.");
	       		
	       	}                                           
      }); 

    }

}

//


//비동기 처리 List 새로 그리는 함수
var reloadList = function(data) {
	
    var data 		 = $(data)[0];
    var list 		 = data.boardList;
    var totalCnt 	 = data.totalCount;
    var html 		 = "";
    
    //조회 게시글이 없으면 안내 문구 노출
    if(totalCnt == 0) {
    
    	$("#boardTable").hide();
    	$("#noneList").show();
	
    //게시글 비동기로 노출
    }else{
    	
    	$("#noneList").hide();
    	$("#boardTable").show();
    	
        var pageInfo	 = data.pageInfo;
        var currentPage  = pageInfo.currentPageNum;
        var amount  	 = pageInfo.postsPerPage;
        var pageHtml 	 = "";


        for(var i=0; i<list.length; i++) {

            var num = totalCnt - (currentPage-1) * amount;

            html +=       '<tr onclick="detailPopup('+list[i].idx+')" style="cursor: pointer">';
            html +=	          '<th>'+(num-i)+'</th>';
            html +=	          '<td>'+list[i].title+'</td>';
            html +=	          '<td class="starList">';
             	              	   for(var j=1; j<=list[i].grades; j++) {
            html +=	                  '<span>★</span>';
             	              	   }
            html +=	          '</td>';
            html +=	          '<td style="color:olive;"><b>'+list[i].contents_title+'</b></td>';
            html +=	          '<td>'+list[i].writer+'</td>';
            html +=	          '<td>'+list[i].regdate+'</td>';
            html +=	       '</tr>';

        }
        
        $("#boardList").html(html);
        

	    //페이징 비동기 처리
	    if(totalCnt > 0) {
	    	
	    	if (pageInfo.isPrevExist == true && pageInfo.currentPageNum > 5) {
	    		pageHtml += '<button type="button" class="btn btn-outline-primary" onclick="pageFn(this)" data-value="'+ 1 +'">&lt;&lt;</button>';
	    	}
	    	
	        if (pageInfo.isPrevExist == true && pageInfo.currentPageNum > 5) {
	            pageHtml += '<button type="button" class="btn btn-outline-primary" onclick="pageFn(this)" data-value="'+ (pageInfo.blockFirstPageNum - 1) +'">&lt;</button>';
	        }
	
	        if (pageInfo.totalPostCount > 0) {
	            for(var i = 0; i < pageInfo.pageList.length; i++) {
	                pageHtml += '   <button type="button" class="btn btn-outline-primary' + (pageInfo.pageList[i] ==  pageInfo.currentPageNum ? " active" : "") +'" onclick="pageFn(this)" data-value="'+pageInfo.pageList[i]+'" >';
	                pageHtml += 	      pageInfo.pageList[i];
	                pageHtml += '   </button>';
	            }
	        }
	
	        if(pageInfo.isNextExist == true) {
	            pageHtml += '<button type="button" class="btn btn-outline-primary" onclick="pageFn(this)" data-value="'+ (pageInfo.blockLastPageNum + 1) +'" >&gt;</button>';
	        }
	        
	        if(pageInfo.isNextExist == true) {
	            pageHtml += '<button type="button" class="btn btn-outline-primary" onclick="pageFn(this)" data-value="'+ (pageInfo.totalLastPageNum) +'" >&gt;&gt;</button>';
	        }
	        
	        $('#pagination').html(pageHtml);
	        
	    }else {
	        $('#pagination').empty();
	    }
        
        //현재 페이지를 불러온 페이지로 변경
        $("#pagination").data("value", currentPage);
	    
	}

};


//파일업로드 함수
var fileUpload = function(boardNo, type) {
	
	var formData = "";
	
	//type의 경우 현재 호출 한 프로세스가, 글작성일 경우 w , 글 수정일 경우 u
	if(type == 'w') {
		formData = new FormData($("#insFileUpload")[0]);
	}else {
		formData = new FormData($("#updFileUpload")[0]);
	}
	
	
    // boardNo 파라미터를 formData에 추가
    formData.append("boardNo", boardNo);
    
	$.ajax({
        url : '/board/fileUpload' ,
        type : 'POST' ,
        enctype: 'multipart/form-data' ,
        data : formData , 
        processData: false ,
   	    contentType: false ,
        success : function(result) {
        	
        	if(type == 'w') {
	   			openPopup("글작성이 완료 되었습니다.", "Y");
        	}else {
        		openPopup("수정이 완료 되었습니다.", "Y");
        	}
        	
       }, error : function(e) {
    	   
      		openPopup("서버 오류가 발생 했습니다.");
       
       }   
	});	
	
}


//파일 삭제 함수
var delFileSubmit = function(file_idx) {
	
    var data = { fileIdx : file_idx };
    
 
    $.ajax({                                     
       	url : "/board/removeFile",                
       	type : 'POST',                              
       	async : false,                              
       	data : data,  
       	contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       	dataType: 'text',                           
       	success : function(data) {
       		
       		openPopup("파일삭제 완료");
       		$("#inputFile").hide();
       		
       	}, error : function(e) {
       		
       		openPopup("서버 오류가 발생 했습니다.");
       		
       	}                                           
  }); 

	
}



var context = document
    .getElementById('myChart')
    .getContext('2d');

var myChart = new Chart(context, {
	
    type: 'bar', // 차트의 형태
    data: { // 차트에 들어갈 데이터
        labels: 
            //x 축
        	chartTitleArr,
        
        datasets: [
            { //데이터
                label: '평점', //차트 제목
                fill: false, // line 형태일 때, 선 안쪽을 채우는지 안채우는지
                
                //x축 label에 대응되는 데이터 값
                data: chartGrade,
                
                backgroundColor: [
                    //색상
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)'
                ]
            ,
                borderColor: [
                    //경계선 색상
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)'
                ],
                borderWidth: 3 //경계선 굵기
            } ,
        ]
    },
    options: {
        scales: {
            yAxes: [
                {
                    ticks: {
                        beginAtZero: true
                    }
                }
            ]
        }
    }
});


//부트스트랩 tooltip
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))

var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
	
  return new bootstrap.Tooltip(tooltipTriggerEl)
  
})


    
</script>
    
    

</div>
</body>
</html>