<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
해당 페이지에서는 가장먼저 팝업창 오픈에 관련된 쿠키가 있는지 먼저 확인한 후 팝업창을 처리해야한다.
*/
//팝업창 오픈 여부 판단을 위한 변수
String popupMode = "on"; 

//쿠키를 배열로 얻어온 후 웹브라우저에 생성된 모든 쿠키를 읽는다.
Cookie[] cookies = request.getCookies();
if (cookies != null) {
    for (Cookie c : cookies) {
        String cookieName = c.getName();
        String cookieValue = c.getValue();
        /*
        생성된 쿠키중에 아래와같이 쿠키명이 일치하는 쿠키를 찾는다.
        조건에 만족한다면 변수에 쿠키값을 저장한다.
        */
        if (cookieName.equals("PopupClose")) {
            popupMode = cookieValue; 
        }
    }
} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키를 이용한 팝업 관리</title>
<style>
    div#popup{
        position: absolute; top:100px; left:100px; color:yellow;  
        width:300px; height:100px; background-color:gray;
    }
    div#popup>div{
        position: relative; background-color:#ffffff; top:0px;
        border:1px solid gray; padding:10px; color:black;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script>
//jQuery의 엔트리포인트(진입점)
$(function() {
	//팝업창의 '닫기' 버튼을 누르면 아래의 jQuery를 실행한다.
    $('#closeBtn').click(function(){
    	//레이어 팝업창을 숨김처리한다.(display속성을 none으로 만든다.)
    	$('#popup').hide();
    	/*
    	하루동안 열지않음 체크박스에 체크한 경우에는 value를 얻어와서 변수에 저장한다.
    	value는 1로 설정되어있다.
    	*/
    	var chkVal = $("input:checkbox[id=inactiveToday]:checked").val();
    	$.ajax({
    		//요청할 서버의 URL(경로)
    		url : './PopupCookie.jsp',
    		//전송방식(get방식으로 설정)
    		type : 'get',
    		/*
    		요청시 전송할 파라미터.
    		여기서는 체크박스의 값을 설정한다.
    		만약 체크를 했다면 1, 아니면 null이 전송된다.
    		*/
    		data : {inactiveToday : chkVal},
    		//콜백데이터의 타입은 text형식으로 지정한다.
    		dataType : "text",
    		//요청성공시 호출될 콜백함수
    		success : function(resData){
    			/*
    			콜백데이터에 지시어 때문에 남게되는 공백때문에 불필요한 새로고침이 일어날 수 있다.
    			따라서 공백을 제거해야 정상적으로 동작하게된다.
    			*/
 				if(resData){
 					console.log('있다');
 				}
 				else{
 					console.log('없다');
 				}
    			console.log("콜백데이터", resData);
 				/*
 				만약 콜백데이터가 있다면 페이지를 새로고침한다.
 				F5를 누르는것과 동일하다.
 				*/
    			if(resData != '')location.reload();
    		}
    	});
    });
});
</script>
</head>
<body>
<h2>팝업 메인 페이지</h2>
<%
	//스크립트렛을 통해 아래 출력문장을 10번 반복한다.
    for (int i = 1; i <= 10; i++) {
    	//변수 popupMode의 초기값은 on이고, 만약 쿠키가 생성되었다면 off로 설정된다.
        out.println("현재 팝업창은 " + popupMode + " 상태입니다.<br/>");
    }
	/*
	만약 변수값이 on이 아니라면 아래 팝업창을 위한 HTML코드는 물리적으로 삽입되니 않는다.
	즉, 쿠키의 상태에 따라 페이지가 동적으로 변경된다.
	이와같은 것을 "동적웹페이지"라고 한다.
	*/
    if (popupMode.equals("on")) {
%>
    <div id="popup">
        <h2 align="center">공지사항 팝업입니다.</h2>
        <div align="right"><form name="popFrm">
            <input type="checkbox" id="inactiveToday" value="1" />
            하루 동안 열지 않음
            <input type="button" value="닫기" id="closeBtn" />
        </form></div>
    </div>
<%
    }
%>
</body>
</html>
