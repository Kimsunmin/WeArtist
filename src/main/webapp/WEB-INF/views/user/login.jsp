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
	
	<!-- 검색 자동완성 js파일 -->
	<script src="${context}/resources/js/common/autoSearch.js"></script>
	
	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
/* 	html,body{ */
/* 		width:100%; */
/* 		height:100%; */
/* 	} */
</style>
</head>
<body onload="window.resizeTo(500,550)">
	<section id="contact" class="section-bg">

      <div class="container" data-aos="fade-up">

        <div class="section-header">
          <h2>Login</h2>
          <p>회원정보를 입력해주세요.</p>
        </div>

        
        <div class="form">
          <form action="${context}/user/loginimpl" id="frm_join" name="popupForm" method="post" role="form" class="php-email-form">
            <div class="form-group mt-3">
              <input type="text" class="form-control" name="userId" id="userId" placeholder="ID" required>
            </div>
            <div class="form-group mt-3">
              <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
            </div>
            <div class="mt-3">
            <a href="" onclick="findPassword()" style="font-size:14px; color:#343a40;">Find ID/Password</a>
            <a href="" onclick="signUp()" id="signUP" style="float:right; font-size:14px; color:#343a40;">Sign Up</a>
            </div>
            <div class="my-3">
              <div class="loading">Loading</div>
              <div class="error-message"></div>
              <div class="sent-message">Your message has been sent. Thank you!</div>
            </div>
            <div class="text-center"><input type="button" class="login-submit" id="btn-login" value="Submit"></div>
          </form>
        </div>

      </div>
      </section>
<script src="${context}/resources/js/user/login.js"></script>
<script type="text/javascript">
	
	let signUp = () => {
		window.opener.location.href="${pageContext.request.contextPath}/user/join"
			self.close();
	};
	
	let findPassword = () => {
		window.opener.location.href="${pageContext.request.contextPath}/user/findPassword"
			self.close();
	};


</script>
</body>
</html>