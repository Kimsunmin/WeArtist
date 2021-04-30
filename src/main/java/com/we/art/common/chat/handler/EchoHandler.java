package com.we.art.common.chat.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.servlet.mvc.method.annotation.AbstractMappingJacksonResponseBodyAdvice;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.we.art.common.interceptor.SessionNames;
import com.we.art.user.model.vo.User;

@RequestMapping("/replyEcho")
public class EchoHandler extends TextWebSocketHandler {
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	Map<String, WebSocketSession> userSessions = new HashMap<String, WebSocketSession>();

	// 커넥션이 연결 됐을 때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("afterConnectionExtablished : " + session);
		sessions.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session);
	}

	// 소켓에 메시지를 보냈을 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handlerTextMessage" + session + "" + message);
		String senderId = getId(session);
//		for (WebSocketSession sess : sessions) {
//			sess.sendMessage(new TextMessage(senderId + ":" + message.getPayload()));
//		}
		
		//protocol : cmd, 댓글작성자, 게시글작성자, bno (ex : reply, user2, user1, 234)
		String msg = message.getPayload();
		if(StringUtils.isEmpty(msg)) {			
			String[] strs = msg.split(",");
			if(strs != null && strs.length==4) {
				String cmd = strs[0];
				String replyWriter = strs[1];
				String boardWriter = strs[2];
				String bno = strs[3];
				
			WebSocketSession boardWriterSession	=userSessions.get(boardWriter);
			if("".equals(cmd) && boardWriterSession!=null) {
				TextMessage tmpMsg =new TextMessage(replyWriter +"님이"+bno+"번 게시글에 댓글을 달았습니다.");
				boardWriterSession.sendMessage(tmpMsg);
			}
			}
		}
	}

	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		User loginUser = (User) httpSession.get(SessionNames.LOGIN);
		if (loginUser == null) {
			return session.getId();
		} else {
			return loginUser.getUserId();
		}
	}

	// 커넥션이 닫혔을 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("afterConnectEstablished : " + session + "" + status);
	}

}
