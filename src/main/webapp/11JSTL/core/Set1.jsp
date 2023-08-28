<%@page import="java.util.Date"%>
<%@page import="common.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 
JSTL의 core태그를 사용하기 위한 지시어 선언
prefix는 접두어, uri는 태그를 지원하는 예약어가 들어간다.
-->
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - set 1</title>
</head>
<body>
<!-- 
set태그 : 변수를 선언할때 사용
	JSP의 setAttribute()와 동일한 기능을 한다.
	4가지 영역에 새로운 속성을 추가한다.
	var : 속성명(변수명). 즉, 영역에 저장될 이름
	value : 속성에 저장될 값
	scope : 4가지 영역명을 가짐. 미지정시 가장 좁은 page 영역에 저장된 
	target : set 태그를 통해 생성된 자바빈즈의 이름을 지정함
	property : target으로 지정한 자바빈즈의 멤버변수 값을 저장한다.
-->
	<!-- 변수 선언 : 여기서는 가장좁은 page영역에 저장된다. -->
	<!-- value에는 일반값, EL, 표현식을 모두 사용할 수 있다. -->
	<c:set var="directVar" value="100" />
	<c:set var="elVar" value="${ directVar mod 5 }" />
	<c:set var="expVar" value="<%= new Date() %>" />
	<c:set var="betweenVar"> 변수값 요렇게 설정</c:set>
	
	<!-- 속성명이 중복되지 않는다면 영역을 표시하는 내장객체를 생략할 수 있다. -->
	<h4>EL을 이용해 변수 출력</h4>
	<ul>
		<li>directVar : ${ pageScope.directVar }</li>
		<li>elVar : ${ elVar }</li>
		<li>expVar : ${ expVar }</li>
		<li>betweenVar : ${ betweenVar }</li>
	</ul>
	
	<!-- 클래스의 생성자를 통해 객체를 생성한 후 request영역에 저장한다. -->
	<h4>자바빈즈 생성 1 - 생성자 사용</h4>
	<!-- 
	JSTL은 JSP코드 이므로 value속성에 기술할때 객체를 생성하기 위한 더블쿼테이션이 겹쳐지는 경우가 발생하게된다.
	이때는 value를 싱글쿼테이션으로 감싸서 겹쳐지지 않게 처리해야한다.
	-->
	<c:set var="personVar1" value='<%= new Person("박문수", 50) %>' scope="request" />
	<!-- 자바빈의 getter()를 통해 멤버변수의 값이 출력된다. -->
	<ul>
		<li>이름 : ${ requestScope.personVar1.name }</li>
		<li>나이 : ${ personVar1.age }</li>
	</ul>
	
	<h4>자바빈즈 생성 2 - target, property 사용</h4>
	<!-- 
	빈 객체를 먼저 생성한 후 target, property를 통해 멤버변수의 값을 설정한다. 
	이때 자바빈의 setter()가 사용된다.
	-->
	<c:set var="personVar2" value="<%= new Person() %>" scope="request" />
	<c:set target="${personVar2 }" property="name" value="정약용" />
	<c:set target="${personVar2 }" property="age" value="60" />
	<ul>
		<li>이름 : ${ personVar2.name }</li>
		<li>나이 : ${ requestScope.personVar2.age }</li>
	</ul>
	<!-- 속성명이 중복되지 않는다면 영역을 지정하는 내장객체는 생략할 수 있다. -->
</body>
</html>