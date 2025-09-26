<%@page import="kr.or.bit.utils.ThePager"%>
<%@page import="kr.or.bit.dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.bit.service.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시판 목록</title>
    <link rel="Stylesheet" href="${pageContext.request.contextPath}/style/default.css" />
</head>
<body>
    <c:import url="/include/header.jsp" />
    게시판 목록
    <br>
    
    <div id="pagecontainer">
        <div style="padding-top: 30px; text-align: center">
            <table width="80%" border="1" cellspacing="0" align="center">
                <tr>
                    <td colspan="5">
                        <form name="list" action="BoardList.do">
                            PageSize설정: 
                            <select name="ps" onchange="submit()">
                                <c:forEach var="i" begin="5" end="20" step="5">
                                    <c:choose>
                                        <c:when test="${pagesize == i}">
                                            <option value="${i}" selected>${i}건</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${i}">${i}건</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </form>
                    </td>
                </tr>
                <tr>
                    <th width="10%">순번</th>
                    <th width="40%">제목</th>
                    <th width="20%">글쓴이</th>
                    <th width="20%">날짜</th>
                    <th width="10%">조회수</th>
                </tr>
                
                <!-- 데이터가 없는 경우 -->
                <c:if test="${empty boardList}">
                    <tr>
                        <td colspan="5" align="center">등록된 게시글이 없습니다.</td>
                    </tr>
                </c:if>
                
                <!-- 게시글 목록 출력 -->
                <c:forEach var="board" items="${boardList}">
                    <tr onmouseover="this.style.backgroundColor='gray'" 
                        onmouseout="this.style.backgroundColor='white'">
                        <td align="center">${board.idx}</td>
                        <td align="left">
                            <c:forEach var="i" begin="1" end="${board.depth}" step="1">
                                &nbsp;&nbsp;&nbsp;
                            </c:forEach>
                            <c:if test="${board.depth > 0}">
                                <img src="${pageContext.request.contextPath}/images/re.gif">
                            </c:if>
                            <a href="BoardContent.do?idx=${board.idx}&cp=${cpage}&ps=${pagesize}">
                                <c:choose>
                                    <c:when test="${board.subject != null && fn:length(board.subject) > 10}">
                                        ${fn:substring(board.subject,0,10)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${board.subject}
                                    </c:otherwise>
                                </c:choose>
                            </a>
                        </td>
                        <td align="center">${board.writer}</td>
                        <td align="center">${board.writedate}</td>
                        <td align="center">${board.readnum}</td>
                    </tr>
                </c:forEach>
                
                <tr>
                    <td colspan="5" align="center">
                        <hr width="100%" color="red">
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <!-- 이전 링크 -->
                        <c:if test="${cpage > 1}">
                            <a href="BoardList.do?cp=${cpage-1}&ps=${pagesize}">이전</a>
                        </c:if>
                        
                        <!-- 페이지 목록 -->
                        <c:forEach var="i" begin="1" end="${pagecount}" step="1">
                            <c:choose>
                                <c:when test="${cpage==i}">
                                    <font color="red">[${i}]</font>
                                </c:when>
                                <c:otherwise>
                                    <a href="BoardList.do?cp=${i}&ps=${pagesize}">[${i}]</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        
                        <!-- 다음 링크 -->
                        <c:if test="${cpage < pagecount}">
                            <a href="BoardList.do?cp=${cpage+1}&ps=${pagesize}">다음</a>
                        </c:if>
                    </td>
                    <td colspan="2" align="center">
                        총 게시물 수 : ${totalboardcount}
                        <br>
                        <a href="BoardWrite.do">새 글 작성</a>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" align="center">
                        ${pager}
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
</body>
</html>





