	$("#btn-login").click(function(){
		
		 let userId = document.getElementById("userId");
		 let password = document.getElementById("password");
	      if(userId.value){
	         fetch("/user/pwchecked?userId=" + userId.value +"&password=" + password.value,{
	            method:"GET"
	         })
	         .then(response => response.text())
	         .then(text =>{
	            if(text == 'success'){
	            	var frm = $("#frm_join").serialize();

	            	$.ajax({
	            	       type: "POST",
	            	       url: "/user/loginimpl ",
	            	       data: frm,

	            	         success: function (data) {
	            	        	 console.log(data);
	            	        	 window.opener.location.reload();
	            	        	
	            	        	 self.close();

	            	        }, error: function (jqXHR, textStatus, errorThrown) {
	            	          alert(jqXHR + ' ' + textStatus.msg);
	            	       }

	            	});
	            }else{
	            	alert("비밀번호가 틀렸거나 없는 회원입니다.");
	            }
	         })
	      
	      }else{
	         alert("아이디를 입력하지 않으셨습니다.");
	      }
		
});