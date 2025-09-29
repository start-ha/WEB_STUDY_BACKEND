// 📌 부서 목록 조회 (select option에 출력)
function loadDepartments() {
    fetch('/department?action=list')
        .then(res => res.json())
        .then(depts => {
            const select = document.getElementById('deptSelect');
            select.innerHTML = '<option value="">부서를 선택하세요</option>';
            depts.forEach(d => {
                const option = document.createElement('option');
                option.value = d.deptNo;
                option.textContent = `${d.deptNo} - ${d.dName}`;
                select.appendChild(option);
            });
        });
}

// 📌 부서 선택 시, 해당 부서의 사원 리스트 출력
function loadEmployeesByDept(deptNo) {
    fetch(`/department?action=employees&deptNo=${deptNo}`)
        .then(res => res.json())
        .then(list => {
            const tbody = document.getElementById('empTableBody');
            tbody.innerHTML = '';
            list.forEach(emp => {
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${emp.empNo}</td>
                    <td>${emp.eName}</td>
                    <td>${emp.sal}</td>
                    <td>${emp.hireDate}</td>
                    <td>${emp.deptNo}</td>
                    <td>${emp.deptName}</td>
                `;
                tbody.appendChild(tr);
            });
        });
}

// 📌 사번 중복 체크
function checkEmpNo() {
    const empNo = document.getElementById('empNo').value;
    fetch(`/employee?action=check&empNo=${empNo}`)
        .then(res => res.json())
        .then(data => {
            const msg = document.getElementById('empNoMsg');
            if (data.exists) {
                msg.textContent = '이미 존재하는 사번입니다.';
                msg.style.color = 'red';
            } else {
                msg.textContent = '사용 가능한 사번입니다.';
                msg.style.color = 'green';
            }
        });
}

// 📌 관리자 사번 목록 로딩
function loadMgrList() {
    fetch('/employee?action=mgrList')
        .then(res => res.json())
        .then(list => {
            const mgrSelect = document.getElementById('mgr');
            list.forEach(emp => {
                const opt = document.createElement('option');
                opt.value = emp.empNo;
                opt.textContent = `${emp.empNo} - ${emp.eName}`;
                mgrSelect.appendChild(opt);
            });
        });
}

// 📌 부서 select 로딩 (insert.jsp용)
function loadDeptSelectForInsert() {
    fetch('/department?action=list')
        .then(res => res.json())
        .then(depts => {
            const deptSelect = document.getElementById('deptNo');
            depts.forEach(d => {
                const opt = document.createElement('option');
                opt.value = d.deptNo;
                opt.textContent = `${d.deptNo} - ${d.dName}`;
                deptSelect.appendChild(opt);
            });
        });
}

// 📌 급여 입력값 숫자만
function validateSalary() {
    const salInput = document.getElementById('sal');
    const regex = /^[0-9]+$/;
    if (!regex.test(salInput.value)) {
        alert('급여는 숫자만 입력 가능합니다.');
        salInput.value = '';
        salInput.focus();
    }
}