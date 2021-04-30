<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>
	<section id="hero">
	    <div class="hero-container middle" data-aos="zoom-in" data-aos-delay="100">
		
		<div class="d-none" id="divUpload">
			<div class="card-body bg-dark">
				<p>${galleryUserId} 님의 Gallery에</p>
				<p>아직 업로드된 작품이 없습니다.</p>
				<a href="${context}/galleryinfo" class="btn btn-light">업로드 하러가기</a>
			</div>
		</div>
		
		<div class="position-absolute top-0 end-0">		
			<c:choose>
				<c:when test="${galleryUserId eq 'main'}">
					<a href="${context}/search/main" class="btn btn-dark">Back</a>
				</c:when>
				<c:otherwise>
					<div onclick="history.back()" class="btn btn-dark">Back</div>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${userInfo.userId eq galleryUserId and !empty galleryList}">
				<a href="${context}/galleryinfo" class="btn btn-dark">
					Setting
				</a>
			</c:if>
		</div>
	   
	    <div class="d-none" style="width: 600px; background-color: rgba(0,0,0,0.8)" id="divTest">
		  <img class="card-img-top" src="" alt="Card image cap" id="imgInfo">
		  <div class="card-body">
		    <p class="card-text" id="imgTitle"></p>
		    <div id="btn_back" class="btn btn-dark text-white">Back</div>
		  </div>
		</div>
	   </div>
	 </section>
	  <!-- End Hero Section -->
	<div id="userGalleryList" class="d-none">
		<c:forEach items="${galleryList}" var="item" varStatus="status">
			<div id="Cube003_${item.imgOrder}"
				data-title="${item.title}"
				data-content="${item.content}"
				data-path="${item.path}">
			</div>
		</c:forEach>
	</div>
	
	<script src="${context}/resources/js/gallery/three.js"></script>
	<script src="${context}/resources/js/gallery/OrbitControls.js"></script>
	<script src="${context}/resources/js/gallery/GLTFLoader.js"></script>
	<script src="${context}/resources/js/gallery/load-image.all.min.js"></script>
	<script type='module' src="${context}/resources/js/gallery/ShowGallery.js"></script>
</body>
</html>