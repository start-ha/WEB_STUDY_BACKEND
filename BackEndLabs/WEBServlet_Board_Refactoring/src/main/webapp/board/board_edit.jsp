<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="kr.or.bit.dto.Board"%>
<%@page import="kr.or.bit.service.BoardService"%>

<c:if test="${empty param.idx}">
    <c:redirect url="board_list.jsp"/>
</c:if>

<%
// 서비스 로직은 스크립틀릿으로 유지 (비즈니스 로직)
BoardService service = BoardService.getInBoardService();
Board board = service.board_EditContent(request.getParameter("idx"));
if(board == null){
    out.print("데이터 오류");
    out.print("<hr><a href='board_list.jsp'>목록가기</a>");
    return;
}
// board 객체를 request scope에 저장
request.setAttribute("board", board);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="Stylesheet" href="${pageContext.request.contextPath}/style/default.css" />
<script type="text/javascript">
function editCheck() {
    if (!edit.writer.value) {
        alert("이름을 입력하세요");
        edit.writer.focus();
        return false;
    }
    if (!edit.pwd.value) {
        alert("비밀번호를 입력해야 합니다.");
        edit.pwd.focus();
        return false;
    }
    if (!edit.email.value) {
        alert("이메일을 입력해야합니다.");
        edit.email.focus();
        return false;
    }
    if (!edit.subject.value) {
        alert("제목을 입력하세요");
        edit.subject.focus();
        return false;
    }
    if (!edit.content.value) {
        alert("글 내용을 입력하세요");
        edit.content.focus();
        return false;
    }
    document.edit.submit();
}
</script>
</head>
<body>
<jsp:include page="/include/header.jsp"/>
<div id="pageContainer">
<div style="padding-top: 25px; text-align: center">
<form name="edit" action="board_editok.jsp" method="POST">
<center>
<table width="90%" border="1">
<tr>
    <td width="20%" align="center"><b> 글번호 </b></td>
    <td width="30%">
        ${param.idx}
        <input type="hidden" name="idx" value="${param.idx}">
    </td>
    <td width="20%" align="center"><b>작성일</b></td>
    <td>${board.writedate}</td>
</tr>
<tr>
    <td width="20%" align="center"><b>글쓴이</b></td>
    <td width="30%">
        <input type="text" name="writer" value="${board.writer}">
    </td>
    <td width="20%" align="center"><b>홈페이지</b></td>
    <td>
        <input type="text" name="homepage" value="${board.homepage}">
    </td>
</tr>
<tr>
    <td width="20%" align="center"><b>비밀번호(기존)</b></td>
    <td>
        <input type="text" name="pwd">
    </td>
    <td width="20%" align="center"><b>이메일</b></td>
    <td>
        <input type="text" name="email" value="${board.email}">
    </td>
</tr>
<tr>
    <td width="20%" align="center"><b>제목</b></td>
    <td colspan="3">
        <input type="text" name="subject" value="${board.subject}" size="40">
    </td>
</tr>
<tr height="100">
    <td width="20%" align="center"><b>글내용</b></td>
    <td colspan="3">
        <textarea rows="7" cols="50" name="content">${board.content}</textarea>
    </td>
</tr>
<tr>
    <td width="20%" align="center"><b>첨부파일</b></td>
    <td colspan="3">${board.filename} (${board.filesize}bytes)<br />
        <input type="file" name="filename">
    </td>
</tr>
<tr>
    <td colspan="4" align="center">
        <input type="button" value="수정하기" onclick="editCheck();">
        <input type="reset" value="다시쓰기">
    </td>
</tr>
<tr>
    <td colspan="4" align="center">
        <a href="board_list.jsp">목록</a>
    </td>
</tr>
</table>
</center>
</form>
</div>
</div>
</body>
</html>