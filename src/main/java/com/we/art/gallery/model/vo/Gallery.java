package com.we.art.gallery.model.vo;

import lombok.Data;

public class Gallery {
	
	private String userId;
	private String fIdx;
	private String bdNo;
	private String path;
	private String imgOrder;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getfIdx() {
		return fIdx;
	}
	public void setfIdx(String fIdx) {
		this.fIdx = fIdx;
	}
	public String getBdNo() {
		return bdNo;
	}
	public void setBdNo(String bdNo) {
		this.bdNo = bdNo;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getImgOrder() {
		return imgOrder;
	}
	public void setImgOrder(String imgOrder) {
		this.imgOrder = imgOrder;
	}
	@Override
	public String toString() {
		return "Gallery [userId=" + userId + ", fIdx=" + fIdx + ", bdNo=" + bdNo + ", path=" + path + ", imgOrder="
				+ imgOrder + "]";
	}
	
	
	
}
