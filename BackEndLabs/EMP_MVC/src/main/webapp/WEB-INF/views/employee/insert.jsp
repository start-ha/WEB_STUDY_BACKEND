<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>사원 등록</title>
    <link rel="stylesheet" href="/css/style.css">
    <script src="/js/employee.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
</head>
<body onload="loadDeptSelectForInsert(); loadMgrList();">

<h2>사원 등록</h2>

<form method="post" action="/employee?action=insert">
    <label>사번: <input type="text" id="empNo" name="empNo" onblur="checkEmpNo()" required></label>
    <span id="empNoMsg"></span><br>

    <label>이름: <input type="text" name="eName" required></label><br>

    <label>급여: <input type="text" id="sal" name="sal" onblur="validateSalary()" required></label><br>

    <label>입사일: <input type="text" id="hireDate" name="hireDate" required></label><br>

    <label>부서번호:
        <select id="deptNo" name="deptNo" required>
            <option value="">부서 선택</option>
        </select>
    </label><br>

    <label>관리자 사번:
        <select id="mgr" name="mgr">
            <option value="">선택</option>
        </select>
    </label><br>

    <button type="submit">사원 등록</button>
</form>

<script>
    $(function() {
        $("#hireDate").datepicker({
            dateFormat: "yy-mm-dd"
        });
    });
</script>

</body>
</html>