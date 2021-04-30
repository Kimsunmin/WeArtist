<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ include file="/WEB-INF/views/include/common_socket.jsp"%> <!-- Socket 연결 모듈 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta content="width=device-width, initial-scale=1.0" name="viewport">
	<title>We Artist!</title>
	
	<c:set var="context" value="${pageContext.request.contextPath}"/>
	<script type="text/javascript" src="${context}/resources/js/common/urlEncoder.js"></script>
	<script type="text/javascript" src="${context}/resources/js/common/asyncPageError.js"></script>
	
	
	<!-- Socket CDN추가 -->
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script> <!-- socjJS CDN -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script> <!-- STOMP CDN -->
	
	
	
	<!-- Google Fonts -->
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">
  	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800" rel="stylesheet">
	<!-- Vendor CSS Files -->
  	<link href="${context}/resources/theEvent/assets/vendor/aos/aos.css" rel="stylesheet">
  	<link href="${context}/resources/theEvent/assets/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
  	<link href="${context}/resources/theEvent/assets/vendor/bootstrap/css/bootstrap-icons.css" rel="stylesheet">
  	<link href="${context}/resources/theEvent/assets/vendor/glightbox/css/glightbox.css" rel="stylesheet">
  	<link href="${context}/resources/theEvent/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
  	
  	<link href="${context}/resources/common/css/common.css" rel="stylesheet">
  	<!-- Template Main CSS File -->
  	<link href="${context}/resources/theEvent/assets/css/style.css" rel="stylesheet">
  	
  	<!-- Vendor JS Files -->
	<script src="${context}/resources/theEvent/assets/vendor/aos/aos.js"></script>
	<script src="${context}/resources/theEvent/assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
	<script src="${context}/resources/theEvent/assets/vendor/glightbox/js/glightbox.js"></script>
	<script src="${context}/resources/theEvent/assets/vendor/swiper/swiper-bundle.min.js"></script>
	
	
	<!-- Template Main JS File -->
	<script src="${context}/resources/theEvent/assets/js/main.js"></script>
	<!-- fontAwsome -->
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" rel="stylesheet"/>
	
	<!-- 구글폰트 링크 -->
	<link href="https://fonts.googleapis.com/css?family=Nanum+Pen+Script&display=swap" rel="stylesheet"/>
	
	<!-- 검색 자동완성 js파일 -->
	<script src="${context}/resources/js/common/autoSearch.js"></script>
<style>
/* 	html,body{ */
/* 		width:100%; */
/* 		height:100%; */
/* 	} */
</style>
</head>
<body>
	<!-- ======= Header ======= -->
<header id="header" class="d-flex align-items-center">
    	<div class="container-fluid d-flex align-items-center justify-content-between">
	      <div class="container text-center" id="logo">
	        <!-- Uncomment below if you prefer to use a text logo -->
	        <!-- <h1><a href="index.html">The<span>Event</span></a></h1>-->
	        <a href="/index" class="scrollto fs-2 text-white" style="text-decoration:none;">We Artist</a>
	      </div>
	      
<!-- <img src="/resources/theEvent/assets/img/logo.png" alt="" title=""> -->
		<div class="container input-group border rounded-pill p-2" style="width:90vw;">
	    			<span class="input-group-text bg-transparent border border-0 px-1"><i class="fas fa-search text-muted" style="font-size:1vw;"></i></span>
 					<input type="text" id="inp_search_user" class="form-control border border-0 shadow-none bg-transparent text-muted p-0" placeholder="유저를 검색하세요" style="outline:none; font-size:1vw;">
			  </div>
	      <nav id="navbar" class="container navbar order-last order-lg-0 d-flex justify-content-center">
	        <ul>
	          <li><a class="nav-link scrollto active fs-5" href="/search/main" style="font-family: 'Open Sans', sans-serif;">Home</a></li>
	          <li><a class="nav-link scrollto fs-5" href="/gallery/main" style="font-family: 'Open Sans', sans-serif;">Gallery</a></li>
	          <li><a class="nav-link scrollto fs-5" href="/live/guest" style="font-family: 'Open Sans', sans-serif;">Live</a></li>
	          <c:if test="${userInfo!=null}">
	           <li><a class="nav-link scrollto fs-5" href="/personal/personal?nickName=${userInfo.nickName}" style="font-family: 'Open Sans', sans-serif;">MyPage</a></li>
	          </c:if>
	          <c:choose>
	          	<c:when test="${empty userInfo}">
	          		<li><a class="nav-link scrollto fs-5" href="/user/login" onclick="window.open(this.href, '_blank', 'width=500, height=400, left=550, top=200'); return false;" style="font-family: 'Open Sans', sans-serif;">Login</a></li>
	          	</c:when>
	          	<c:otherwise>
	          		<li><a class="nav-link scrollto fs-5" href="/user/logout" style="font-family: 'Open Sans', sans-serif;">Logout</a></li>
	          	</c:otherwise>
	          </c:choose>
	          <li><a class="nav-link scrollto fs-5" href="/user/join" style="font-family: 'Open Sans', sans-serif;">Join</a></li>
	          <li><a class="nav-link scrollto fs-5" href="/chat/direct" style="font-family: 'Open Sans', sans-serif;"><i class="fas fa-envelope fs-5 text-white"></i></a>
	          	 <span id="message_noti_count" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.3vw;"></span>
	          </li>
			  <li style="cursor: pointer;">
			 	 <i id="notification_icon" class="fas fa-bell fs-5 text-white"></i>
				 <span id="noti_count" class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.3vw;"></span>
			 </li>
	        </ul>
	        <i class="bi bi-list mobile-nav-toggle"></i>
	      </nav>
	      <!-- .navbar -->
    	</div>
    		<div id="auto_search"class="card position-fixed top-0 start-50 translate-middle-x border border-1" style="width: 30vw; z-index: 999; visibility: hidden; margin-top:7.7vh;"></div>
    		<div id="noti_box"class="card position-fixed top-0 end-0 border border-1" style="width: 20vw; height:20vh; z-index: 999; visibility: hidden; margin-top:7.7vh; margin-right:1vh; overflow:auto;">
    			<div id="empty_noti_box"class="d-flex align-items-center justify-content-center text-muted "style="height:100%;">
    				알림이 없습니다.
    			</div>
    			<ul id="list_group" class="list-group">
    			
    			</ul>
    			<!-- 알림 목록을 동적으로 뿌려줄 곳 -->
    		</div>
  	</header>
<!--   	<div id="auto_search"class="navbar-nav position-fixed start-50 translate-middle-x border border-1" style="width:30vw; z-index:999; visibility:hidden;"></div> -->
  	
  	
  	<!-- Toast창  -->
  	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 5">
		<div id="liveMessageToast" class="toast fade" role="alert" aria-live="assertive" aria-atomic="true">
    		<div class="toast-header bg-light d-flex justify-content-end">
      			<button id="btn_toast_close"type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    		</div>
    	<div class="toast-body">
    		<a id="toast_msg" class="text-primary" onclick="" style="cursor:pointer;"></a>
    	</div>
  		</div>
	</div>
	
	<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 4">
		<div id="liveFollowingToast" class="toast fade" role="alert" aria-live="assertive" aria-atomic="true">
    		<div class="toast-header bg-light d-flex justify-content-between">
    			<i class="fas fa-bell fs-5 text-dark"></i>
      			<button id="btn_toast_close"type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
    		</div>
    	<div class="toast-body">
      		<a id="followingMessage" class="text-primary" onclick="" style="cursor:pointer;">팔로잉 요청이있습니다.</a>
    	</div>
  		</div>
	</div>