<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>


	<div class="container">
    	<div class="py-5 text-center">
        	<h2>로그인</h2>
    	</div>
    	
	    <div class="row justify-content-center">
	        <form class="needs-validation col-sm-6" id="frm_join" action="${context}/user/loginimpl" method="post">
	                <div class="input-group mb-3">
	                    <input type="text" name="userId" class="form-control" placeholder="아아디">
	                    	<div class="input-group-append">
	                        	<div class="input-group-text">
	                        		<span class="fas fa-exclamation">
	                        		</span>
	                    		</div> 
	                		</div>
	    			</div>
	    			
	    			<div class="input-group mb-3">
	        			<input type="password" name="password" class="form-control" placeholder="비밀번호">
	        				<div class="input-group-append">
	            				<div class="input-group-text">
	 								<span class="fas fa-lock">
									</span>
	            				</div>
	       					</div>
	   				</div>
	   				
					<div class="form-group">
						<div class="interval_height a_none">
							<a href="${pageContext.request.contextPath}/user/findPassword">&nbsp; 아이디 / 비밀번호 찾기</a>
						</div>
					</div>
	
	        		<div class="col-4">
	            		<button type="btn-login" class="btn btn-primary btn-block"> 로그인</button>
	        		</div>
	    	</form>
	       
		</div>
	</div>



</body>
</html>