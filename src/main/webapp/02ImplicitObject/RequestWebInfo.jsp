<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - request</title>
</head>
<body>
	<h2>1. 클라이언트와 서버의 환경정보 읽기</h2>
	<ul>
		<!-- get 혹은 post로 출력된다. -->
		<li>데이터 전송 방식 : <%= request.getMethod() %></li>
		<!-- 현재 접속한 전체경로를 반환한다. -->
		<li>URL : <%= request.getRequestURL() %></li>
		<!-- URL에서 호스트(Host)를 제외한 나머지 경로를 반환한다. -->
		<li>URI : <%= request.getRequestURI() %></li>
		<li>프로토콜 : <%= request.getProtocol() %></li>
		<li>서버명 : <%= request.getServerName() %></li>
		<li>서버포트 : <%= request.getServerPort() %></li>
		<!-- localhost는 루프백 주소이므로 0:0과 같이 표현된다. -->
		<li>클라이언트 IP 주소 : <%= request.getRemoteAddr() %></li>
		<!-- 
		get방식으로 전송할 경우 경로명 뒤에 클라이언트가 전송한 값을 출력한다.
		즉, get방식일때만 출력된다.
		-->
		<li>쿼리스트링 : <%= request.getQueryString() %></li>
		<!-- 
		클라이언트가 get 혹은 post 방식으로 전송한 값을 받을때 사용한다.
		단, Tomcat 9.x 버전에서는 post방식으로 전송하는 경우 한글의 깨짐현상이 발생되므로 별도의 인코딩처리가 필요하다.
		-->
		<li>전송된 값 1 : <%= request.getParameter("eng") %></li>
		<li>전송된 값 2 : <%= request.getParameter("han") %></li>
	</ul>
</body>
</html>