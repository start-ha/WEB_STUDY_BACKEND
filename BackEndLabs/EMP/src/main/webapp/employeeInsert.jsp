<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사원 입력</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Malgun Gothic', sans-serif; background: #f5f5f5; }
        .container { max-width: 800px; margin: 30px auto; padding: 20px; }
        .content-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; margin-bottom: 30px; font-size: 2em; text-align: center; }
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        .form-group input, .form-group select { width: 100%; padding: 12px; font-size: 1em; border: 2px solid #ddd; border-radius: 5px; transition: border 0.3s; }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #4CAF50; }
        .check-group { display: flex; gap: 10px; }
        .check-group input { flex: 1; }
        .check-group button { padding: 12px 25px; background: #2196F3; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1em; }
        .check-group button:hover { background: #0b7dda; }
        .message { padding: 10px; margin-top: 8px; border-radius: 5px; font-size: 0.9em; }
        .success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .submit-btn { width: 100%; padding: 15px; background: #4CAF50; color: white; border: none; border-radius: 5px; font-size: 1.2em; cursor: pointer; font-weight: bold; margin-top: 20px; }
        .submit-btn:hover { background: #45a049; }
        .submit-btn:disabled { background: #ccc; cursor: not-allowed; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container">
        <div class="content-box">
            <h2>사원 정보 입력</h2>
            
            <form id="empForm" method="post" action="insertEmployee.jsp">
                <div class="form-group">
                    <label for="empNo">사번 *</label>
                    <div class="check-group">
                        <input type="text" id="empNo" name="empNo" required>
                        <button type="button" onclick="checkEmpNo()">중복 체크</button>
                    </div>
                    <div id="empNoMsg"></div>
                </div>
                
                <div class="form-group">
                    <label for="empName">이름 *</label>
                    <input type="text" id="empName" name="empName" required>
                </div>
                
                <div class="form-group">
                    <label for="salary">급여 *</label>
                    <input type="text" id="salary" name="salary" required placeholder="숫자만 입력하세요">
                    <div id="salaryMsg"></div>
                </div>
                
                <div class="form-group">
                    <label for="hireDate">입사일 *</label>
                    <input type="text" id="hireDate" name="hireDate" required placeholder="날짜를 선택하세요" readonly>
                </div>
                
                <div class="form-group">
                    <label for="deptNo">부서번호 *</label>
                    <select id="deptNo" name="deptNo" required>
                        <option value="">부서를 선택하세요</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="mgrNo">관리자 사번</label>
                    <select id="mgrNo" name="mgrNo">
                        <option value="">관리자를 선택하세요</option>
                    </select>
                </div>
                
                <button type="submit" class="submit-btn" id="submitBtn" disabled>사원 등록</button>
            </form>
        </div>
    </div>

    <script>
        var empNoChecked = false;
        
        $(document).ready(function() {
            // 날짜 캘린더 초기화
            $('#hireDate').datepicker({
                dateFormat: 'yy-mm-dd',
                changeMonth: true,
                changeYear: true,
                yearRange: '1950:2025',
                maxDate: new Date()
            });
            
            // 부서 목록 로드
            loadDepartments();
            
            // 관리자 목록 로드
            loadManagers();
            
            // 급여 입력 검증 (정규표현식 - 숫자만)
            $('#salary').on('input', function() {
                var value = $(this).val();
                var numberPattern = /^[0-9]+$/;
                
                if(value === '') {
                    $('#salaryMsg').html('');
                    return;
                }
                
                if(!numberPattern.test(value)) {
                    $('#salaryMsg').html('<div class="message error">숫자만 입력 가능합니다.</div>');
                    $(this).val(value.replace(/[^0-9]/g, ''));
                } else {
                    $('#salaryMsg').html('<div class="message success">올바른 형식입니다.</div>');
                }
            });
            
            // 사번 입력 시 중복체크 초기화
            $('#empNo').on('input', function() {
                empNoChecked = false;
                $('#empNoMsg').html('');
                checkFormValidity();
            });
            
            // 폼 제출
            $('#empForm').submit(function(e) {
                e.preventDefault();
                
                if(!empNoChecked) {
                    alert('사번 중복 체크를 해주세요.');
                    return false;
                }
                
                if(!validateForm()) {
                    return false;
                }
                
                // AJAX로 데이터 전송
                $.ajax({
                    url: 'insertEmployee.jsp',
                    type: 'POST',
                    data: $(this).serialize(),
                    success: function(response) {
                        alert('사원이 성공적으로 등록되었습니다.');
                        location.href = 'employeeList.jsp';
                    },
                    error: function() {
                        alert('사원 등록에 실패했습니다.');
                    }
                });
            });
            
            // 입력값 변경 시 폼 유효성 검사
            $('#empForm input, #empForm select').on('change input', function() {
                checkFormValidity();
            });
        });
        
        // 사번 중복 체크
        function checkEmpNo() {
            var empNo = $('#empNo').val().trim();
            
            if(empNo === '') {
                alert('사번을 입력하세요.');
                return;
            }
            
            $.ajax({
                url: 'checkEmpNo.jsp',
                type: 'GET',
                data: { empNo: empNo },
                dataType: 'json',
                success: function(data) {
                    if(data.exists) {
                        $('#empNoMsg').html('<div class="message error">이미 사용중인 사번입니다.</div>');
                        empNoChecked = false;
                    } else {
                        $('#empNoMsg').html('<div class="message success">사용 가능한 사번입니다.</div>');
                        empNoChecked = true;
                    }
                    checkFormValidity();
                },
                error: function() {
                    alert('중복 체크에 실패했습니다.');
                }
            });
        }
        
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
                    $('#deptNo').html(options);
                },
                error: function() {
                    alert('부서 목록을 불러오는데 실패했습니다.');
                }
            });
        }
        
        // 관리자 목록 로드 (DISTINCT)
        function loadManagers() {
            $.ajax({
                url: 'getManagers.jsp',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    var options = '<option value="">관리자를 선택하세요</option>';
                    $.each(data, function(index, mgr) {
                        options += '<option value="' + mgr.empNo + '">' 
                                 + mgr.empNo + ' - ' + mgr.empName + '</option>';
                    });
                    $('#mgrNo').html(options);
                },
                error: function() {
                    alert('관리자 목록을 불러오는데 실패했습니다.');
                }
            });
        }
        
        // 폼 유효성 검사
        function validateForm() {
            if($('#empNo').val().trim() === '') {
                alert('사번을 입력하세요.');
                return false;
            }
            
            if($('#empName').val().trim() === '') {
                alert('이름을 입력하세요.');
                return false;
            }
            
            if($('#salary').val().trim() === '') {
                alert('급여를 입력하세요.');
                return false;
            }
            
            if($('#hireDate').val().trim() === '') {
                alert('입사일을 선택하세요.');
                return false;
            }
            
            if($('#deptNo').val() === '') {
                alert('부서를 선택하세요.');
                return false;
            }
            
            return true;
        }
        
        // 폼 유효성에 따라 제출 버튼 활성화/비활성화
        function checkFormValidity() {
            var isValid = empNoChecked && 
                         $('#empNo').val().trim() !== '' &&
                         $('#empName').val().trim() !== '' &&
                         $('#salary').val().trim() !== '' &&
                         $('#hireDate').val().trim() !== '' &&
                         $('#deptNo').val() !== '';
            
            $('#submitBtn').prop('disabled', !isValid);
        }
    </script>
</body>
</html>