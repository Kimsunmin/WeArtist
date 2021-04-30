package com.we.art.common.chat.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.messaging.simp.annotation.support.SimpAnnotationMethodMessageHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.we.art.user.model.vo.User;

//@SendTo : 1:N으로 메시지를 뿌릴 때 사용하는 구조이며 보통 경로가 /topic 으로 시작
//@SendToUser : 1:1로 메세지를 보낼 때 사용하는 구조이며 보통 경로가 /queue로 시작

@Controller
public class MessageController {
		
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	@MessageMapping("message") ///message라는 경로에 메시지를 send헀을 때 실행
//	@SendTo("/queue/info") //구독경로설정(이 경로를 구독하고 있는 사용자들에게 메시지를 뿌린다.)
	public void info(Map<String,String> message,SimpMessageHeaderAccessor messageHeaderAccessor) {
		HttpSession session = (HttpSession) messageHeaderAccessor.getSessionAttributes().get("session");
		User userInfo = (User) session.getAttribute("userInfo"); //현재 세션에 있는 유저
		System.out.println(userInfo.getUserId()+"가 보낸 메세지 내용 :"+ message);
		String msgTo = message.get("msgTo");
		String roomId = message.get("roomId");
		simpMessagingTemplate.convertAndSend("/queue/"+ roomId,message);
//		return message;
	}
	
	@MessageMapping("push")
	public void commonPusdh(Map<String,String> message, SimpMessageHeaderAccessor messageHeaderAccessor) {
		HttpSession session = (HttpSession) messageHeaderAccessor.getSessionAttributes().get("session");
		User userInfo = (User) session.getAttribute("userInfo"); //현재 세션에 있는 유저
		System.out.println(userInfo.getUserId()+"가 보낸 메세지 내용 :"+ message);
		String fromId = message.get("fromId");
		String toId = message.get("toId");
		simpMessagingTemplate.convertAndSend("/queue/"+toId,message);
	}

}
