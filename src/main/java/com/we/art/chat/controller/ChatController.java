package com.we.art.chat.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.we.art.chat.model.service.ChatService;
import com.we.art.chat.model.vo.ChatContent;
import com.we.art.chat.model.vo.ChatRoom;
import com.we.art.user.model.vo.User;

@Controller
@RequestMapping("chat")
public class ChatController {

	private final ChatService chatService;

	public ChatController(ChatService chatService) {
		this.chatService = chatService;
	}

	@GetMapping("direct")
	public String direct(@SessionAttribute("userInfo") User userInfo,
			@SessionAttribute("myChatRoomList") List<ChatRoom> myChatRoomList,
			@RequestParam(value = "sendDirectNickName", required = false, defaultValue = "0") String sendDirectNickName,
			@RequestParam(value = "sendDirectUserId", required = false, defaultValue = "0") String sendDirectUserId,
			HttpSession session,
			Model model) {
		
		System.out.println("다이렉트 메세지 보낼 사람: "+sendDirectNickName+" , "+sendDirectUserId );
		User directUser = new User();
		directUser.setNickName(sendDirectNickName);
		directUser.setUserId(sendDirectUserId);
		
		List<Map<String,String>> senderList = new ArrayList<Map<String,String>>();
		senderList = chatService.selectSenderList(userInfo.getUserId());
		List<Map<String, Object>> lastMessageList = new ArrayList<>();
		
//		for(int i = 0; i<senderList.size(); i++) {
//			for(int j=0; j<lastMessageList.size();j++) {
//				if(senderList.get(i).get("nickName").equals(lastMessageList.get(j).get("msgToNickName")) 
//						|| senderList.get(i).get("nickName").equals(lastMessageList.get(j).get("msgFromNickName"))){
//						senderList
//					}
//			}
//			
//		}
		
//		chatContent.msgFrom !=userInfo.userId && chatContent.isCheck==0
				
//		if (senderList.size() != 0) {
//			senderList = chatService.selectSenderList(userInfo.getUserId());
//		}
		if (myChatRoomList.size() != 0) {
			lastMessageList = chatService.selectLastMessageList(myChatRoomList);
		}
		
		System.out.println("senderList : "+ senderList);
		model.addAttribute("sendDirect",directUser);
		model.addAttribute("senderList", senderList);
		model.addAttribute("lastMessageList", lastMessageList);
		System.out.println("라스트메세지 : "+lastMessageList);
		return "mypage/direct";
	}

	@PostMapping("subscribeimpl")
	@ResponseBody
	public String subscribeImpl(@SessionAttribute("userInfo") User userInfo, @RequestBody ChatContent chatContent,
			HttpSession session, Model model) {
		model.addAttribute("chatContent", chatContent);
		return "success";
	}

	@PostMapping("enterchatroomimpl")
	@ResponseBody
	public String enterChatRoom(@RequestBody ChatRoom chatRoom) {
		System.out.println("이건 컨트롤러 챗룸 : "+ chatRoom);
		//이미 만들어진 채팅방이 있는 지 확인
		ChatRoom currentChatRoom = chatService.selectRoomId(chatRoom);
		//만약 이미 만들어진 채팅방이 있다면
		if (currentChatRoom != null) {
			//그 채팅방의 번호를 반환
			return currentChatRoom.getChatRoomNo();
		} else {
			//만약 이미 만들어진 채팅방이 없다면
			//채팅방을 새로 생성
			int res = chatService.insertChatRoom(chatRoom);
			if (res != 0) {
				//채팅방 생성을 성공했으면 방금 그 채팅방 번호를 반환
				currentChatRoom = chatService.selectRoomId(chatRoom);
				if (currentChatRoom != null) {
					return currentChatRoom.getChatRoomNo();
				} else {
					return "failed";
				}
			} else {
				return "failed";
			}
		}
	}

	@PostMapping("insertchatcontentimpl")
	@ResponseBody
	public String insertChatContentImpl(@RequestBody ChatContent chatContent) {
		int res = chatService.insertChatContent(chatContent);
		if (res != 0) {
			return "success";
		} else {
			return "failed";
		}
	}

	@PostMapping("selectchatcontentlistimpl")
	@ResponseBody
	public List<Map<String, Object>> selectChatContentListImpl(@RequestBody ChatRoom chatRoom) {
		List<Map<String, Object>> chatContentList = new ArrayList<Map<String, Object>>();
		System.out.println(chatRoom.getFirstUser());
		System.out.println(chatRoom.getSecondUser());
		chatContentList = chatService.selectChatContentList(chatRoom);
		return chatContentList;
	}

	@GetMapping("selectmychatroomlistimpl")
	@ResponseBody
	public List<ChatRoom> selectMyChatRoomListimpl(@SessionAttribute("userInfo") User userInfo, HttpSession session) {
		List<ChatRoom> myChatRoomList = new ArrayList<ChatRoom>();
		myChatRoomList = chatService.selectMyChatRoomList(userInfo.getUserId());
		session.setAttribute("myChatRoomList", myChatRoomList);
		System.out.println("MYCHATROOMLIST : " + myChatRoomList);
		return myChatRoomList;
	}
	
	
	
	@GetMapping("resetsenderlist")
	@ResponseBody
	public List<Map<String,String>> resetSenderList(@SessionAttribute("userInfo") User userInfo){
		List<Map<String,String>> senderList = new ArrayList<Map<String,String>>();
		senderList = chatService.selectSenderList(userInfo.getUserId());
		
		return senderList;
	}
	
	@PostMapping("updatechatcontentimpl")
	@ResponseBody
	public String updateChatContentImpl(@RequestBody ChatContent chatContent) {
		
		int res = chatService.updateChatContent(chatContent);
		if(res!=0) {
			return "success";
		}else{
			return "failed";
		}
	}
	
	@GetMapping("selectnoticheckchatcontentimpl")
	@ResponseBody
	public List<ChatContent> selectNotCheckChatContent(@RequestParam("msgTo") String msgTo){
		List<ChatContent> notiCheckedChatContentList = new ArrayList<>();
		notiCheckedChatContentList = chatService.selectNotiCheckChatContent(msgTo);
		return notiCheckedChatContentList;
	}
	
	
	
	
	
	
}
