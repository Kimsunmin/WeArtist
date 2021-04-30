package com.we.art.user.model.vo;

import lombok.Data;

public class User {
	private String userId;
	private String password;
	private String email;
	private String name;
	private String phone;
	private String nickName;
	private String fIdx;
	private String loginMethod;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getfIdx() {
		return fIdx;
	}
	public void setfIdx(String fIdx) {
		this.fIdx = fIdx;
	}
	public String getLoginMethod() {
		return loginMethod;
	}
	public void setLoginMethod(String loginMethod) {
		this.loginMethod = loginMethod;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", password=" + password + ", email=" + email + ", name=" + name + ", phone="
				+ phone + ", nickName=" + nickName + ", fIdx=" + fIdx + ", loginMethod=" + loginMethod + "]";
	}

	
	
}
