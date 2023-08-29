<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - out</title>
</head>
<body>
<!-- 
out태그 : 영역에 저장된 변수를 출력할때 사용한다.
	escapeXml속성이 true이면 HTML 태그가 그대로 출력된다.
	innerText와 동일하다.
-->
	<!-- <i>태그가 포함된 문자열로 변수를 생성한다. -->
	<c:set var="iTag">
		i 태그는 <i>기울임</i>을 표현합니다.
	</c:set>
	
	<h4>기본 사용</h4>
	<!-- escapeXml 속성은 true가 디폴트이므로 HTML이 그대로 출력된다. -->
	<c:out value="${ iTag }"></c:out>
	
	<h4>escapeXml 속성</h4>
	<!--
	false가 되면 HTML태그가 적용되어 출력된다.
	즉, innerHTML과 동일하다.
	-->
	<c:out value="${ iTag }" escapeXml="false"></c:out>
	
	<h4>default 속성</h4>
	<!-- 최초 실행시에는 파라미터가 없는 상태이므로 default값이 출력된다. -->
	<c:out value="${ param.name }" default="이름 없음"></c:out>
	<!-- value속성이 null일때만 default값이 출력되고 빈 값인 경우에는 출력되지 않는다. -->
	<c:out value="" default="빈 문자열도 값입니다."></c:out>
</body>
</html>