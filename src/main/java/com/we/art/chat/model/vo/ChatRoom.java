package com.we.art.chat.model.vo;


public class ChatRoom {
	private String chatRoomNo;
	private String firstUser;
	private String secondUser;

	public String getChatRoomNo() {
		return chatRoomNo;
	}

	public void setChatRoomNo(String chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}

	public String getFirstUser() {
		return firstUser;
	}

	public void setFirstUser(String firstUser) {
		this.firstUser = firstUser;
	}

	public String getSecondUser() {
		return secondUser;
	}

	public void setSecondUser(String secondUser) {
		this.secondUser = secondUser;
	}

	@Override
	public String toString() {
		return "ChatRoom [chatRoomNo=" + chatRoomNo + ", firstUser=" + firstUser + ", secondUser=" + secondUser + "]";
	}

}
