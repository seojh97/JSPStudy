package servlet;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import membership.MemberDAO;
import membership.MemberDTO;

public class MemberAuth extends HttpServlet{
	
	//서블릿에서 멤버변수 선언
	MemberDAO dao;
	
	/*
	클라이언트가 최초로 요청했을때 서블릿 객체가 생성되는데 이때 최초 1번만 호출되는 init() 메서드에서 DB연결 처리를 한다.
	*/
	@Override
	public void init() throws ServletException {
		
		/*
		서블릿 내에서 application 내장객체를 얻어온다.
		모델2 방식에서는 서블리이 먼저 요청을 받기 때문에 모델1 방식과 같이 JSP에서 매개변수로 내장객체를 전달할 수 없다.
		따라서 각 내장객체를 얻어올 수 있는 메서드가 존재한다.
		*/
		ServletContext application = this.getServletContext();
		
		//web.xml에 저장된 컨텍스트 초기화 파라미터를 얻어온다.
		String driver = application.getInitParameter("OracleDriver");
		String connectUrl = application.getInitParameter("OracleURL");
		String oId = application.getInitParameter("OracleId");
		String oPass = application.getInitParameter("OraclePwd");
		
		dao = new MemberDAO(driver, connectUrl, oId, oPass);
	}
	
	/* service() 메서드는 get/post 방식 둘다 요청을 받을 수 있다. */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		서블릿 매핑 시 <init-param>에 등록한 서블릿 초기화 파라미터를 얻어온다.
		해당 서블릿에서만 사용할 수 있다.
		*/
		String admin_id = this.getInitParameter("admin_id");
		
		//쿼리스트링으로 전달된 파라미터를 얻어온다.
		String id = req.getParameter("id");
		String pass = req.getParameter("pass");
		
		/*
		DAO의 회원인증을 위한 메서드를 호출한다.
		아이디, 패스워드를 통해 회원인증을 진행한 후 일치하는 정보가 있다면 회원레코드를 DTO에 저장 후 반환한다.
		*/
		MemberDTO memberDTO = dao.getMemberDTO(id, pass);
		
		String memberName = memberDTO.getName();
		if(memberName != null) {
			/* DTO객체에 회원의 이름이 저장되어 있다면 로그인에 성공한 경우로 판단할 수 있다. */
			req.setAttribute("authMessage", memberName + " 회원님 방가방가^^*");
		}
		else {
			/*
			회원인증에 실패한 경우에는 서블릿 초기화 파라미터와 비교해서 최고관리자인지 확인한다.
			만약 최고관리자도 아니라면 비회원으로 판단한다.
			*/
			if(admin_id.equals(id))
				req.setAttribute("authMessage", admin_id + "는 최고 관리자입니다.");
			else
				req.setAttribute("authMessage", "귀하는 회원이 아닙니다.");
		}
		req.getRequestDispatcher("/12Servlet/MemberAuth.jsp").forward(req, resp);
	}
	
	//서블릿 종료시 DAO객체도 같이 자원해제한다.
	@Override
	public void destroy() {
		dao.close();
	}
}
