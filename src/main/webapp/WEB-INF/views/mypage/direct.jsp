<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/topMenuHead.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script> <!-- socjJS CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script> <!-- STOMP CDN -->

<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Montserrat:300,400,500,600,700" rel="stylesheet">

<style>
 	@media(max-width: 992px) {  
 	 	#follow_list{ 
 	 	display:none;
 	 	} 
 	 	#chat_layout{
 	 		width:100vw;
 	 	}
	 } 
</style>
</head>
<body id="body">
	<main id="main">
	<section id="contact" class="section-bg bg-dark d-flex justify-content-center">
		<div class="row container  d-flex justify-content-center align-items-center bg-light p-2" style="height:70vh; border-radius:50px;">
			<div id="follow_list"class="card col-4 bg-light" style="height:60vh;">
				<div id="userId" class="card-header p-4 bg-light text-center fw-bold">${userInfo.nickName}</div> 
				<div id="sender_list_box"class="card-body d-flex flex-column" style="width:100%;height:70vh; overflow:auto;">
					<c:forEach var ="chatContent" items ="${lastMessageList}" varStatus="status">
						<div class="chat_room_card card p-3 position-relative mb-2 bg-light">
							<c:if test="${userInfo.userId eq chatContent.msgTo}">
							<a href="#" class="following_user text-dark mb-3 item_following_user" data-userid="${chatContent.msgFrom}"><c:out value="${chatContent.msgFromNickName}"></c:out></a>
							</c:if>
							<c:if test="${userInfo.userId eq chatContent.msgFrom}">
							<a href="#" class="following_user text-dark mb-3 item_following_user" data-userid="${chatContent.msgTo}"><c:out value="${chatContent.msgToNickName}"></c:out></a>
							</c:if>
								<c:if test="${chatContent.msgFrom !=userInfo.userId and chatContent.isCheck eq '0'}">
								<div class="last_message text-dark fw-bold" data-usernick='${chatContent.msgFromNickName}'><c:out value="${chatContent.msg}"></c:out></div>
								</c:if>
								<c:if test="${chatContent.msgFrom !=userInfo.userId and chatContent.isCheck eq '1'}">
								<div class="last_message text-dark"  data-usernick='${chatContent.msgFromNickName}'><c:out value="${chatContent.msg}"></c:out></div>
								</c:if>
								<c:if test="${chatContent.msgFrom == userInfo.userId}">
								<div class="last_message text-dark"  data-usernick='${chatContent.msgToNickName}'><c:out value="${chatContent.msg}"></c:out></div>
								</c:if>
								<p class="last_message_time position-absolute bottom-0 end-0 p-1 fw-light" style="margin-bottom: 0px; font-size:1px;"><c:out value="${chatContent.msgTime}"></c:out></p>
						</div>
					</c:forEach>
				</div>
			</div>
			<div id="chat_layout"class="card col-7 bg-light" style="height:60vh;">
				<div id="opponent_layout"class="d-flex justify-content-between align-items-center border-bottom py-3" style="visibility:hidden;">
					<div id="opponent" class="bg-light p-2 fw-bold"></div>
					<div onclick="showChatListModal();" style="cursor:pointer;">
						<p id="plus"><i id="plus_content"class="fas fa-plus-circle position-absolute top-0 end-0 mx-3 mt-3"style="font-size:30px;"></i></p>
					</div>
				</div>
					<div id="chat_box" class="card-body d-flex flex-column" style="overflow:auto;">
					<div id="chat_index"class="container position-relative" style="width:30vw; height:100%">
						<div onclick="showChatListModal();" style="cursor:pointer;">
						<p class="position-absolute top-50 start-50 translate-middle"><i class="far fa-circle" style="font-size:45px;"></i></p>
						<p class="position-absolute top-50 start-50 translate-middle"><i class="fas fa-location-arrow"style="font-size:25px;"></i></p>
						</div>
						
					</div>
					</div>
					<div id="send_message_box" class="card-footer bg-transparent" style="visibility:hidden;">
						<div class="input-group border rounded-pill p-2 bg-white">
 			 				<input id="msg_box" type="text" class="form-control border border-0 bg-white shadow-none" placeholder="메시지를 입력하세요" style="outline:none" onkeydown="JavaScript:sendMessage();">
						</div>
					</div>
			</div>
		</div>
	</section>
	<!-- 채팅방 리스트 모달 -->
	<div class="modal fade" id="messageListModal" tabindex="-1" aria-labelledby="messageListModalLabel" aria-hidden="true">
 			<div class="modal-dialog modal-dialog-centered">
   				<div class="modal-content" style="border-radius: 20px;">
    				<div class="d-flex border-bottom p-2">
        				<div class="modal-title fw-bold text-center flex-fill" id="messageListModal">
        				새로운 메세지
        				<button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
        				</div>
        			
      				</div>
      				<ul id="chat_list"class="list-group list-group-flush m-2" style="overflow:auto; height:20vh;">
      					<!-- 비동기로 데이터를 받아올 곳 -->
      				</ul>	
    			</div>
 		 	</div>
		</div>
	
	</main>	
		<%@include file ="/WEB-INF/views/include/footer.jsp" %>
		<script src="${context}/resources/js/mypage/direct.js"></script>
		<script>
			let senderList = new Array();
			let obj;
			<c:forEach var="senderInfo" items="${senderList}" varStatus="status">
				obj = new Object();
				obj.userId = "${senderInfo.userId}";
				obj.nickName = "${senderInfo.nickName}";
				senderList.push(obj);
			</c:forEach>
			console.dir(senderList);
		</script>
	
	
</body>
</html>