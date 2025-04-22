<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="dbConnection.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String location = request.getParameter("location");
    String className = request.getParameter("class_name");
    String teacher = request.getParameter("teacher");
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    String people = request.getParameter("people");

    PreparedStatement pstmt = null;

    try {
        String sql = "INSERT INTO BARE_BOOK (LOCATION, DATE, TIME, CLASS, TEACHER, PEOPLE, WAITNUMBER) VALUES (?, ?, ?, ?, ?, ?, 0)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, location);
        pstmt.setString(2, date);
        pstmt.setString(3, time);
        pstmt.setString(4, className);
        pstmt.setString(5, teacher);
        pstmt.setInt(6, Integer.parseInt(people));

        int result = pstmt.executeUpdate();
        
        if (result > 0) {
            response.sendRedirect("admin_schedule.jsp"); // 성공 시 일정 관리 페이지로 이동
        } else {
%>
            <script>
                alert("수업 추가에 실패했습니다. 다시 시도해주세요.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("오류 발생: <%= e.getMessage() %>");
            history.back();
        </script>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
