<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>🎟️ 수강권 관리</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .ticket-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: flex-start;
        }
        .ticket-card {
            width: 200px;
            background: #fff;
            border-radius: 10px;
            padding: 15px;
            box-shadow: 2px 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            position: relative;
        }
        .edit-btn, .delete-btn {
            margin-top: 10px;
            padding: 6px 12px;
            border: none;
            cursor: pointer;
        }
        .edit-btn { background: #4CAF50; color: white; }
        .delete-btn { background: #d9534f; color: white; }
        .add-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: #f04e30;
            color: white;
            border: none;
            padding: 15px;
            border-radius: 50%;
            font-size: 20px;
            cursor: pointer;
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
    <h2>🎟️ 수강권 관리</h2>

    <!-- 수강권 목록 -->
    <div class="ticket-container">
        <%
            PreparedStatement pstmt = conn.prepareStatement("SELECT NAME, PRICE, MONTH FROM TICKET_INFO");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String name = rs.getString("NAME");
                String price = rs.getString("PRICE");
                String formattedPrice = price.replaceAll("\\B(?=(\\d{3})+(?!\\d))", ","); // 1000 단위 콤마 추가
                int month = rs.getInt("MONTH");
        %>
            <div class="ticket-card">
                <b><%= name %></b><br>
                💰 가격: <%= formattedPrice %> 원<br>
                📅 기간: <%= month %> 개월<br>
                <button class="edit-btn" onclick="openEditModal('<%= name %>', '<%= price %>', '<%= month %>')">수정</button>
                <button class="delete-btn" onclick="deleteTicket('<%= name %>')">삭제</button>
            </div>
        <%
            }
            rs.close();
            pstmt.close();
        %>
    </div>

    <!-- 추가 버튼 <button class="add-btn" onclick="openAddModal()">+</button> -->
    
</div>

<!-- 수강권 추가 모달 -->
<div id="addModal" class="modal" style="display: none;">
    <h3>🎟️ 수강권 추가</h3>
    <label>이름:</label> <input type="text" id="addName"><br>
    <label>가격:</label> <input type="text" id="addPrice" onkeyup="formatPrice(this)"><br>
    <label>기간 (개월):</label> <input type="number" id="addMonth"><br>
    <button onclick="addTicket()">추가</button>
    <button onclick="closeAddModal()">닫기</button>
</div>

<!-- 수강권 수정 모달 -->
<div id="editModal" class="modal" style="display: none;">
    <h3>🎟️ 수강권 수정</h3>
    <input type="hidden" id="originalName">
    <label>이름:</label> <input type="text" id="editName"><br>
    <label>가격:</label> <input type="text" id="editPrice" onkeyup="formatPrice(this)"><br>
    <label>기간 (개월):</label> <input type="number" id="editMonth"><br>
    <button onclick="updateTicket()">수정</button>
    <button onclick="closeEditModal()">닫기</button>
</div>

<script>
// 가격 입력 시 콤마 추가
function formatPrice(input) {
    let value = input.value.replace(/,/g, '');
    input.value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 모달 열기 및 닫기
function openAddModal() { $("#addModal").show(); }
function closeAddModal() { $("#addModal").hide(); }
function openEditModal(name, price, month) {
    $("#originalName").val(name);
    $("#editName").val(name);
    $("#editPrice").val(price.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); 
    $("#editMonth").val(month);
    $("#editModal").show();
}
function closeEditModal() { $("#editModal").hide(); }

// 수강권 추가
function addTicket() {
    let ticketData = {
        name: $("#addName").val(),
        price: $("#addPrice").val().replace(/,/g, ''),
        month: $("#addMonth").val()
    };

    $.ajax({
        url: "/addTicketadmin.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(ticketData),
        success: function(response) {
            alert(response.message);
            location.reload();
        }
    });
}

// 수강권 수정
function updateTicket() {
    let ticketData = {
        originalName: $("#originalName").val(),
        name: $("#editName").val(),
        price: $("#editPrice").val().replace(/,/g, ''),
        month: $("#editMonth").val()
    };

    $.ajax({
        url: "/updateTicketadmin.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(ticketData),
        success: function(response) {
            alert(response.message);
            location.reload();
        }
    });
}

// 수강권 삭제
function deleteTicket(name) {
    if (confirm("정말 삭제하시겠습니까?")) {
        $.ajax({
            url: "/deleteTicketadmin.do",
            type: "POST",
            data: { name: name },
            success: function(response) {
                alert(response.message);
                location.reload();
            }
        });
    }
}
</script>

</body>
</html>
