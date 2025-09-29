<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.google.gson.*, java.util.*" %>
<%
    response.setContentType("application/json");
    
    String empNo = request.getParameter("empNo");
    
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
        
        String sql = "SELECT COUNT(*) AS CNT FROM EMP WHERE EMPNO = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(empNo));
        rs = pstmt.executeQuery();
        
        Map<String, Boolean> result = new HashMap<>();
        
        if(rs.next()) {
            int count = rs.getInt("CNT");
            result.put("exists", count > 0);
        }
        
        Gson gson = new Gson();
        out.print(gson.toJson(result));
        
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