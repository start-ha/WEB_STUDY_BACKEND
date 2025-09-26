<%@page import="kr.or.bit.dto.Reply"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.bit.dto.Board"%>
<%@page import="kr.or.bit.service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시글 상세보기</title>
    <link rel="Stylesheet" href="${pageContext.request.contextPath}/style/default.css" />
</head>
<body>
    <jsp:include page="/include/header.jsp"/>
    
    <div id="pageContainer">
        <div style="padding-top: 30px; text-align: center">
            <center>
                <b>게시판 글내용</b>
                <table width="80%" border="1">
                    <tr>
                        <td width="20%" align="center"><b>글번호</b></td>
                        <td width="30%">${board.idx}</td>
                        <td width="20%" align="center"><b>작성일</b></td>
                        <td>${board.writedate}</td>
                    </tr>
                    <tr>
                        <td width="20%" align="center"><b>글쓴이</b></td>
                        <td width="30%">${board.writer}</td>
                        <td width="20%" align="center"><b>조회수</b></td>
                        <td>${board.readnum}</td>
                    </tr>
                    <tr>
                        <td width="20%" align="center"><b>홈페이지</b></td>
                        <td>${board.homepage}</td>
                        <td width="20%" align="center"><b>첨부파일</b></td>
                        <td>${board.filename}</td>
                    </tr>
                    <tr>
                        <td width="20%" align="center"><b>제목</b></td>
                        <td colspan="3">${board.subject}</td>
                    </tr>
                    <tr height="100">
                        <td width="20%" align="center"><b>글내용</b></td>
                        <td colspan="3">
                            ${fn:replace(board.content, newLineChar, '<br>')}
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <a href="BoardList.do?cp=${cpage}&ps=${pagesize}">목록가기</a> |
                            <a href="BoardEdit.do?idx=${board.idx}&cp=${cpage}&ps=${pagesize}">편집</a> |
                            <a href="BoardDelete.do?idx=${board.idx}&cp=${cpage}&ps=${pagesize}">삭제</a> |
                            <a href="BoardRewrite.do?idx=${board.idx}&cp=${cpage}&ps=${pagesize}&subject=${board.subject}">답글</a>
                        </td>
                    </tr>
                </table>
                
                <!-- 댓글 작성 폼 -->
                <form name="reply" action="BoardReplyOk.do" method="POST">
                    <input type="hidden" name="idx" value="${board.idx}">
                    <input type="hidden" name="userid" value="">
                    
                    <table width="80%" border="1">
                        <tr>
                            <th colspan="2">덧글 쓰기</th>
                        </tr>
                        <tr>
                            <td align="left">
                                작성자: <input type="text" name="reply_writer"><br />
                                내&nbsp;&nbsp;용: <textarea name="reply_content" rows="2" cols="50"></textarea>
                            </td>
                            <td align="left">
                                비밀번호: <input type="password" name="reply_pwd" size="4">
                                <input type="button" value="등록" onclick="reply_check()">
                            </td>
                        </tr>
                    </table>
                </form>
                
                <!-- 댓글 목록 -->
                <c:if test="${not empty replyList}">
                    <br>
                    <table width="80%" border="1">
                        <tr>
                            <th colspan="2">REPLY LIST</th>
                        </tr>
                        <c:forEach var="reply" items="${replyList}">
                            <tr align="left">
                                <td width="80%">
                                    [${reply.writer}] : ${reply.content}
                                    <br>작성일: ${reply.writedate}
                                </td>
                                <td width="20%">
                                    <form action="ReplyDelete.do" method="POST" style="display:inline;">
                                        <input type="hidden" name="no" value="${reply.no}">
                                        <input type="hidden" name="idx" value="${board.idx}">
                                        비밀번호: <input type="password" name="delPwd" size="4">
                                        <input type="button" value="삭제" onclick="reply_del(this.form)">
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:if>
            </center>
        </div>
    </div>
    
    <script type="text/javascript">
        function reply_check() {
            var frm = document.reply;
            if (frm.reply_writer.value == "" || frm.reply_content.value == "" || frm.reply_pwd.value == "") {
                alert("리플 내용, 작성자, 비밀번호를 모두 입력해야합니다.");
                return false;
            }
            frm.submit();
        }
        
        function reply_del(frm) {
            if (frm.delPwd.value == "") {
                alert("비밀번호를 입력하세요");
                frm.delPwd.focus();
                return false;
            }
            if (confirm("정말 삭제하시겠습니까?")) {
                frm.submit();
            }
        }
    </script>
</body>
</html>