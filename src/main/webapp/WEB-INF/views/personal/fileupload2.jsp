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
body{ 
	-ms-overflow-style: none; 
	} 
::-webkit-scrollbar { 
	display: none; 
	}
.notes {
  background-attachment: local;
  background-image:
    linear-gradient(to right, white 10px, transparent 10px),
    linear-gradient(to left, white 10px, transparent 10px),
    repeating-linear-gradient(white, white 30px, #ccc 30px, #ccc 31px, white 31px);
  line-height: 31px;
  padding-top: 0 !important;
}
input:focus {
    outline: none !important;
}
textarea:focus {
    outline: none !important;
}

</style>
</head>
<body>
    <section id="hotels" class="section-with-bg">

      <div class="container" data-aos="fade-up">
        <div class="section-header">
          <h2>Upload Board</h2>
          <!-- <p>사진을 업로드하세요.</p> -->
        </div>
	<div class="card mx-auto text-center">
		<div class="card-header d-flex justify-content-between" style="background-color: rgba(6, 12, 34, 0.98); color:white;">
 			<div class="align-self-center">
					<%-- ${userInfo.userId}'s Board Upload  --%>
			</div>
			<div class="flex-inline justify-content-end">
				<a class="btn btn-danger btn-sm" id="btn-closes" href="" onclick="closeBoard()" style="
					color: #dc3545;
				    background-color: white;
				    border-color: white;"
			    >
					<i class="fas fa-times"></i>
				</a> 
			</div>
		</div>
		<div>
			<form action="${context}/sibal" method="post" enctype="multipart/form-data" onsubmit="return false" name="upload_form">
				<div class="input-group input-group-lg">
				  <input type="text" class="form-control" placeholder="Title" aria-label="Large" aria-describedby="inputGroup-sizing-sm" name="bdTitle" style="border:none; font-size:1.7rem">
				</div>
				<hr>
				<div class="input-group input-group-lg">
					<textarea class="form-control border-0 outline-none notes" placeholder="Content" rows="6" aria-label="With textarea" name="bdContent"></textarea>
				</div>
				<div class="tag_area d-flex flex-wrap">
					<div class="d-none" id="add_tag_input">
						<input type="text" class="border-0 bg-postit text-postit outline-none" id="add_tag_text" size="3"/>
					</div>
					<div class="mx-2 my-2 rgyPostIt" id="add_tag">+</div>				
				</div>
				<input type="text" id="tag" name="tag" class="d-none">
				<label class="btn btn-outline-dark w-25">
				<i class="far fa-images"></i><br>
					Choose file
					<input type="file" multiple class="d-none" accept="image/*" name="files" onchange="preview(this)">
				</label>					
				<div class="img_area mb-2 d-flex flex-wrap">
				</div>
				<button class="btn btn-dark w-100" onclick="submitBtn()">
				<i class="fas fa-file-upload"></i>
				Done
				</button>

				
			</form>	
		</div>
	</div>
	</div>
	</section>
<script src="${context}/resources/js/personal/fileUpload2.js"></script>
<script type="text/javascript">
	
	let closeBoard = () => {
		window.opener.location.href="${context}/personal/personal?nickName=${userInfo.nickName}";
			self.close();
	};



</script>
</body>
</html>