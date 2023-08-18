<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Collection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 응답 헤더에 추가할 값 준비
/*
get방식을 전송된 폼값을 날짜형식을 통해 타임스템프로 변경한다.
getTime() : 날짜를 1970년부터 지금까지의 시간을 초단위로 변경하여 반환해준다.
*/
//문자열 형식을 날자 형식으로 변형하기 위해 포맷을 설정한다.
/*
응답헤더에 날짜를 지정하는 경우 대한민국은 세계표준시(그리니치천문대)에 +09 즉, 9시간이 빠르므로 그만큼을 더해줘야 날짜가 출력된다.
만약 09시 이전의 시간으로 세팅되면 하루전의 날짜가 출력된다.
*/
SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm");
//초단위로 변경된 시간을 long타입의 변수에 저장한다.
long add_date = s.parse(request.getParameter("add_date")).getTime();

//숫자형식으로 전송된 값은 정수로 변환한다.
int add_int = Integer.parseInt(request.getParameter("add_int"));
//문자형은 그대로 사용하면된다.
String add_str = request.getParameter("add_str");
/*
<form>태그를 통해 서버로 전송되는 값은 모두 String 타입이므로 숫자나 날짜형식의 연산이 필요한 경우에는 변환 후 사용해야한다.
*/

// 응답 헤더에 값 추가
/*
addDateHeader(헤더명, long타입의 타임스템프) : 응답헤더에 날짜형식을 추가하는 경우 long타입의 타임스템프로 변환 후 추가하면된다.
addIntHeader() : 숫자형식의 응답헤더를 추가한다.
addHeader() : 문자형식의 응답헤더를 추가한다.
*/
//날짜형식 추가
response.addDateHeader("myBirthday", add_date);
//정수형식 추가. 동일한 헤더명으로 2개의 값을 추가한다.
response.addIntHeader("myNumber", add_int);
response.addIntHeader("myNumber", 1004); //추가
//기존의 응답헤더를 '안중근'으로 수정한다.
response.addHeader("myName", add_str);
response.setHeader("myName", "안중근"); //수정
%>
<html>
<head>
<title>내장 객체 - response</title>
</head>
<body>
	<h2>응답 헤더 정보 출력하기</h2>
	<%
	//getHeaderNames()를 통해 응답헤더명 전체를 얻어온다.
	Collection<String> headerNames = response.getHeaderNames();
	//확장for문으로 갯수만큼 반복한다.
	for(String hName : headerNames){
		//헤더명을 통해 헤더값을 얻어온 후 출력한다.
		String hValue = response.getHeader(hName);
	%>
		<li><%= hName %> : <%= hValue %></li>
	<%
	}
	/*
	첫번째 출력결과에서 myNumber라는 헤더명이 2번 출력되는데 이때 동일한 값 8282가 출력된다.
	이것은 getHeader()메서드의 특성으로 처음 입력한 헤더값만 출력되게된다.
	*/
	%>
	
	<h2>myNumber만 출력하기</h2>
	<%
	/*
	myNumber라는 헤더명으로 2개의 값을 추가했으므로 아래에서는 각각의 값이 정상적으로 출력된다.
	즉, add계열의 메서드는 헤더명을 동일하게 사용하더라도 헤더값은 정상적으로 추가된다.
	즉, 덮어쓰기 되지 않는다.
	*/
	Collection<String> myNumber = response.getHeaders("myNumber");
	for(String myNum : myNumber){
	%>
		<!-- 8282, 1004가 순서대로 출력된다. -->
		<li>myNumber : <%= myNum %></li>
	<%
	}
	%>
</body>
</html>