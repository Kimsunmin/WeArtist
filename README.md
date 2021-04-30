# WeArtist 팀프로젝트
***
>가상의 전시관에 전시를 할 수 있는 사이트

+ 팀원 (맡은 기능)
  + 김선민(본인)
    + Gallery Page, Live Page, Upload Page
  + 김종환
    + Join Page, Profile Page
  + 장영우
    + DirectMessage, Chat, Main Page, MyPage
  + 김지연
    + Login Page, Index Page

### Index Page Screenshot
![WeArtist_index](https://user-images.githubusercontent.com/19908489/116662870-4c66da00-a9d1-11eb-8ff3-a8bbcc1f79ee.jpg)


## Gallery Page 소개 
***
Three.js를 통해 회원이 업로드한 작품을 가상의 전시관에 전시하는 페이지

### 구현기능
***
>전시관 불러오기
```JavaScript
let target;
  const gltfLoader = new GLTFLoader();
  const url = '/resources/landscape_gallery_by_stoneysteiner/scene.gltf';
  //gltfLoader.load() 이용하여 Gallery gltf파일을 불러온다.
  gltfLoader.load(url, (gltf) => {
    const root = gltf.scene;
    scene.add(root); // 불러온 gltf파일을 Scene에 추가한다.
    
    target = root.getObjectByName('Cube003'); // 3D오브젝트 객체에서 필요한 오브젝트를 불러온다.
    // 불러온 오브젝트를 돌며 회원이 업로드한 작품을 올린다.
    for(let item of target.children){
      item.material.map = textureLoader.load(imgData[item.name]);
      targetList.push(item);
    }
  
    root.add(camera);
    
});
```

### 어려려웠던 점
***
+ 이미 만들어져 있던 GLTF파일에서 필요한 3D객체를 찾아 이미지를 교체하는 과정
  + 해결방법 : scene객체의 getObjectByName()을 통해 필요한 객체를 찾아 해당 오브젝트의 material.map 속성을 업로드한 이미지로 변경
  
+ 이미지를 클릭했을때 이벤트 발생
  + 해결방법 : 클릭시 해당위치의 x,y값을 입력받아 미리 저장한 targetList와 클릭된 객체를 비교하였다.
```javascript
let ray = new THREE.Raycaster();
ray.setFromCamera( mouse, camera );
let intersects = ray.intersectObjects( targetList);
if(intersects.length > 0){
  targetList.forEach((e) => {
    // 클릭했을때 눌린 객체가 그림인지 아닌지 확인하는 조건문
    if(e.name === intersects[0].object.name && galleryData[e.name]){
      clickObject(e.name);
    }
  })}
```

### Screenshot
***
![WeArtist_Gallery](https://user-images.githubusercontent.com/19908489/116664644-b7191500-a9d3-11eb-8a2c-ed1e0a180e0d.jpg)

## Live Page 소개
***
WebRTC를 사용한 실시간 스트리밍 페이지로써 회원의 작품제작 과정을 보여줄 수 있다.
이때 WevRTC를 사용하기 위해 Spring WebSocket을 Signaling Server로 사용하였고 AWS를 이용해 Trun서버를 구축하였다.

### 구현기능
***
> Spring WebSocket을 Signaling Server으로 사용
```java
@Configuration
@EnableWebSocket
public class WebSocketConfiguration implements WebSocketConfigurer{

	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(new SocketHandler(), "/socket").setAllowedOrigins("*");	
	}
}
```
> TextWebSocketHandler를 상속받아 SocketHandler를 만들어 클라이언트와 정보를 교환할 수 있게 했다.
```java
@Component
public class SocketHandler extends TextWebSocketHandler{
	
	// 연결된 유저들을 저장하는 리스트
	List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
  	// socket에 접근한 유저의 아이디와 sessionID를 저장하는 리스트
	List<Map<String, String>> userList = new ArrayList<Map<String,String>>();
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception { 
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> data = new HashMap<String, Object>(); 
		
		data = mapper.readValue(message.getPayload(), new TypeReference<Map<String,Object>>(){}); // json타입으로 온 메세지를 파싱한다
		
    		//event 값으로 user이 넘어온다면 해당 유저의 ID와 SessionId를 저장한다
		if(data.get("event").equals("user")) {
			Map<String, String> commandMap = new HashMap<String, String>();
			commandMap.put((String) data.get("data"), session.getId());
			userList.add(commandMap);
    		//event 값으로 bye가 넘어온다면 해당 session을 리스트에서 삭제후 close()해준다.
		}else if(data.get("event").equals("bye")) {
			sessions.remove(session);
			session.close();
			System.out.println(sessions);
		}
    
		for (WebSocketSession webSocketSession : sessions) { // 메세지가 온다면
            if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) { // 세션이열려있고, 보낸사람이 아니라면
                webSocketSession.sendMessage(message); // 메세지 전송
            }
        }
	}
```
> 연결을 위한 기본적인 WebRTC 설정을 한다
```javascript
//peer연결을 위한 설정을 한뒤 저장
let peerConnection = new RTCPeerConnection(configuration);
//DataChannel을 생성한다. DataChannel -> 이미지,영상,텍스트 데이터를 전송할 수 있는 채널
let dataChannel = peerConnection.createDataChannel("dataChannel", {reliable : true});
// navigator.mediaDevices.getUserMedia를 사용하여 해당 디바이스의 카메라를 사용한다
navigator.mediaDevices.getUserMedia(constraints)
.then((stream) => {
  localStream = stream;
  localVideo.srcObject = stream;
  for(const track of stream.getTracks()){
    peerConnection.addTrack(track,stream); // 해당 영상 정보를 peerConnection에 track를 추가한다.
  }
})	
```

### Screenshot
***
![WeAriist_Live](https://user-images.githubusercontent.com/19908489/116673215-1419c880-a9de-11eb-9cd2-f2767dc45606.jpg)




