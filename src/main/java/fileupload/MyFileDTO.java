package fileupload;

//myfile 테이블의 레코드를 저장할 수 있는 DTO클래스
public class MyFileDTO {
	
	//멤버변수
	private String idx;		 //일련번호
	private String title;	 //제목
	private String cate;	 //카테고리
	private String ofile;    //원본 파일명(ex:고길동_레포트_최종.hwp)
	private String sfile;	 //저장된 파일명(ex:20230101_123059.hwp)
	private String postdate; //등록 날짜
	
	//생성자는 필요할때만 생성한다.
	
	//getter/setter
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getSfile() {
		return sfile;
	}
	public void setSfile(String sfile) {
		this.sfile = sfile;
	}
	public String getPostdate() {
		return postdate;
	}
	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}

}
