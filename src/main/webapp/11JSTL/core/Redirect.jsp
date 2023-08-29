<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - redirect</title>
</head>
<body>
<!--
redirect태그 : 태그가 실행되는 즉시 페이지가 이동된다.
	새로운 페이지에 대한 요청이므로 request 영역은 공유되지 않는다.
	절대경로 사용시 컨텍스트루트 경로는 제외한다.
-->
	<!-- request 영역에 변수를 저장 -->
	<c:set var="requestVar" value="MustHave" scope="request" />
	<!-- 페이지 이동시 파라미터를 전달한다. 주소줄에 쿼리스트링으로 표시된다. -->
	<c:redirect url="/11JSTL/inc/OtherPage.jsp">
		<c:param name="user_param1" value="출판사" />
		<c:param name="user_param2" value="골든레빗"></c:param>
	</c:redirect>
	
	<!-- 
	response 내장객체를 통한 이동시에는 컨텍스트루트 경로를 반드시 기술해야한다.
	또한 파라미터가 한글인 경우 깨짐 현상이 발생되므로 URLEncoder 클래스를 통해 인코딩 처리를 해줘야한다.
	-->
	<h4>JSP 내장객체를 통한 페이지 이동</h4>
	<%
	String p1 = URLEncoder.encode("더조은");
	String p2 = URLEncoder.encode("종각지점");
	
	response.sendRedirect(request.getContextPath()+"/11JSTL/inc/OtherPage.jsp?user_param1="+p1+"&user_param2="+p2);
	%>
	
</body>
</html>