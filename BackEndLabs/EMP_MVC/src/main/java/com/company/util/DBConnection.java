package com.company.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // DB 연결 정보 (실제 환경에 맞게 수정하세요)
    private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String USER = "your_username";
    private static final String PASSWORD = "your_password";
    
    // static 블록으로 드라이버 로드 (한 번만 실행)
    static {
        try {
            Class.forName(DRIVER);
            System.out.println("Oracle JDBC Driver 로드 성공");
        } catch (ClassNotFoundException e) {
            System.err.println("Oracle JDBC Driver 로드 실패");
            e.printStackTrace();
        }
    }
    
    // Connection 객체 반환
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    // 연결 종료
    public static void close(AutoCloseable... resources) {
        for (AutoCloseable resource : resources) {
            if (resource != null) {
                try {
                    resource.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}