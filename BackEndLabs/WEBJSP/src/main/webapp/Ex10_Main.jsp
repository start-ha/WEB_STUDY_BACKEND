<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 

	공통 페이지를 만들고 싶어요
	
	JSP action 태그
	>> JSP:include  >> 현재 페이지에 공통의 페이지를 붙이기
	>> 공통으로 들어오는 파일


 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<b>SITE MAIN PAGE 상단</b>
	<br>
		<jsp:include page="/common/sub.jsp"></jsp:include>
	<br>
	<b>SITE MAIN PAGE 하단</b>
</body>
</html>