<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Session</title></head>
<body> 
	<jsp:include page="../Common/Link.jsp" />
    <h2>로그인 페이지</h2>
 
 	<!-- 
 	로그인을 위해 폼값을 전송한 후 만약 조건에 맞는 회원정보가 없는 경우 request영역에 에러메세지를 저장한 후 현재페이지로 forward한다.
 	request영역은 forward된 페이지까지는 영역이 공유되므로 아래에 메세지를 출력할 수 있다.
 	-->
    <span style="color: red; font-size: 1.2em;"> 
        <%= request.getAttribute("LoginErrMsg") == null ?
                "" : request.getAttribute("LoginErrMsg") %>
    </span>
    <%
    /*
    session영역에 해당 속성값이 있는지 확인한다.
    즉, session영역에 데이터가 없다면 로그아웃 상태 이므로 로그인 폼을 웹브라우저에 출력한다.
    */
    if (session.getAttribute("UserId") == null) { 
    %>
    <script>
    /* 로그인 폼의 입력값을 검증하기 위한 함수로 빈값인지를 확인한다. */
    function validateForm(form) {
    	//입력값이 공백인지 확인후 경고창, 포커스이동, 폼값전송 중단처리를 한다.
        if (!form.user_id.value) {
            alert("아이디를 입력하세요.");
            form.user_id.focus();
            return false;
        }
        if (form.user_pw.value == "") {
            alert("패스워드를 입력하세요.");
            form.user_pw.focus();
            return false;
        }
    }
    </script>

	<!-- 회원정보는 보안이 필요하므로 반드시 post방식으로 전송해야한다. -->
    <form action="LoginProcess.jsp" method="post" name="loginFrm"
        onsubmit="return validateForm(this);">
        아이디 : <input type="text" name="user_id" /><br />
        패스워드 : <input type="password" name="user_pw" /><br />
        <input type="submit" value="로그인하기" />
    </form>
    <%
    } else { 
    	//로그인이 된 상태에서는 회원의 이름과 로그아웃 버튼을 출력한다.
    %>
        <%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다.<br />
        <a href="Logout.jsp">[로그아웃]</a>
    <%
    }
    %>
</body>
</html>
