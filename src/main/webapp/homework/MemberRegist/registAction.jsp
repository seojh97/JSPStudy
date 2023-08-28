<%@page import="homework.regist.RegistDAO"%>
<%@page import="homework.regist.RegistDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//폼값받기
String id = request.getParameter("id");
String pass = request.getParameter("pass1");
String name = request.getParameter("name");
String email = request.getParameter("email1")+"@"+request.getParameter("email2");
String mailing = request.getParameter("mailing");
String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");
String mobile = request.getParameter("mobile1")+"-"+request.getParameter("mobile2")+"-"+request.getParameter("mobile3");
String sms = request.getParameter("sms");

//DTO객체에 저장하기
RegistDTO dto = new RegistDTO();
dto.setId(id);
dto.setPass(pass);
dto.setName(name);
dto.setEmail(email);
dto.setMailing(mailing);
dto.setZipcode(zipcode);
dto.setAddr1(addr1);
dto.setAddr2(addr2);
dto.setMobile(mobile);
dto.setSms(sms);

//DAO객체 생성 및 insert 처리
RegistDAO dao = new RegistDAO(application);
int result = dao.registInsert(dto);
if(result==1){
	out.println("입력성공");
}
else{
	out.println("입력실패");
}




%>