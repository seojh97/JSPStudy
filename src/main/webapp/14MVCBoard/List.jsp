<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<style>a{text-decoration:none;}</style>
</head>
<body>
    <h2>파일 첨부형 게시판 - 목록 보기(List)</h2>

    <!-- 검색 폼 -->
    <form method="get">  
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField">
                <option value="title">제목</option>
                <option value="content">내용</option>
                <option value="name">작성자</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>
    </table>
    </form>

    <!-- 목록 테이블 -->
    <table border="1" width="90%">
        <tr>
            <th width="10%">번호</th>
            <th width="*">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
            <th width="8%">첨부</th>
        </tr>
		<!-- 게시물이 없을 때 -->
        <c:choose>
        	<c:when test="${ empty boardLists }">
        		<tr>
        			<td colspan="6" align="center">
        				등록된 게시물이 없습니다.
        			</td>
        		</tr>
        	</c:when>
        	<c:otherwise> <!-- 게시물이 있을때 -->
        		<!-- 
        		확장for문 형태로 List에 저장된 레코드를 반복 출력한다. 
        		items속성에는 반복가능한 객체를 기술하고, 순서대로 추출된 데이터는 var속성에 지정한 변수로 입력된다.
        		-->
        		<c:forEach items="${ boardLists }" var="row" varStatus="loop">
        			<tr align="center">
        				<td>
        					${ map.totalCount - (((map.pageNum-1) * map.pageSiez) + loop.index)}
        				</td>
        				<td align="left">
        					<a href="../mvcboard/view.do?idx=${ row.idx }">${ row.title }</a>
        				</td>
        				<td>${ row.name }</td>
        				<td>${ row.visitcount }</td>
        				<td>${ row.postdate }</td>
        				
        				<td> <!-- 첨부파일 -->
        				<!-- 
        				첨부한 파일이 있는 경우에만 다운로드 링크를 출력한다.
        				해당 링크의 파라미터는 원본파일명, 저장된파일명, 일련번호 3개로 구성된다.
        				특히 일련번호는 다운로드 횟수 증가에 사용된다. 
        				-->
        				<c:if test="${ not empty row.ofile }">
        					<a href="../mvcboard/download.do?ofile=${ row.ofile } &sfile=${ row.sfile }&idx=${ row.idx }">[Down]</a>
        				</c:if>
        				</td>
        			</tr>
        		</c:forEach>
        	</c:otherwise>
        </c:choose>
    </table>
   
	<!-- 하단 메뉴(바로가기, 글쓰기) -->
    <table border="1" width="90%">
        <tr align="center">
            <td>
                ${ map.pagingImg }
            </td>
            <td width="100"><button type="button"
                onclick="location.href='../mvcboard/write.do';">글쓰기</button></td>
        </tr>
    </table>
</body>
</html>
