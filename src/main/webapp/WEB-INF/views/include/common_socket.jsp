<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script>
let currentUserId;
let stompClient = null;
let stompPushClient = null;
let myChatRoomList = null;
let tempMsgFrom = null;
let followingList = new Array();
window.onload = function() { //페이지의 모든 요소들이 로드되면 호출
	console.log("window.onload !")
	currentUserId = "${userInfo.userId}"; //현재 로그인한 유저의 ID
	currentUserNickName = "${userInfo.nickName}"; //현재 로그인한 유저의 닉네임
	getAlluser();
	myChatRoomList = new Array(); //내가 속한 채팅방 리스트
	let chatRoom;
	<c:forEach items='${myChatRoomList}' var='item'>
		chatRoom = new Object();
		chatRoom.chatRoomNo = "${item.chatRoomNo}"
		chatRoom.firstUser = "${item.firstUser}";
		chatRoom.seconduser = "${item.secondUser}";
		myChatRoomList.push(chatRoom)
	</c:forEach>
	connectSocket(); //소켓 연결
	connectPushSocket();
	fetchNotiCount();
	selectNotiheckChatContentImpl(currentUserId); //현재 유저가 확인하지 않은 메세지의 갯수를 구하는 메소드
	let currentURI = document.location.pathname; //현재 페이지의 uri을 가져오는 코드
	if(currentURI.indexOf('/chat/direct')!=-1){
		setTimeout(function() {
		 	directMessage();
			}, 500);
	}

}

// 소켓 연결을 위한 함수
let connectSocket = function(){
	let socket = new SockJS("/chat/room1"); //sockJS객체 생성 endPoint : "room1"
	let currentURI = document.location.pathname;
	stompClient = Stomp.over(socket); //stomp객체에 sockJs객체 연경
	stompClient.connect({}, function(frame) {  
		//내가 속한 모든 채팅방을 구독
		for(let i = 0; i < myChatRoomList.length; i++){
			stompClient.subscribe("/queue/"+myChatRoomList[i].chatRoomNo,function(response){
				let msgInfo = JSON.parse(response.body) //넘어온 message 정보를 담고있는 json을 파싱
				let msg = msgInfo.message;
				let msgFrom = msgInfo.msgFrom;
				let msgTo = msgInfo.msgTo;
				let roomId = msgInfo.roomId;
				let msgToNickName = msgInfo.msgToNickName;
				let msgFromNickName = msgInfo.msgFromNickName;
				if(currentURI.indexOf('/chat/direct')!=-1){ //만약 현제 페이지가 채팅화면 이라면
					
					let chatRoomCard = document.querySelectorAll(".chat_room_card"); //팔로잉하고 있는 유저들의 item항목을 담고있는 div태그 리스트
					let lastMessage = document.querySelectorAll(".last_message"); //해당 유저에게 마지막으로 받은 message를 보여 줄 div태그 리스트
					let lastMessageTime = document.querySelectorAll(".last_message_time") //해당 유저에게 마지막으로 message 를 받은 시간을 나타내는 p태그리스트 
					let senderListBox = document.getElementById("sender_list_box");
					//받은 메세지가 글자수 10자를 넘으면 10글자만 보여주고 나머지는 "......."으로 표시
					let lastMsg = msg;
					if (msg.length >= 10) {
						lastMsg = msg.substr(0,10)+"......" 
					}
					
					for(let i =0; i< chatRoomCard.length; i++){
						let uName = chatRoomCard[i].querySelector(".following_user").innerHTML;
						//메세지를 보낸 유저와 팔로잉 한 유저가 일치한다면 그 유저가 보낸 메세지를 Cardview에 표시
						if((uName==msgFromNickName || uName == msgToNickName )){
							senderListBox.insertBefore(chatRoomCard[i],senderListBox.firstChild);
							if(uName==msgFromNickName){
								lastMessage[i].setAttribute("class","last_message text-dark fw-bold");
								let curMessageNotiCount = parseInt(document.getElementById("message_noti_count").innerHTML);
								document.getElementById("message_noti_count").innerHTML = curMessageNotiCount+1
							}else if(uName!=msgFromNickName || document.getElementById("opponent").innerHTML==uName){
								lastMessage[i].setAttribute("class","last_message text-dark");
							}
							lastMessage[i].innerHTML = lastMsg
							lastMessageTime[i].innerHTML = getCurrentTime();
						}
					}
					
					
					
					
					let chatIndex = document.getElementById("chat_index"); //유저를 선택하지 않았을 시의 채팅창 화면
					if(msgFrom!= currentUserId && chatIndex==null && roomId == currentRoomId) {
						let lastMessages = document.querySelectorAll('.last_message');
						let followingUsers = document.querySelectorAll('.following_user');
						for(let i=0;i<followingUsers.length; i++){
							if(followingUsers[i].innerHTML == document.getElementById("opponent").innerHTML){
								lastMessages[i].setAttribute("class","last_message text-dark");
							}
						}
// 						for(let i = 0; i<lastMessages.length; i++){
// 							console.log(lastMessages[i].dataset.usernick)
// 							console.log(document.getElementById("opponent").innerHTML)
// 							if(lastMessages[i].dataset.usernick==document.getElementById("opponent").innerHTML){
// 								lastMessages[i].setAttribute("class","last_message text-dark");
								
// 							}
// 						}
						updateChatContentImpl(msgTo,msgFrom); //메시지를 확인했으므로 IS_CHECK를 1로 변경
						let chatBox = document.getElementById("chat_box");
						let borderBox = document.createElement("div");
						borderBox.style.padding = "10px";
						borderBox.style.marginBottom = "10px";
						borderBox.style.border = "1px solid #DCDCDC"
						if (msg.length >= 20) {
							borderBox.style.width = "30%";
						}
						
						borderBox.style.borderRadius = "20px";
						let br = document.createElement("br");
						let messageBox = document.createElement("div");

						borderBox.style.background = "#FFFFFF";
						borderBox.className = "float-start align-self-start"
						messageBox.style.textAlign = "left"
						chatBox.appendChild(br);
						messageBox.innerHTML = msg;
						borderBox.appendChild(messageBox);
						chatBox.appendChild(borderBox);
						chatBox.scrollTop = chatBox.scrollHeight; 
					}
					
				}else{
					document.getElementById("liveMessageToast").className ="toast show";
					document.getElementById("toast_msg").innerHTML = msgFromNickName+"님으로부터 메세지가 도착했습니다.";
					document.getElementById("toast_msg").addEventListener('click',function(event){
						location.href="/chat/direct?sendDirectNickName="+msgFromNickName+"&sendDirectUserId="+msgFrom;
					});
					if(msgFrom!=currentUserId){
						let curMessageNotiCount = parseInt(document.getElementById("message_noti_count").innerHTML);
						document.getElementById("message_noti_count").innerHTML = curMessageNotiCount+1
					}
					setTimeout(function() {
			 			document.getElementById("liveMessageToast").className ="toast hide";
						}, 5000);
					
						
					}
					
				
			});
		}
		console.log("유저의 모든 채팅방 구독완료")
		console.log("채팅용 소켓 연결 완료")
	});	
}


//받은 메시지를 Controller에 전달하는 함수
function subscribeImpl(msg,msgFrom,msgTo){
	const url = '/chat/subscribeimpl';
	let paramObj = new Object();
	paramObj.msg = msg;
	paramObj.msgFrom = msgFrom;
	paramObj.msgTo = msgTo;
	
	let headerObj = new Headers();
	headerObj.append('content-type',"application/json");
	fetch(url,{
		method:"POST",
		headers:headerObj,
		body:JSON.stringify(paramObj)
	})
	.then(response =>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		if(text=='fail'){
			
		}else{
		}
	})
}

//현재 시간을 반환 하는 함수
function getCurrentTime(){
	let today = new Date();
	
	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	let day = today.getDay();  // 요일
	let hours = today.getHours(); // 시
	let minutes = today.getMinutes();  // 분
	let seconds = today.getSeconds();  // 초
	let milliseconds = today.getMilliseconds(); // 밀리초
	
	return year+"-"+month+"-"+date+" "+hours+":"+minutes+":"+seconds;
}

//팔로잉 요청 및 좋아요 알림 푸시 소켓
function connectPushSocket(){
	let socket = new SockJS("/chat/room2"); //sockJS객체 생성 endPoint : "room2"
	stompPushClient = Stomp.over(socket); //stomp객체에 sockJs객체 연결
	stompPushClient.connect({}, function(frame) {  
		//이곳으로 reponse가 오면 팔로잉 요청 이나 좋아요 알림이 온 것임.
		stompPushClient.subscribe("/queue/"+currentUserId,function(response){
			let pushInfo = JSON.parse(response.body)
			let fromId = pushInfo.fromId;
			let toId = pushInfo.toId;
			let nickName = pushInfo.nickName;
			let message = pushInfo.message;
			let bdNo = pushInfo.bdNo;
			let notiMethod = pushInfo.notiMethod;
			
			//<우측 하단 토스트를 띄워주기 위한 부분>
			if((fromId!=toId) && notiMethod!='direct'){
				let followingMessage = document.getElementById("followingMessage");
				followingMessage.innerHTML = message;
				document.getElementById("liveFollowingToast").className ="toast show";
						setTimeout(function() {
				 			document.getElementById("liveFollowingToast").className ="toast hide";
							}, 5000);
						
				document.getElementById("followingMessage").addEventListener("click",function(event){
					checkNoti(pushInfo);
				});		
			//</우측 하단 토스트를 띄워주기 위한 부분>
//	 			createNewRoom(fromId,toId);
//	 			fetchNotiCount();
				let notiBox = document.getElementById("noti_box");
				let listGroup = document.getElementById("list_group");
				let emptyNotiBox = document.getElementById("empty_noti_box");
				if(emptyNotiBox!=null){
					notiBox.removeChild(emptyNotiBox);
				}
				let curNotiCount = parseInt(document.getElementById("noti_count").innerHTML)
				document.getElementById("noti_count").innerHTML = curNotiCount+1;
				let notiInfo = document.createElement("li");
				notiInfo.setAttribute("class","list-group-item");
				notiInfo.innerHTML = message;
				notiInfo.style.cursor = "pointer";
				notiInfo.addEventListener("click",(e)=>{
					clickNoti(e.target,pushInfo);
				});
				listGroup.appendChild(notiInfo);
				notiBox.appendChild(listGroup);
			}else if((fromId!=toId) &&notiMethod=='direct'){
				 stompClient.disconnect();
		         reSetMyChatRoomList();
			}
		});
	});
}





function fetchNotiCount(){
	const url = '/communication/fetchnoticountimpl';
	fetch(url,{
		method : "GET",
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		let historyList = JSON.parse(text);
		console.dir(historyList);
		let notiBox = document.getElementById("noti_box");
		let notiCount = document.getElementById("noti_count")
		let listGroup = document.getElementById("list_group");
		
		let emptyNotiBox = document.getElementById("empty_noti_box");
		// 알람 아이콘 클릭 시
		document.getElementById("notification_icon").addEventListener("click",(e)=>{
			if(document.getElementById("noti_box").style.visibility=='visible'){
				document.getElementById("noti_box").style.visibility = "hidden";
			}else{
				document.getElementById("noti_box").style.visibility = "visible";
			}
		});
		if(historyList.length!=0){
			notiBox.removeChild(emptyNotiBox);
		}
		notiCount.innerHTML = historyList.length;
		for(let i=0;i<historyList.length;i++){
			let notiInfo = document.createElement("li");
			notiInfo.setAttribute("class","list-group-item");
			if(historyList[i].notiMethod =='following'){
				notiInfo.innerHTML = historyList[i].nickName +"님으로부터 팔로잉 요청이 있습니다.";
			}else{
				notiInfo.innerHTML = historyList[i].nickName +"님이 "+historyList[i].bdTitle +"게시물을 좋아합니다.";
			}
			notiInfo.style.cursor = "pointer";
			notiInfo.addEventListener("click",(e)=>{
				clickNoti(e.target,historyList[i]);
			});
			listGroup.appendChild(notiInfo);
			notiBox.appendChild(listGroup);
		}
// 		notiBox.style.visibility = "visible";
	});
}

function checkNoti(pushInfo){
	const url = '/communication/updatehistoryimpl'
		let paramObj = new Object();
		paramObj.toId = pushInfo.toId;
		paramObj.fromId = pushInfo.fromId;
		paramObj.bdNo = pushInfo.bdNo;
		paramObj.notiMethod = pushInfo.notiMethod;
		
		let headerObj = new Headers();
		headerObj.append('content-type','application/json');
		
		fetch(url,{
			method: "POST",
			headers : headerObj,
			body : JSON.stringify(paramObj)
		}).then(response=>{
			if(response.ok){
				return response.text();
			}
		}).then((text)=>{
			if(text=="success"){
				location.href ="/personal/personal?nickName="+pushInfo.nickName;
			}
		})
}

function clickNoti(liTag,pushInfo){
	let data = JSON.stringify(pushInfo);
	document.getElementById("list_group").removeChild(liTag);
	checkNoti(pushInfo);
	
}


function directMessage(){
	let obj= new Object();
	obj.userId = "${sendDirect.userId}";
	obj.nickName="${sendDirect.nickName}";
	console.log("directMessage실행");
	if(obj.userId!="0" && obj.nickName!="0"){
		createRoomId(obj)
	}
}

function createNewRoom(fromId,toId){
    
    let url = '/chat/enterchatroomimpl'
    let paramObj = new Object();
    paramObj.firstUser = fromId;
    paramObj.secondUser = toId;
    let headerObj = new Headers();
    headerObj.append("content-type","application/json");
    fetch(url,{
        method : "POST",
        headers : headerObj,
        body : JSON.stringify(paramObj)
    })
    .then(response=>{
        if(response.ok){
            return response.text()
        }
    })
    .then((text)=>{
        if(text!='failed'){
            //TODO 채팅방 만들기를 성공했을 시
            stompClient.disconnect();
            reSetMyChatRoomList();
            
            
        }else{
            //TODO 채팅방 만들기를 실패했을 시
        }
    });
}


function reSetMyChatRoomList(){
    let url = '/chat/selectmychatroomlistimpl'
        fetch(url,{
            method : "GET"
        })
        .then(response=>{
            if(response.ok){
                return response.text()
            }
        })
        .then((text)=>{
            if(text!='failed'){
                myChatRoomList = JSON.parse(text) //내가 속한 채팅방 리스트
                connectSocket();
            }else{
            }
        });
}


function selectMessageHistory(userId){
	let url = '/communication/selectmessagehistoryimpl?userId='+ userId;
	fetch(url,{
		method:"GET"
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		if(text=='success'){
			
		}else{
			insertMessageHistoryImpl(userId);
		}
	});	
}


function insertMessageHistoryImpl(userId){
	let url = '/communication/insertmessagenotiimpl?userId='+ userId;
	fetch(url,{
		method:"GET"
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		if(text=='success'){
			let messageNoti = document.getElementById("message_noti");
			messageNoti.setAttribute("style","visibility:visible");
		}else{
			
		}
	});
}

function updateChatContentImpl(msgTo,msgFrom){
	console.log("IS_CHECK을 1로 변경!")
	let url ='/chat/updatechatcontentimpl';
	let paramObj = new Object();
	paramObj.msgTo = msgTo;
	paramObj.msgFrom = msgFrom;
	
	let headerObj = new Headers();
	headerObj.append('content-type','application/json');
	
	fetch(url,{
		method : "POST",
		headers : headerObj,
		body : JSON.stringify(paramObj)
	}).then(response=>{
		if(response.ok){
			return response.text();
		}
	}).then((text)=>{
		if(text=="success"){
			selectNotiheckChatContentImpl(msgTo);
		}else{
			
		}
	});
}

function selectNotiheckChatContentImpl(msgTo){
	let url ='/chat/selectnoticheckchatcontentimpl?msgTo='+msgTo;
	fetch(url,{
		method : "GET"
	}).then(response=>{
		if(response.ok){
			return response.text();
		}		
	}).then((text)=>{
		let messageNotiCount = document.getElementById("message_noti_count");
		let notiCheckedChatContentList = JSON.parse(text);
		messageNotiCount.innerHTML = notiCheckedChatContentList.length;
		
		
	});
}


</script>