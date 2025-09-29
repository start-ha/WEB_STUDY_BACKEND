<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.google.gson.*, java.util.*" %>
<%
    response.setContentType("application/json");
    
    String deptNo = request.getParameter("deptNo");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // DB 연결 정보 설정
        String driver = "oracle.jdbc.driver.OracleDriver";
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbUser = "kosa";
        String dbPass = "1004";
        
        Class.forName(driver);
        conn = DriverManager.getConnection(url, dbUser, dbPass);
        
        String sql = "SELECT E.EMPNO, E.ENAME, E.SAL, E.HIREDATE, E.DEPTNO, D.DNAME " +
                     "FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO " +
                     "WHERE E.DEPTNO = ? ORDER BY E.EMPNO";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(deptNo));
        rs = pstmt.executeQuery();
        
        List<Map<String, Object>> list = new ArrayList<>();
        
        while(rs.next()) {
            Map<String, Object> map = new HashMap<>();
            map.put("empNo", rs.getInt("EMPNO"));
            map.put("empName", rs.getString("ENAME"));
            map.put("salary", rs.getInt("SAL"));
            map.put("hireDate", rs.getDate("HIREDATE").toString());
            map.put("deptNo", rs.getInt("DEPTNO"));
            map.put("deptName", rs.getString("DNAME"));
            list.add(map);
        }
        
        Gson gson = new Gson();
        out.print(gson.toJson(list));
        
    } catch(Exception e) {
        e.printStackTrace();
        Map<String, String> error = new HashMap<>();
        error.put("error", e.getMessage());
        Gson gson = new Gson();
        out.print(gson.toJson(error));
    } finally {
        try {
            if(rs != null) rs.close();
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>