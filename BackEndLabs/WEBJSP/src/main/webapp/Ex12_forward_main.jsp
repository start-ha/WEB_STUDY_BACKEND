<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	/*  
	[요청에 대한 흐름 제어]
	
	1. include (공통 디자인) > 공통 페이지 만들고(top,bottom)  추가 >BUFFER를 쓰다가 인클루드한 페이지 내용을 BUFFER에 채웠다가 끝나면 다시 원래 페이지로 돌아감(제어권 회복)
	2. forward (중계자 : 경찰서 112상황실 통제권한) > 자기코드는 의미가 없어요 > 논리제어 .... >> 주소는 요청페이지인데 요청페이지의 BUFFER 내용이 다 지워지고 포워드한 파일이 BUFFER를 끝까지 사용
	
	*******************************************************************************
	공통점 : request객체를 공유한다 (^^!)
	*******************************************************************************
	차이점 : 제어권 : include(제어권을 다시 가지고 온다)
	               foward (제어권을 넘겨준다) >> spring 에서 ....(servlet) >>요청마다 다른 서비스
				 ******  POINT) [요청주소]는 [동일]한데 [다른 page]의 내용을 서비스 *******
	ex)
	http://192.168.0.29:8090/WebJSP/_forward.jsp?code=B
	http://192.168.0.29:8090/WebJSP/_forward.jsp?code=C
	
	1. 클라이언트가 요청한 page >> _forward.jsp (Buffer주인)
	2. 클랑이언트가 받는 page 정보는 > A.jsp or  B.jsp or C.jsp (파라미터에 따라 페이지 정보 달라짐)
	
	원리: Buffer 주인 > _forward.jsp > Buffer는 _forward 내용을 담아야 하는데
	    forward를 만나면 > 주인 배신 > Buffer 비워버리고 > 비워진 Buffer > forward 된 page 내용 
	    > Client 서비스 
	
	*/
	
	String code = request.getParameter("code");
	String viewUrl = null;
	
	//논리의 흐름 : 요청값에 따라서 다른 페이지의 내용을 서비스
	if(code.equals("A")){
		viewUrl = "/forward/A.jsp";
	}else if(code.equals("B")){
		viewUrl = "/forward/B.jsp";
	}else if(code.equals("C")){
		viewUrl = "/forward/C.jsp";
	}
	
	//http://localhost:8090/Ex12_forward_main.jsp?code=A    사용되는  buffer > Ex12_forward_main.jsp
	//http://localhost:8090/Ex12_forward_main.jsp?code=B		
%>
<jsp:forward page="<%=viewUrl%>"></jsp:forward>
<!-- 아래 UI 의미가 없다 ... forward  -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h3>
		[요청의 흐름제어 : forward]
		forward jsp 내용 >> 흐름의 제어만 하고, 
		forward 내용을 반영할 수 없다.
		버퍼를 그대로 두면서 컨텐츠를 바꿔줌 (요청값에 따라서)
		=============================================
		주소 안바뀌면서 페이지 내용 다르게 할 때
		</a></h3>
	
	
</body>
</html>
