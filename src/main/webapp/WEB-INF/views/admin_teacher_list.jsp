<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>👨‍🏫 강사 관리</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .container { max-width: 1000px; margin: auto; padding: 20px; }
        .teacher-card {
            display: inline-block;
            width: 200px;
            padding: 15px;
            margin: 10px;
            border-radius: 8px;
            background: #f9f9f9;
            text-align: center;
            border: 1px solid #ddd;
        }
        .delete-btn, .edit-btn, .add-btn {
            padding: 5px 10px;
            margin: 5px;
            border: none;
            cursor: pointer;
        }
        .delete-btn { background: #e74c3c; color: white; }
        .edit-btn { background: #3498db; color: white; }
        .add-btn { background: #2ecc71; color: white; }
        .add-teacher-btn {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #e74c3c;
            color: white;
            padding: 15px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 20px;
        }
        .modal { 
            display: none; 
            position: fixed; 
            top: 50%; 
            left: 50%; 
            transform: translate(-50%, -50%);
            background: white; 
            padding: 20px; 
            border-radius: 5px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>👨‍🏫 강사 관리</h2>
    
    <div id="teacherList">
        <% 
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM BARE_TEACHER ORDER BY NAME ASC");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) { 
        %>
            <div class="teacher-card">
                <b><%= rs.getString("NAME") %></b><br>
                <%= rs.getString("PHONE") %><br>
                <button class="edit-btn" onclick="openEditModal('<%= rs.getString("NAME") %>', '<%= rs.getString("PHONE") %>')">수정</button>
                <button class="delete-btn" onclick="deleteTeacher('<%= rs.getString("NAME") %>')">삭제</button>
            </div>
        <% 
            } 
            rs.close();
            pstmt.close();
        %>
    </div>

    <!-- 강사 추가 버튼 -->
    <button class="add-teacher-btn" onclick="openAddModal()">+</button>
</div>

<!-- 강사 추가 모달 -->
<div id="addModal" class="modal">
    <h3>강사 추가</h3>
    <label>이름:</label> <input type="text" id="addName"><br>
    <label>전화번호:</label> <input type="text" id="addPhone"><br>
    <button class="add-btn" onclick="addTeacher()">추가</button>
    <button onclick="closeAddModal()">닫기</button>
</div>

<!-- 강사 수정 모달 -->
<div id="editModal" class="modal">
    <h3>강사 수정</h3>
    <input type="hidden" id="editOldName">
    <label>이름:</label> <input type="text" id="editName"><br>
    <label>전화번호:</label> <input type="text" id="editPhone"><br>
    <button class="edit-btn" onclick="updateTeacher()">수정</button>
    <button onclick="closeEditModal()">닫기</button>
</div>

<script>
function openAddModal() {
    $("#addModal").show();
}

function closeAddModal() {
    $("#addModal").hide();
}

function addTeacher() {
    let name = $("#addName").val();
    let phone = $("#addPhone").val();

    if (!name || !phone) {
        alert("모든 필드를 입력해주세요.");
        return;
    }

    $.ajax({
        url: "/addTeacher.do",
        type: "POST",
        data: { name: name, phone: phone },
        success: function(response) {
            alert(response.message);
            location.reload();
        },
        error: function(xhr) {
            alert("오류 발생: " + xhr.responseText);
        }
    });
}

function openEditModal(name, phone) {
    $("#editOldName").val(name);
    $("#editName").val(name);
    $("#editPhone").val(phone);
    $("#editModal").show();
}

function closeEditModal() {
    $("#editModal").hide();
}

function updateTeacher() {
    let oldName = $("#editOldName").val();
    let newName = $("#editName").val();
    let phone = $("#editPhone").val();

    if (!newName || !phone) {
        alert("모든 필드를 입력해주세요.");
        return;
    }

    $.ajax({
        url: "/updateTeacher.do",
        type: "POST",
        data: { oldName: oldName, newName: newName, phone: phone },
        success: function(response) {
            alert(response.message);
            location.reload();
        },
        error: function(xhr) {
            alert("오류 발생: " + xhr.responseText);
        }
    });
}

function deleteTeacher(name) {
    if (!confirm("정말 삭제하시겠습니까?")) return;

    $.ajax({
        url: "/deleteTeacher.do",
        type: "POST",
        data: { name: name },
        success: function(response) {
            alert(response.message);
            location.reload();
        },
        error: function(xhr) {
            alert("오류 발생: " + xhr.responseText);
        }
    });
}
</script>

</body>
</html>
