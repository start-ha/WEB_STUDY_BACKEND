package kr.or.kosa.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import kr.or.kosa.dto.Emp;
import kr.or.kosa.utils.ConnectionHelper;
import kr.or.kosa.utils.ConnectionPoolHelper;

public class EmpDao {
	

	public List<Emp> getAllEmpList() throws SQLException {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "select * from emp";

			
			conn = ConnectionPoolHelper.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			List<Emp> empList = new ArrayList<>();

			try {
				
				while(rs.next()) {
					Emp emp = new Emp();
					emp.setEmpno(rs.getInt("empno"));
					emp.setEname(rs.getString("ename"));
					emp.setJob(rs.getString("job"));
					emp.setMgr(rs.getInt("mgr"));
					//emp.setHireDate(rs.getTimestamp("hiredate"));
					emp.setSal(rs.getInt("sal"));
					emp.setComm(rs.getInt("comm"));
					emp.setDeptno(rs.getInt("deptno"));
					
					empList.add(emp);
				}
				
			} catch (Exception e) {
				System.err.println(e.getMessage());
			} finally {
				ConnectionPoolHelper.close(rs);
				ConnectionPoolHelper.close(pstmt);
				ConnectionPoolHelper.close(conn);
			}
			
			return empList;
		}
	
	
	public Emp getEmpListByEmpno(int empno) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from emp where empno = ?";
		Emp emp = new Emp();

		try {
			conn = ConnectionPoolHelper.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, empno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				emp.setEmpno(rs.getInt("empno"));
				emp.setEname(rs.getString("ename"));
				emp.setJob(rs.getString("job"));
				emp.setDeptno(rs.getInt("deptno"));
//				emp.setHireDate(rs.getTimestamp("HireDate"));
				emp.setMgr(rs.getInt("mgr"));
				emp.setSal(rs.getInt("sal"));
				emp.setComm(rs.getInt("comm"));
			}
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
		} finally {
			ConnectionHelper.close(rs);
			ConnectionHelper.close(pstmt);
			ConnectionHelper.close(conn);
		}
		
		return emp;
	}
	
	public int insertEmp(Emp emp) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into emp(empno,ename,job,deptno,mgr,sal,comm) values(?,?,?,?,?,?,?)"; 
		int row = 0;
		
		try {
			conn = ConnectionPoolHelper.getConnection();
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setInt(1, emp.getEmpno());
			pstmt.setString(2, emp.getEname());
			pstmt.setString(3, emp.getJob());
			pstmt.setInt(4, emp.getDeptno());
			pstmt.setInt(5, emp.getMgr());
			pstmt.setInt(6, emp.getSal());
			pstmt.setInt(7, emp.getComm());
			
			row = pstmt.executeUpdate();
			
			if(row > 0) {
				System.out.println("inserted successfully");
			} else {
				System.out.println("no update");
			}
		} catch (SQLException e) {
			System.out.println("예외발생 : " + e.getMessage());
		}finally {
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return row;
	}
	
	
	//수정
	public int updateEmpno(Emp emp) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into emp values(?,?,?,?,?,?,?,?)";
		int row = 0;
		Timestamp now = new Timestamp(System.currentTimeMillis());
		try {
			conn = ConnectionPoolHelper.getConnection();
		    pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, emp.getEmpno());
			pstmt.setString(2, emp.getEname());
			pstmt.setString(3, emp.getJob());
			pstmt.setInt(4, emp.getDeptno());
//			pstmt.setTimestamp(5,now);
			pstmt.setInt(5, emp.getMgr());
			pstmt.setInt(6, emp.getSal());
			pstmt.setInt(7, emp.getComm());
			
			row = pstmt.executeUpdate();
			if(row > 0) {
				System.out.println("updated successfully");
			} else {
				System.out.println("no update");
			}
		} catch (SQLException e) {
			 System.out.println("예외발생 : " + e.getMessage());
		}finally{
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		
		
		return row;
		
	}
	
	
	public int deleteEmp(int empno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "delete from emp where empno = ?";
		int row = 0;
		
		try {
			conn = ConnectionPoolHelper.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, empno);
			row = pstmt.executeUpdate();
			
			if(row > 0) {
				System.out.println("deleted successfully");
			} else {
				System.out.println("no update");
			}
		} catch (SQLException e) {
			System.out.println("예외발생 : " + e.getMessage());
		}finally {
			ConnectionPoolHelper.close(pstmt);
			ConnectionPoolHelper.close(conn);
		}
		return row;
	}	
}