<%@page import="utils.JSFunction"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//전송된 폼값을 받는다.
String user_id = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");
/*
체크박스의 경우 둘 이상의 값이라면 getParameterValues()를 통해 폼값을 받아야 되지만, 항목이 한개라면 아래와 같이 받을 수 있다.
*/
String save_check = request.getParameter("save_check");

//단순한 문자열 비교를 통해 로그인 성공/실패를 판단한다.
if("must".equals(user_id) && "1234".equals(user_pw)){
	if(save_check != null && save_check.equals("Y")){
		/*
		로그인에 성공하고, 아이디저장을 체크한 경우에는 하루동안 유효한 쿠키를 생성한다.
		쿠키값은 로그인한 아이디로 설정한다.
		*/
		CookieManager.makeCookie(response, "loginId", user_id, 86400);
	}
	else{
		/*
		로그인에 성공하고, 아이디저장을 체크하지 않은 경우에는 쿠키를 삭제한다.
		*/
		CookieManager.deleteCookie(response, "loginId");
	}
	
	//로그인 성공 경고창을 띄운 후 로그인페이지로 이동한다.
	JSFunction.alertlocation("로그인에 성공했습니다.", "IdSaveMain.jsp", out);
}
else{
	//로그인에 실패한 경우 경고창을 띄운 후 뒤로 이동한다.
	//JSFunction.alertBack("로그인에 실패했습니다.", out);
%>
	<!-- 
	자바스크립트를 작성하려면 이와같이 스크립트렛을 분리하여 HTML영역을 만든 후 스크립트를 삽입해야한다.
	따라서 소스가 지저분해지고 가독성도 떨어진다.
	-->
	<script>
		alert('로그인에 실패했습니다.');
		//뒤로이동
		//history.back();
		history.go(-1);
	</script>
<%
}
%>

