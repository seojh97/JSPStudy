<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//외부파일의 경로를 문자열 변수로 저장한다.
String outerPath1 = "./inc/OuterPage1.jsp";
String outerPath2 = "./inc/OuterPage2.jsp";

//page, request영역에 각각 속성값을 저장한다.
pageContext.setAttribute("pAttr", "동명왕");
request.setAttribute("rAttr", "온조왕");
%>
<html>
<head>
<title>지시어와 액션 태그 동작 방식 비교</title>
</head>
<body>
	<h2>지시어와 액션 태그 동작 방식 비교</h2>
	
	<h3>지시어로 페이지 포함하기</h3>
	<!-- 
	지시어를 이용한 인클루드의 경우 페이지의 경로는 문자열 형태로만 기술할 수 있다.
	표현식을 통해 변수를 사용할 수 없다.
	-->
	<%@ include file="./inc/OuterPage1.jsp" %>
	<%--@ include file="<%outerPath1OuterPage1%>" --%>
	
	<!-- 
	지시어를 통한 인클루드는 포함할 파일의 소스를 그대로 현재 문서에 포함시킨 후 컴파일을 진행한다.
	따라서 하나의 페이지이므로 newVar1은 정상적으로 출력된다.
	-->
	<p>외부 파일에 선언한 변수 : <%=newVar1 %></p>
	
	<h3>액션 태그로 페이지 포함하기</h3>
	<!-- 액션태그를 이용한 인클루드는 문자열과 표현식 두가지 모두 사용할 수 있다. -->
	<jsp:include page="./inc/OuterPage2.jsp" />
	<jsp:include page="<%=outerPath2 %>" />
	
	<!-- 
	액션태그를 통한 인클루드는 포함할 파일을 먼저 실행(컴파일)한 후 실행된 결과페이지를 해당 문서에 포함시킨다.
	따라서 외부파일에서 선언한 변수를 현재페이지에서는 사용할 수 없게된다.
	-->
	<p>외부 파일에 선언한 변수 : <%--=newVar2 --%></p>
	
	<!-- 
	include 지시어와 액션태그의 차이점
	지시어 
		- jsp소스를 그대로 포함시킨 후 페이지를 컴파일한다.
		- 따라서 같은 페이지를 의미한다.
		- jsp코드와 변수 등이 포함된 경우 사용한다.
	액션태그
		- jsp소스를 먼저 실행한 후 실행된 결과를 포함시킨다.
		- 따라서 기존페이지에서 선언한 변수는 포함시킨 페이지에서 사용할 수 없다.
		- HTML태그만 있거나 단독으로 실행가능한 JSP코드만 있을때 사용한다.
	-->
</body>
</html>