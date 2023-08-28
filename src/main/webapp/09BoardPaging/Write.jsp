<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ include file="./IsLoggedIn.jsp"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<!-- 
글쓰기 폼은 반드시 post방식으로 제작해야한다.
get방식은 파일을 첨부할 수 없고, 전송량도 4Kb로 제한된다.
하지만 post는 전송량의 제한이 없고 이미지, 음원 등의 파일도 전송할 수 있기 때문이다.
-->
<script type="text/javascript">
function validateForm(form) {  // 폼 내용 검증
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>
</head>
<body>
<jsp:include page="../Common/Link.jsp" />
<h2>회원제 게시판 - 글쓰기(Write)</h2>
<form name="writeFrm" method="post" action="WriteProcess.jsp"
      onsubmit="return validateForm(this);">
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='List.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
