<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.google.gson.*, java.util.*" %>
<%
    response.setContentType("application/json");
    request.setCharacterEncoding("UTF-8");
    
    // 파라미터 받기
    String empNo = request.getParameter("empNo");
    String empName = request.getParameter("empName");
    String salary = request.getParameter("salary");
    String hireDate = request.getParameter("hireDate");
    String deptNo = request.getParameter("deptNo");
    String mgrNo = request.getParameter("mgrNo");
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        // DB 연결 정보 설정
        String driver = "oracle.jdbc.driver.OracleDriver";
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        String dbUser = "kosa";
        String dbPass = "1004";
        
        Class.forName(driver);
        conn = DriverManager.getConnection(url, dbUser, dbPass);
        
        // INSERT 쿼리
        String sql = "INSERT INTO EMP (EMPNO, ENAME, SAL, HIREDATE, DEPTNO, MGR) " +
                     "VALUES (?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(empNo));
        pstmt.setString(2, empName);
        pstmt.setInt(3, Integer.parseInt(salary));
        pstmt.setString(4, hireDate);
        pstmt.setInt(5, Integer.parseInt(deptNo));
        
        // MGR은 선택사항이므로 null 처리
        if(mgrNo != null && !mgrNo.isEmpty()) {
            pstmt.setInt(6, Integer.parseInt(mgrNo));
        } else {
            pstmt.setNull(6, Types.INTEGER);
        }
        
        int result = pstmt.executeUpdate();
        
        Map<String, Object> resultMap = new HashMap<>();
        
        if(result > 0) {
            resultMap.put("success", true);
            resultMap.put("message", "사원이 성공적으로 등록되었습니다.");
        } else {
            resultMap.put("success", false);
            resultMap.put("message", "사원 등록에 실패했습니다.");
        }
        
        Gson gson = new Gson();
        out.print(gson.toJson(resultMap));
        
    } catch(Exception e) {
        e.printStackTrace();
        Map<String, Object> error = new HashMap<>();
        error.put("success", false);
        error.put("message", "오류 발생: " + e.getMessage());
        Gson gson = new Gson();
        out.print(gson.toJson(error));
    } finally {
        try {
            if(pstmt != null) pstmt.close();
            if(conn != null) conn.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
%>