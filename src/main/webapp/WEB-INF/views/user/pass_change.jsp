<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>
	<style>
		.login_container {
		    width: 78%;
		    height: 52%;
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    margin: 0 auto;
		    border: 1px solid #E6E6E6;
		}
		
		.logo_header {
		    width: 90%;
		    display: flex;
		    justify-content: center;
		    padding: 10% 0 10%;
		}
		
		.logo_letter {
		    font-family: Lobster Two;
		    font-size: 50px;
		}
		
		.login_box {
		    display: flex;
		    flex-direction: column;
		}
		
		.login_input{
		    width: 75%;
		    height: 20%;
		    color: #999999;
		    background-color: #FAFAFA;
		    border: 1px solid #E6E6E6;
		    border-radius: 2%;
		    margin-bottom: 4%;
		    padding: 4%;
		}
		
		.btn {
		    margin-top: 5px;
		}
		
		.login_btn {
		    width: 268px;
		    height: 30px;
		    border-radius: 6px;
		    border: none;
		    margin: 5px 0 55px;
		    background-color: #0095F6;
		    color: white;
		    font-size: 14px;
		}
		.login_btn:disabled {
		    background-color: #C0DFFD;
		}
		
		.forgot_pw {
		    font-size: 14px;
		    color: #013569;
		    text-decoration: none;
		    align-items: baseline;
		}
	</style>
	
	
	<div class="container">
    	<div class="py-5 text-center">
        	<h2>비밀번호 설정하기</h2>
    	</div>
    	
    	<div class="login_container">
        	<header class="logo_header">
            	새로운 비밀번호를 입력해 주세요.
        	</header>
        	
        	<section class="login_box">
            	<input type="text" placeholder="새 비밀번호 입력" class="login_input" id="userID">
            		<div class="btn">
                		<button type="submit" name="submit"  class="login_btn" >로그인 하러가기</button>
            		</div>
        	</section>
    	</div>
   </div>
   
  

</body>
</html>