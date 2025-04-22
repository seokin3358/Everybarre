<%@ page import="java.sql.Connection, java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>

<%
    // DB 연결 정보 설정
    String DB_URL = "jdbc:mariadb://fullstaybyeollae.co.kr:3306/jo7220";  // 데이터베이스 URL
    String DB_USER = "jo7220";  // DB 사용자명
    String DB_PASSWORD = "poiu0987";  // DB 비밀번호

    Connection conn = null;
    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
