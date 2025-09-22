<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page errorPage="/error/commonError.jsp"  %>
    
    
 <!-- 
 예외 상황이 발생해도 >> 특정 페이지가 처리하도록 ( 다른 화면 보여주기 )
  1. 해당 페이지에 설정하기 (직접 설정 : 개발 페이지당 다 설치해야되서 불편)
		>> 3번줄
  2. 전역적인 방법
  web.xml(웹 사이트 전체 : 전역 설정 파일) >> application.property, 야멀파일
  -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3> 잠시 네트워크 장애가 발생하였습니다... 잠시후 로그인 하세요 </h3>

<%

	int data = 0/0;

%>


</body>
</html>