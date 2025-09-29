<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 관리 시스템</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Malgun Gothic', sans-serif; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 50px auto; padding: 20px; }
        .main-content { background: white; padding: 60px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        h1 { color: #333; margin-bottom: 50px; font-size: 2.5em; }
        .menu-links { display: flex; gap: 30px; justify-content: center; flex-wrap: wrap; }
        .menu-link { display: inline-block; padding: 20px 40px; background: #4CAF50; color: white; text-decoration: none; border-radius: 8px; font-size: 1.2em; transition: all 0.3s; }
        .menu-link:hover { background: #45a049; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(76,175,80,0.3); }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container">
        <div class="main-content">
            <h1>사원 관리 시스템</h1>
            <div class="menu-links">
                <a href="employeeInsert.jsp" class="menu-link">사원 입력</a>
                <a href="employeeList.jsp" class="menu-link">부서별 사원 조회</a>
            </div>
        </div>
    </div>
</body>
</html>