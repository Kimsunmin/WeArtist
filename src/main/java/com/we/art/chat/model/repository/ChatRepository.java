package com.we.art.chat.model.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.we.art.chat.model.vo.ChatContent;
import com.we.art.chat.model.vo.ChatRoom;

@Mapper
public interface ChatRepository {
	
	//채팅방 생성 쿼리
	@Insert("INSERT INTO TB_CHAT_ROOM(CHAT_ROOM_NO,FIRST_USER,SECOND_USER)"
			+ " VALUES('CHATROOM'||SC_CHAT_ROOM_IDX.NEXTVAL,#{firstUser},#{secondUser})")
	int insertChatRoom(ChatRoom chatRoom);
	
	//로그인 한 유저의 Following 리스트를 조회하는 쿼리
	List<Map<String,String>> selectSenderList(@Param("userId") String userId);
	
	//특정 유저와의 채팅방을 조회하는 메소드
	@Select("SELECT *"
			+ " FROM TB_CHAT_ROOM"
			+ "	WHERE (FIRST_USER = #{firstUser} AND SECOND_USER = #{secondUser})"
			+ "	OR (FIRST_USER = #{secondUser} AND SECOND_USER = #{firstUser})")
	ChatRoom selectRoomId(ChatRoom chatRoom);
	
	@Select("SELECT *FROM TB_CHAT_ROOM WHERE FIRST_USER = #{userId} OR SECOND_USER = #{userId}")	
	List<ChatRoom> selectMyChatRoomList(String userId);
	
	@Insert("INSERT INTO TB_CHAT_CONTENT(CHAT_NO,CHAT_ROOM_NO,MSG,MSG_TIME,MSG_TO,MSG_FROM)"
			+" VALUES('CHATNO'||SC_CHAT_IDX.NEXTVAL,#{chatRoomNo},#{msg},#{msgTime},#{msgTo},#{msgFrom})")
	int insertChatContent(ChatContent chatContent);
	
	List<Map<String,Object>> selectChatContentList(ChatRoom chatRoom);
	
	List<Map<String,Object>> selectLastMessageList(@Param("myChatRoomList")List<ChatRoom> myChatRoomList);
	
	int updateChatContent(ChatContent chatContent);
	
	List<ChatContent> selectNotiCheckChatContent(@Param("msgTo") String msgTo);
}
