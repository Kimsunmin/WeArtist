let conn = new WebSocket('wss:/3.19.138.148:8443/socket'); // 해당 주소로 소켓을 연다
//let conn = new WebSocket('wss:/localhost:8443/socket'); // 해당 주소로 소켓을 연다

let peerConnection;
let dataChannel; // 연결채널, 데이터 전송을 위한 채널을 연다
let input = document.getElementById("messageInput"); // 채팅 입력받을 곳

let localStream;
let localVideo = document.querySelector('#localVideo'); // Host화면

// 채팅 입력시 사용
let sendMessage = () => {
	dataChannel.send(input.value);
	insertChatRoom(false,input.value);
	input.value = "";
}

// 비디오,오디오 사용여부 추후 선택가능하게 변경
const constraints = {
	video : {
		width : 640,
		height : 480
	},
	audio : false
}

let setMedia = (isDisplay) => {
		if(isDisplay){
			navigator.mediaDevices.getDisplayMedia(constraints)
			.then((stream) => {
				localStream = stream;
				localVideo.srcObject = stream;
				for(const track of stream.getTracks()){
					peerConnection.addTrack(track,stream);
				}
			})
		}else{
			navigator.mediaDevices.getUserMedia(constraints)   // getUserMedia 사용시 해당 디바이스의 카메라를 사용한다
			.then((stream) => {
				localStream = stream;
				localVideo.srcObject = stream;
				for(const track of stream.getTracks()){
					peerConnection.addTrack(track,stream);
				}
			})	
		}
		//navigator.mediaDevices.getDisplayMedia(constraints)  // getDisplayMedia 사용시 해당 원하는 화면을 사용할 수 있다.
}

// conn 에 대한 이벤트 작성
conn.onopen = () => {
	console.log('Host Connected');
	initialize(); //연결됬을때 실행
	setMedia(confirm('화면공유 사용은 확인, 웹캠 사용은 취소 를 클릭하세요'));
	send({
		event : "user", // 후보자
        data : document.querySelector('#hostUserId').innerText
	})
}

conn.onmessage = (msg) => {
	console.log('Got Message', msg.data);
	let content = JSON.parse(msg.data);
	let data = content.data;
	switch(content.event){
		case "offer":
			handleOffer(data);
			break;
		case "answer":
			handleAnswer(data);
			break;
		case "candidate":
			handleCandidate(data);
        	break;
		default:
			break;
	}
}

let send = (message) => {
	conn.send(JSON.stringify(message));
}

let initialize = () => {
	
	input.addEventListener('keyup',()=>{
		if(window.event.keyCode == 13 && input.value.trim()){
			sendMessage();
		}
	})
	
	let configuration = {
		'iceServers' : [
			{
				"url" : 'stun:stun2.1.google.com:19302'
			},
			{
		    	url: 'turn:3.19.138.148:3478?transport=udp',
				credential: 'sunmin',
				username: 'sunmin'
		    },
		    {
		      	url: 'turn:3.19.138.148:3478?transport=tcp',
				credential: 'sunmin',
				username: 'sunmin'
		    }
		]
	};
	
	// 로컬 컴퓨터와 원격 피어의 연결을 담당한다
	peerConnection = new RTCPeerConnection(configuration);

	
	// Setup ice handling
	// 후보자가 서버에 접근할때 마다 해당 이벤트가 발생한다.
    peerConnection.onicecandidate = (event) => {
	 	console.dir(event);
        if (event.candidate) {
            send({
                event : "candidate", // 후보자
                data : event.candidate
            });
        }
		//createOffer();
    };

	peerConnection.onnegotiationneeded = () => {
		peerConnection.createOffer((offer) => {
	        send({
	            event : "offer",
	            data : offer
	        });
	        peerConnection.setLocalDescription(offer);
	    }, (error) => {
	        alert("Error creating an offer");
	    });
	}

	// creating data channel
	// dataChannel -> 이미지,영상,텍스트 데이터를 전송할 수 있는 채널이다.
    dataChannel = peerConnection.createDataChannel("dataChannel", {
        reliable : true
    });

    dataChannel.onerror = (error) => {
        console.log("Error occured on datachannel:", error);
    };

    // when we receive a message from the other peer, printing it on the console
	// 메세지 를 받으면 발생하는 이벤트
    dataChannel.onmessage = (event) => {
		insertChatRoom(true,event.data);
        console.log("message:", event.data);
    };

    dataChannel.onclose = () => {
        console.log("data channel is closed");
    };
  
  	peerConnection.ondatachannel = (event) => {
        dataChannel = event.channel;
  	};
	
	window.addEventListener('beforeunload',(e)=>{
		e.preventDefault();
		send({
			"event" : "bye",
			"data" : "yes"
		})
		//peerConnection.close();
		e.returnValue = 'end'; 
		
	})
	
}
// 성공시 offer를 전송하고 실패시 메시지를 띄운다.
let createOffer = () => {
	console.log('createOffer Yes');
    peerConnection.createOffer((offer) => {
        send({
            event : "offer",
            data : offer
        });
        peerList[userCount].setLocalDescription(offer);
    }, (error) => {
        alert("Error creating an offer");
    });
}

let handleOffer = (offer) => {
    peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
    // create and send an answer to an offer
	peerConnection.addStream(localStream);
    peerConnection.createAnswer((answer) => {
        peerConnection.setLocalDescription(answer);
        send({
            event : "answer",
            data : answer
        });
    }, (error) => {
        alert("Error creating an answer");
    });

};

// 새로운 유저?가 원격 서버에 접속했을때 발생 시킬 함수
let  handleCandidate = (candidate) => {
    peerConnection.addIceCandidate(new RTCIceCandidate(candidate));
};

let handleAnswer = (answer) => {
    peerConnection.setRemoteDescription(new RTCSessionDescription(answer));
    console.log("connection established successfully!!");
};
























