<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- 
trimDirectiveWhitespaces : 지시어 속성 중 지시어때문에 남은 불필요한 공백을 삭제한다.
콜백데이터는 해당 페이지에 출력되는 모든 소스코드를 반환하게 되는데, 공백도 하나의 문자이므로 필요없는 경우 제거하는 것이 좋다.
--%>
<%
/*
하루동안열지않음 체크박스를 체크한 후 닫기 버튼을 누르면 값 1이 파라미터로 전송된다.
*/
String chkVal = request.getParameter("inactiveToday");

//파라미터가 1이라면 아래와 같이 쿠키를 생성한다.
if(chkVal != null && chkVal.equals("1")){
	//생성자를 통해 쿠키를 생성한다.
	Cookie cookie = new Cookie("PopupClose", "off");
	//경로는 컨텍스트루트로 설정한다.
	cookie.setPath(request.getContextPath());
	//유지시간은 하루로 설정한다.
	cookie.setMaxAge(60*60*24);
	//응답헤더를 통해 생성된 쿠키를 클라이언트로 전송한다.
	response.addCookie(cookie);
	//콜백데이터를 웹브라우저에 출력한다.
	out.println("쿠키 : 하루 동안 열지 않음");
}
%>
