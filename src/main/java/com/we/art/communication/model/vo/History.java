package com.we.art.communication.model.vo;

import lombok.Data;

public class History {

	private String toId;
	private String fromId;
	private int isCheck;
	private String notiMethod;
	private String notiTime;
	private String bdNo;
	private String bdTitle;

	public String getToId() {
		return toId;
	}

	public void setToId(String toId) {
		this.toId = toId;
	}

	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public int getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(int isCheck) {
		this.isCheck = isCheck;
	}

	public String getNotiMethod() {
		return notiMethod;
	}

	public void setNotiMethod(String notiMethod) {
		this.notiMethod = notiMethod;
	}

	public String getNotiTime() {
		return notiTime;
	}

	public void setNotiTime(String notiTime) {
		this.notiTime = notiTime;
	}

	public String getBdNo() {
		return bdNo;
	}

	public void setBdNo(String bdNo) {
		this.bdNo = bdNo;
	}

	public String getBdTitle() {
		return bdTitle;
	}

	public void setBdTitle(String bdTitle) {
		this.bdTitle = bdTitle;
	}

	@Override
	public String toString() {
		return "History [toId=" + toId + ", fromId=" + fromId + ", isCheck=" + isCheck + ", notiMethod=" + notiMethod
				+ ", notiTime=" + notiTime + ", bdNo=" + bdNo + ", bdTitle=" + bdTitle + "]";
	}

}
