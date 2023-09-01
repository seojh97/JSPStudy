<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<!-- 
수정페이지는 작성페이지를 복사한 후 조금만 수정하면된다.
단, 패스워드 검증을 거쳐서 진입하게 되므로 패스워드 입력란은 제거한다.
또한 검증된 패스워드는 세션 영역에 저장되어있다.
-->
<script type="text/javascript">
	function validateForm(from){
		if(form.name.value == ""){
			alert("작성자를 입력하세요.");
			form.name.focus();
			return false;
		}
		if(form.title.value == ""){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if(form.content.value == ""){
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
		/* 패스워드 부분은 삭제한다. */
	}
</script>
</head>
<body>
	<h2>파일 첨부형 게시판 - 수정하기(Edit)</h2>
	<form action="../mvcboard/edit.do" name="writeFrm" method="post" enctype="multipart/form-data" onsubmit="return validateForm(this);">
	
	<!-- 수정할 게시물의 일련번호 -->
	<input type="hid-den" name="idx" value="${ dto.idx }" />
	<!-- 
	기존에 등록된 파일명 
	만약 수정페이지에서 첨부파일을 변경하지 않는다면 여기에 등록된 파일명을 사용해서 update할 예정이다.
	-->
	<input type="hid-den" name="prevOfile" value="${ dto.ofile }" />
	<!--  -->
	<input type="hid-den" name="prevSfile" value="${ dto.sfile }" />
	
	<table border="1" width="90%">
    <tr>
        <td>작성자</td>
        <td>
            <input type="text" name="name" style="width:150px;" value="${ dto.name }" />
        </td>
    </tr>
    <tr>
        <td>제목</td>
        <td>
            <input type="text" name="title" style="width:90%;" value="${ dto.title }" />
        </td>
    </tr>
    <tr>
        <td>내용</td>
        <td>
            <textarea name="content" style="width:90%;height:100px;">${ dto.content }</textarea>
        </td>
    </tr>
    <tr>
        <td>첨부 파일</td>
        <td>
        	<!--
        	파일의 경우에는 value 속성을 사용하지 않는다.
        	만약 사용한다면 단순한 String정보 이므로 의미가 없다.
        	-->
            <input type="file" name="ofile" />
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center">
            <button type="submit">작성 완료</button>
            <button type="reset">RESET</button>
            <button type="button" onclick="location.href='../mvcboard/list.do';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>    
</form>
</body>
</html>