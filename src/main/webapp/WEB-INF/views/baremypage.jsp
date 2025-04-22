<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%
    String userName = (String) session.getAttribute("userName");
	String userEmail = (String) session.getAttribute("userEmail");
	String userPhone = (String) session.getAttribute("userPhone");
	String userCash = (String) session.getAttribute("userCash");
	String userBirth = (String) session.getAttribute("userBirth");
	String userOneday = (String) session.getAttribute("userOneday");

	List<Map<String, String>> storeList = (List<Map<String, String>>) session.getAttribute("storeList");
	List<Map<String, String>> ticketList = (List<Map<String, String>>) session.getAttribute("ticketList");
	List<Map<String, String>> userticketList = (List<Map<String, String>>) session.getAttribute("userticketList");
	List<Map<String, String>> userBookList = (List<Map<String, String>>) session.getAttribute("userBookList");
	List<Map<String, String>> userWaitList = (List<Map<String, String>>) session.getAttribute("userWaitList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
     <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
    <style>
    @font-face {
    font-family: 'Cafe24OhsquareAir-v2.0';
    src: url('/fonts/Cafe24OhsquareAir-v2.0.otf') format('opentype');
}
        
        body, html {
        font-family: "Cafe24OhsquareAir-v2.0", sans-serif;
		  font-style: normal;
        }
    .header_menu {
    position: fixed;
    width: 100%;
    background-color: #d43618;
    display: flex;
    align-items: center; /* 로고와 메뉴를 한 줄로 정렬 */
    justify-content: space-between;
    padding: 10px 20px;
    z-index: 1000;
}

/* 📌 로고 스타일 */
.navbar-brand {
    display: flex;
    align-items: center; /* 로고 중앙 정렬 */
}

/* 📌 네비게이션 메뉴 */
.navbar-nav {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
}

.navbar-nav li a {
    font-size: 14px;
    color: white;
    padding: 8px 12px;
}

.navbar-header {
  position: relative;
  left: 35%; /* 네모칸과 화살표 방향으로 로고 이동 */
}

.custom_navbar-brand {
  margin-left: 0; /* 필요하면 이 값을 조정 */
  text-align: left; /* 정렬 */
}
.navbar-right {
  margin-right: -15%; 
}
    body {
        
        background-color: #ffffff; /* 밝은 배경색 */
        color: #000000; /* 검은색 텍스트 */
        text-align: center;
    }

    .navbar-dark {
        background-color: #d43618; /* 상단 네비게이션바 색상 */
    }

    .nav-link {
        color: #ffffff !important;
    }

    .main-container {
    	padding-top: 10%;
        max-width: 800px;
    }

    .card {
        border: 1px solid #ddd; /* 카드 테두리 */
        background-color: #f8f9fa; /* 카드 배경 */
        color: #333; /* 카드 텍스트 색상 */
    }

    .card-header {
        background-color: #4CAF50; /* 카드 헤더 배경 */
        color: #ffffff; /* 카드 헤더 텍스트 색상 */
        font-weight: bold;
    }

    .btn-primary, .btn-danger {
        margin-right: 10px;
    }

    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }

    .btn-danger {
        background-color: #dc3545;
        border-color: #dc3545;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }

    th {
        background-color: #4CAF50;
        color: white;
    }

    td {
        background-color: #ffffff;
        color: white;
    }
    .modal-content {
        background-color: #ffffff; /* 밝은 배경 */
        color: #333333; /* 검정 텍스트 */
        border-radius: 8px; /* 부드러운 모서리 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        padding: 20px;
    }

    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #ddd;
        padding-bottom: 10px;
    }

    .modal-header h5 {
        margin: 0;
        font-size: 1.25em;
        font-weight: bold;
        color: #4CAF50; /* 초록색 강조 */
    }

    .modal-header .btn-close {
        background: none;
        border: none;
        font-size: 1.5em;
        color: #555;
        cursor: pointer;
    }

    .modal-header .btn-close:hover {
        color: #000;
    }

    .modal-body {
        margin-top: 20px;
        line-height: 1.5;
        font-size: 1em;
    }

    .modal-body select,
    .modal-body input[type="checkbox"] {
        margin-bottom: 15px;
    }

    .modal-footer {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }

    .modal-footer .btn {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        font-size: 1em;
        cursor: pointer;
    }

    .modal-footer .btn-secondary {
        background-color: #f8f9fa;
        color: #333;
        border: 1px solid #ddd;
    }

    .modal-footer .btn-secondary:hover {
        background-color: #e2e6ea;
    }

    .modal-footer .btn-primary {
        background-color: #4CAF50;
        color: #fff;
    }

    .modal-footer .btn-primary:hover {
        background-color: #45a049;
    }

    .alert-info {
        background-color: #e9f5ea; /* 연한 초록색 */
        color: #333;
        padding: 15px;
        border-radius: 5px;
        margin-top: 15px;
    }

    .alert-info span {
        font-weight: bold;
    }
	.navbar-header {
	  position: relative;
	  left: 35%; /* 네모칸과 화살표 방향으로 로고 이동 */
	}
	
	.custom_navbar-brand {
	  margin-left: 0; /* 필요하면 이 값을 조정 */
	  text-align: left; /* 정렬 */
	}

    /* 모바일 화면 최적화 */
    @media screen and (max-width: 768px) {
    .navbar-collapse.collapse {
        display: none;
    }

    /* 토글 후 메뉴 보이게 설정 */
    .navbar-collapse.show {
        display: block !important;
    }
    .calendar {
        flex-direction: column;
    }

    .calendar-header {
        flex-direction: column;
        align-items: center;
    }

    .week-days {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 10px;
        margin-top: 10px;
    }

    .week-day {
        font-size: 14px;
        padding: 8px;
    }

    table {
        font-size: 12px;
    }

    th, td {
        padding: 8px;
    }

    .modal-content {
        width: 90%;
        font-size: 14px;
    }

    .modal-content h2 {
        font-size: 16px;
    }

    .calendar-header button {
        width: 100%;
        margin: 5px 0;
    }

    .today-button {
        width: 100%;
        margin-top: 5px;
    }
    .modal-container {
        flex-direction: column;
        gap: 15px;
    }

    .modal-left, .modal-right {
        flex: 1 1 100%;
    }

    .modal-buttons {
        flex-direction: column;
    }

    .modal-buttons .btn-experience,
    .modal-buttons .btn-enroll {
        width: 100%;
    }
    .navbar-header {
	  position: relative;
	  left:17%;
	}
	.navbar-right {
	  margin-right: 0%; 
	}

    .header_menu {
        height: 60px; /* 모바일에서 헤더 높이 줄이기 */
        padding: 5px 15px;
    }

    .navbar-brand img {
        max-width: 200px; /* 모바일에서 로고 크기 증가 */
        height: auto;
    }
     .navbar-toggler {
        z-index: 1050;
        background-color: transparent;
        border: none;
        font-size: 24px;
        color: white;
    }

    .navbar-collapse {
        position: absolute;
        top: 60px;
        left: 0;
        width: 100%;
        background-color: #e94560;
        padding: 10px;
        display: none; /* 기본적으로 숨김 */
    }

    .navbar-nav {
        flex-direction: column; /* 세로 정렬 */
        align-items: flex-start;
    }

    .navbar-nav li {
        width: 100%;
    }

    .navbar-nav li a {
        font-size: 14px;
        padding: 10px;
        display: block;
    }
    	.custom_navbar-brand {
		  margin-left: 0; /* 필요하면 이 값을 조정 */
		  text-align: left; /* 정렬 */
		}
        .main-container {
            padding-top: 20%;
        }

        h1 {
            font-size: 1.5em;
        }

        .card {
            margin-bottom: 20px;
        }

        .card-header {
            font-size: 1em;
            text-align: center;
        }

        .card-body p {
            font-size: 0.9em;
        }

        .btn-primary, .btn-danger {
            width: 100%;
            margin: 5px 0;
        }

        table {
            font-size: 0.8em;
        }

        table thead {
            font-size: 0.9em;
        }

        table td, table th {
            padding: 8px;
        }
    }
</style>
            <!-- 토스 결제 sdk -->
        <script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body style="background-color: #1f1f1f; color: white;">
<!-- Header Navigation -->
<section id="header">
            <div class="header-area">
			<div class="header_menu text-center" data-spy="affix" data-offset-top="50" id="nav">
                    <div class="container">
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container-fluid">
        <a class="navbar-brand custom_navbar-brand" href="/everybare.do">
            <img src="/static_uploads/img/logo.png" alt="EveryBare">
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/everybare.do#header">Home</a>
                </li>
                <li class="nav-item">
                    <% if (userName != null) { %>
                        <!-- 로그인 상태 -->
                        <a class="nav-link active" href="/mypage.do">My Page</a>
                        <form action="/logout.do" method="post" class="d-inline">
                        </form>
                    <% } else { %>
                        <!-- 비로그인 상태 -->
                        <a class="nav-link" href="/barelogin.do">Login</a>
                    <% } %>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/everybare.do#contact_us">Contact Us</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
 </div>
                    <!--End of container-->
                </div></div></section>
<!-- Main Container -->
<div class="container main-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>My Page</h1>
        <a class="btn btn-danger btn-logout" href="/logout.do">Logout</a>
    </div>
    
    <!-- 1. Personal Information -->
    <div class="card mb-4">
        <div class="card-header">내 정보</div>
        <div class="card-body">
            <p><strong>Name:</strong> ${userName}</p>
            <p><strong>Email:</strong> ${userEmail}</p>
            <p><strong>Phone:</strong> ${userPhone}</p>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateInfoModal">수정하기</button>
        </div>
        
        <!-- 회원정보 수정 모달 -->
		<div class="modal fade" id="updateInfoModal" tabindex="-1" aria-labelledby="updateInfoModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="updateInfoModalLabel">회원정보 수정</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
		      </div>
		      <div class="modal-body">
		        <form id="updateInfoForm">
		          <div class="mb-3">
		            <label for="updateName" class="form-label">이름</label>
		            <input type="text" class="form-control" id="updateName" value="<%= userName %>" required>
		          </div>
		          <div class="mb-3">
		            <label for="updateEmail" class="form-label">이메일</label>
		            <input type="email" class="form-control" id="updateEmail" value="<%= userEmail %>" readonly>
		            <div id="emailCheckMessage" class="text-danger"></div>
		          </div>
		          <div class="mb-3">
		            <label for="updatePassword" class="form-label">비밀번호</label>
		            <input type="password" class="form-control" id="updatePassword" placeholder="8자리이상">
		          </div>
		          <div class="mb-3">
		            <label for="updatePasswordConfirm" class="form-label">비밀번호 확인</label>
		            <input type="password" class="form-control" id="updatePasswordConfirm">
		            <div id="passwordMatchMessage" class="text-danger"></div>
		          </div>
		          <div class="mb-3">
		            <label for="updateBirth" class="form-label">생년월일</label>
		            <input type="text" class="form-control" id="updateBirth" value="<%= userBirth %>" placeholder="YYMMDD">
		          </div>
		          <div class="mb-3">
		            <label for="updatePhone" class="form-label">휴대폰 번호</label>
		            <input type="text" class="form-control" id="updatePhone" value="<%= userPhone %>" placeholder="01012345678">
		          </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		        <button type="button" class="btn btn-primary" id="updateInfoButton">수정하기</button>
		      </div>
		    </div>
		  </div>
		</div>
    </div>
    
    <!-- 2. Remaining Cash -->
    <div class="card mb-4">
        <div class="card-header">횟수권 관리</div>
        <div class="card-body">
            <p><strong>횟수권 정보</strong></p>
            <hr>
            <% if (userticketList == null || userticketList.isEmpty()) { %>
			    <p>횟수권이 존재하지 않습니다. 아래 버튼을 통해 구매하세요.</p>			  
			<% } else { %>
            <ul>
             <% for (Map<String, String> userticket : userticketList) {
                	String location = userticket.get("LOCATION");
                	String start = userticket.get("START_DATE");
                	String end = userticket.get("END_DATE"); 
                	String name = userticket.get("TICKET_NAME");
                	String count = userticket.get("TICKET_COUNT");
                %>
                 <li>
			        <p><strong>지점:</strong> <%= location %></p>
			        <p><strong>기간:</strong> <%= start %> ~ <%= end %></p>
			        <p><strong>티켓 이름:</strong> <%= name %></p>
			        <p><strong>남은 횟수:</strong> <%= count %>회</p>
			        <hr>
			    </li>
                 <%} %>
            </ul>
            <%} %>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#cashPurchaseModal">
			    횟수권 구매하기
			</button>
        </div>
    </div>
    
    <!-- 3. Current Reservations -->
<div class="card mb-4">
    <div class="card-header">예약정보</div>
    <div class="card-body">
        <% if (userBookList == null || userBookList.isEmpty()) { %>
            <p>현재 예약된 클래스가 없습니다.</p>
        <% } else { %>
            <table class="table table-dark">
                <thead>
                    <tr>
                        <th>Class</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Location</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, String> reservation : userBookList) { 
                        String className = reservation.get("CLASS");
                        String date = reservation.get("DATE");
                        String time = reservation.get("TIME");
                        String location = reservation.get("LOCATION");
                    %>
                    <tr class="reservation-row" data-book-id="<%= String.valueOf(reservation.get("BOOK_ID")) %>">
                        <td class="class-name"><%= className %></td>
                        <td class="date"><%= date %></td>
                        <td class="time"><%= time %></td>
                        <td class="location"><%= location %></td>
                        <td>
                            <button class="btn btn-danger btn-sm cancel-btn">Cancel</button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>
</div>

    
    
    <div class="card mb-4">
        <div class="card-header">대기정보</div>
        <div class="card-body">
                    <% if (userWaitList == null || userWaitList.isEmpty()) { %>
            <p>현재 대기중인 클래스가 없습니다.</p>
        <% } else { %>
                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Class</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Location</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Map<String, String> reservation : userWaitList) { 
                        String className = reservation.get("CLASS");
                        String date = reservation.get("DATE");
                        String time = reservation.get("TIME");
                        String location = reservation.get("LOCATION");
                    %>
                    <tr class="reservation-row" data-wait-id="<%= String.valueOf(reservation.get("WAIT_ID")) %>" data-book-id="<%= String.valueOf(reservation.get("BOOK_ID")) %>">
                        <td class="class-name"><%= className %></td>
                        <td class="date"><%= date %></td>
                        <td class="time"><%= time %></td>
                        <td class="location"><%= location %></td>
                        <td>
                            <button class="btn btn-danger btn-sm wait-cancel-btn">Cancel</button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            <%} %>
        </div>
    </div>
    
 <!-- 4. Past Usage Records 
    <div class="card mb-4">
        <div class="card-header">결제내역</div>
        <div class="card-body">
            <c:if test="${not empty PAYMENT_HISTORY}">
                <table class="table table-dark table-striped">
                    <thead>
                    <tr>
                        <th>Date</th>
                        <th>Amount</th>
                        <th>Method</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="payment" items="${PAYMENT_HISTORY}">
                        <tr>
                            <td>${payment.date}</td>
                            <td>${payment.amount}</td>
                            <td>${payment.method}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty PAYMENT_HISTORY}">
                <p>결제내역이 없습니다.</p>
            </c:if>
        </div>
    </div>-->

</div>

<!-- 횟수권 구매 모달창 -->
<div class="modal fade" id="cashPurchaseModal" tabindex="-1" aria-labelledby="cashPurchaseModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    <div class="modal-header">
        <h5 class="modal-title" id="cashPurchaseModalLabel">횟수권 구매</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">&times;</button>
    </div>
    <div class="modal-body">
        <form id="cashPurchaseForm">
            <div class="mb-3">
                <label for="cashOption" class="form-label">구매할 횟수권을 선택하세요:</label>
                <select class="form-select" id="cashOption" name="cashOption">
                <% for (Map<String, String> ticket : ticketList) {
                	String name = ticket.get("NAME");
                	String price = ticket.get("PRICE");
                	String count = ticket.get("TICKET"); 
                %>
                    <option value="<%= count %>"><%= name %> - <%= price %>원</option>
                    <%} %>
                </select>
            </div>
            <div class="mb-3">
                <label for="branchOption" class="form-label">이용하실 지점을 선택해주세요:</label>
                <select class="form-select" id="branchOption" name="branchOption">
                <% for (Map<String, String> store : storeList) {
                	String name = store.get("LOCATION");                	
                %>
                    <option value="<%= name %>"><%= name %></option>
                    <%} %>
                </select>
            </div>
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="multiBranchOption" name="multiBranchOption">
                <label class="form-check-label" for="multiBranchOption">
                    다른 지점도 이용할 수 있도록 추가 (+30,000원)
                </label>
            </div>
        </form>
        <div id="purchaseSummary" class="alert alert-info" role="alert">
            <p>선택한 횟수권: <span id="selectedCash">1회체험권 (계정당한번만 가능)</span></p>
            <p>선택한 지점: <span id="selectedBranch">강남점</span></p>
            <p>추가 옵션: <span id="multiBranchSummary">없음</span></p>
            <p>결제 금액: <span id="selectedPrice" value="33000">33,000원</span></p>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="payment-button">구매하기</button>
    </div>
</div>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/jquery-1.12.3.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const cashOption = document.getElementById("cashOption");
    const branchOption = document.getElementById("branchOption");
    const multiBranchOption = document.getElementById("multiBranchOption");
    const selectedCash = document.getElementById("selectedCash");
    const selectedBranch = document.getElementById("selectedBranch");
    const multiBranchSummary = document.getElementById("multiBranchSummary");
    const selectedPrice = document.getElementById("selectedPrice");
    const paymentButton = document.getElementById("payment-button");

    // 횟수권 가격 매핑
    const cashPrices = {
        "1": 33000,
        "10": 370000,
        "20": 680000,
        "40": 1200000,
        "99": 430000
    };

    let totalPrice = 0;

    // 선택한 횟수권 및 지점 정보 표시
    function updateSummary() {
        const selectedOption = cashOption.value;
        const selectedBranchValue = branchOption.value;
        const multiBranchChecked = multiBranchOption.checked;

        const basePrice = cashPrices[selectedOption] || 0;
        const extraCharge = multiBranchChecked ? 30000 : 0;

        totalPrice = basePrice + extraCharge;

        selectedCash.innerText = cashOption.options[cashOption.selectedIndex].text;
        selectedBranch.innerText = selectedBranchValue;
        multiBranchSummary.innerText = multiBranchChecked ? "+30,000원 (다른 지점 이용 가능)" : "없음";
        selectedPrice.innerText = totalPrice.toLocaleString() + "원";
        $("#selectedPrice").val(totalPrice);
        
    }

    // 이벤트 리스너 추가
    cashOption.addEventListener("change", updateSummary);
    branchOption.addEventListener("change", updateSummary);
    multiBranchOption.addEventListener("change", updateSummary);

    // 초기 설정
    updateSummary();

 	// 결제 UI 알럿 띄우기
    paymentButton.addEventListener("click", () => {
        updateSummary(); // 가격 업데이트

     // 전달할 데이터 준비
        const orderName = encodeURIComponent(cashOption.options[cashOption.selectedIndex].text);
        const value = encodeURIComponent(totalPrice);
        const customerEmail = "<%=userEmail%>";
        const customerName = "<%=userName%>";
        const customerMobilePhone = "<%=userPhone%>";
        const email = encodeURIComponent(customerEmail);
        const name = encodeURIComponent(customerName);
        const phone = encodeURIComponent(customerMobilePhone);
        const place = encodeURIComponent(selectedBranch.innerText);
        
        
        if("<%=userOneday%>" > 0 && cashOption.options[cashOption.selectedIndex].text == "1회체험권 (계정당한번만 가능) - 35,000원"){
        	alert("체험권은 한번만 사용가능합니다. 1회권 사용 바랍니다.");
    	    return;
        }

        // checkout.jsp 팝업 호출
        const popupUrl = "checkout.do?orderName="+orderName+"&value="+value+"&customerEmail="+email+"&customerName="+name+"&customerMobilePhone="+phone+"&Place="+place;

        
        window.open(popupUrl, 'checkoutPopup', 'width=600,height=700,scrollbars=yes');
        
    });
});

//팝업 창에서 메시지를 받는 리스너
window.addEventListener("message", function (event) {
    // 보안 검증: event.origin 확인
    if (event.origin !== window.location.origin) {
        console.warn("허용되지 않은 출처에서 메시지를 받았습니다.");
        return;
    }

    const { status, message } = event.data;

    if (status === "success") {
        
        
        const cashOption = document.getElementById("cashOption").value;
        const branchOption = document.getElementById("branchOption").value;
        const multiBranchOption = document.getElementById("multiBranchOption").checked;
        const ticketname = document.getElementById("cashOption").options[document.getElementById("cashOption").selectedIndex].text;
        const username = "<%=userName%>";
        const price = $("#selectedPrice").val();
        
        
        
        
        var sendData = {USER_NAME:username,LOCATION:branchOption,TICKET_NAME:ticketname,TICKET_COUNT:cashOption,UNLIMITED:multiBranchOption,cardAmount:price};
		
		 $.ajax({
			type:"post",
			url:"/ticketsave",
			data:sendData,
			dataType:"",
			success: function(data){
				console.log("완료");
				if(data.result == "success"){
					alert(message); // 구매 완료 알림
					// 페이지 이동
			        window.location.href = "/everybare.do";
				}else{
					alert("데이터저장오류발생 관리자에게 문의하세요.");
				}
				

			}
		});
		 
        
    }
});

document.getElementById("updateInfoButton").addEventListener("click", function () {
	  const name = document.getElementById("updateName").value.trim();
	  const email = document.getElementById("updateEmail").value.trim();
	  const password = document.getElementById("updatePassword").value.trim();
	  const passwordConfirm = document.getElementById("updatePasswordConfirm").value.trim();
	  const birth = document.getElementById("updateBirth").value.trim();
	  const phone = document.getElementById("updatePhone").value.trim();
	  const passwordMatchMessage = document.getElementById("passwordMatchMessage");

	  // 유효성 검사
	  if (!name || !email || !phone || !birth || !password || !passwordConfirm) {
	    alert("모든 필수 항목을 입력하세요.");
	    return;
	  }

	  const birthRegex = /^\d{6}$/; // YYYYMMDD 형식
	  const phoneRegex = /^\d{10,11}$/; // 전화번호 형식

	  if (password.value && password.value.length < 8) {
		  alert("비밀번호는 8자리 이상이어야 합니다.");
	      return;
	    } 

	  if (!birthRegex.test(birth)) {
	    alert("생년월일은 YYMMDD 형식이어야 합니다.");
	    return;
	  }

	  if (!phoneRegex.test(phone)) {
	    alert("휴대폰 번호는 10~11자리 숫자여야 합니다.");
	    return;
	  }

	  // 비밀번호와 비밀번호 확인이 일치하는지 확인
	  if (password !== passwordConfirm) {
	    passwordMatchMessage.textContent = "비밀번호가 일치하지 않습니다.";
	    passwordMatchMessage.style.color = "red";
	    return;
	  } else {
	    passwordMatchMessage.textContent = "";
	  }

	  const updateData = {
	    userName: name,
	    userEmail: email,
	    userPassword: password,
	    userBirth: birth,
	    userPhone: phone,
	  };

	  // AJAX로 수정 요청 보내기
	  $.ajax({
	    type: "post",
	    url: "/updateUserInfo",
	    data: updateData,
	    dataType: "json",
	    success: function (response) {
	      if (response.success) {
	        alert("회원정보가 성공적으로 수정되었습니다.");
	        window.location.href = "/logout.do";	      
	      } else {
	        alert(response.message || "회원정보 수정에 실패했습니다.");
	      }
	    },
	    error: function () {
	      alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
	    },
	  });
	});
	
$(document).ready(function() {
    $(".cancel-btn").on("click", function() {
        var row = $(this).closest("tr"); // 클릭된 버튼이 속한 <tr> 가져오기
        var className = row.find(".class-name").text().trim();
        var date = row.find(".date").text().trim();
        var time = row.find(".time").text().trim();
        var location = row.find(".location").text().trim();
        var bookId = row.data("book-id");  
        
        // 📌 현재 시간과 예약 시간을 비교하여 12시간 이내인지 확인
        var now = new Date(); // 현재 시간
        var reservationDateTime = new Date(date + " " + time); // 예약 시간

        // 12시간(밀리초 단위: 12시간 * 60분 * 60초 * 1000밀리초)
        var twelveHoursInMillis = 12 * 60 * 60 * 1000;
        
        if (reservationDateTime - now <= twelveHoursInMillis) {
            alert("예약 취소는 클래스 시작 12시간 전까지만 가능합니다.");
            return; // ✅ 취소 요청을 보내지 않음
        }
        

        if (!confirm("정말로 이 예약을 취소하시겠습니까?\n" +
                     "클래스: " + className + "\n" +
                     "날짜: " + date + "\n" +
                     "시간: " + time + "\n" +
                     "지점: " + location)) {
            return;
        }

        $.ajax({
            type: "POST",
            url: "/cancelReservation",
            data: {
                CLASS: className,
                DATE: date,
                TIME: time,
                LOCATION: location,
                BOOKID: bookId
            },
            dataType: "json",
            success: function(response) {
                if (response.success) {
                    alert("예약이 성공적으로 취소되었습니다.");
                    window.location.href = "/mypage.do";
                } else {
                    alert("예약 취소에 실패했습니다. 다시 시도해 주세요.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
            }
        });
    });
    $(".wait-cancel-btn").on("click", function() {
        var row = $(this).closest("tr"); // 클릭된 버튼이 속한 <tr> 가져오기
        var className = row.find(".class-name").text().trim();
        var date = row.find(".date").text().trim();
        var time = row.find(".time").text().trim();
        var location = row.find(".location").text().trim();
        var waitId = row.data("wait-id");      
        var bookId = row.data("book-id");  
        

        if (!confirm("정말로 이 대기내역을 취소하시겠습니까?\n" +
                     "클래스: " + className + "\n" +
                     "날짜: " + date + "\n" +
                     "시간: " + time + "\n" +
                     "지점: " + location)) {
            return;
        }

        $.ajax({
            type: "POST",
            url: "/cancelWaitReservation",
            data: {
                CLASS: className,
                DATE: date,
                TIME: time,
                LOCATION: location,
                WAITID: waitId,
                bookId: bookId
            },
            dataType: "json",
            success: function(response) {
                if (response.success) {
                    alert("대기내역이 취소되었습니다.");
                    window.location.href = "/mypage.do";
                } else {
                    alert("대기 취소에 실패했습니다. 다시 시도해 주세요.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
            }
        });
    });
});
</script>
</body>
</html>
