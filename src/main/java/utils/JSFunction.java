package utils;

import java.io.PrintWriter;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.JspWriter;

public class JSFunction {
	/*
	메서드 생성시 static을 통해 정적메서드로 정의하면 객체 생성없이 클래스명으로 즉시 메서드를 호출할 수 있다.
	*/
	public static void alertlocation(String msg, String url, JspWriter out) {
		/*
		Java클래스에서는 JSP의 내장객체를 즉시 사용할 수 없으므로 반드시 매개변수로 전달받아 사용해야한다.
		여기서는 웹브라우저에 문자열을 출력하기 위해 out내장객체를 JspWriter 타입으로 받은 후 사용하고있다.
		*/
		try{
			//Javascript를 하나의 문자열로 정의한다.
			String script = ""
						  + "<script>"
						  + "	alert	('" + msg + "');"
						  + "	location.href='" + url + "';"
						  + "</script>";
			//해당 문자열을 웹브라우저에 출력한다.
			out.println(script);
		}
		catch(Exception e) {}
	}
	
	public static void alertBack(String msg, JspWriter out) {
		try {
			String script = ""
						  + "<script>"
						  + "	alert('" + msg + "');"
						  + "	history.back();"
						  + "</script>";
			out.println(script);
		}
		catch(Exception e) {}
	}
	
	public static void alertlocation(HttpServletResponse resp, String msg, String url) {
		/*
		Java클래스에서는 JSP의 내장객체를 즉시 사용할 수 없으므로 반드시 매개변수로 전달받아 사용해야한다.
		여기서는 웹브라우저에 문자열을 출력하기 위해 out내장객체를 JspWriter 타입으로 받은 후 사용하고있다.
		*/
		try{
			//컨텐츠 타입을 설정
			resp.setContentType("text/html;charset=UTF-8");
			//PrintWriter객체를 통해 스크립트를 서블릿에서 직접 출력한다.
			PrintWriter writer = resp.getWriter();
			String script = ""
						  + "<script>"
						  + "	alert	('" + msg + "');"
						  + "	location.href='" + url + "';"
						  + "</script>";
			//해당 문자열을 웹브라우저에 출력한다.
			writer.print(script);
		}
		catch(Exception e) {}
	}
	
	/*
	상단 2개의 메서드는 JSP에서 사용하기 위해 정의하였다.
	JSP에서 out내장객체를 전달하면 매개변수로 받아서 사용한다.
	아래 2개는 서블릿(Servlet)에서 사용하기 위해 메서드 오버로딩을 통해 정의하였다.
	서블릿이 직접 요청을 받으므로 response내장객체를 통해 화면출력 용도인 PrintWriter 객체를 생성하여 사용한다.
	*/
	
	public static void alertBack(HttpServletResponse resp, String msg) {
		try {
			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter writer = resp.getWriter();
			String script = ""
						  + "<script>"
						  + "	alert('" + msg + "');"
						  + "	history.back();"
						  + "</script>";
			writer.println(script);
		}
		catch(Exception e) {}
	}
	
	
}
