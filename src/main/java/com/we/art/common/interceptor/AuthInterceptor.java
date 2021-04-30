package com.we.art.common.interceptor;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerAdapter;
import org.springframework.web.servlet.HandlerInterceptor;

import com.we.art.common.code.ErrorCode;
import com.we.art.common.exception.ToAlertException;

public class AuthInterceptor implements HandlerInterceptor{
	//Handlerinterceptor : 특정한 URI호출을 가로채는 역할을 한다.
	//이를 이용하여 기존 컨트롤러의 로직을 수정하지 않고도, 사전이나 사후제어가 가능하다.
	// Filter vs HandlerInterceptor : 두 기능 모두 특정 URI에 접근할 때 제어하는 용도로 사용.
	// 두 기능의 가장 큰 차이는 Context(실행 영역)에 있다.
	// Filter는 웹 어플리케이션 내에서 동작하기 때문에 Spring Context에 접근하기 어렵다. 반면
	// Interceptor의 경우 Spring 영역 내에서 동작하기 때문에, Spring Context에 접근하기 용이하다.
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws ServletException, IOException { // 지정된 컨트롤러의 동작 이전에 수행할 동작(사전 제어)
		// session에 userInfo 속성이 없을 경우 myPage로의 접근을 막음
		// session에 persistInfo 속성이 없을 경우 joinImpl로의 접근을 막음

		HttpSession session = request.getSession();
		String[] uriArr = request.getRequestURI().split("/");
		System.out.println(uriArr); 
		 if(uriArr.length > 0) {
	         switch (uriArr[1]) {
	         case  "" : break;
	         }
	      }
	      return true;

	}
}
