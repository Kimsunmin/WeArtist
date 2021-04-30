package com.we.art.communication.model.vo;

public class LikeHistory {

	private String bdNo;
	private String toId;
	private String fromId;
	private int isCheck;

	public String getBdNo() {
		return bdNo;
	}

	public void setBdNo(String bdNo) {
		this.bdNo = bdNo;
	}

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

	@Override
	public String toString() {
		return "LikeHistory [bdNo=" + bdNo + ", toId=" + toId + ", fromId=" + fromId + ", isCheck=" + isCheck + "]";
	}

}
