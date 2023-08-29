package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
서블릿 클래스를 만들기 위한 절차
1. HttpServlet 클래스를 상속한다.
2. 클라이언트의 요청을 받아 처리하기 위한 doGet() 혹은 doPost()메서드를 오버라이딩한다.
3. 서블릿에 필수적인 패키지 임포트와 예외처리는 자동완성된다.
4. request내장객체를 사용할때는 매개변수 req를 이용한다. resposnse는 resp로 사용하면된다.
*/
public class HelloServlet extends HttpServlet{

	/*
	서블릿 작성시 발생되는 경고(Warning)을 위해 추가한다.
	없어도 실행에는 영향을 미치지 않는다.
	*/
	private static final long serialVersionUID = 1L;
	
	//get방식의 요청을 처리하기 위한 doGet()메서드 오버라이딩
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//request영역에 속성을 저장한다.
		req.setAttribute("message", "Hello 서블릿..!!");
		//View에 해당하는 JSP페이지로 포워드한다.
		req.getRequestDispatcher("/12Servlet/HelloServlet.jsp").forward(req, resp);
		/*
		request 영역은 포워드 된 페이지까지 공유되므로 서블릿에서 저장한 속성은 JSP에서 사용할 수 있다.
		*/
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	}
}
