<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/header.jsp" />

	<div class="card" style="margin:10rem;">
		<div class="card-body">
			Empno <h5 class="card-title">${requestScope.empdetail.empno}</h5>
			<hr>
			Ename <p class="card-text">${requestScope.empdetail.ename}</p>
			<hr>
			Job <p class="card-text">content ${requestScope.empdetail.job}</p>
			<hr>
			Deptno <p class="card-text">content ${requestScope.empdetail.deptno}</p>
			<hr>
			Mgr <p class="card-text">content ${requestScope.empdetail.mgr}</p>
			<hr>
			Sal <p class="card-text">content ${requestScope.empdetail.sal}</p>
			<hr>
			Comm <p class="card-text">content ${requestScope.empdetail.comm}</p>
			
			
			<a class="btn btn-primary" href="empdelete.do?id=${requestScope.empdetail.empno}">삭제하기</a>
		<a class="btn btn-primary" href="empupdate.do?id=${requestScope.empdetail.empno}">수정하기</a>
		</div>
	</div>
</body>
</html>