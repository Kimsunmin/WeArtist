<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="kr">
<%-- 모든 페이지에서 공통적으로 사용할 헤더정보를 담은 헤더태그 --%>
<head>
	<meta charset="UTF-8">
	<title>pclass</title>
	<%-- 
		contextPath를 context변수에 저장 
		ex)이 프로젝트에서는 contextPath가 jsp임으로 jsp가 context변수에 담긴다. 
	--%>
	<c:set var="context" value="${pageContext.request.contextPath}"/>
	<script type="text/javascript" src="/resources/js/common/urlEncoder.js"></script>
	<script type="text/javascript" src="/resources/js/common/asyncPageError.js"></script>
</head>
