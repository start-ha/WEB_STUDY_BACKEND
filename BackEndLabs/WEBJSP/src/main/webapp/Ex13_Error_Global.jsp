<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String data = request.getParameter("name"); //에러 안남
	String data2 = data.toLowerCase(); //null 데이터를 소문자로 못바꿈 >> 에러
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	전달받은 내용 [전역 예외]<%=data2%>
</body>
</html>