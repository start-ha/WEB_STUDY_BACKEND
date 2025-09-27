<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action = "Form" method = "post">
		이름 : <input type = "text" name = "name" size="10"><br>
		아이디 : <input type = "text" name = "id" size = "10"><br>
		비밀번호 : <input type ="text" name = "pw" size = "10"><br>
		취미 : <input type = "checkbox" name = "hobby" value = "read">독서
		 <input type = "checkbox" name = "hobby" value = "read">요리
		 <input type = "checkbox" name = "hobby" value = "read">조깅
		 <input type = "checkbox" name = "hobby" value = "read">헬스
		 <input type = "checkbox" name = "hobby" value = "read">취침<br>
		 
		 <input type = "radio" name = "major" value ="kor">국어
		 <input type = "radio" name = "major" value ="eng">영어
		 <input type = "radio" name = "major" value ="math">수학
		 <input type = "radio" name = "major" value ="des">디자인
		 
		 <input type="submit" vlue="전송">
	</form>
</body>
</html>