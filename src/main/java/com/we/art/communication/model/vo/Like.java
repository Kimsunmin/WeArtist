package com.we.art.communication.model.vo;

public class Like {

	private String bdNo;
	private String lkId;

	public String getBdNo() {
		return bdNo;
	}

	public void setBdNo(String bdNo) {
		this.bdNo = bdNo;
	}

	public String getLkId() {
		return lkId;
	}

	public void setLkId(String lkId) {
		this.lkId = lkId;
	}

	@Override
	public String toString() {
		return "Like [bdNo=" + bdNo + ", lkId=" + lkId + "]";
	}

}
