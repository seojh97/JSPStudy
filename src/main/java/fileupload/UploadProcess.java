package fileupload;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/*
어노테이션을 통해 매핑한다. 
파일업로드 폼에서 전송(submit)하면 요청을 받아 처리한다.
*/
@WebServlet("/13FileUpload/UploadProcess.do")
/*
첨부파일의 초대용량을 설정한다.
maxFileSize : 개별 파일의 최대용량으로 1Mb로 설정
maxRequestSize : 첨부할 전체 파일의 용량을 10Mb로 설정
*/
@MultipartConfig(
		maxFileSize = 1024 * 1024 * 1,
		maxRequestSize = 1024 * 1024 * 10
)
public class UploadProcess extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	/* 파일업로드 폼에서 전송방식은 post이므로 doPost()를 오버라이딩한다. */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			//파일이 저장될 디렉토리의 물리적 경로를 가져온다.
			String saveDirectory = getServletContext().getRealPath("/Uploads");

			//유틸리티 클래스의 uploadFile()을 호출하여 파일을 업로드한다.
			String originalFileName = FileUtil.uploadFile(req, saveDirectory);
			
			//renameFile()을 호출하여 저장된 파일명을 변경한다.
			String savedFileName = FileUtil.renameFile(saveDirectory, originalFileName);
			
			//폼값을 정리해서 테이블에 Insert 처리한다.
			insertMyFile(req, originalFileName, savedFileName);
			
			//업로드가 완료되었다면 목록으로 리다이렉트(이동)한다.
			resp.sendRedirect("FileList.jsp");
		}
		catch(Exception e) {
			//만약 업로드에 실패한다면 작성페이지로 포워드한다.
			e.printStackTrace();
			req.setAttribute("errorMessage", "파일 업로드 오류");
			req.getRequestDispatcher("FileUploadMain.jsp").forward(req, resp);
		}
	}
	
	private void insertMyFile(HttpServletRequest req, String oFileName, String sFileName) {
		
		//파일이외의 폼값을 전송받는다.
		String title = req.getParameter("title");
		String[] cateArray = req.getParameterValues("cate");
		StringBuffer cateBuf = new StringBuffer();
		if(cateArray == null) {
			cateBuf.append("선택한 항목 없음");
		}
		else {
			for (String s : cateArray) {
				cateBuf.append(s + ", ");
			}
		}
		System.out.println("파일외폼값:"+title +"\n"+ cateBuf);
		
		//DTO객체에 폼값과 파일명(원본파일명, 저장된파일명)을 저장한다.
		MyFileDTO dto = new MyFileDTO();
		dto.setTitle(title);
		dto.setCate(cateBuf.toString());
		dto.setOfile(oFileName);
		dto.setSfile(sFileName);
		
		//DAO객체를 생성하여 DBCP를 통해 오라클에 연결한다.
		MyFileDAO dao = new MyFileDAO();
		//DTO객체를 전달하여 테이블에 insert한다.
		dao.insertFile(dto);
		dao.close();
	}
	
}
