<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>

<section class="position-relative">
	<div class="card w-50 mx-auto">
		<div class="card-header d-flex justify-content-between">
				<div class="align-self-center">
					${userInfo.userId} 
				</div>
				<div class="flex-inline justify-content-end">
					<div class="btn btn-danger btn-sm" id="btn-closes" onclick="backPage('${userInfo.nickName}')">
						X
					</div> 
				</div>
			</div>
		<div class="row justify-content-center">
			<c:forEach items="${userGalleryData}" var="data" begin="3" end="5" varStatus="status">			
				<div class="col-3">
					<c:choose>
						<c:when test="${empty data}">
							<img src="/resources/img/defaultImg.png" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:when>
						<c:otherwise>
							<img src="${data.path}" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:otherwise>
					</c:choose>
				</div>
			</c:forEach>
		</div>
		
		<c:forEach items="${userGalleryData}" var="data" begin="8" end="8" varStatus="status">
			<div class="row justify-content-between">
				<div class="col-3">
					<c:choose>
						<c:when test="${empty data}">
							<img src="/resources/img/defaultImg.png" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:when>
						<c:otherwise>
							<img src="${data.path}" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col-3">
					<c:choose>
						<c:when test="${empty data}">
							<img src="/resources/img/defaultImg.png" alt="" class="img-thumbnail" id="gallery-img${status.index+2}"/>
						</c:when>
						<c:otherwise>
							<img src="${data.path}" alt="" class="img-thumbnail" id="gallery-img${status.index+2}"/>
						</c:otherwise>
					</c:choose>
				</div>
			</div>			
		</c:forEach>
		
		<c:forEach items="${userGalleryData}" var="data" begin="7" end="7" varStatus="status">
			<div class="row justify-content-between">
				<div class="col-3">
					<c:choose>
						<c:when test="${empty data}">
							<img src="/resources/img/defaultImg.png" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:when>
						<c:otherwise>
							<img src="${data.path}" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col-3">
					<c:choose>
						<c:when test="${empty data}">
							<img src="/resources/img/defaultImg.png" alt="" class="img-thumbnail" id="gallery-img${status.index+4}"/>
						</c:when>
						<c:otherwise>
							<img src="${data.path}" alt="" class="img-thumbnail" id="gallery-img${status.index+4}"/>
						</c:otherwise>
					</c:choose>
				</div>
			</div>			
		</c:forEach>
		
		<c:forEach items="${userGalleryData}" var="data" begin="6" end="6" varStatus="status">
			<div class="row justify-content-between">
				<div class="col-3">
					<c:choose>
						<c:when test="${empty data}">
							<img src="/resources/img/defaultImg.png" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:when>
						<c:otherwise>
							<img src="${data.path}" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="col-3">
					<c:choose>
						<c:when test="${empty data}">
							<img src="/resources/img/defaultImg.png" alt="" class="img-thumbnail" id="gallery-img${status.index+6}"/>
						</c:when>
						<c:otherwise>
							<img src="${data.path}" alt="" class="img-thumbnail" id="gallery-img${status.index+6}"/>
						</c:otherwise>
					</c:choose>
				</div>
			</div>			
		</c:forEach>
		
		<div class="row justify-content-center d-flex flex-row-reverse">
			<c:forEach items="${userGalleryData}" var="data" begin="0" end="2"  varStatus="status">			
				<div class="col-3">
					<c:choose>
						<c:when test="${empty data}">
							<img src="/resources/img/defaultImg.png" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:when>
						<c:otherwise>
							<img src="${data.path}" alt="" class="img-thumbnail" id="gallery-img${status.index+1}"/>
						</c:otherwise>
					</c:choose>
				</div>
			</c:forEach>
		</div>
		<div class="card-footer">
			<div class="btn btn-light" onclick="uploadGalleryInfo('${userInfo.nickName}')">Save</div>
		</div>
	</div>
    <div class="d-none" id="BoardList" style="background-color: rgba(255,255,255,1);">
		<div class="card-header d-flex justify-content-between">
			<div class="align-self-center">
				Upload
			</div>
			<div class="flex-inline justify-content-end">
				<div class="btn btn-danger btn-sm" id="btn-close">
					X
				</div> 
			</div>
		</div>
		<div class="row card-body overflow-auto" style="height: 600px;" id="boardListContent">
			<div class="col-3 mb-1" onclick="setGalleryInfo(null,null,'${userInfo.userId}','/resources/img/defaultImg.png')">
				<img src="/resources/img/defaultImg.png" alt="" class="img-fluid"/>
				
			</div>
			<c:forEach items="${userBoardData}" var="boardData">			
					<c:forEach items="${boardData.files}" var="boardFile" varStatus="status">				
						<div class="col-3 mb-1" onclick='setGalleryInfo(
														"${boardData.board.bdNo}",
														"${boardFile.fIdx}",
														"${boardFile.userId}",
														"/images/${boardFile.fSavePath}${boardFile.fRename}")'>
							<img src="/images/${boardFile.fSavePath}${boardFile.fRename}" alt="" class="img-fluid"/>
						</div>
					</c:forEach>
			</c:forEach>
		</div>
	</div>
</section>

<script type="text/javascript" src="/resources/js/gallery/upload.js"></script>
</body>
</html>