<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL - choose/when/otherwise</title>
</head>
<body>
<!-- 
choose태그 : 하위에 when, otherwise 태그를 가지고있다.
여러 조건이 있는 경우 사용하기에 적합하다.
-->
	<!-- 변수선언 -->
	<c:set var="number" value="100" />
	
	<!--
	choose태그와 when태그 사이에 HTML주석을 기술하면 에러가 발생한다.
	또한 when과 otherwise사이에도 기술하면 안된다.
	-->
	<h4>choose 태그로 홀짝 판단하기</h4>
	<!-- if태그와 동일하게 test속성에 조건을 기술한다. -->
	<c:choose>
		<c:when test="${ number mod 2 eq 0 }">
			<!-- number를 2로 나눈 나머지가 0이면 짝수로 판단한다. -->
			${ number }는 짝수입니다.
		</c:when>
		<c:otherwise>
		<!-- else와 동일한 역할을 한다.	위 조건에 만족하지 않을때 실행된다.	-->
			${ number }는 홀수입니다.
		</c:otherwise>
	</c:choose>
	
	<h4>국, 영, 수 점수를 입력하면 평균을 내어 학점 출력</h4>
	<!-- form태그에 속성이 없으면 get방식으로 현재페이지로 폼값이 전송된다. -->
	<form>
		국어 : <input type="text" name="kor" /> <br>
		영어 : <input type="text" name="eng" /> <br>
		수학 : <input type="text" name="math" /> <br>
		<input type="submit" value="학점구하기" />
	</form>
	<!-- 국,영,수 3과목 모두 점수를 입력해야 조건에 만족하므로 하나라도 입력되지 않으면 평균점수는 출력되지 않는다. -->
	<c:if test="${ not (empty param.kor or empty param.eng or empty param.math) }">
		<!-- 
		3과목의 점수를 더한 후 평균값을 계산한다.
		이 값은 avg에 저장된다.
		EL은 자동으로 형변화 되므로 경우에 따라 실수의 결과가 나올수도 있다. -->
		<c:set var="avg" value="${ (param.kor + param.eng + param.math) / 3 }" />
		평균 점수는 ${avg }으로
		
		<!--
		평균점수를 통해 조건을 걸어 학점을 출력한다.
		when태그는 if 혹은 else if와 동일하고 otherwise는 else와 동일하다. 
		-->
		<c:choose>
			<c:when test="${ avg >= 90 }">A 학점</c:when>
			<c:when test="${ avg >= 80 }">B 학점</c:when>
			<c:when test="${ avg ge 70 }">C 학점</c:when>
			<c:when test="${ avg ge 60 }">D 학점</c:when>
			<c:otherwise>F 학점</c:otherwise>
		</c:choose>
		<!-- ge(greater than equal) 이므로 >=와 동일하다 -->
		입니다.
	</c:if>
</body>
</html>