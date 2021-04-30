package com.we.art.common.code;

public enum NotificationCode {
	LIKE("like"),
	FOLLOWING("following");
	
	
	private String method;

	private NotificationCode(String method) {
		this.method = method;
	}

	@Override
	public String toString() {
		return method;
	}

	
	
}
