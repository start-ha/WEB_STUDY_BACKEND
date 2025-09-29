package com.company.service;

import java.util.List;

import com.company.dao.DepartmentDAO;
import com.company.dto.DepartmentDTO;
import com.company.dto.EmployeeDTO;

public class DepartmentService {
    private DepartmentDAO departmentDAO;
    
    public DepartmentService() {
        this.departmentDAO = new DepartmentDAO();
    }
    
    // 전체 부서 조회
    public List<DepartmentDTO> getAllDepartments() {
        return departmentDAO.getAllDepartments();
    }
    
    // 부서번호로 부서 조회
    public DepartmentDTO getDepartmentByNo(int deptNo) {
        return departmentDAO.getDepartmentByNo(deptNo);
    }
    
    public List<EmployeeDTO> getEmployeesByDept(int deptNo) {
        return departmentDAO.getEmployeesByDept(deptNo);
    }

    public DepartmentDTO getDepartmentById(int deptNo) {
        return departmentDAO.getDepartmentByNo(deptNo);
    }
	
}