<%@page import="java.util.Set"%>
<%@page import="common.Person"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>application 영역</title>
</head>
<body>
	<h2>application 영역의 속성 읽기</h2>
	<%
	//Object로 저장된 속성값을 Map타입으로 형변환한다.
	Map<String, Person> maps = (Map<String, Person>)application.getAttribute("maps");
	/*
	Map은 Key를 통해 Value를 저장하므로 반복하기전 Key를 먼저 얻어온다.
	keySet()을 통해 얻어온 후 반복해서 Value를 읽어와서 출력한다.
	*/
	Set<String> keys = maps.keySet();
	for(String key : keys){
		Person person = maps.get(key);
		out.print(String.format("이름 : %s, 나이 : %d<br>", person.getName(), person.getAge()));
	}
	%>
</body>
</html>