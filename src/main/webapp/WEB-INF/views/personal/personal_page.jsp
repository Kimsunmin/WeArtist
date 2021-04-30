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
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"integrity="sha256-4+XzXVhsDmqanXGHaHvgh1gMQKX40OUvDEBTu8JcmNs="crossorigin="anonymous"></script>
  <script type="text/javascript">
  function overlap(id){
	  let div = document.getElementById(id);
	  let icon = document.createElement("i");
	  icon.setAttribute("class","fas fa-copy position-absolute top-0 end-0 m-3 fs-3 text-warning");
	  div.appendChild(icon)
  }
  </script>
  <style>
  	p{
  		font-family : 'Nanum Gothic', sans-serif';
  		font-style:normal;
  		font-weight: 400;
  	}
  	
  	body.modal-open {
    overflow: hidden;
	}
	
	@media(max-width: 991px) { 
	 	#board_content{
	 	display:none;
	 	}
	 	#content_modal{
	 		width:80%;
	 	}
	 	#detail_info{
	 		display:none;
	 	}
	 	#option{
	 	display:none;
	 	}
	 }
	 
	 .btn-per{
	 	width:101px;
	 }
  </style>
</head>
<body id="body">
<main id="main">
    <!-- ======= Speaker Details Sectionn ======= -->
    <section id="speakers-details" class="section-with-bg">
    <div class="container d-flex justify-content-center">
     <div class="jb-a rounded-circle" style="  width: 14rem;   height: 14rem;border: 0.5rem solid rgba(0, 0, 0, 0.1);">
		<img class="mx-auto propic" id="picture" src="/images/${personalUserInfo.fSavePath}/${personalUserInfo.fRename}" alt="" style=" width: 14rem;  height: 14rem;">
	 </div>
          <div class="details">
          	<div class="d-flex align-items-center flex-column">
          		<div class="mb-3">
	             	<mark id="user" class="fs-4 text-center fw-bold my-0"style= "font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 700;">${personalUserInfo.nickName}</mark>	
          		</div>
          		<div id="detail_info"class="d-flex justify-content-center m-3">
            	<div class="d-flex mr-1"><p class="text-lg" style="font-weight:bolder;">게시물&nbsp; </p><p class="text-lg">${personalBoardInfoList.size()}</p></div>
            	<div class="d-flex mx-3"><p class="text-lg" style="cursor: pointer; font-weight:bolder;" onclick="fetchFollowingList();">팔로잉&nbsp; </p><p id="following_count"class="text-lg">${followingCount}</p></div>
            	<div class="d-flex ml-1"><p class="text-lg" style="cursor: pointer; font-weight:bolder;" onclick="fetchFollowerList();">팔로워&nbsp; </p><p id="follower_count"class="text-lg">${followerCount}</p></div>
            </div>
          		<div id="option"class="d-flex align-items-center">
             	 <c:choose>
          			<c:when test="${pageState eq 'isMine'}">
          			<button type="button" class="btn btn-dark btn-sm text-lg mx-3 btn-per" onclick="modifyProfile()" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 400;">프로필 설정</button>
          			<button type="button" class="btn btn-dark btn-sm text-lg mx-3 btn-per" onclick="location.href='/live/host'" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 400;">Live</button>
          			<!-- 밑에 팝업으로 바꿔봄 -->
          			<!-- <button type="button" class="btn btn-primary btn-sm text-lg mx-3" onclick="location.href='/fileupload'" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 400;">사진 올리기</button> -->
          			<button type="button" class="btn btn-dark btn-sm text-lg mx-3 btn-per" onclick="window.open('/fileupload2', '_blank', 'width=578, height=700, left=550, top=100'); return false;" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 400;">사진 올리기</button>
          			</c:when>
          			<c:when test="${pageState eq 'isFollowed'}">
          				<button  type="button" id="btn_about_following" onclick="unfollowing()"class="btn btn-dark btn-sm mx-3 btn-per" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight:400;">팔로우 끊기</button>
          				<button type="button" class="btn btn-dark btn-sm text-lg mx-3 btn-per" onclick="sendDirectMessage();" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 400;">메세지 보내기</button>
          			</c:when>
          			<c:when test="${pageState eq 'nothing'}">
          				<button type="button" id="btn_about_following" onclick="following()" class="btn btn-dark mx-3 btn-per" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 400; width:120px; height:40px;">팔로우</button>
          				<button type="button" class="btn btn-dark btn-sm text-lg mx-3 btn-per" onclick="sendDirectMessage();" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 400; ">메세지 보내기</button>
         		 	</c:when>
         		 </c:choose>
         		 
         		 	<button type="button" class="btn btn-dark btn-sm text-lg mx-3 btn-per" onclick="location.href='/gallery/${personalUserInfo.userId}'" style="font-family: 'Nanum Gothic', sans-serif;font-style:normal;font-weight: 400;">갤러리</button>
         		 </div>
         		 
             </div>
            
      	</div>
            
      </div>
      </section>
	<!--사진피드 -->
      <section id="venue" class="section-with-bg">
      <div class="container aos-init aos-animate" data-aos="fade-up">
        <div class="section border-bottom border-top border-2 mb-3">
          <h2 class="text-center fs-1 fw-bold p-5">게시물</h2>
        </div>
         <c:if test="${personalBoardInfoList.size()==0}">
      		<div class="container d-flex justify-content-center align-items-center" style="height:50vh;">
      			<div>
      				<p class="text-center"><i class="fas fa-box-open fs-1"></i></p>
      				<h1 class="fs-1">게시물 없음</h1>
      			</div>
      			
      		</div>
      	</c:if>
      	<c:if test="${personalBoardInfoList.size()!=0}">
        <c:set var="loop_flag" value="false" />
		 	<div class="row g-0 aos-init aos-animate" data-aos="fade-up" data-aos-delay="100">
		 		<c:forEach var ="boardInfo" items ="${personalBoardInfoList}" varStatus="sts">
		 			<c:forEach var ="file" items ="${boardInfo.files}" varStatus="status">
		 			<c:if test="${status.index==0}">
					<div class="col-lg-4 col-md-6">
             				<div class="venue-gallery position-relative mb-0" id="${boardInfo.board.bdNo}" onclick="showModal('${boardInfo.board.bdNo}','${boardInfo}');"style="cursor: pointer;">
<!--                 				<img src=<c:url value='/images/2021/4/12/2cdfe272-71d5-42d5-8b59-cb4d30b6809b'/> alt="" class="img-fluid" style="width:30rem; height:20rem;object-fit: cover;"> -->
                				<img src=<c:url value='/images/${file.fSavePath}/${file.fRename}'/> alt="" class="img-fluid" style="width:30rem; height:20rem; object-fit: cover;">
              				</div>
          			</div>		
          			<c:if test="${fn:length(boardInfo.files)>1}">
          				<script>overlap("${boardInfo.board.bdNo}");</script>
          			</c:if>
          			</c:if>
		 			</c:forEach>
		 		</c:forEach>
		 	</div>
		 	</c:if>
		</div>
		 <!-- Modal --> 
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<p id="btn_modal_close"class="float-end text-white fs-1 mt-2 mr-1" style="cursor: pointer;"><i class="fas fa-times"></i></p>
			<button class="carousel-control-prev position-fixed top-50 start-0" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev" style="z-index:9999; height:10vh;">
    			<span class="carousel-control-prev-icon primary" aria-hidden="true"></span>
    			<span class="visually-hidden">Previous</span>
  			</button>
  			<button class="carousel-control-next position-absolute top-50 end-0 translate-middle-y" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next" style="z-index:9999;height:10vh;">
    			<span class="carousel-control-next-icon" aria-hidden="true"></span>
    			<span class="visually-hidden">Next</span>
  			</button>
  			<div id="content_modal"class="modal-dialog modal-lg modal-dialog-centered">
   				 <div class="modal-content" style="border-radius: 20px;">
   				 	<div class="modal-body">
   				 		<div class="container">
   				 			<div class="row"> 
    							<div class="col-lg-8">
       								<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
       									<div class="carousel-inner">
       									<!-- 비동기로 데이터를 받아서 뿌려줄 부분 -->
  										</div>
									</div>
      							</div>
      							<div class="col-lg-4 d-flex flex-column">
      								<div class="d-flex justify-content-between  align-items-center border-bottom mx-1 p-2">
      									<div id="board_title" style="font-size:1vw;"></div>
      									<div id="delete_link" class="text-danger" style="font-size:10px; cursor:pointer;" onclick="deleteBoard();">삭제</div>
      								</div>
            						<div id="board_content"class="p-2 border-bottom mx-1" style="height:90%; overflow:auto; font-size:0.8vw;"></div>
           		 					<div class="p-2 d-flex align-items-center">
            							<i id="like_icon" onclick="updateLike();" class="fas fa-heart text-dark mx-2 my-1" style="cursor:pointer; font-size:20px;"></i>
            							<div id="like_description" style="font-size:12px; cursor:pointer;" onclick="fetchLikeUserList();"class="p-2"></div>
            						</div>
      							</div>
      						</div>
      					</div>	
      				</div>	
  			  </div>
 		 </div>
		</div>

		<!-- 좋아요 리스트 모달-->
		<div class="modal fade" id="likeUserListModal" tabindex="-1" aria-labelledby="likeUserListModalLabel" aria-hidden="true">
 			<div class="modal-dialog modal-dialog-centered">
   				<div class="modal-content" style="border-radius: 20px;">
    				<div class="d-flex border-bottom p-2">
        				<div class="modal-title  fw-bold text-center flex-fill" id="likeUserListModalLabel">좋아요
        				<button type="button" class="btn-close float-end " data-bs-dismiss="modal" aria-label="Close"></button>
        				</div>
      				</div>
      				<ul id="like_user_list"class="list-group list-group-flush m-2" style="overflow:auto; height:20vh;">
      					<!-- 비동기로 데이터를 받아올 곳 -->
      				</ul>	
    			</div>
 		 	</div>
		</div>
		<!-- 팔로잉 리스트 모달-->
      <div class="modal fade" id="followingListModal" tabindex="-1" aria-labelledby="followingListModalLabel" aria-hidden="true">
 			<div class="modal-dialog modal-dialog-centered">
   				<div class="modal-content" style="border-radius: 20px;">
    				<div class="d-flex border-bottom p-2">
        				<div class="modal-title fw-bold text-center flex-fill" id="followingListModalLabel">팔로잉
        				<button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
        				</div>
      				</div>
      				<ul id="following_list"class="list-group list-group-flush m-2" style="overflow:auto; height:20vh;">
      					<!-- 비동기로 데이터를 받아올 곳 -->
      				</ul>	
    			</div>
 		 	</div>
		</div>
		<!-- 팔로워 리스트 모달-->
      <div class="modal fade" id="followerListModal" tabindex="-1" aria-labelledby="followerListModalLabel" aria-hidden="true">
 			<div class="modal-dialog modal-dialog-centered">
   				<div class="modal-content" style="border-radius: 20px;">
    				<div class="d-flex border-bottom p-2">
        				<div class="modal-title fw-bold text-center flex-fill" id="followerListModalLabel">
        				팔로워
        				<button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
        				</div>
        			
      				</div>
      				<ul id="follower_list"class="list-group list-group-flush m-2" style="overflow:auto; height:20vh;">
      					<!-- 비동기로 데이터를 받아올 곳 -->
      				</ul>	
    			</div>
 		 	</div>
		</div>
      </section>				
      

  </main>
<!-- footer부분 -->
 	<%@include file ="/WEB-INF/views/include/footer.jsp" %>
  
  
  <script src="${context}/resources/theEvent/assets/vendor/aos/aos.js"></script>
  <script src="${context}/resources/theEvent/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${context}/resources/theEvent/assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="${context}/resources/theEvent/assets/vendor/php-email-form/validate.js"></script>
  <script src="${context}/resources/theEvent/assets/vendor/swiper/swiper-bundle.min.js"></script>
  <script src="${context}/resources/theEvent/assets/js/main.js"></script>
  
<%--   <script src="${context}/resources/js/personal/personal.js"> --%>
<script>
let myModalEl = document.getElementById('exampleModal')
myModalEl.addEventListener('hidden.bs.modal', function (event) {
	  let carouselInner = document.querySelector(".carousel-inner");
	  while(carouselInner.hasChildNodes()){
		  carouselInner.removeChild(carouselInner.firstChild);
	  }
});

let modalCloseBtn = document.getElementById('btn_modal_close');
modalCloseBtn.addEventListener('click',function(){
	  $('#exampleModal').modal("hide");
});
myModalEl.addEventListener('shown.bs.modal',function(event){
	
});


let likeUserListModal = document.getElementById("likeUserListModal");
likeUserListModal.addEventListener('shown.bs.modal', function (event) {
	
});
likeUserListModal.addEventListener('hidden.bs.modal', function (event) {
	 $("body").addClass("modal-open");
	  let likeUserList = document.getElementById("like_user_list");
	  while(likeUserList.hasChildNodes()){
		  likeUserList.removeChild(likeUserList.firstChild);
	  }
});


	let selectedBoard;
	let boardInfo;
	let fileList;
	
	 function showModal(bdNo,boardInfo){
		fetchSelectBoard(bdNo);
		
	}
	    function fetchSelectBoard(bdNo){
		const url = '/fetchselectedboard?bdNo='+bdNo;
		fetch(url,{
			method : "GET"
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			selectedBoard = JSON.parse(text);
			let carouselInner = document.querySelector(".carousel-inner");
			let boardContent = document.getElementById("board_content");
			let boardTitle = document.getElementById("board_title");
			let likeIcon = document.getElementById("like_icon")
			let likeDescription = document.getElementById("like_description");
			likeIcon.setAttribute("onclick","updateLike();")
			boardContent.innerHTML = selectedBoard.board.bdContent;
			boardTitle.innerHTML = selectedBoard.board.bdTitle;
			boardInfo = selectedBoard.board; //선택한 게시물 정보
			fileList = selectedBoard.files; //선택한 게시물에 속해있는 파일 리스트 정보
			for(let i = 0; i<fileList.length; i++){
					let carouselItem = document.createElement("div")
					let img = document.createElement("img");
// 					let img = document.createElement("img");
// 					img.setAttribute("id","content_img")
// 					img.setAttribute("class","d-block w-100 img-fluid");
// 					img.setAttribute("style","width:30rem;");
// 					img.src="/images/2021/4/12/2cdfe272-71d5-42d5-8b59-cb4d30b6809b";
// // 					img.src = "/images/"+fileList[i].fSavePath+"/"+fileList[i].fRename;
// //					img.style="width:100%;height:100%;object-fit:cover;";
				if(i==0){
					img.setAttribute("id","content_img")
					img.setAttribute("class","d-block w-100");
					img.setAttribute("style","width:25rem; height:25rem; object-fit:contain;");
// 					img.src="/images/2021/4/12/2cdfe272-71d5-42d5-8b59-cb4d30b6809b";
					img.src = "/images/"+fileList[i].fSavePath+"/"+fileList[i].fRename;
//					img.style="width:100%;height:100%;object-fit:cover;";
					carouselItem.setAttribute("class","carousel-item active");
				}else{
					img.setAttribute("id","content_img")
					img.setAttribute("class","d-block w-100");
					img.setAttribute("style","width:25rem; height:25rem; object-fit:contain;");
// 					img.src="/images/2021/4/12/2cdfe272-71d5-42d5-8b59-cb4d30b6809b";
					img.src = "/images/"+fileList[i].fSavePath+"/"+fileList[i].fRename;
//					img.style="width:100%;height:100%;object-fit:cover;";
					carouselItem.setAttribute("class","carousel-item");
				}
	       			carouselItem.appendChild(img);
	       			carouselInner.appendChild(carouselItem);
			}
			likeDescription.innerHTML=selectedBoard.board.likeCount+"명이 게시물을 좋아합니다.";
			test();
		});
	}
	
	async function test(){
		let likeIcon = document.getElementById("like_icon");
		let result = await certificatelike(selectedBoard.board.bdNo);
			if(result=="true"){
				likeIcon.setAttribute("class","fas fa-heart text-dark");
			}else{
				likeIcon.setAttribute("class","fas fa-heart text-danger");
			}
			$('#exampleModal').modal("show")
	}
	function following(){
		let userId = "${personalUserInfo.userId}";
		let nickName = "${curUserInfo.nickName}";
		if(currentUserId!=""){
//	 		createNewRoom(currentUserId,userId);
//	 		reSetMyChatRoomList();	
	 		followingImpl(userId,currentUserId);
		}else{
			location.href = "/user/login";
		}

	}
	
	function followingImpl(toId,fromId){
		const url = '/communication/followingimpl';
		let paramObj = new Object();
		paramObj.toId = toId;
		paramObj.fromId = fromId;
		
		let headerObj = new Headers();
		headerObj.append('content-type','application/json');
		
		fetch(url,{
			method:"POST",
			headers : headerObj,
			body : JSON.stringify(paramObj)
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			if(text=="success"){
				//팔로잉 성공 시
				let userId = "${personalUserInfo.userId}";
				let nickName = "${curUserInfo.nickName}";
				stompPushClient.send("/push", {}, JSON.stringify({'fromId' : fromId, 'toId': toId, 'nickName' : nickName, 'bdNo' : null, notiMethod : 'following','message' : nickName+'님이 당신을 팔로우 했습니다.' })); //해당 유저에게 팔로잉 요청을 보낸다.
				let fBtn = document.getElementById("btn_about_following");
				fBtn.innerHTML ="팔로우 끊기";
				fBtn.setAttribute("onclick","unfollowing()")
				reSetFollowingCountimpl();
			}else{
				//팔로잉 실패 시
			}
		})
	}
	
	function unfollowing(){
		let toId = "${personalUserInfo.userId}";
		let fromId = currentUserId;
		unFollowingImpl(toId,fromId);
	}
	
	
	function unFollowingImpl(toId,fromId){
		const url ='/communication/unfollowingimpl';
		let paramObj = new Object();
		paramObj.toId = toId;
		paramObj.fromId = fromId;
		
		let headerObj = new Headers();
		headerObj.append('content-type','application/json');
		
		fetch(url,{
			method:"POST",
			headers : headerObj,
			body : JSON.stringify(paramObj)
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			if(text=="success"){
				//언팔로우 성공 시
				let fBtn = document.getElementById("btn_about_following");
				fBtn.innerHTML ="팔로잉";
				fBtn.setAttribute("onclick","following()")
				reSetFollowingCountimpl();
			}else{
				//언팔로우 실패 시
			}
		})
	}
	
	
	function reSetFollowingCountimpl(){
		let nickName = "${personalUserInfo.nickName}";
		const url = '/personal/resetfollowingcountimpl?nickName='+nickName;
		fetch(url,{
			method:"GET",
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			document.getElementById("follower_count").innerHTML = text;
		});
		
	}
	
	
	function modifyProfile(){
		location.href ="/user/profile?userId="+currentUserId;
	}
	
	
	   async function updateLike(){
		bdNo = selectedBoard.board.bdNo;
		bdTitle = selectedBoard.board.bdTitle;
		 let result =  await certificatelike(bdNo);
		if(result=="true"){
			console.log("좋아요를 한 적이 없으니까 insert하자")
			insertLike(bdNo,bdTitle); 
		}else{
			console.log("좋아요를 한 적이 있으니까 delete하자")
			deleteLike(bdNo);
		}
	}
	
	    async function certificatelike(bdNo){
		const url = '/certificatelike?bdNo='+bdNo+'&lkId='+currentUserId;
		let response = await fetch(url,{method:"GET"});
		if(response.ok){
			let result = await response.text();
			if(result=="ok"){
				console.log("좋아요를 한 적이 없다.")
				return "true";
			}else{
				console.log("좋아요를 한 적이 있다.")
				return "false";
			}
		}
	}
	
	
	function insertLike(bdNo,bdTitle){
		//전달 받은 bdNo의 like업데이트
		const url = '/insertlike';
		let paramObj = new Object();
		paramObj.toId = "${personalUserInfo.userId}"
		paramObj.bdNo = bdNo;
		paramObj.bdTitle = bdTitle;
		
		let headerObj = new Headers();
		headerObj.append('content-type','application/json');
		fetch(url,{
			method:"POST",
			headers : headerObj,
			body : JSON.stringify(paramObj)
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			if(text=="sendNoti"){
				//좋아요 성공 시
				let likeIcon = document.getElementById("like_icon");
				likeIcon.setAttribute("class","fas fa-heart text-danger");
				selectLikeCount(bdNo);
				
				let toId = "${personalUserInfo.userId}";
				let nickName = "${curUserInfo.nickName}";
				let fromId = currentUserId;
				//해당 유저에게 좋아요를 했다고 알림을 보낸다.
				stompPushClient.send("/push", {}, JSON.stringify(
					{'fromId' : fromId, 'toId': toId, 'nickName' : nickName, 'bdNo' :bdNo, 'notiMethod' : 'like' ,'message' : nickName+'님이 '+bdTitle +' 게시물을 좋아합니다.'}
					)); 
			}else if(text=="notSendNoti"){
				let likeIcon = document.getElementById("like_icon");
				likeIcon.setAttribute("class","fas fa-heart text-danger");
				selectLikeCount(bdNo);	
			}else{
				//좋아요 실패 시
				
			}
		})
		
	}
	
	
	function deleteLike(bdNo){
		const url = '/deletelike?bdNo='+bdNo+'&lkId='+currentUserId;
		fetch(url,{
			method:"GET"
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			if(text=="success"){
				//좋아요 취소 성공 시
					let likeIcon = document.getElementById("like_icon");
					likeIcon.setAttribute("class","fas fa-heart text-dark");
					selectLikeCount(bdNo);
			}else{
				//좋아요 취소 실패 시
			}
		})
	}
	
	function selectLikeCount(bdNo){
		const url ='/selectlikecount?bdNo='+bdNo;
		fetch(url,{
			method:"GET"
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			let likeCount = text
				let likeDescription = document.getElementById("like_description");
				likeDescription.innerHTML = likeCount+"명이 게시물을 좋아합니다.";
		})
	}
	
	function fetchLikeUserList(){
		bdNo = selectedBoard.board.bdNo;
		const url ='/fetchlikeuserlist?bdNo='+bdNo;
		fetch(url,{
			method:"GET"
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			let likeUserList = JSON.parse(text);
			let ul = document.getElementById("like_user_list");
			for(let i = 0; i<likeUserList.length; i++){
				let li = document.createElement("li");
				li.setAttribute("class","list-group-item border-0")
				li.setAttribute("style","cursor:pointer")
				li.setAttribute("onclick","location.href='/personal/personal?nickName='+'"+likeUserList[i].nickName+"'")
				let nickNameDiv = document.createElement("div");
				nickNameDiv.setAttribute("class","mb-1 fw-bold");
				let nameDiv = document.createElement("div");
				nickNameDiv.innerHTML = likeUserList[i].nickName;			
				nameDiv.innerHTML = likeUserList[i].name;
				nameDiv.setAttribute("class","text-muted");
				nameDiv.setAttribute("style","font-size:0.8vw");
				li.append(nickNameDiv,nameDiv);
				ul.appendChild(li);
			}
			$('#likeUserListModal').modal("show")
		})
	}
	
	function fetchFollowingList(){
		const url ='/personal/fetchfollowinglist?userId='+"${personalUserInfo.userId}";
		fetch(url,{
			method: "GET"
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			let followingList = JSON.parse(text);
			let ul = document.getElementById("following_list");
			for(let i = 0; i < followingList.length; i++){
				let li = document.createElement("li")
				li.setAttribute("class","list-group")
				li.setAttribute("class","list-group-item border-0")
				li.setAttribute("style","cursor:pointer")
				li.setAttribute("onclick","location.href='/personal/personal?nickName='+'"+followingList[i].nickName+"'")
				let nickNameDiv = document.createElement("div");
				nickNameDiv.setAttribute("class","mb-1 fw-bold");
				let nameDiv = document.createElement("div");
				nickNameDiv.innerHTML = followingList[i].nickName;			
				nameDiv.innerHTML = followingList[i].name;
				nameDiv.setAttribute("class","text-muted");
				nameDiv.setAttribute("style","font-size:0.8vw");
				li.append(nickNameDiv,nameDiv);
				ul.appendChild(li);
			}
			$('#followingListModal').modal("show")
		});
	}
	
	function fetchFollowerList(){
		const url ='/personal/fetchfollowerlist?userId='+"${personalUserInfo.userId}";
		fetch(url,{
			method: "GET"
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			let followerList = JSON.parse(text);
			let ul = document.getElementById("follower_list");
			for(let i = 0; i < followerList.length; i++){
				let li = document.createElement("li")
				li.setAttribute("class","list-group")
				li.setAttribute("class","list-group-item border-0")
				li.setAttribute("style","cursor:pointer")
				li.setAttribute("onclick","location.href='/personal/personal?nickName='+'"+followerList[i].nickName+"'")
				let nickNameDiv = document.createElement("div");
				nickNameDiv.setAttribute("class","mb-1 fw-bold");
				let nameDiv = document.createElement("div");
				nickNameDiv.innerHTML = followerList[i].nickName;			
				nameDiv.innerHTML = followerList[i].name;
				nameDiv.setAttribute("class","text-muted");
				nameDiv.setAttribute("style","font-size:0.8vw");
				li.append(nickNameDiv,nameDiv);
				ul.appendChild(li);
			}
			$('#followerListModal').modal("show")
		});
	}
	
	function deleteBoard(){
		const url ='/deleteboardimpl';
		let paramObj = new Object();
		paramObj.bdNo = boardInfo.bdNo;
		let headerObj = new Headers();
		headerObj.append("content-type",'application/json');
		fetch(url,{
			method : "POST",
			headers : headerObj,
			body : JSON.stringify(paramObj)
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			if(text=='success'){
				location.href ="/personal/personal?nickName="+currentUserNickName;
			}
		});
	}
	
	
	function sendDirectMessage(){
		let nickName = '${personalUserInfo.nickName}';
		let userId ='${personalUserInfo.userId}';
		location.href="/chat/direct?sendDirectNickName="+nickName+"&sendDirectUserId="+userId
	}
	
	</script>
	
</body>
</html>