<%@page import="java.util.Calendar"%>
<%@page import="kr.or.kosa.Emp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	 Emp emp = new Emp();
	 emp.setEmpno(1000);
	 emp.setEname("홍길동");
	
	 Calendar cal = Calendar.getInstance();
	 int year = cal.get(Calendar.YEAR);
	 int month = cal.get(Calendar.MONTH) + 1;
	 int date = cal.get(Calendar.DATE);
	
	 //jsp는 출력용으로 기존 html에서 jsp로 바꾸는게 좋다(형식수정하는 것마다 안바꿔도 되서)
	 //내장객체 이해하기
	 //request 객체를 [클라이언트가 요청하는 페이지마다] 생성
	 //request 객체에는 IP, 여러정보 들어있음
	 
	 //Session : 클라이언트의 고유한 정보 >> key값 (id, pwd)
	 //Session :  서버가 클라이언트를 봤다는 증거 키값을 만들어서 브라우저에 쿠키로 던짐
	 //서버는 클라이언트가 쿠키 갖고 있는지 확인, 세션ID >> 서버는 20분동안 Session 객체를 갖고 있다
	 //클라이언트의 브라우저당 하나씩 부여 >> 천개의 브라우저 있으면 천개 세션 생성됨
	 //Application >> SessionID >>클라이언트의 고유의 것
	
	 //request : [클라이언트가 요청마다] 생성되는 객체
	 // JSP가 다른 페이지를 [include forward]하면 그 페이지의 request 객체를 공유할 수 있다(원래 페이지 안에서만 사용 가능)
	 //Session : 클라이언트의 고유한 정보 >> key값 (id, pwd)
	 //Application 기본객체 : (전역)공유자원 관리
	 //TAEYO.NET 국내 최초의 ASP사이트

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3> 출력 표현식</h3>
	<%= emp.getEmpno() %><br>
	<%= emp.getEname() %><br>
	<%= emp.toString() %><br>
	<hr>
	웹 서버의 날짜 : <%=year %>년 <%=month %>월 <%=date %>일
</body>
</html>