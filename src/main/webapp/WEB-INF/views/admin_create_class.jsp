<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>📚 수업 추가</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<% 
    String message = request.getParameter("message"); 
    if (message != null) { 
%>
    <script>
        alert("<%= message %>"); // 수업 추가 완료 메시지
    </script>
<% } %>

<!-- 네비게이션 바 -->
<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>📚 수업 추가</h2>

    <form id="classForm" method="post" action="admin_add_class.do">
        <!-- 지점 선택 -->
		<label for="location">지점 선택:</label>
		<select id="location" name="location">
		    <option value="">지점 선택</option>
		    <%
		        Statement stmtLocation = conn.createStatement();
		        ResultSet rsLocation = stmtLocation.executeQuery("SELECT LOCATION FROM BARE_LOCATION");
		        while (rsLocation.next()) {
		            String loc = rsLocation.getString("LOCATION");
		    %>
		            <option value="<%= loc %>" <%= (request.getParameter("location") != null && request.getParameter("location").equals(loc)) ? "selected" : "" %> >
		                <%= loc %>
		            </option>
		    <%
		        }
		        rsLocation.close();
		        stmtLocation.close();
		    %>
		</select>
		
		<!-- 강사 선택 -->
		<label for="teacher">강사 선택:</label>
		<select id="teacher" name="teacher">
		    <option value="">강사 선택</option>
		    <%
		        Statement stmtTeacher = conn.createStatement();
		        ResultSet rsTeacher = stmtTeacher.executeQuery("SELECT NAME FROM BARE_TEACHER");
		        while (rsTeacher.next()) {
		            String teacher = rsTeacher.getString("NAME");
		    %>
		            <option value="<%= teacher %>" <%= (request.getParameter("teacher") != null && request.getParameter("teacher").equals(teacher)) ? "selected" : "" %> >
		                <%= teacher %>
		            </option>
		    <%
		        }
		        rsTeacher.close();
		        stmtTeacher.close();
		    %>
		</select>
		
		<!-- 수업명 -->
		<label for="className">수업명:</label>
		<input type="text" id="className" name="className" value="<%= request.getParameter("className") != null ? request.getParameter("className") : "" %>" required>
		
		<!-- 최대 수강 인원 -->
		<label for="people">최대 수강 인원:</label>
		<input type="number" id="people" name="people" value="<%= request.getParameter("people") != null ? request.getParameter("people") : "10" %>" min="1">
		
		<!-- 수업 날짜 -->
		<label for="startDate">수업 기간:</label>
		<input type="date" id="startDate" name="startDate" value="<%= request.getParameter("startDate") != null ? request.getParameter("startDate") : "" %>" required> ~
		<input type="date" id="endDate" name="endDate" value="<%= request.getParameter("endDate") != null ? request.getParameter("endDate") : "" %>" required>
		
		<!-- 수업 시간 -->
		<label for="time">수업 시간:</label>
		<input type="time" id="time" name="time" required>
		
		<!-- 요일 선택 -->
		<label>요일 선택:</label>
		<div id="days">
		    <button type="button" class="day-btn" data-day="월">월</button>
		    <button type="button" class="day-btn" data-day="화">화</button>
		    <button type="button" class="day-btn" data-day="수">수</button>
		    <button type="button" class="day-btn" data-day="목">목</button>
		    <button type="button" class="day-btn" data-day="금">금</button>
		    <button type="button" class="day-btn" data-day="토">토</button>
		    <button type="button" class="day-btn" data-day="일">일</button>
		</div>
		<input type="hidden" id="selectedDays" name="selectedDays">
		
		<!-- 수업 추가 버튼 -->
		<button type="submit">수업 추가</button>
    </form>
</div>

<script>
    let selectedDays = [];

    // 요일 버튼 클릭 이벤트
    $(".day-btn").click(function() {
        let day = $(this).data("day");
        if (selectedDays.includes(day)) {
            selectedDays = selectedDays.filter(d => d !== day);
            $(this).removeClass("selected");
        } else {
            selectedDays.push(day);
            $(this).addClass("selected");
        }
        $("#selectedDays").val(selectedDays.join(","));
    });

    // 폼 제출 시 요일이 선택되지 않았으면 경고
    $("#classForm").submit(function(event) {
        if (selectedDays.length === 0) {
            alert("요일을 선택해주세요!");
            event.preventDefault();
        }
    });
</script>

<style>
    .day-btn {
        margin: 5px;
        padding: 10px;
        background-color: #f1f1f1;
        border: 1px solid #ccc;
        cursor: pointer;
        color: black;
    }
    .selected {
        background-color: #4CAF50;
        color: white;
    }
</style>

</body>
</html>
