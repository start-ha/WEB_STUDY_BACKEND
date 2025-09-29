package com.company.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.company.dto.DepartmentDTO;
import com.company.dto.EmployeeDTO;
import com.company.util.DBConnection;

public class DepartmentDAO {
    
    // 전체 부서 조회
    public List<DepartmentDTO> getAllDepartments() {
        List<DepartmentDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT DEPTNO, DNAME, LOC FROM DEPT ORDER BY DEPTNO";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                DepartmentDTO dept = new DepartmentDTO();
                dept.setDeptNo(rs.getInt("DEPTNO"));
                dept.setDeptName(rs.getString("DNAME"));
                dept.setLocation(rs.getString("LOC"));
                list.add(dept);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, pstmt, conn);
        }
        
        return list;
    }
    
    // 부서번호로 부서 조회
    public DepartmentDTO getDepartmentByNo(int deptNo) {
        DepartmentDTO dept = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT DEPTNO, DNAME, LOC FROM DEPT WHERE DEPTNO = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, deptNo);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                dept = new DepartmentDTO();
                dept.setDeptNo(rs.getInt("DEPTNO"));
                dept.setDeptName(rs.getString("DNAME"));
                dept.setLocation(rs.getString("LOC"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, pstmt, conn);
        }
        
        return dept;
    }
    
    
    public List<EmployeeDTO> getEmployeesByDept(int deptNo) {
        List<EmployeeDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = """
                SELECT e.EMPNO, e.ENAME, e.SAL, e.HIREDATE, e.DEPTNO, d.DNAME
                FROM EMP e
                JOIN DEPT d ON e.DEPTNO = d.DEPTNO
                WHERE e.DEPTNO = ?
            """;
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, deptNo);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                EmployeeDTO emp = new EmployeeDTO();
                emp.setEmpNo(rs.getInt("EMPNO"));
                emp.setEmpName(rs.getString("ENAME"));
                emp.setSalary(rs.getInt("SAL"));
                emp.setHireDate(rs.getDate("HIREDATE"));
                emp.setDeptNo(rs.getInt("DEPTNO"));
                emp.setDeptName(rs.getString("DNAME")); // EmployeeDTO에 필드 추가 필요
                list.add(emp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, pstmt, conn);
        }
        return list;
    }
    
    
}