<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.we.art.common.code.ConfigCode"
    %>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<body>
	<h1>반갑습니다. ${email} 님</h1>
	<h1>We Artist 사이트에 가입하셨던 비밀번호는 ${tempPw} 입니다.</h1>
	<a href="<%= ConfigCode.DOMAIN %>/user/login">로그인 하러 가기</a>
</body>
</html>