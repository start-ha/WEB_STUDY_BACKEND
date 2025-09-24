<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*
		DBCP 커넥션 풀 (미리 연결 생성해놓고 .. 사용하고 반환 // 반환안하면 서버터짐(서버연결안됨))
		커넥션 풀 종류 (Hikari CP, 연습 : Tomcat이 제공하는 풀 사용 tomcat-dbcp.jar)
	
		context.xml 설정 가져와서 사용
		1. Tomcat 가지고 있는 context.xml 설정
		2. 프로젝트 단위 설정 context.xml > META-INF > context.xml
		
		//JNDI (Java의 Naming and Directory Interface) //파일 탐색기처럼 특정 단어를 넣으면 특정 파일을 찾아주는 방식
			: 윈도우 탐색기 검색 ..... 찾는다
		*/
		
		Context context = new InitialContext(); //검색기능
		//현재 프로젝트에서 검색(이름으로)
		DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/oracle");
		//약속된 표현 : "java:comp/env/ + 이름(사용자정의)
		//context.xml <Resource 안에 name 사용)


		//웹 서버 메모리에 가게 오픈 (튜브-커넥션풀 : 20개) > conn 객체 빌려쓰고 다쓰면 반환 > 커넥션 풀
		
		
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>