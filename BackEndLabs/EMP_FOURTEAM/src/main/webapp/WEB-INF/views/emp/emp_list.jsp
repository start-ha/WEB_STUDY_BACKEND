<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	font-family: arial, sans-serif;
	border-collapse: collapse; /* 붕괴하다 , 무너지다 */
	width: 100%;
}

th {
	border: 1px solid #dddddd;
	text-align: center;
	padding: 8px;
}

td {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) { /* even 짝수     odd 홀수 */
	background-color: #dddddd;
}
</style>

</head>
<body>
	<jsp:include page="/header.jsp"/>
	<div align=center>
		<hr color=green width=400>
		<h2>EMP List</h2>

		<hr color=green width=400>
		<table style="width: 80%">
			<tr>
				<th>Empno</th>
				<th>Ename</th>
				<th>JOB</th>
				<th>Deptno</th>
				<th>Mgr</th>
				<th>Sal</th>
				<th>Comm</th>
			</tr>
			<!--  EL & JSTL 데이터 출력하세요 -->
			<c:forEach var="emp" items="${requestScope.empList}">
				<tr onclick="location.href='memodetail.do?id=${emp.empno}'"
					style="cursor: pointer;">
					<td>${emp.empno}</td>
					<td>${emp.ename}</td>
					<td>${emp.job}</td>
					<td>${emp.deptno}</td>
					<td>${emp.mgr}</td>
					<td>${emp.sal}</td>
					<td>${emp.comm}</td>
				</tr>
			</c:forEach>
		</table>
	</div>

</body>
</html>
