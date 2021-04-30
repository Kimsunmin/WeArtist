package com.we.art.chat.model.vo;

import lombok.Data;


public class ChatContent {
	private String chatNo;
	private String chatRoomNo;
	private String msg;
	private String msgTime;
	private String msgTo;
	private String msgFrom;
	private int isCheck;
	public String getChatNo() {
		return chatNo;
	}
	public void setChatNo(String chatNo) {
		this.chatNo = chatNo;
	}
	public String getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(String chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMsgTime() {
		return msgTime;
	}
	public void setMsgTime(String msgTime) {
		this.msgTime = msgTime;
	}
	public String getMsgTo() {
		return msgTo;
	}
	public void setMsgTo(String msgTo) {
		this.msgTo = msgTo;
	}
	public String getMsgFrom() {
		return msgFrom;
	}
	public void setMsgFrom(String msgFrom) {
		this.msgFrom = msgFrom;
	}
	
	
	public int getIsCheck() {
		return isCheck;
	}
	public void setIsCheck(int isCheck) {
		this.isCheck = isCheck;
	}
	@Override
	public String toString() {
		return "ChatContent [chatNo=" + chatNo + ", chatRoomNo=" + chatRoomNo + ", msg=" + msg + ", msgTime=" + msgTime
				+ ", msgTo=" + msgTo + ", msgFrom=" + msgFrom + ", isCheck=" + isCheck + "]";
	}
	
	
	
}
