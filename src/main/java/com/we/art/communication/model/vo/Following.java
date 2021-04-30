package com.we.art.communication.model.vo;


public class Following {
	private String fromId;
	private String toId;

	
	
	
	public Following() {
		
	}


	public Following(String fromId, String toId) {
		this.fromId = fromId;
		this.toId = toId;
	}

	public String getFromId() {
		return fromId;
	}

	public void setFromId(String fromId) {
		this.fromId = fromId;
	}

	public String getToId() {
		return toId;
	}

	public void setToId(String toId) {
		this.toId = toId;
	}


	@Override
	public String toString() {
		return "Following [fromId=" + fromId + ", toId=" + toId + "]";
	}


}
