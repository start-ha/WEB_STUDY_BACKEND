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
	<div style="margin: 100px;">
		<form action="${pageContext.request.contextPath}/empinsert.do"
			method="post">
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Enumber</label> <input
					type="text" class="form-control" name="id" placeholder="empno 입력"
					required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Ename</label>
				<input type="text" class="form-control" name="ename"
					placeholder="이름 입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Job</label>
				<input type="text" class="form-control" name="content"
					placeholder="job 입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Deptno</label>
				<input type="text" class="form-control" name="content"
					placeholder="부서번호 입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Mgr</label>
				<input type="text" class="form-control" name="content"
					placeholder="mgr입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Sal</label>
				<input type="text" class="form-control" name="content"
					placeholder="Sal 입력" required="required">
			</div>
			<div class="mb-3">
				<label for="formGroupExampleInput" class="form-label">Comm</label>
				<input type="text" class="form-control" name="content"
					placeholder="Comm 입력" required="required">
			</div>
			<div class="col-12">
				<button type="submit" class="btn btn-primary">글쓰기</button>
			</div>
			<div class="col-12">
				<button onclick="location.href = 'memolist.do'" type="button"
					class="btn btn-light">취소</button>
			</div>
		</form>
	</div>

</body>
</html>