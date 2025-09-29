package com.company.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.company.dto.EmployeeDTO;
import com.company.util.DBConnection;

public class EmployeeDAO {
    
    // 부서별 사원 조회
    public List<EmployeeDTO> getEmployeesByDept(int deptNo) {
        List<EmployeeDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT E.EMPNO, E.ENAME, E.SAL, E.HIREDATE, E.DEPTNO, D.DNAME " +
                     "FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO " +
                     "WHERE E.DEPTNO = ? ORDER BY E.EMPNO";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, deptNo);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                EmployeeDTO emp = new EmployeeDTO();
                emp.setEmpNo(rs.getInt("EMPNO"));
                emp.setEmpName(rs.getString("ENAME"));
                emp.setSalary(rs.getInt("SAL"));
                emp.setHireDate(rs.getDate("HIREDATE"));
                emp.setDeptNo(rs.getInt("DEPTNO"));
                emp.setDeptName(rs.getString("DNAME"));
                list.add(emp);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, pstmt, conn);
        }
        
        return list;
    }
    
    // 사번 중복 체크
    public boolean checkEmpNo(int empNo) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean exists = false;
        
        String sql = "SELECT COUNT(*) AS CNT FROM EMP WHERE EMPNO = ?";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, empNo);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                exists = rs.getInt("CNT") > 0;
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, pstmt, conn);
        }
        
        return exists;
    }
    
    // 관리자 목록 조회 (DISTINCT)
    public List<EmployeeDTO> getManagers() {
        List<EmployeeDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT DISTINCT EMPNO, ENAME FROM EMP ORDER BY EMPNO";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                EmployeeDTO emp = new EmployeeDTO();
                emp.setEmpNo(rs.getInt("EMPNO"));
                emp.setEmpName(rs.getString("ENAME"));
                list.add(emp);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, pstmt, conn);
        }
        
        return list;
    }
    
    // 사원 등록
    public boolean insertEmployee(EmployeeDTO emp) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean result = false;
        
        String sql = "INSERT INTO EMP (EMPNO, ENAME, SAL, HIREDATE, DEPTNO, MGR) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, emp.getEmpNo());
            pstmt.setString(2, emp.getEmpName());
            pstmt.setInt(3, emp.getSalary());
            pstmt.setDate(4, emp.getHireDate());
            pstmt.setInt(5, emp.getDeptNo());
            
            if(emp.getMgrNo() != null) {
                pstmt.setInt(6, emp.getMgrNo());
            } else {
                pstmt.setNull(6, Types.INTEGER);
            }
            
            int count = pstmt.executeUpdate();
            result = count > 0;
            
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(pstmt, conn);
        }
        
        return result;
    }
    
    // 전체 사원 조회
    public List<EmployeeDTO> getAllEmployees() {
        List<EmployeeDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT E.*, D.DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO ORDER BY E.EMPNO";
        
        try {
            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                EmployeeDTO emp = new EmployeeDTO();
                emp.setEmpNo(rs.getInt("EMPNO"));
                emp.setEmpName(rs.getString("ENAME"));
                emp.setJob(rs.getString("JOB"));
                emp.setMgrNo((Integer)rs.getObject("MGR"));
                emp.setSalary(rs.getInt("SAL"));
                emp.setHireDate(rs.getDate("HIREDATE"));
                emp.setDeptNo(rs.getInt("DEPTNO"));
                emp.setDeptName(rs.getString("DNAME"));
                list.add(emp);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, pstmt, conn);
        }
        
        return list;
    }
}