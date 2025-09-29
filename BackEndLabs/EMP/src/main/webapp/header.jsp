<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .header { background: #2c3e50; color: white; padding: 20px 0; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
    .header-content { max-width: 1200px; margin: 0 auto; padding: 0 20px; display: flex; justify-content: space-between; align-items: center; }
    .header h2 { font-size: 1.8em; color: white; }
    .header nav a { color: white; text-decoration: none; margin-left: 30px; font-size: 1.1em; transition: color 0.3s; }
    .header nav a:hover { color: #3498db; }
</style>

<header class="header">
    <div class="header-content">
        <h2>🏢 사원 관리 시스템</h2>
        <nav>
            <a href="index.jsp">홈</a>
            <a href="employeeInsert.jsp">사원 입력</a>
            <a href="employeeList.jsp">사원 조회</a>
        </nav>
    </div>
</header>