package model2.mvcboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;
//import model1.board.BoardDTO;

//커넥션풀을 통한 DB연결을 위해 클래스 상속
public class MVCBoardDAO extends DBConnPool{
	
	//기본생성자(정의하지 않아도 자동으로 삽입된다.)
	public MVCBoardDAO() {
		super();
	}
	
	/*
	게시물의 갯수를 카운트한다.
	검색어가 있는 경우 where절을 추가하여 조건에 맞는 게시물을 카운트한다.
	*/
	public int selectCount(Map<String, Object>map) {
		int totalCount = 0;
		
		String query = "SELECT COUNT(*) FROM mvcboard";
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		try {
			//인파라미터가 없는 정적쿼리문이므로 statement인터페이스 생성
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			/*
			count(*)는 항상 결과값이 있다.
			조건에 맞는게 없으면 0, 아니면 1이상의 값이 항상 반환된다.
			*/
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 카운트 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	//목록에 출력할 게시물을 얻어오기 위한 메서드
	public List<MVCBoardDTO> selectListPage(Map<String, Object>map){

		//mvcboard테이블을 대상으로 하므로 타입매개변수 확인 필요함
		List<MVCBoardDTO> board = new Vector<MVCBoardDTO>();
		
		/*
		페이징 처리를 위한 서브쿼리문
		특정 페이지에 해당하는 rownum의 구간으로 게시물을 인출한다.
		*/
		String query = " SELECT * FROM ("
					+	"	SELECT Tb.*, ROWNUM rNum FROM ( "
					+	"   	SELECT * FROM mvcboard	";

		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField")
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}

		query += "			ORDER BY idx DESC "
				+ "    ) Tb "
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		try {
			/*
			인파라미터가 있는 동적쿼리문이므로 prepared 객체 생성 및 인파라미터 설정
			*/
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());
			rs = psmt.executeQuery();
			while(rs.next()) {
				MVCBoardDTO dto = new MVCBoardDTO();
				
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));//날짜이므로 getDate()사용
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));//숫자이므로 getInt()사용
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
				
				board.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}
		return board;
		
	}
	
	//글쓰기 페이지에서 전송한 폼값을 테이블에 insert한다.
	public int insertWrite(MVCBoardDTO dto) {
		int result = 0;
		try {
			/*
			쿼리문의 일련번호는 모델1 게시판에서 생성한 시퀀스를 그대로 사용한다.
			나머지 값들은 컨트롤러(서블릿)에서 받은 후 모델(DAO)로 전달한다.
			*/
			String query = "INSERT INTO mvcboard("
					+ " idx, name, title, content, ofile, sfile, pass) "
					+ " VALUES ( "
					+ " seq_board_num.NEXTVAL,?,?,?,?,?,?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getPass());
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//내용보기를 위해 일련번호에 해당하는 게시물 1개를 인출해서 반환
	public MVCBoardDTO selectView(String idx) {
		MVCBoardDTO dto = new MVCBoardDTO();
		String query = "SELECT * FROM mvcboard WHERE idx=?";
		
		try {
			//쿼리문 준비
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, idx);
			//쿼리문 실행
			rs = psmt.executeQuery();
			
			//결과를 DTo객체에 저장
			if(rs.next()) {
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setContent(rs.getString(4));
				dto.setPostdate(rs.getDate(5));
				dto.setOfile(rs.getString(6));
				dto.setSfile(rs.getString(7));
				dto.setDowncount(rs.getInt(8));
				dto.setPass(rs.getString(9));
				dto.setVisitcount(rs.getInt(10));
			}
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기 중 예외 발생");
			e.printStackTrace();
		}
		//결과 반환
		return dto;
	}
	
	//게시물의 조회수를 1증가시킨다.
	public void updateVisitCount(String idx) {
		String query = "UPDATE mvcboard SET "
					+ " visitcount=visitcount+1 "
					+ " WHERE idx=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}
		catch(Exception e) {
			System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
	}
	
	//패스워드 검증용 메서드
	public boolean confirmPassword(String pass, String idx) {
		boolean isCorr = true;
		try {
			//일련번호와 패스워드의 조건에 일치하는 게시물이 있는지 확인
			String sql = "SELECT COUNT(*) FROM mvcboard WHERE pass=? AND idx=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, idx);
			rs = psmt.executeQuery();
			//count()함수는 반드시 결과값이 있으므로 if문 없이 next()를 호출
			rs.next();
			//결과가 0이라면 조건에 맞는 게시물이 없으므로 false 저장
			if(rs.getInt(1) == 0) {
				isCorr = false;
			}
		}
		catch(Exception e) {
			/*
			쿼리문 실행도중 예외가 발생되면 바로 catch절로 넘어오므로 이 경우에도 false로 값을 설정해야한다.
			*/
			isCorr = false;
			e.printStackTrace();
		}
		return isCorr;
	}
	
	//일련번호에 해당하는 게시물 1개를 삭제한다.
	public int deletePost(String idx) {
		int result = 0;
		try {
			String query = "DELETE FROM mvcboard WHERE idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//다운로드 횟수 1증가
	public void downCountPlus(String idx) {
		String sql = "UPDATE mvcboard SET "
				+ " downcount=downcount+1 "
				+ "WHERE idx=? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}
		catch(Exception e) {}
	}
	
	//게시물 수정하기. 첨부파일까지 포함되어있음
	public int updatePost(MVCBoardDTO dto) {
		int result = 0;
		try {
			//쿼리문 템플릿 준비
			String query = "UPDATE mvcboard"
						 + " SET title=?, name=?, content=?, ofile=?, sfile=? "
						 + " WHERE idx=? and pass=?";
			/*
			서블리 게시판은 비회원제이므로 게시물 수정시 일련번호 뿐만 아니라 패스워드까지 조건절로 추가한다.
			따라서 패스워드가 일치하지 않는다면 게시물은 수정되지 않는다.
			*/
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getOfile());
			psmt.setString(5, dto.getSfile());
			psmt.setString(6, dto.getIdx());
			psmt.setString(7, dto.getPass());
			
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
}

