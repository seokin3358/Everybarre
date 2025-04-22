<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>👥 회원 목록</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .filter-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            margin-bottom: 15px;
        }
        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .filter-group label {
            white-space: nowrap;
        }
        .filter-group input {
            width: 200px;
            padding: 5px;
        }
        .search-btn {
            margin-left: auto;
            padding: 6px 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .search-btn:hover {
            background-color: #45a049;
        }
        .pagination {
            text-align: center;
            margin-top: 10px;
        }
        .pagination button {
            padding: 5px 10px;
            margin: 2px;
            border: 1px solid #ccc;
            cursor: pointer;
        }
        .pagination button.active {
            background-color: #4CAF50;
            color: white;
        }
        .ticket-list {
            font-size: 12px;
            color: #666;
            background: #f8f8f8;
            padding: 5px;
            border-radius: 5px;
            margin-top: 3px;
        }
    </style>
</head>
<body>

<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>👥 회원 목록</h2>

    <!-- 필터 (이름, 전화번호) -->
    <div class="filter-container">
        <div class="filter-group">
            <label for="searchName">이름:</label>
            <input type="text" id="searchName" placeholder="회원 이름 입력">
            
            <label for="searchPhone">전화번호:</label>
            <input type="text" id="searchPhone" placeholder="전화번호 입력">
        </div>
        <button class="search-btn" onclick="loadMembers(1)">검색</button>
        <button onclick="downloadExcel()" class="search-btn" style="margin-left: 10px; padding: 6px 12px; background-color: #007bff; color: white; border: none; cursor: pointer;">📥 엑셀 다운로드</button>
       
    </div>

    <!-- 회원 목록 테이블 -->
    <table>
        <thead>
            <tr>
                <th>회원 ID</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>생년월일</th>
                <th>보유 수강권</th>
                <th>메모</th>
                <th>상세보기</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody id="memberTable">
            <!-- AJAX로 회원 데이터 로드 -->
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div id="pagination" class="pagination"></div>
</div>

<script>
$(document).ready(function() {
    loadMembers(1);
});

function loadMembers(page) {
    let name = $("#searchName").val();
    let phone = $("#searchPhone").val();

    $.ajax({
        url: "/getMemberList.do",
        type: "GET",
        data: { name: name, phone: phone, page: page },
        dataType: "json",
        success: function(response) {
            let tableContent = "";
            response.members.forEach(member => {
                tableContent += "<tr>";
                tableContent += "<td>" + (member.USER_ID || '') + "</td>";
                tableContent += "<td>" + (member.USER_NAME || '') + "</td>";
                tableContent += "<td>" + (member.USER_PHONE || '') + "</td>";
                tableContent += "<td>" + (member.USER_MAIL || '') + "</td>";
                tableContent += "<td>" + (member.USER_BIRTH || '') + "</td>";

                // 수강권 목록 가져오기
                let ticketContent = "";
                if (member.tickets && member.tickets.length > 0) {
                	let shownCount = 0;
                	const today = new Date();
                	
                    member.tickets.forEach(ticket => {
                    	const endDateStr = ticket.END_DATE;
                        const endDate = endDateStr ? new Date(endDateStr) : null;

                        if (ticket.TICKET_COUNT && parseInt(ticket.TICKET_COUNT) > 0 &&
                            endDate && endDate >= today &&
                            shownCount < 5) {

                            ticketContent += "<div class='ticket-list'>" 
                                + (ticket.LOCATION || '') + " / " 
                                + (ticket.TICKET_NAME || '') + " (" 
                                + (ticket.START_DATE || '') + " ~ " 
                                + (ticket.END_DATE || '') + ") - " 
                                + (ticket.TICKET_COUNT || '') + "회 남음</div>";
                            shownCount++;
                        }
                    });

                    if (shownCount === 0) {
                        ticketContent = "<div class='ticket-list'>수강권 없음</div>";
                    }
                } else {
                    ticketContent = "<div class='ticket-list'>수강권 없음</div>";
                }
                tableContent += "<td>" + ticketContent + "</td>";
                tableContent += "<td>" + (member.USER_MEMO || '메모 없음') + "</td>";

                tableContent += "<td><a href='/admin_member_detail.do?userId=" + (member.USER_ID || '') + "'>보기</a></td>";
                tableContent += "<td><button onclick='deleteMember(" + (member.USER_ID || '') + ")'>삭제</button></td>";
                tableContent += "</tr>";
            });

            $("#memberTable").html(tableContent);
            updatePagination(response.totalPages, page);
        },
        error: function(xhr, status, error) {
            console.error("AJAX 오류:", error);
        }
    });
}

function updatePagination(totalPages, currentPage) {
    let paginationHtml = "";
    for (let i = 1; i <= totalPages; i++) {
        paginationHtml += "<button onclick='loadMembers(" + i + ")' " + (i === currentPage ? "class='active'" : "") + ">" + i + "</button>";
    }
    $("#pagination").html(paginationHtml);
}

function deleteMember(userId) {
    if (confirm("해당 회원을 삭제하시겠습니까?")) {
        $.ajax({
            url: "/deleteMember.do",
            type: "POST",
            data: { userId: userId },
            success: function(response) {
                alert("회원이 삭제되었습니다.");
                loadMembers(1);
            },
            error: function(xhr, status, error) {
                console.error("삭제 오류:", error);
            }
        });
    }
}

function downloadExcel() {
    let name = $("#searchName").val();
    let phone = $("#searchPhone").val();

    // 파라미터 포함한 요청
    let queryParams = "?name=" + encodeURIComponent(name) + "&phone=" + encodeURIComponent(phone);
    window.location.href = "/downloadMemberExcel.do" + queryParams;
}

</script>

</body>
</html>
