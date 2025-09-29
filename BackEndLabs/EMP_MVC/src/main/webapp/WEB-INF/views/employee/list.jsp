<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>부서별 사원 조회</title>
    <link rel="stylesheet" href="/css/style.css">
    <script src="/js/employee.js"></script>
</head>
<body onload="loadDepartments()">

<h2>부서별 사원 조회</h2>

<select id="deptSelect" onchange="loadEmployeesByDept(this.value)">
    <!-- 부서 목록 비동기 로딩 -->
</select>

<table>
    <thead>
        <tr>
            <th>사번</th>
            <th>이름</th>
            <th>급여</th>
            <th>입사일</th>
            <th>부서번호</th>
            <th>부서명</th>
        </tr>
    </thead>
    <tbody id="empTableBody">
        <!-- 사원 목록 비동기 출력 -->
    </tbody>
</table>

</body>
</html>