<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="x" uri="jakarta.tags.xml" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - xml</title>
</head>
<body>
	<!-- 
	import 태그를 통해 xml문서를 가져온다.
	var속성에 지정한 변수에 저장한다.
	-->
	<c:set var="booklist">
    	<c:import url="/11JSTL/inc/BookList.xml" charEncoding="UTF-8" />
    </c:set>

	<!-- 
	XML파일을 위해 parse태그에 1차로 설정한다.
	뒤에서 blist라는 변수명으로 각 노드를 파싱할 것이다.
	-->
    <x:parse xml="${booklist}" var="blist" />
   
   	<!-- 
   	bookilist 하위 노드에서 2개의 book이 있으므로 인덱스를 통해 접근한 후 데이터를 파싱한다.
   	이와같이 XML문서를 마치 경로처럼 접근하는 것을 XPath라고 한다.
   	XPath는 EL과는 다르게 {} (중괄호)를 사용하지 않는다.
   	-->
    <h4>파싱 1</h4>
    제목 : <x:out select="$blist/booklist/book[1]/name" /> <br />
    저자 : <x:out select="$blist/booklist/book[1]/author" /> <br />
    가격 : <x:out select="$blist/booklist/book[1]/price" /> <br />
    
    <h4>파싱 2</h4>
    <table border="1">
        <tr>
            <th>제목</th><th>저자</th><th>가격</th>
        </tr>
        <!-- 해당 노드에는 2권의 책 정보가 있으므로 반복할 수 있다. -->
        <x:forEach select="$blist/booklist/book" var="item">
        <tr>
            <td><x:out select="$item/name" /></td>
            <td><x:out select="$item/author" /></td>
            <td>
            	<!-- 조건물을 통해 아래와 같이 분기할 수 있다. -->
                <x:choose>
                    <x:when select="$item/price >= 20000"> 
                        2만 원 이상 <br />
                    </x:when>
                    <x:otherwise>
                        2만 원 미만 <br />
                    </x:otherwise>
                </x:choose>
            </td>        
        </tr>
        </x:forEach>
    </table> 
        
    <h4>파싱 3</h4>
    <table border="1">
        <x:forEach select="$blist/booklist/book" var="item">
        <tr>
            <td><x:out select="$item/name" /></td>
            <td><x:out select="$item/author" /></td>
            <td><x:out select="$item/price" /></td>
            <!-- 
            if태그로 조건이 true일때만 실행되는 구문을 작성함
            비교연산자로 ==대신 =을 사용하니 주의해야한다.
            -->
            <td><x:if select="$item/name = '총,균,쇠'">구매함</x:if></td> 
        </tr>
        </x:forEach>    
    </table>
</body>
</html>