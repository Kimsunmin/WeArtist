package com.we.art.common.util.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.we.art.user.model.vo.User;

@Component
public class SocketHandler extends TextWebSocketHandler{
	
	// 연결된 유저들을 저장하는 배열
	List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();
	List<Map<String, String>> userList = new ArrayList<Map<String,String>>();
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception { 
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> data = new HashMap<String, Object>();
		
		data = mapper.readValue(message.getPayload(), new TypeReference<Map<String,Object>>(){});
		
		if(data.get("event").equals("user")) {
			Map<String, String> commandMap = new HashMap<String, String>();
			commandMap.put((String) data.get("data"), session.getId());
			System.out.println("성공?? : " + data.get("data") + " : " + session.getId());
			userList.add(commandMap);
		}else if(data.get("event").equals("bye")) {
			sessions.remove(session);
			session.close();
			System.out.println(sessions);
		}
		
		
		System.out.println(message.getPayload());
		for (WebSocketSession webSocketSession : sessions) { // 메세지가 온다면
            if (webSocketSession.isOpen() && !session.getId().equals(webSocketSession.getId())) { // 세션이열려있고, 보낸사람이 아니라면
                webSocketSession.sendMessage(message); // 메세지 전송
            }
        }
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("after : " + session);
		sessions.add(session); // 수신된 세션을 세션 목록에 저장
	}
	
	public List<Map<String, String>> getUserList(){
		return this.userList;
	}
	
}
