<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Object adminCdObj = session.getAttribute("ADMIN_CD");
    int adminCd = 0;
    if (adminCdObj != null) {
        try {
            adminCd = Integer.parseInt(adminCdObj.toString());
        } catch (NumberFormatException e) {
            adminCd = 0;
        }
    }
%>

<nav class="admin-nav">
    <ul>
        <li><a href="/everybare.do">메인화면으로 이동</a></li>

        <% if (adminCd >= 1) { %>
            <li><a href="admin_schedule.do">📅 일정 관리</a></li>
            <li><a href="admin_class_list.do">📚 수업 목록</a></li>
            <li><a href="admin_members.do">👤 회원 목록</a></li>
        <% } %>

        <% if (adminCd == 3) { %>
            <li><a href="admin_teachers.do">🧑‍🏫 강사 관리</a></li>
            <li><a href="admin_tickets.do">🎟️ 수강권 관리</a></li>
            <li><a href="admin_locations.do">📍 지점 관리</a></li>
            <li><a href="admin_sales.do">💰 매출 관리</a></li>
            <li><a href="admin_slide_upload.do">🧑메인페이지 각종 수정</a></li>
        <% } %>
    </ul>
</nav>

<style>
    .admin-nav {
        background-color: #f8f9fa;
        padding: 10px 20px;
        border-bottom: 1px solid #ddd;
    }
    .admin-nav ul {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        gap: 15px;
    }
    .admin-nav li {
        display: inline;
    }
    .admin-nav a {
        text-decoration: none;
        color: #333;
        font-weight: bold;
        padding: 8px 12px;
        border-radius: 5px;
    }
    .admin-nav a:hover {
        background-color: #e9ecef;
    }
</style>
