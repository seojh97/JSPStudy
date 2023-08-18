<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="IsErrorPage.jsp" %>
<!-- 
에러페이지 처리방법2 : page 지시어에 errorPage속성을 추가한다.
해당 속성은 에러발생시 현재 페이지에서 처리하지 않고, 지정된 페이지로 오류를 전달하겠다는 의미를 가지고있다.
Java에서 throws와 동일하다.

해당 파일을 실행하면 즉시 500에러가 발생된다.
이때 에러는 지시어에 지정한 페이지로 전달하게되어 실제 출력되는 내용은 IsErrorPage.jsp파일이 출력하게된다.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>page 지시어 - errorPage, isErrorPage 속성</title>
</head>
<body>
<%
int myAge = Integer.parseInt(request.getParameter("age")) + 10;
out.println("10년 후 당신의 나이는 " + myAge + "입니다.");
%>
</body>
</html>