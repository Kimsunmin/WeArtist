<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>
    <section id="contact" class="section-bg">

      <div class="container" data-aos="fade-up">

        <div class="section-header">
          <h2>PROFILE</h2>
          <p>프로필 정보를 설정해주세요.</p>
        </div>

        <div class="row contact-info">

          <div class="col-lg-4">
            <div class="contact-address">
            <div class="jb-a rounded-circle" style="
							    width: 14rem;
							    height: 14rem;
							    border: 0.5rem solid rgba(0, 0, 0, 0.1);
							">
            	<c:set var="pic" value="${picture.files}"/>
                    <c:choose>
                    	<c:when test="${empty pic}">
		                    <img class="mx-auto propic" id="picture" src="/resources/img/dummy_img.png" alt="" style="
							    width: 14rem;
							    height: 14rem;
							">
						</c:when>
						<c:otherwise>
							<img class="mx-auto propic" id="picture" src="<c:url value="/images/${pic.fSavePath}/${pic.fRename}"/>" alt="" style="
							    width: 14rem;
							    height: 14rem;"
							    >
						</c:otherwise>
					</c:choose>
					<div class="overlay overlayFade">
						<div class="textProPic">
							<label for="ex_file">
								<i class="fas fa-plus" style="color: blanchedalmond;"></i>
							</label> 
						</div>
					</div>			
			</div>
			<p></p>
             <form action="${contetxt}/user/proPic" id="frm-pic" name="form"
						method="post" enctype="multipart/form-data" autocomplete="off" style="margin-top: 5px">
						<input class="d-none" type="file" id="ex_file" accept="image/jpeg,image/png" name="files" onchange="preview(this)" required />
						<!-- <input type="button" class="btn btn-outline-secondary" onClick="ajaxFileUpload();" value="업로드"/> -->
						<!-- <button class="btn btn-outline-secondary" id="submit-frm" onclick="submitBtn()">업로드</button> -->
				</form>
			<div style="font-size: 30px;
				    margin-bottom: 15px;
				    font-weight: bold;
				    color: #112363;
				    margin-top: 8px;
				    ">
				    <mark>
             ${sessionScope.userInfo.userId}
             </mark>
              </div>
            </div>
          </div>

          <div class="col-lg-6">
            <div class="contact"  style="
            		margin-bottom: 20px;
            		padding: 20px 0;
            		">
            		<div class="form">
		          <form id="frm-profile" action="${context}/user/update" method="post" role="form" class="php-email-form" novalidate>
		            
		              <div class="form-group col-md-10 row">
		              	<label for="name" class="col-sm-2 col-form-label">Name</label>
		              	<input class="form-control" type="hidden" name="userId" value="${sessionScope.userInfo.userId }">
		                <input type="text" name="name" class="form-profile" id="name" value="${sessionScope.userInfo.name }"  minlength="2" maxlength="50" required>
		              </div>
		              <div class="form-group col-md-10 mt-3 row">
		              	<label class="col-sm-2 col-form-label">Email</label>
		                <input type="email" class="form-profile" name="email" id="email" value="${sessionScope.userInfo.email }" readonly>
		              </div>
		            
		            <div class="form-group col-md-10 mt-3 row">
		            	<label for="password" class="col-sm-2 col-form-label">Password</label>
		              	<input type="password" class="form-profile" name="password" id="pw" placeholder="Password" minlength="8" maxlength="16" required>
		              	<span id="pw_confirm" class="text-danger"></span>
		            </div>
		            <div class="form-group col-md-10 mt-3 row">
		            	<label for="phone" class="col-sm-2 col-form-label">Phone</label>
		             	<input type="tel" class="form-profile" id="phone" name="phone" value="${sessionScope.userInfo.phone }">
		            </div>
		            <div class="form-group col-md-10 mt-3 row">
		            	<label for="inputNickname" class="col-sm-2 col-form-label">Nickname</label>
		             	<input type="text" class="form-profile" name="nickName" id="nickName" value="${sessionScope.userInfo.nickName }" required>
		             	<input type="hidden" class="form-profile" name="curNick" id="curNick" value="${sessionScope.userInfo.nickName }">
		             	<div class="row col-md-12">
		             	<button class="btn btn-dark btn-submit" type="button" onclick="nicknameCheck()" style="margin-top:5px;">check</button>
		             	<span class="text-danger nick-check" id="nickname_check"></span>
		             	</div>
		            </div>
		            <div class="my-3">
		              <div class="loading">Loading</div>
		              <div class="error-message"></div>
		              <div class="sent-message">Your message has been sent. Thank you!</div>
		            </div>
		            <div class="text-center col-md-10"><button type="submit">Submit</button></div>
		          </form>
		        </div>
            </div>
          </div>

          <!-- <div class="col-md-4">
            <div class="contact-email">
              
            </div>
          </div> -->

        </div>

        

      </div>
    </section><!-- End Contact Section -->
    <%@include file ="/WEB-INF/views/include/footer.jsp" %>
<script src="${context}/resources/js/user/profile.js"></script>

</body>
</html>