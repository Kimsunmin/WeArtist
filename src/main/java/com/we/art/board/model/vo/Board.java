package com.we.art.board.model.vo;

import lombok.Data;

public class Board {
	private String bdNo;
	private String userId;
	private String bdTitle;
	private String bdContent;
	private String vNo;
	private String tag;

	public String getBdNo() {
		return bdNo;
	}

	public void setBdNo(String bdNo) {
		this.bdNo = bdNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBdTitle() {
		return bdTitle;
	}

	public void setBdTitle(String bdTitle) {
		this.bdTitle = bdTitle;
	}

	public String getBdContent() {
		return bdContent;
	}

	public void setBdContent(String bdContent) {
		this.bdContent = bdContent;
	}

	public String getvNo() {
		return vNo;
	}

	public void setvNo(String vNo) {
		this.vNo = vNo;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	@Override
	public String toString() {
		return "Board [bdNo=" + bdNo + ", userId=" + userId + ", bdTitle=" + bdTitle + ", bdContent=" + bdContent
				+ ", vNo=" + vNo + ", tag=" + tag + "]";
	}

}