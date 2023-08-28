<%@page import="utils.JSFunction"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 수정 처리 전 로그인 되었는지 확인한다. -->
<%@ include file="./IsLoggedIn.jsp" %>
<%
//수정폼에서 입력한 내용을 파라미터로 받는다.
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");

//DTO 객체에 수정할 내용을 저장한다.
BoardDTO dto = new BoardDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

//DAO객체 생성을 통해 오라클에 연결한다.
BoardDAO dao = new BoardDAO(application);
//update 쿼리문을 실행하여 게시물을 수정한다.
int affected = dao.updateEdit(dto);
//자원해제
dao.close();

if(affected ==1 ){
	/*
	수정이 완료되면 수정된 내용을 확인하기 위해 주로 내용보기 페이지로 이동한다.
	*/
	response.sendRedirect("View.jsp?num=" + dto.getNum());
}
else{
	//수정에 실패하면 경고창을 띄우고 뒤로 이동한다.
	JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>
