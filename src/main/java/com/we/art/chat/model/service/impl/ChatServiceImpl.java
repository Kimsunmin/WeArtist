package com.we.art.chat.model.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.we.art.chat.model.repository.ChatRepository;
import com.we.art.chat.model.service.ChatService;
import com.we.art.chat.model.vo.ChatContent;
import com.we.art.chat.model.vo.ChatRoom;

@Service
public class ChatServiceImpl implements ChatService{

	private final ChatRepository chatRepository;
	
	
	public ChatServiceImpl(ChatRepository chatRepository) {
		this.chatRepository = chatRepository;
	}


	@Override
	public int insertChatRoom(ChatRoom chatRoom) {
		System.out.println("챗룸 :"+chatRoom);
		return chatRepository.insertChatRoom(chatRoom);
	}


	@Override
	public List<Map<String,String>> selectSenderList(String userId) {
		return chatRepository.selectSenderList(userId);
	}


	@Override
	public ChatRoom selectRoomId(ChatRoom chatRoom) {
		return chatRepository.selectRoomId(chatRoom);
	}


	@Override
	public List<ChatRoom> selectMyChatRoomList(String userId) {
		return chatRepository.selectMyChatRoomList(userId);
	}


	@Override
	public int insertChatContent(ChatContent chatContent) {
		return chatRepository.insertChatContent(chatContent);
	}


	@Override
	public List<Map<String, Object>> selectChatContentList(ChatRoom chatRoom) {
		System.out.println(chatRoom);
		return chatRepository.selectChatContentList(chatRoom);
	}


	@Override
	public List<Map<String,Object>> selectLastMessageList(List<ChatRoom> myChatRoomList) {
		return chatRepository.selectLastMessageList(myChatRoomList);
	}


	@Override
	public int updateChatContent(ChatContent chatContent) {
		return chatRepository.updateChatContent(chatContent);
	}


	@Override
	public List<ChatContent> selectNotiCheckChatContent(String msgTo) {
		return chatRepository.selectNotiCheckChatContent(msgTo);
	}

	
	
	
	
}
