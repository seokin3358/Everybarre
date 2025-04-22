<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    String location = request.getParameter("location");
    String year = request.getParameter("year");
    String month = request.getParameter("month");
    String day = request.getParameter("day");

    String query = "SELECT DATE, TIME, CLASS, TEACHER, PEOPLE, WAITNUMBER FROM BARE_BOOK WHERE YEAR(DATE) = ? AND MONTH(DATE) = ?";
    if (day != null && !day.isEmpty()) {
        query += " AND DAY(DATE) = ?";
    }
    if (!"all".equals(location)) {
        query += " AND LOCATION = ?";
    }

    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, year);
        pstmt.setString(2, month);
        int paramIndex = 3;
        if (day != null && !day.isEmpty()) {
            pstmt.setString(paramIndex++, day);
        }
        if (!"all".equals(location)) {
            pstmt.setString(paramIndex, location);
        }

        rs = pstmt.executeQuery();

        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getString("DATE") %></td>
                <td><%= rs.getString("TIME") %></td>
                <td><%= rs.getString("CLASS") %></td>
                <td><%= rs.getString("TEACHER") %></td>
                <td><%= rs.getInt("PEOPLE") %></td>
                <td><%= rs.getInt("WAITNUMBER") %></td>
            </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
