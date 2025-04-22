<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>💰 매출 관리</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="js/jquery-3.6.0.min.js"></script>
    <style>
        .sales-container {
            width: 100%;
            padding: 20px;
        }
        .filter-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        .sales-table {
            width: 100%;
            border-collapse: collapse;
        }
        .sales-table th, .sales-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .sales-table th {
            background-color: #f8f9fa;
        }
        .canceled {
            color: red;
            font-weight: bold;
        }
        /* 페이지네이션 */
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination button {
            margin: 0 5px;
            padding: 8px 12px;
            border: 1px solid #ddd;
            background-color: white;
            color: black;
            cursor: pointer;
        }
        .pagination button.active {
            background-color: #007bff;
            color: white;
        }
        .pagination button:hover {
            background-color: #0056b3;
            color: white;
        }
        .dashboard {
		    display: grid;
		    grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
		    gap: 15px;
		    margin-bottom: 20px;
		}
		
		.dashboard-card {
		    padding: 15px;
		    border-radius: 10px;
		    text-align: center;
		    box-shadow: 0 3px 8px rgba(0,0,0,0.1);
		    background-color: #f8f9fa;
		    transition: transform 0.2s ease;
		}
		
		.dashboard-card:hover {
		    transform: translateY(-3px);
		}
		
		.dashboard-card .title {
		    font-weight: bold;
		    font-size: 1.1rem;
		    margin-bottom: 10px;
		    color: #333;
		}
		
		.dashboard-card .amount {
		    font-size: 1.3rem;
		    font-weight: bold;
		    color: #007bff;
		}
		
		.dashboard-card.total .amount { color: #2e86de; }
		.dashboard-card.new .amount { color: #28a745; }
		.dashboard-card.repeat .amount { color: #17a2b8; }
		.dashboard-card.trial .amount { color: #fd7e14; }
		.dashboard-card.refund .amount { color: #dc3545; }
		.dashboard-card.due .amount { color: #6c757d; }
		        
    </style>
</head>
<body>

<%@ include file="admin_nav.jsp" %>

<div class="container sales-container">
    <h2>💰 매출 관리</h2>

    <!-- 🔍 검색 필터 -->
    <div class="filter-bar">
        <label>📅 시작일: <input type="date" id="startDate"></label>
        <label>📅 종료일: <input type="date" id="endDate"></label>
        <label>🎟 수강권명: 
            <select id="filterTicket">
                <option value="">전체</option>
                <%
                    PreparedStatement pstmtTicket = conn.prepareStatement("SELECT DISTINCT TICKET_NAME FROM MEMBER_TICKET");
                    ResultSet rsTicket = pstmtTicket.executeQuery();
                    while (rsTicket.next()) {
                        String ticketName = rsTicket.getString("TICKET_NAME");
                %>
                <option value="<%= ticketName %>"><%= ticketName %></option>
                <% } 
                    rsTicket.close();
                    pstmtTicket.close();
                %>
            </select>
        </label>
        <label>📍 지점명: 
            <select id="filterLocation">
                <option value="">전체</option>
                <%
                    PreparedStatement pstmtLoc = conn.prepareStatement("SELECT DISTINCT LOCATION FROM MEMBER_PAYMENT");
                    ResultSet rsLoc = pstmtLoc.executeQuery();
                    while (rsLoc.next()) {
                        String location = rsLoc.getString("LOCATION");
                %>
                <option value="<%= location %>"><%= location %></option>
                <% } 
                    rsLoc.close();
                    pstmtLoc.close();
                %>
            </select>
        </label>
        <div class="filter-bar">
		    <button onclick="searchSales()">🔍 검색</button>
		    <button onclick="downloadExcel()">📥 엑셀 다운로드</button>
		</div>

    </div>
    
<!-- 📊 매출 대시보드 -->
<div class="dashboard">
    <div class="dashboard-card total">
        <div class="title">합계</div>
        <div id="totalSum" class="amount">0 원</div>
    </div>
    <div class="dashboard-card new">
        <div class="title">신규결제</div>
        <div id="newSum" class="amount">0 원</div>
    </div>
    <div class="dashboard-card repeat">
        <div class="title">재결제</div>
        <div id="repeatSum" class="amount">0 원</div>
    </div>
    <div class="dashboard-card trial">
        <div class="title">체험</div>
        <div id="trialSum" class="amount">0 원</div>
    </div>
    <div class="dashboard-card refund">
        <div class="title">환불</div>
        <div id="refundSum" class="amount">0 원</div>
    </div>
    <div class="dashboard-card due">
        <div class="title">미수금</div>
        <div id="dueSum" class="amount">0 원</div>
    </div>
</div>


    <!-- 📊 매출 테이블 -->
    <table class="sales-table">
        <thead>
            <tr>
                <th>회원명</th>
                <th>수강권명</th>
                <th>결제일</th>
                <th>지점</th>
                <th>카드 결제</th>
                <th>현금 결제</th>
                <th>총 결제금액</th>
                <th>미수금</th>
                <th>결제횟수</th>
                <th>취소 여부</th>
                <th>취소일</th>
            </tr>
        </thead>
        <tbody id="salesTable">
            <!-- AJAX로 매출 데이터 로드 -->
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="pagination" id="pagination"></div>
</div>

<script>
    function loadSales(page) {
        let startDate = document.getElementById("startDate").value;
        let endDate = document.getElementById("endDate").value;
        let filterTicket = document.getElementById("filterTicket").value;
        let filterLocation = document.getElementById("filterLocation").value;
        
        console.log("📌 JSON data 확인:", startDate,endDate,filterTicket,filterLocation);

        $.ajax({
            url: "/getSalesList.do",
            type: "GET",
            data: { 
                startDate: startDate, 
                endDate: endDate, 
                filterTicket: filterTicket, 
                filterLocation: filterLocation, 
                page: page
            },
            dataType: "json",
            success: function(response) {
                console.log("📌 JSON 응답 확인:", response);
                
                let tableContent = "";

                response.sales.forEach(sale => {
                    tableContent += "<tr>";
                    tableContent += "<td>" + (sale.USER_NAME || '') + "</td>";
                    tableContent += "<td>" + (sale.TICKET_NAME || '') + "</td>";
                    tableContent += "<td>" + (sale.PAYMENT_DATE_KST || '') + "</td>";
                    tableContent += "<td>" + (sale.LOCATION || '') + "</td>";
                    tableContent += "<td>" + (sale.CARD_AMOUNT ? sale.CARD_AMOUNT.toLocaleString() : '0') + " 원</td>";
                    tableContent += "<td>" + (sale.CASH_AMOUNT ? sale.CASH_AMOUNT.toLocaleString() : '0') + " 원</td>";
                    tableContent += "<td>" + (sale.TOTAL_AMOUNT ? sale.TOTAL_AMOUNT.toLocaleString() : '0') + " 원</td>";
                    tableContent += "<td>" + (sale.DUE_AMOUNT ? sale.DUE_AMOUNT.toLocaleString() : '0') + " 원</td>";
                    tableContent += "<td>" + (sale.USER_CASH ? sale.USER_CASH.toLocaleString() : '0') + " 번</td>";
                    tableContent += "<td class='" + (sale.CANCEL_YN === 'Y' ? "canceled" : "") + "'>" + (sale.CANCEL_YN === 'Y' ? "✅ 취소됨" : "-") + "</td>";
                    tableContent += "<td>" + (sale.CANCEL_DATE || '-') + "</td>";
                    tableContent += "</tr>";
                });

                $("#salesTable").html(tableContent);
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
            if (i === currentPage) {
                paginationHtml += "<button onclick='loadSales(" + i + ")' class='active'>" + i + "</button>";
            } else {
                paginationHtml += "<button onclick='loadSales(" + i + ")'>" + i + "</button>";
            }
        }

        $("#pagination").html(paginationHtml);
    }
    
    function formatDateLocal(date) {
        let y = date.getFullYear();
        let m = date.getMonth() + 1;
        let d = date.getDate();
        return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
    }

    $(document).ready(function() {
        let today = new Date();
        let y = today.getFullYear();
        let m = today.getMonth();

        let firstDay = formatDateLocal(new Date(y, m, 1));
        let lastDay = formatDateLocal(new Date(y, m + 1, 0));

        $("#startDate").val(firstDay);
        $("#endDate").val(lastDay);
        
        loadSales(1);
        loadDashboard();
    });
    
    function downloadExcel() {
        let startDate = document.getElementById("startDate").value;
        let endDate = document.getElementById("endDate").value;
        let filterTicket = document.getElementById("filterTicket").value;
        let filterLocation = document.getElementById("filterLocation").value;
        console.log(startDate);
        console.log(endDate);

        let queryParams = `?startDate=`+startDate+`&endDate=`+endDate+`&filterTicket=`+filterTicket+`&filterLocation=`+filterLocation;

        window.location.href = "/downloadSalesExcel.do" + queryParams;
    }
    
    function loadDashboard() {
        let startDate = document.getElementById("startDate").value;
        let endDate = document.getElementById("endDate").value;
        let filterLocation = document.getElementById("filterLocation").value;

        $.ajax({
            url: "/getSalesSummary.do",
            type: "GET",
            data: { 
                startDate: startDate, 
                endDate: endDate, 
                filterLocation: filterLocation 
            },
            dataType: "json",
            success: function(summary) {
                $("#totalSum").text(summary.total.toLocaleString() + " 원");
                $("#newSum").text(summary.new.toLocaleString() + " 원");
                $("#repeatSum").text(summary.repeat_payment.toLocaleString() + " 원");
                $("#trialSum").text(summary.trial.toLocaleString() + " 원");
                $("#refundSum").text(summary.refund.toLocaleString() + " 원");
                $("#dueSum").text(summary.due.toLocaleString() + " 원");
            },
            error: function(xhr, status, error) {
                console.error("대시보드 로딩 오류:", error);
            }
        });
    }
    
    function searchSales() {
        loadSales(1);
        loadDashboard();  // 📌 검색 기준으로 대시보드도 새로 불러오기
    }


</script>

</body>
</html>
