<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>📌 수업 수정</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .button-container {
            text-align: right; /* 오른쪽 정렬 */
            margin-top: 10px; /* 위쪽 간격 */
        }

        .button-container button {
            padding: 8px 12px;
            font-size: 14px;
            background-color: #4CAF50; /* 버튼 색상 */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .button-container button:hover {
            background-color: #45a049; /* 호버 효과 */
        }
    </style>
</head>
<body>

<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>📌 수업 수정</h2>

    <%
        String bookId = request.getParameter("bookId");
        String className = "", location = "", teacher = "", date = "", time = "", maxPeople = "";

        if (bookId != null) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM BARE_BOOK WHERE BOOK_ID = ?");
            pstmt.setString(1, bookId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                className = rs.getString("CLASS");
                location = rs.getString("LOCATION");
                teacher = rs.getString("TEACHER");
                date = rs.getString("DATE");
                time = rs.getString("TIME");
                maxPeople = rs.getString("MAXPEOPLE");
            }
            rs.close();
            pstmt.close();
        }
    %>

    <!-- 돌아가기 버튼 (오른쪽 정렬) -->
    <div class="button-container">
        <button onclick="window.history.back()">돌아가기</button>
    </div>

    <form id="editClassForm">
        <input type="hidden" name="bookId" id="bookId" value="<%= bookId %>">

        <label>수업명:</label>
        <input type="text" name="className" id="className" value="<%= className %>" required><br>

        <label>지점:</label>
        <select name="location" id="location">
            <%
                Statement stmtLocation = conn.createStatement();
                ResultSet rsLocation = stmtLocation.executeQuery("SELECT LOCATION FROM BARE_LOCATION");
                while (rsLocation.next()) {
                    String loc = rsLocation.getString("LOCATION");
            %>
            <option value="<%= loc %>" <%= loc.equals(location) ? "selected" : "" %>><%= loc %></option>
            <%
                }
                rsLocation.close();
                stmtLocation.close();
            %>
        </select><br>

        <label>강사:</label>
        <select name="teacher" id="teacher">
            <%
                Statement stmtTeacher = conn.createStatement();
                ResultSet rsTeacher = stmtTeacher.executeQuery("SELECT NAME FROM BARE_TEACHER");
                while (rsTeacher.next()) {
                    String teach = rsTeacher.getString("NAME");
            %>
            <option value="<%= teach %>" <%= teach.equals(teacher) ? "selected" : "" %>><%= teach %></option>
            <%
                }
                rsTeacher.close();
                stmtTeacher.close();
            %>
        </select><br>

        <label>날짜:</label>
        <input type="date" name="date" id="date" value="<%= date %>" required><br>

        <label>시간:</label>
        <input type="time" name="time" id="time" value="<%= time %>" required><br>

        <label>최대 인원:</label>
        <input type="number" name="maxPeople" id="maxPeople" value="<%= maxPeople %>" required><br>

        <button type="button" onclick="updateClass()">수정 완료</button>
    </form>
</div>

<script>
    function updateClass() {
        let classData = {
            BOOK_ID: $("#bookId").val(),
            className: $("#className").val(),
            LOCATION: $("#location").val(),
            TEACHER: $("#teacher").val(),
            DATE: $("#date").val(),
            TIME: $("#time").val(),
            MAXPEOPLE: $("#maxPeople").val()
        };

        $.ajax({
            url: "/updateClass.do",
            type: "POST",
            contentType: "application/json", // JSON 데이터 전송
            dataType: "json", // JSON 응답 받기
            data: JSON.stringify(classData),
            success: function(response) {
                if (response.status === "success") {
                    alert(response.message); // ✅ 정상 응답 메시지 출력
                    window.location.href = "/admin_class_list.do"; // 목록 페이지로 이동
                } else {
                    alert("수정 실패: " + response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error("AJAX 오류:", error);
                console.log(xhr.responseText); // 서버 응답 확인
                alert("수업 수정 중 오류가 발생했습니다.");
            }
        });
    }
</script>

</body>
</html>
