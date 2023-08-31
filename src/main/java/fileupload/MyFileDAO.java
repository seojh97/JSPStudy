package fileupload;

import java.util.List;
import java.util.Vector;

import common.DBConnPool;

/*
커넥션풀(DBCP)를 이용해서 오라클DB에 연결한다.
설정 정보는 server.xml, context.xml에 기술되어있다.
이클립스는 복사본을 사용하게되고 원본은 Tomcat10.1 디렉토리 하위 conf 폴더에 위치한다.
*/
public class MyFileDAO extends DBConnPool{
	
	//새로운 게시물을 입력합니다.
	public int insertFile(MyFileDTO dto) {
		int applyResult = 0;
		try {
			/*
			인파라미터가 있는 동적쿼리문으로 작성
			클라이언트가 폼에 입력한 내용을 DTO에 저장 후 전달하면 해당 쿼리문의 인파라미터를 설정하게된다.
			*/
			String query = "INSERT INTO myfile ("
					+ " idx, title, cate, ofile, sfile)"
					+ " VALUES ( "
					+ " seq_board_num.nextval, ?, ?, ?, ?)";
			/*
			시퀀스는 모델1 게시판에서 생성했던 것을 그대로 사용한다.
			실무에서는 일반적으로 테이블당 하나의 시퀀스를 생성한다.
			*/
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getCate());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			//인파라미터를 설정한 후 insert 쿼리문을 실행한다.
			applyResult = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("INSERT 중 예외 발생");
			e.printStackTrace();
		}
		return applyResult;
	}
	
	//파일 목록을 반환
	public List<MyFileDTO> myFileList(){
		List<MyFileDTO> fileList = new Vector<MyFileDTO>();
		
		//인파라미터가 없는 정적 select 쿼리문 작성
		String query = "SELECT * FROM myfile ORDER BY idx DESC";
		try {
			//statement 객체 생성 및 쿼리 실행
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			
			//레코드의 갯수만큼 반복
			while(rs.next()) {
				//DTO에 저장
				MyFileDTO dto = new MyFileDTO();
				dto.setIdx(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setCate(rs.getString(3));
				dto.setOfile(rs.getString(4));
				dto.setSfile(rs.getString(5));
				dto.setPostdate(rs.getString(6));
				//목록에 추가
				fileList.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("SELECT 시 예외 발생");
			e.printStackTrace();
		}
		//목록 반환
		return fileList;
	}
}
