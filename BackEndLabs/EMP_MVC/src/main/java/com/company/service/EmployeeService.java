package com.company.service;

import java.util.List;
import com.company.dao.EmployeeDAO;
import com.company.dto.EmployeeDTO;

public class EmployeeService {
    private EmployeeDAO employeeDAO;
    
    public EmployeeService() {
        this.employeeDAO = new EmployeeDAO();
    }
    
    // 부서별 사원 조회
    public List<EmployeeDTO> getEmployeesByDept(int deptNo) {
        return employeeDAO.getEmployeesByDept(deptNo);
    }
    
    // 사번 중복 체크
    public boolean checkEmpNo(int empNo) {
        return employeeDAO.checkEmpNo(empNo);
    }
    
    // 관리자 목록 조회
    public List<EmployeeDTO> getManagers() {
        return employeeDAO.getManagers();
    }
    
    // 사원 등록
    public boolean insertEmployee(EmployeeDTO emp) {
        // 비즈니스 로직 추가 가능 (유효성 검사 등)
        if(emp.getEmpNo() <= 0) {
            return false;
        }
        if(emp.getEmpName() == null || emp.getEmpName().trim().isEmpty()) {
            return false;
        }
        if(emp.getSalary() < 0) {
            return false;
        }
        
        return employeeDAO.insertEmployee(emp);
    }
    
    // 전체 사원 조회
    public List<EmployeeDTO> getAllEmployees() {
        return employeeDAO.getAllEmployees();
    }
}