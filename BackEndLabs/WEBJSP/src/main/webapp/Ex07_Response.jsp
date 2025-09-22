<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/*  
		웹 환경(Client - Server)
		
		Client -> Server (요청된 정보를 requset 객체를 생성해서 그 안에 정보를 담고 사용)
		     요청(request)
		     
		Server -> Client (response 응답 > 서버 자원 > Client 전달(클라이언트 브라우져 해석 가능 자원))
		     응답(response)
		
		클라이언트 브라우져(크롬 , IE) 해석 : html , css , javscript , text , xml , json , img)
	

        response  객체 
        1. 표현식 (출력)  <%=
        2. 페이지 이동 (response.sendRedirect()) : 서버에게 새로운 페이지 요청 ... 
        2.1 javascript 표현 :  location.href="이동할 주소" //클라이언트의 브라우저에서 표현되는 식
        2.2 브라우져에서 F5 새로고침과 같은 효과 ()
	*/

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		1. 일반적인 출력담당 <%= 100+200+300 %><br>
		2. sendRedirect 
		<%
			//response.sendRedirect("Ex01_index.jsp"); //	나 이 페이지 Ex01_index.jsp 보여주
			//서버쪽에 쓰는 표현 jsp
		
			//Spring : redirect
		%>
</body>
	<script type="text/javascript">
		  location.href="Ex01_Index.jsp";
	</script>
</html>
​