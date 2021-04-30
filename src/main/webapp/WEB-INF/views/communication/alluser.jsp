<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Montserrat:300,400,500,600,700" rel="stylesheet">
<link href="${context}/resources/rapid/assets/vendor/aos/aos.css" rel="stylesheet">
<link href="${context}/resources/rapid/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
<%-- <link href="${context}/resources/rapid/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>
<link href="${context}/resources/rapid/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<%-- <link href="${context}/resources/rapid/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet"> --%>

 

<link href="${context}/resources/rapid/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
</head>
<body>
	<div class="container d-flex flex-column">
		<c:forEach var ="userInfo" items ="${allUserList}" varStatus="status">
			<div><a class="user"onclick="followingTest('${userInfo.userId}')"><c:out value="${userInfo.userId}"></c:out></a></div>
		</c:forEach>
	</div>
	<script>
		function followingTest(userId){
			connectPushSocket(userId); //소켓 푸시로 팔로잉 할 유저 구독하여 푸시알림 전송
// 			const url ="communication/followingimpl";
// 			let paramObj = new Object();
// 			paramObj.fromId = currentUserId;
// 			paramObj.toId = userId;
// 			let headerObj = new Headers();
// 			headerObj.append("content-type","application/json");
			
// 			fetch(url,{
// 				method : "POST",
// 				headers : headerObj,
// 				bodt : JSON.stringify(paramObj)
// 			}).then(response =>{
// 				if(response.ok){
// 					return response.text();
// 				}
// 			}).then((text)=>{
// 				if(text!='failed'){
					
// 				}else{
					
// 				}
// 			});
// 		}
		
		function connectPushSocket(userId){
			stompPushClient.send("/push", {}, JSON.stringify({'fromId' : currentUserId, 'toId': userId})); //해당 유저에게 팔로잉 요청을 보낸다.
			createNewRoom(currentUserId,userId);
			reSetMyChatRoomList();	
			
// 			stompClient.connect({}, function(frame) {  
// 				stompClient.subscribe("/queue/"+userId,function(response){
					
// 				}
			}
		}
		
		
	</script>
</body>
</html>