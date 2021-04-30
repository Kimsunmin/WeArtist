package com.we.art.common.exception;

import com.we.art.common.code.ErrorCode;

public class CustomException extends RuntimeException{
	
	private static final long serialVersionUID = 7531344378242001266L;
	public ErrorCode error;
	
	//1. 실제로 예외가 발생한 것이 아니라 우리가 지정한 예외상황에 대한
	//예외처리를 위한 생성자. stackTrace를 찍지 않는다.
	public CustomException(ErrorCode error) {
		this.error = error;
		//stackTrace를 공백으로 초기화
		this.setStackTrace(new StackTraceElement[0]);
	}
	
	public CustomException(ErrorCode error, Exception e) {
		//콘솔창에 log를 작성
		e.printStackTrace();
		//error 전달받은 enum을 저장
		this.error = error;
	}
}
