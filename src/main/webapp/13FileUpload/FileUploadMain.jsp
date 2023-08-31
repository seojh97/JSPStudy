<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FileUploadMain</title>
</head>
<script>
	/*
	폼 값을 submit(전송)할때 빈 값에 대한 검증을 위한 JS함수 필수사항인 제목과 첨부파일에 대해서만 검증한다.
	*/
	function validateForm(form){
		if(form.title.value == ""){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if(from.ofile.value == ""){
			alert("첨부파일은 필수 입력입니다.");
			return false;
		}
	}
</script>
<body>
	<h3>파일 업로드</h3>
	<span style="color:red;">${errorMessage }</span>
	<!--
	파일 첨부를 위한 <form>태그 구성 시 아래 2가지는 필수사항
	1. method 속성은 반드시 'post'
	2. enctype 속성은 'multipart/form-data' 로 해야한다.
	마약 get방식으로 설정하는 경우에는 파일이 전송되는게 아니라 파일명만 전송되게된다.
	-->
	<form name="fileForm" method="post" enctype="multipart/form-data" action="UploadProcess.do" onsubmit="return validateForm(this);">
		제목: <input type="text" name="title" /><br />
		카테고리(선택사항) : 
		<input type="checkbox" name="cate" value="사진"  checked/>사진
		<input type="checkbox" name="cate" value="과제" />과제
		<input type="checkbox" name="cate" value="워드" />워드
		<input type="checkbox" name="cate" value="음원" />음원<br />
		첨부파일 : <input type="file" name="ofile" /><br />
		<input type="submit" value="전송하기"/>
	</form>
</body>
</html>