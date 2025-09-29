<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.google.gson.*, java.util.*" %>
<%
    response.setContentType("application/json");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // DB 연결 정보 설정
        String driver = "oracle.jdbc.driver.OracleDriver";
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // 실제 DB 정보로 변경
        String dbUser = "kosa"; // 실제 사용자명으로 변경
        String dbPass = "1004"; // 실제 비밀번호로 변경
        
        Class.forName(driver);
        conn = DriverManager.getConnection(url, dbUser, dbPass);
        
        String sql = "SELECT DEPTNO, DNAME FROM DEPT ORDER BY DEPTNO";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        
        List<Map<String, Object>> list = new ArrayList<>();
        
        while(rs.next()) {
            Map<String, Object> map = new HashMap<>();
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