<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>
    
	<div class="card w-50 mx-auto text-center" style="margin-top: 20px;">
		<div class="card-header d-flex justify-content-between" style="background-color: rgba(6, 12, 34, 0.98); color:white;">
			<div class="align-self-center">
					${userInfo.userId}'s Board Upload 
			</div>
			<div class="flex-inline justify-content-end">
				<a class="btn btn-danger btn-sm" id="btn-closes" href="${context}/personal/personal?nickName=${userInfo.nickName}" style="
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
				  <input type="text" class="form-control" placeholder="Title" aria-label="Large" aria-describedby="inputGroup-sizing-sm" name="bdTitle" style="border:none">
				</div>
				<hr>
				<div class="input-group input-group-lg">
					<textarea class="form-control border-0 outline-none" placeholder="Content" rows="10" aria-label="With textarea" name="bdContent"></textarea>
				</div>
				<div class="tag_area d-flex flex-wrap">
					<div class="d-none" id="add_tag_input">
						<input type="text" class="border-0 bg-postit text-postit outline-none" id="add_tag_text" size="3"/>
					</div>
					<div class="mx-2 my-2 rgyPostIt" id="add_tag">+</div>				
				</div>
				<input type="text" id="tag" name="tag" class="d-none">
				<div class="form-group row">
				<label class="btn btn-outline-dark w-100" style="width: 200px !important;">
				<i class="far fa-images"></i>
					Choose file
					<input type="file" multiple class="d-none" accept="image/*" name="files" onchange="preview(this)">
				</label>
				<button class="btn btn-outline-dark w-100" style="width: 200px !important;" onclick="submitBtn()">
				<i class="fas fa-file-upload"></i>
				Done
				</button>
				</div>
				<div class="img_area mb-2 d-flex flex-wrap">
				</div>

				
			</form>	
		</div>
	</div>
	<script src="${context}/resources/js/personal/fileUpload.js"></script>
</body>
</html>