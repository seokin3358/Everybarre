<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>👤 회원 상세 정보</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .container { max-width: 800px; margin: auto; padding: 20px; }
        .section { margin-bottom: 20px; padding: 15px; background: #f9f9f9; border-radius: 5px; }
        .ticket-card { border: 1px solid #ddd; padding: 10px; margin: 5px; border-radius: 5px; display: inline-block; }
        .ticket-list { margin-top: 10px; }
        .edit-btn, .add-btn { background: #4CAF50; color: white; border: none; padding: 5px 10px; cursor: pointer; }
        .edit-btn:hover, .add-btn:hover { background: #45a049; }
        .modal { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; padding: 20px; border-radius: 5px; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); }
        /* 탭 버튼 스타일 */
		.tab-container {
		    display: flex;
		    justify-content: center;
		    margin-bottom: 15px;
		}
		
		.tab-btn {
		    padding: 10px 20px;
		    margin: 0 5px;
		    border: none;
		    background: #ddd;
		    cursor: pointer;
		    border-radius: 5px;
		    font-weight: bold;
		}
		
		.tab-btn.active {
		    background: #4CAF50;
		    color: white;
		}
		
		/* 탭 내용 숨김 기본 설정 */
		.tab-content {
		    display: none;
		}
		
		/* 기본적으로 수강권 내역 표시 */
		#ticketSection {
		    display: block;
		}
		#locationFilter {
		    padding: 5px;
		    margin: 10px 0;
		    border-radius: 5px;
		}
		.modal-content {
		  background-color: #fff;
		  padding: 30px;
		  border-radius: 12px;
		  width: 90%;
		  max-width: 500px;
		  box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
		  text-align: center;
		  animation: fadeIn 0.3s ease-in-out;
		
		  /* 👇 추가 */
		  max-height: 80vh;
		  overflow-y: auto;
		}
		        
    </style>
</head>
<body>

<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>👤 회원 상세 정보</h2>

    <%
        String userId = request.getParameter("userId");
        String userName = "", userPhone = "", userMail = "", userBirth = "", memo = "", admin_cd = "";

        if (userId != null) {
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM MEMBER_INFO WHERE USER_ID = ?");
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("USER_NAME");
                userPhone = rs.getString("USER_PHONE");
                userMail = rs.getString("USER_MAIL");
                userBirth = rs.getString("USER_BIRTH");
                memo = rs.getString("MEMO");
                admin_cd = rs.getString("ADMIN_CD");
            }
            rs.close();
            pstmt.close();
        }
    %>

    <!-- 회원 정보 -->
    <div class="section">
        <h3>회원 정보</h3>
        <form id="updateMemberForm">
            <input type="hidden" id="userId" value="<%= userId %>">
            <label>이름:</label> <input type="text" id="userName" value="<%= userName %>"><br>
            <label>전화번호:</label> <input type="text" id="userPhone" value="<%= userPhone %>"><br>
            <label>이메일:</label> <input type="text" id="userMail" value="<%= userMail %>"><br>
            <label>생년월일:</label> <input type="text" id="userBirth" value="<%= userBirth %>"><br>
            <label>메모:</label> <input type="text" id="memo" value="<%= memo %>"><br>
            <label for="admin_cd">관리자 등급 선택:</label>
			<select id="admin_cd" name="admin_cd"
				<%= !"3".equals(String.valueOf(session.getAttribute("ADMIN_CD"))) ? "disabled" : "" %>>
			    <option value="0" <%= "0".equals(admin_cd) ? "selected" : "" %>>0단계 - 일반 사용자</option>
			    <option value="1" <%= "1".equals(admin_cd) ? "selected" : "" %>>1단계 - 수업 확인 + 회원 수강권 추가</option>
			    <option value="2" <%= "2".equals(admin_cd) ? "selected" : "" %>>2단계 - 수업 추가 가능</option>
			    <option value="3" <%= "3".equals(admin_cd) ? "selected" : "" %>>3단계 - 매출 관리 가능</option>
			</select>
			<div style="margin-top:10px; font-size:14px; color: #666;">
			    <ul style="padding-left: 20px; list-style-type: disc;">
			        <li><b>0단계</b>: 일반 사용자 (권한 없음)</li>
			        <li><b>1단계</b>: 수업 확인, 회원 수강권 추가</li>
			        <li><b>2단계</b>: 수업 추가 가능 (1단계 포함)</li>
			        <li><b>3단계</b>: 매출 관리 가능 (2단계 포함)</li>
			    </ul>
			</div>
            <button type="button" class="edit-btn" onclick="updateMember()">회원 정보 수정</button>
        </form>
    </div>

    <!-- 탭 버튼 -->
<div class="tab-container">
    <button class="tab-btn active" onclick="showTab('ticketSection')">📌 수강권 내역</button>
    <button class="tab-btn" onclick="showTab('reservationSection')">📅 예약 내역</button>
</div>

<!-- 📌 수강권 내역 -->
<div id="ticketSection" class="tab-content">
    <div class="section">
        <h3>📌 사용 중인 수강권</h3>
        <div class="ticket-list">
    <%
        PreparedStatement pstmtTicket = conn.prepareStatement("SELECT * FROM MEMBER_TICKET WHERE USER_ID = ? AND TICKET_COUNT > 0 AND END_DATE >= NOW() AND CANCEL_YN = 'N'");
        pstmtTicket.setString(1, userId);
        ResultSet rsTicket = pstmtTicket.executeQuery();
        while (rsTicket.next()) {
    %>
        <div class="ticket-card" 
             onclick="openEditTicketModal(
                 '<%= rsTicket.getString("TICKET_ID") %>', 
                 '<%= rsTicket.getString("TICKET_NAME") %>', 
                 '<%= rsTicket.getString("LOCATION") %>', 
                 '<%= rsTicket.getString("START_DATE") %>', 
                 '<%= rsTicket.getString("END_DATE") %>', 
                 '<%= rsTicket.getString("TICKET_COUNT") %>'
             )">
            <b><%= rsTicket.getString("TICKET_NAME") %></b><br>
            <%= rsTicket.getString("LOCATION") %><br>
            유효기간: <%= rsTicket.getString("START_DATE") %> ~ <%= rsTicket.getString("END_DATE") %><br>
            남은 횟수: <%= rsTicket.getString("TICKET_COUNT") %>회
        </div>
    <%
        }
        rsTicket.close();
        pstmtTicket.close();
    %>
    </div>
 </div>
    <!-- 사용 완료된 수강권 -->
<div class="section">
    <h3>📌 사용 완료된 수강권</h3>
    <div class="ticket-list" id="usedTicketsList">
        <%
        String usedTicketQuery = 
        "SELECT T.*, P.CANCEL_YN, P.CANCEL_DATE " +
        "FROM MEMBER_TICKET T " +
        "LEFT JOIN MEMBER_PAYMENT P ON T.TICKET_ID = P.TICKET_ID " +
        "WHERE T.USER_ID = ? AND " +
        " (T.TICKET_COUNT = 0 OR T.END_DATE < NOW()) " +
        "AND T.END_DATE >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) " +
        "ORDER BY T.END_DATE DESC LIMIT 10";

            PreparedStatement pstmtUsedTickets = conn.prepareStatement(usedTicketQuery);
            pstmtUsedTickets.setString(1, userId);
            ResultSet rsUsedTickets = pstmtUsedTickets.executeQuery();

            boolean hasUsedTickets = false;
            while (rsUsedTickets.next()) {
                hasUsedTickets = true;

                boolean isCanceled = "Y".equals(rsUsedTickets.getString("CANCEL_YN"));
                String cancelDate = rsUsedTickets.getString("CANCEL_DATE");
        %>
            <div class="ticket-card">
                <b><%= rsUsedTickets.getString("TICKET_NAME") %></b>
                <% if (isCanceled) { %>
                    <span style="color: red;">(티켓취소)</span>
                <% } else { %>
                    <span style="color: red;">(사용 완료)</span>
                <% } %>
                <br>
                <%= rsUsedTickets.getString("LOCATION") %><br>
                사용기간: <%= rsUsedTickets.getString("START_DATE") %> ~ <%= rsUsedTickets.getString("END_DATE") %><br>
                <% if (isCanceled && cancelDate != null) { %>
                    취소날짜: <%= cancelDate.substring(0, 10) %><br>
                <% } %>
            </div>
        <%
            }
            rsUsedTickets.close();
            pstmtUsedTickets.close();

            if (!hasUsedTickets) {
        %>
            <p style="color: gray;">최근 6개월 내 사용 완료된 수강권이 없습니다.</p>
        <%
            }
        %>
    </div>

    <button class="add-btn" onclick="openUsedTicketsModal()">📜 더 보기</button>
</div>

</div>

<!-- 📅 예약 내역 -->
<div id="reservationSection" class="tab-content" style="display: none;">
    <div class="section">
        <h3>📅 예약 내역</h3>

        <!-- ✅ 지점 선택 필터 -->
        <label for="locationFilter">지점 선택:</label>
        <select id="locationFilter" onchange="filterReservation()">
            <option value="전체">전체</option>
            <%
                Statement locationStmt = conn.createStatement();
                ResultSet locationRs = locationStmt.executeQuery("SELECT LOCATION FROM BARE_LOCATION");
                while (locationRs.next()) {
            %>
                <option value="<%= locationRs.getString("LOCATION") %>"><%= locationRs.getString("LOCATION") %></option>
            <%
                }
                locationRs.close();
                locationStmt.close();
            %>
        </select>

        <!-- ✅ 날짜 선택 필터 -->
        <label for="startDateFilter">시작 날짜:</label>
		<input type="date" id="startDateFilter" onchange="filterReservation()">
		<label for="endDateFilter">종료 날짜:</label>
		<input type="date" id="endDateFilter" onchange="filterReservation()">

        <div class="reservation-list" id="reservationList">
            <%
                PreparedStatement pstmtReservation = conn.prepareStatement("SELECT * FROM MEMBER_BOOK WHERE USER_ID = ? ORDER BY DATE DESC");
                pstmtReservation.setString(1, userId);
                ResultSet rsReservation = pstmtReservation.executeQuery();

                boolean hasReservation = false;
                while (rsReservation.next()) {
                    hasReservation = true;

                    // 현재 날짜와 비교하여 취소 버튼 활성화 여부 결정
                    String reservationDate = rsReservation.getString("DATE"); // YYYY-MM-DD
					Time reservationTime = rsReservation.getTime("TIME"); // HH:mm:ss 형식으로 가져옴
					
					// Timestamp 생성
					Timestamp reservationTimestamp = Timestamp.valueOf(reservationDate + " " + reservationTime.toString());
					boolean isCancelable = reservationTimestamp.after(new Timestamp(System.currentTimeMillis()));

            %>
                <div class="ticket-card reservation-item" 
                    data-location="<%= rsReservation.getString("LOCATION") %>" 
                    data-date="<%= rsReservation.getString("DATE") %>">
                    
                    <b><%= rsReservation.getString("CLASS") %></b><br>
                    지점: <%= rsReservation.getString("LOCATION") %><br>
                    예약일: <%= rsReservation.getString("DATE") %> <%= rsReservation.getString("TIME") %><br>
                    
                    <% if (isCancelable) { %>
                        <button class="cancel-btn" onclick="cancelReservation('<%= rsReservation.getString("BOOK_ID") %>')">❌ 예약 취소</button>
                    <% } %>
                </div>
            <%
                }
                rsReservation.close();
                pstmtReservation.close();

                if (!hasReservation) {
            %>
                <p id="noReservationMessage" style="color: gray;">예약 내역이 없습니다.</p>
            <%
                }
            %>
        </div>
    </div>
</div>



</div>

<!-- 사용 완료된 수강권 모달 -->
<div id="usedTicketsModal" class="modal" style="display: none;">
    <h3>📜 전체 사용 완료된 수강권</h3>
    <div id="fullUsedTicketsList">
        <p style="color: gray;">로딩 중...</p>
    </div>
    <button onclick="closeUsedTicketsModal()">닫기</button>
</div>

<!-- 수강권 추가 모달 -->
<div id="addTicketModal" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%); background:white; padding:20px; border-radius:5px;">
    <h3>수강권 추가</h3>
    <label>수강권 선택:</label>
    <select id="ticketSelect" onchange="updateTicketPrice()">
        <option value="" data-price="0">수강권 선택</option>
        <%
            Statement stmtTicket = conn.createStatement();
            ResultSet rsTicketList = stmtTicket.executeQuery("SELECT NAME, PRICE FROM TICKET_INFO");
            while (rsTicketList.next()) {
        %>
            <option value="<%= rsTicketList.getString("NAME") %>" 
			        data-price="<%= rsTicketList.getString("PRICE").replace(",", "") %>">
			    <%= rsTicketList.getString("NAME") %> (가격: <%= rsTicketList.getString("PRICE") %>원)
			</option>
        <%
            }
            rsTicketList.close();
            stmtTicket.close();
        %>
    </select><br>

    <label>지점 선택 :</label>
    <select id="locationSelect">
        <option value="전지점">전지점</option>
        <%
            Statement locationTicket = conn.createStatement();
            ResultSet rslocationList = locationTicket.executeQuery("SELECT LOCATION FROM BARE_LOCATION");
            while (rslocationList.next()) {
        %>
            <option value="<%= rslocationList.getString("LOCATION") %>"><%= rslocationList.getString("LOCATION") %></option>
        <%
            }
            rslocationList.close();
            locationTicket.close();
        %>
    </select><br>

    <label>시작일:</label> <input type="date" id="startDate"><br>
    <label>종료일:</label> <input type="date" id="endDate"><br>
    <label>횟수:</label> <input type="number" id="ticketCount"><br>

    <!-- 결제 정보 -->
    <h3>💳 결제 정보</h3>
    <label>총 가격:</label> <span id="totalPrice">0</span> 원<br>
    <label>카드 결제:</label> <input type="number" id="cardAmount" value="0" oninput="calculateDueAmount()"><br>
    <label>현금 결제:</label> <input type="number" id="cashAmount" value="0" oninput="calculateDueAmount()"><br>
    <label>미수금:</label> <span id="dueAmount">0</span> 원<br><br>
    
    <label>결제 메모:</label>
    <input type="text" id="memoInput" placeholder="메모를 입력하세요"><br><br>

    <button onclick="addTicket()">추가</button>
    <button onclick="closeAddTicketModal()">닫기</button>
</div>

<!-- 수강권 수정 모달 -->
<div id="editTicketModal" class="modal" style="display: none;">
    <h3>수강권 정보 수정</h3>
    <input type="hidden" id="editTicketId">
    
    <label>수강권 이름:</label>
    <input type="text" id="editTicketName" readonly><br>

    <label>지점:</label>
    <input type="text" id="editLocation" readonly><br>

    <label>시작일:</label>
    <input type="date" id="editStartDate"><br>

    <label>종료일:</label>
    <input type="date" id="editEndDate"><br>

    <label>잔여 횟수:</label>
    <input type="number" id="editTicketCount"><br>

    <!-- 💳 결제 정보 -->
    <h3>💳 결제 정보</h3>
    <label>총 가격:</label> <span id="editTotalPrice">0</span> 원<br>
    <label>카드 결제:</label> <input type="number" id="editCardAmount" value="0" oninput="calculateEditDueAmount()"><br>
    <label>현금 결제:</label> <input type="number" id="editCashAmount" value="0" oninput="calculateEditDueAmount()"><br>
    <label>미수금:</label> <span id="editDueAmount">0</span> 원<br>
    <label>결제일:</label>
    <input type="date" id="PaymentDay"><br><br>

	<label>결제 메모:</label>
    <input type="text" id="editMemo" placeholder="결제 관련 메모 입력"><br><br>

    <button onclick="updateTicket()">수정</button>
    <button onclick="deleteTicket()">취소</button>
    <button onclick="closeEditTicketModal()">닫기</button>
</div>

<!-- 📌 우측 하단 플로팅 버튼 -->
<button id="openAddTicketModalBtn" style="
    position: fixed;
    bottom: 30px;
    right: 30px;
    width: 60px;
    height: 60px;
    border-radius: 50%;
    background-color: #e94560;
    color: white;
    border: none;
    font-size: 30px;
    cursor: pointer;
    box-shadow: 0px 4px 10px rgba(0,0,0,0.2);
">+</button>


<script>
//사용 완료된 수강권 모달 열기
function openUsedTicketsModal() {
    $("#fullUsedTicketsList").html("<p style='color: gray;'>로딩 중...</p>");
    $("#usedTicketsModal").show();

    $.ajax({
        url: "/getAllUsedTickets.do",
        type: "GET",
        data: { userId: $("#userId").val() },
        dataType: "json",
        success: function(response) {
            if (response.length === 0) {
                $("#fullUsedTicketsList").html("<p style='color: gray;'>사용 완료된 수강권이 없습니다.</p>");
                return;
            }

            let htmlContent = "";
            response.forEach(ticket => {
                htmlContent += "<div class='ticket-card'>";
                htmlContent += "<b>" + ticket.TICKET_NAME + "</b><br>";
                htmlContent += ticket.LOCATION + "<br>";
                htmlContent += "사용기간: " + ticket.START_DATE + " ~ " + ticket.END_DATE + "<br>";

                if (ticket.CANCEL_YN == "WQ==") {
                	console.log(ticket.CANCEL_DATE);
                    htmlContent += "<span style='color: orange;'>(티켓 취소)</span><br>";
                    htmlContent += "<span style='color: gray;'>취소일: " + (ticket.CANCEL_DATE || '-') + "</span>";
                } else {           	
                    htmlContent += "<span style='color: red;'>(사용 완료)</span>";
                }

                htmlContent += "</div>";
            });

            $("#fullUsedTicketsList").html(htmlContent);
        },
        error: function() {
            $("#fullUsedTicketsList").html("<p style='color: red;'>데이터를 불러오는 중 오류가 발생했습니다.</p>");
        }
    });
}


// 사용 완료된 수강권 모달 닫기
function closeUsedTicketsModal() {
    $("#usedTicketsModal").hide();
}


function updateMember() {
    let memberData = {
        userId: $("#userId").val(),
        userName: $("#userName").val(),
        userPhone: $("#userPhone").val(),
        userMail: $("#userMail").val(),
        userBirth: $("#userBirth").val(),
        memo: $("#memo").val(),
        admin_cd: $("#admin_cd").val()
    };

    $.ajax({
        url: "/updateMember.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(memberData),
        success: function(response) {
            alert(response.message);
            location.reload();
        },
        error: function(xhr) {
            console.error("수정 오류:", xhr.responseText);
        }
    });
}

function showTab(tabId) {
    // 모든 탭 내용 숨기기
    document.getElementById("ticketSection").style.display = "none";
    document.getElementById("reservationSection").style.display = "none";

    // 선택한 탭 내용 표시
    document.getElementById(tabId).style.display = "block";

    // 모든 버튼에서 active 클래스 제거
    document.querySelectorAll(".tab-btn").forEach(btn => btn.classList.remove("active"));

    // 클릭된 버튼에 active 클래스 추가
    event.currentTarget.classList.add("active");
}

function openAddTicketModal() {
    $("#addTicketModal").show();
}

function closeAddTicketModal() {
    $("#addTicketModal").hide();
}

function addTicket() {
    let userId = $("#userId").val();
    let ticketName = $("#ticketSelect").val();
    let location = $("#locationSelect").val();
    let startDate = $("#startDate").val();
    let endDate = $("#endDate").val();
    let ticketCount = $("#ticketCount").val();
    let totalPrice = parseInt($("#totalPrice").text()) || 0;
    let cardAmount = parseInt($("#cardAmount").val()) || 0;
    let cashAmount = parseInt($("#cashAmount").val()) || 0;
    let dueAmount = parseInt($("#dueAmount").text()) || 0;
    let userName = $("#userName").val();
    let memo = $("#memoInput").val();

    if (!ticketName || !location || !startDate || !endDate || !ticketCount) {
        alert("모든 필수 값을 입력해야 합니다.");
        return;
    }

    let ticketData = {
        userId: userId,
        userName: userName,
        ticketName: ticketName,
        location: location,
        startDate: startDate,
        endDate: endDate,
        ticketCount: ticketCount,
        cardAmount: cardAmount,
        cashAmount: cashAmount,
        dueAmount: dueAmount,
        memo: memo
    };

    $.ajax({
        url: "/addTicket.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(ticketData),
        success: function(response) {
            alert(response.message);
            window.location.href = window.location.href;
        },
        error: function(xhr) {
            console.error("수강권 추가 오류:", xhr.responseText);
        }
    });
}

function filterReservation() {
    let selectedLocation = document.getElementById("locationFilter").value;
    let startDate = document.getElementById("startDateFilter").value;
    let endDate = document.getElementById("endDateFilter").value;
    let reservations = document.querySelectorAll(".reservation-item");
    let hasVisible = false;

    reservations.forEach(reservation => {
        let location = reservation.getAttribute("data-location");
        let date = reservation.getAttribute("data-date"); // YYYY-MM-DD 형식

        // 필터링 조건 확인
        let locationMatch = (selectedLocation === "전체" || location === selectedLocation);
        let dateMatch = (!startDate || !endDate || (date >= startDate && date <= endDate));

        if (locationMatch && dateMatch) {
            reservation.style.display = "block";
            hasVisible = true;
        } else {
            reservation.style.display = "none";
        }
    });

    // 예약 내역이 없을 경우 메시지 표시
    document.getElementById("noReservationMessage").style.display = hasVisible ? "none" : "block";
}

// ❌ 예약 취소 요청 (AJAX)
function cancelReservation(bookId) {
    if (!confirm("정말로 이 예약을 취소하시겠습니까?")) {
        return;
    }
    let userId = $("#userId").val();

    $.ajax({
        url: "/AdmincancelReservation",
        type: "POST",
        data: { bookId: bookId , userId: userId},
        dataType: "json",
        success: function(response) {
            if (response.success) {
                alert("예약이 성공적으로 취소되었습니다.");
                location.reload();
            } else {
                alert("예약 취소에 실패했습니다.");
            }
        },
        error: function(xhr) {
            console.error("취소 오류:", xhr.responseText);
            alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
        }
    });
}


function openEditTicketModal(ticketId, ticketName, location, startDate, endDate, ticketCount) {
    $("#editTicketId").val(ticketId);
    $("#editTicketName").val(ticketName);
    $("#editLocation").val(location);
    $("#editStartDate").val(startDate);
    $("#editEndDate").val(endDate);
    $("#editTicketCount").val(ticketCount);

    // AJAX 요청: 해당 수강권의 결제 정보 가져오기
    $.ajax({
        url: "/getPaymentInfo.do",
        type: "GET",
        data: { ticketId: ticketId },
        dataType: "json",
        success: function(response) {
            $("#editTotalPrice").text(response.cardAmount+response.cashAmount+response.dueAmount);
            $("#editCardAmount").val(response.cardAmount);
            $("#editCashAmount").val(response.cashAmount);
            $("#editDueAmount").text(response.dueAmount);
            $("#editMemo").val(response.memo || "");
            if (response.PAYMENT_DATE) {
                let originalDate = new Date(response.PAYMENT_DATE);
                originalDate.setDate(originalDate.getDate()); 
                
                let year = originalDate.getFullYear();
                let month = String(originalDate.getMonth() + 1).padStart(2, "0"); 
                let day = String(originalDate.getDate()).padStart(2, "0");

                let formattedDate = year + "-" + month + "-" + day; 
                $("#PaymentDay").val(formattedDate);
            } else {
                $("#PaymentDay").val(""); // 값이 없을 경우 초기화
            }
        },
        error: function(xhr) {
            console.error("결제 정보 로드 오류:", xhr.responseText);
        }
    });

    $("#editTicketModal").show();
}


function closeEditTicketModal() {
    $("#editTicketModal, #modalOverlay").hide();
}

function updateTicket() {
    let ticketData = {
        ticketId: $("#editTicketId").val(),
        startDate: $("#editStartDate").val(),
        endDate: $("#editEndDate").val(),
        ticketCount: $("#editTicketCount").val(),
        cardAmount: $("#editCardAmount").val(),
        cashAmount: $("#editCashAmount").val(),
        dueAmount: $("#editDueAmount").text(),
        memo: $("#editMemo").val(),
        PAYMENT_DATE: $("#PaymentDay").val()
    };

    $.ajax({
        url: "/updateTicketPayment.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(ticketData),
        success: function(response) {
            alert(response.message);
            location.reload();
        }
    });
}

function updateTicketPrice() {
    let selectedOption = $("#ticketSelect option:selected");
    let price = selectedOption.data("price") || 0;
    let location = $("#locationSelect").val();

    if (location === "전지점") {
        price += 30000; // 전지점 선택 시 3만원 추가
    }

    $("#totalPrice").text(price);
    calculateDueAmount();
}

function calculateDueAmount() {
    let totalPrice = parseInt($("#totalPrice").text()) || 0;
    let cardAmount = parseInt($("#cardAmount").val()) || 0;
    let cashAmount = parseInt($("#cashAmount").val()) || 0;
    let dueAmount = totalPrice - (cardAmount + cashAmount);

    if (dueAmount < 0) {
        alert("결제 금액이 총 가격을 초과할 수 없습니다.");
        $("#cardAmount").val(0);
        $("#cashAmount").val(0);
        dueAmount = totalPrice;
    }

    $("#dueAmount").text(dueAmount);
}

//미수금 계산
function calculateEditDueAmount() {
    let totalPrice = parseInt($("#editTotalPrice").text()) || 0;
    let cardAmount = parseInt($("#editCardAmount").val()) || 0;
    let cashAmount = parseInt($("#editCashAmount").val()) || 0;
    let dueAmount = totalPrice - (cardAmount + cashAmount);

    if (dueAmount < 0) {
        alert("결제 금액이 총 가격을 초과할 수 없습니다.");
        $("#editCardAmount").val(0);
        $("#editCashAmount").val(0);
        dueAmount = totalPrice;
    }

    $("#editDueAmount").text(dueAmount);
}

function deleteTicket() {
    let ticketId = $("#editTicketId").val();
    if (confirm("정말 취소하시겠습니까?")) {
        $.ajax({
            url: "/deleteTicket.do",
            type: "POST",
            data: { ticketId: ticketId },
            success: function(response) {
                alert(response.message);
                location.reload();
            }
        });
    }
}
</script>

<script>
document.getElementById("openAddTicketModalBtn").addEventListener("click", function() {
    $("#addTicketModal").show();
});
$("#locationSelect").on("change", updateTicketPrice);
</script>


</body>
</html>
