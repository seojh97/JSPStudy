<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberAuth.jsp</title>
</head>
<body>
    <h2>MVC 패턴으로 회원인증하기</h2>
    <p>
        <strong>${ authMessage }</strong>
        <br />        
 		<!-- 
 		요청명을 설정한 후 get방식의 요청을 위해 쿼리스트링으로 아이디와 패스워드를 전달한다.
 		해당 링크는 get방식의 <form>에서 submit한 것과 동일한 결과를 보여준다.
 		-->
        <a href="./MemberAuth.mvc?id=nakja&pass=1234">회원인증(관리자)</a>
        &nbsp;&nbsp;
        <a href="./MemberAuth.mvc?id=musthave&pass=1234">회원인증(회원)</a>
        &nbsp;&nbsp;
        <a href="./MemberAuth.mvc?id=stranger&pass=1234">회원인증(비회원)</a>
    </p>
</body>
</html>
