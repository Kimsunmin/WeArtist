let conn = new WebSocket('wss://localhost:8443/socket');

let peerConnection, dataChannel;
let input = document.getElementById("messageInput"); // 입력받은 메세지 정보

let localStream;
let localVideo = document.querySelector('#localVideo');
let remoteStream;
let remoteVideo = document.querySelector('#remoteVideo');

// 상태여부를 가지고 있는 변수
let isInitiator = false;
let isStarted = false;
let isChannelReay = false;

let sendMessage = () => {
    dataChannel.send(input.value);
    input.value = "";
}

const constraints = {
	video : true,
	audio : false
}

navigator.mediaDevices.getUserMedia(constraints)   // getUserMedia 사용시 해당 디바이스의 카메라를 사용한다
//navigator.mediaDevices.getDisplayMedia(constraints)  // getDisplayMedia 사용시 해당 원하는 화면을 사용할 수 있다.
.then((stream) => {
	peerConnection.addStream(stream);
	localStream = stream;
	localVideo.srcObject = stream;
	console.dir(stream);
})
.catch((error) => {
	
})

conn.onopen = () => {
	console.log('Connected');
	initialize();
};

conn.onmessage = (msg) => {
    console.dir("Got message", msg.data);
    let content = JSON.parse(msg.data);
    let data = content.data;
    switch (content.event) {
    case "offer":
        handleOffer(data);
        break;
    case "answer":
        handleAnswer(data);
        break;
    // when a remote peer sends an ice candidate to us
    case "candidate":
        handleCandidate(data);
        break;
    default:
        break;
    }
};

let send = (message) => {
	conn.send(JSON.stringify(message));
}

let initialize = () => {
    let configuration = {
		'iceServers' : [
			{
				"url" : 'stun:stun2.1.google.com:19302'
			},
			{
		      'urls': 'turn:3.19.138.148:3478?transport=udp',
		      'credential': 'sunmin',
		      'username': 'sunmin:sunmin'
		    },
		    {
		      'urls': 'turn:3.19.138.148:3478?transport=tcp',
		      'credential': 'sunmin',
		      'username': 'sunmin:sunmin'
		    }
		]
	}; // 이게 뭔지 모르겠네

    peerConnection = new RTCPeerConnection(configuration);

    // Setup ice handling
	// 후보자가 서버에 접근할때 마다 해당 이벤트가 발생한다.
    peerConnection.onicecandidate = (event) => {
        if (event.candidate) {
            send({
                event : "candidate", // 후보자
                data : event.candidate
            });
        }
    };
	peerConnection.onaddstream = (event) => {
			console.dir(event);
			remoteVideo.srcObject = event.stream;
	};

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
        console.log("message:", event.data);
    };

    dataChannel.onclose = () => {
        console.log("data channel is closed");
    };
  
  	peerConnection.ondatachannel = (event) => {
        dataChannel = event.channel;
  	};
    
}

// 성공시 offer를 전송하고 실패시 메시지를 띄운다.
let createOffer = () => {
	console.log('createOffer Yes');
    peerConnection.createOffer((offer) => {
        send({
            event : "offer",
            data : offer
        });
		peerConnection.addStream(localStream);
        peerConnection.setLocalDescription(offer);
    }, (error) => {
        alert("Error creating an offer");
    });
}

let handleOffer = (offer) => {
    peerConnection.setRemoteDescription(new RTCSessionDescription(offer));
    // create and send an answer to an offer
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