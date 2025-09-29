<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>부서별 사원 조회</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Malgun Gothic', sans-serif; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 30px auto; padding: 20px; }
        .content-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 30px; font-size: 2em; text-align: center; }
        .search-area { margin-bottom: 30px; text-align: center; }
        .search-area label { font-size: 1.1em; font-weight: bold; margin-right: 10px; }
        .search-area select { padding: 10px 20px; font-size: 1em; border: 2px solid #ddd; border-radius: 5px; cursor: pointer; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 15px; text-align: center; border-bottom: 1px solid #ddd; }
        th { background: #4CAF50; color: white; font-weight: bold; }
        tr:hover { background: #f5f5f5; }
        .no-data { text-align: center; padding: 40px; color: #999; font-size: 1.1em; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container">
        <div class="content-box">
            <h2>부서별 사원 조회</h2>
            
            <div class="search-area">
                <label for="deptSelect">부서 선택:</label>
                <select id="deptSelect">
                    <option value="">부서를 선택하세요</option>
                </select>
            </div>
            
            <div id="resultArea"></div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            // 페이지 로드 시 부서 목록 가져오기
            loadDepartments();
            
            // 부서 선택 시 사원 목록 조회
            $('#deptSelect').change(function() {
                var deptNo = $(this).val();
                if(deptNo) {
                    loadEmployees(deptNo);
                } else {
                    $('#resultArea').html('');
                }
            });
        });
        
        // 부서 목록 로드
        function loadDepartments() {
            $.ajax({
                url: 'getDepartments.jsp',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    var options = '<option value="">부서를 선택하세요</option>';
                    $.each(data, function(index, dept) {
                        options += '<option value="' + dept.deptNo + '">' 
                                 + dept.deptNo + ' - ' + dept.deptName + '</option>';
                    });
                    $('#deptSelect').html(options);
                },
                error: function() {
                    alert('부서 목록을 불러오는데 실패했습니다.');
                }
            });
        }
        
        // 사원 목록 로드
        function loadEmployees(deptNo) {
            $.ajax({
                url: 'getEmployeesByDept.jsp',
                type: 'GET',
                data: { deptNo: deptNo },
                dataType: 'json',
                success: function(data) {
                    if(data.length > 0) {
                        var html = '<table>';
                        html += '<tr><th>사번</th><th>이름</th><th>급여</th><th>입사일</th><th>부서번호</th><th>부서명</th></tr>';
                        
                        $.each(data, function(index, emp) {
                            html += '<tr>';
                            html += '<td>' + emp.empNo + '</td>';
                            html += '<td>' + emp.empName + '</td>';
                            html += '<td>$' + Number(emp.salary).toLocaleString() + '</td>';
                            html += '<td>' + emp.hireDate + '</td>';
                            html += '<td>' + emp.deptNo + '</td>';
                            html += '<td>' + emp.deptName + '</td>';
                            html += '</tr>';
                        });
                        
                        html += '</table>';
                        $('#resultArea').html(html);
                    } else {
                        $('#resultArea').html('<div class="no-data">해당 부서에 사원이 없습니다.</div>');
                    }
                },
                error: function() {
                    alert('사원 목록을 불러오는데 실패했습니다.');
                }
            });
        }
    </script>
</body>
</html>