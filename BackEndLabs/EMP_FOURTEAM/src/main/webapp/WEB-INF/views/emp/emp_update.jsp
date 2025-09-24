<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/header.jsp"/>
	<div style="margin: 100px;">
		<form action="${pageContext.request.contextPath}/memoupdateok.do?id=${requestScope.empupdate.empno}"
			method="post">
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">EMPNO</label> 
				<input
					value="${requestScope.empupdate.empno}" readonly
					type="text" class="form-control" name="id" placeholder="id입력"
					required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">ENAME</label>
				<input value="${requestScope.empupdate.ename}" type="text" class="form-control" name="email"
					placeholder="email입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">JOB</label>
				<input value="${requestScope.empupdate.job}" type="text" class="form-control" name="content"
					placeholder="content 입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">DEPTNO</label>
				<input value="${requestScope.empupdate.deptno}" type="text" class="form-control" name="content"
					placeholder="content 입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">MGR</label>
				<input value="${requestScope.empupdate.mgr}" type="text" class="form-control" name="content"
					placeholder="content 입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">SAL</label>
				<input value="${requestScope.empupdate.sal}" type="text" class="form-control" name="content"
					placeholder="content 입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">COMM</label>
				<input value="${requestScope.empupdate.comm}" type="text" class="form-control" name="content"
					placeholder="content 입력" required="required">
			</div>
			
			<div class="col-12">
				<button type="submit" class="btn btn-primary">수정하기</button>
			</div>
			<div class="col-12">
				<button onclick="location.href = 'emplist.do'" type="button"
					class="btn btn-light">취소</button>
			</div>
		</form>
	</div>

</body>
</html>