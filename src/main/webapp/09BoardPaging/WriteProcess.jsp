<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 페이지에 오랫동안 머물러 세션이 삭제되는 경우가 있으므로
글쓰기 처리 페이지에서도 반드시 로그인을 확인해야 한다. -->
<%@ include file="./IsLoggedIn.jsp"%>
<%
//클라이언트가 작성한 폼값을 받아온다.
String title = request.getParameter("title");
String content = request.getParameter("content");

//폼값을 DTO객체에 저장한다.
BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);
/* 특히 아이디의 경우 로그인 후 작성페이지에 진입할 수 있으므로
세션영역에 저장된 회원아이디를 가져와서 저장한다. */
dto.setId(session.getAttribute("UserId").toString());

BoardDAO dao = new BoardDAO(application);

//기존과 같이 게시물 1개를 등록할때 사용..
//int iResult = dao.insertWrite(dto);

//페이징 테스트를 위해 100개의 게시물을 한번에 입력..
int iResult = 0;
for(int i=1; i<=100; i++){
	/*
	만약 제목을 "안녕하세요"로 입력했다면...
	"..세요1", "..세요2" 와 같이 설정된다.
	*/
	dto.setTitle(title + i);
	iResult = dao.insertWrite(dto);
}


//자원해제
dao.close();

if(iResult == 1){
   //글쓰기에 성공했다면 목록으로 이동한다.
   response.sendRedirect("List.jsp");
}else{
   //실패했다면 경고창(alert)을 띄우고, 뒤로(history) 이동한다.
   JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>