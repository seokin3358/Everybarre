<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %> <!-- DB 연결 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <title>📅 일정 관리</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    
    .day-cell {
    width: 36px;
    height: 36px;
    display: inline-block;
    line-height: 34px;
    text-align: center;
    border-radius: 50%;
    transition: all 0.2s ease-in-out;
}

.day-cell.selected {
    background-color: #e94560;
    color: white;
    font-weight: bold;
}
    </style>
</head>
<body>

<!-- 네비게이션 바 -->
<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>📅 일정 관리</h2>

    <!-- 지점 선택 -->
    <label for="location">지점 선택:</label>
    <select id="location" onchange="loadSchedule()">
        <option value="all">전체 지점</option>
        <%
            Statement stmt = null;
            ResultSet rs = null;
            try {
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT LOCATION FROM BARE_LOCATION");
                while (rs.next()) {
                    String location = rs.getString("LOCATION");
        %>
                    <option value="<%= location %>"><%= location %></option>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        %>
    </select>
    <!-- 강사 선택 -->
	<label for="teacher">강사 선택:</label>
	<select id="teacher" onchange="loadSchedule()">
	    <option value="all">전체 강사</option>
	    <%
	        Statement stmtTeacher = null;
	        ResultSet rsTeacher = null;
	        try {
	            stmtTeacher = conn.createStatement();
	            rsTeacher = stmtTeacher.executeQuery("SELECT NAME FROM BARE_TEACHER");
	            while (rsTeacher.next()) {
	                String teacherName = rsTeacher.getString("NAME");
	    %>
	                <option value="<%= teacherName %>"><%= teacherName %></option>
	    <%
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (rsTeacher != null) try { rsTeacher.close(); } catch (Exception e) { e.printStackTrace(); }
	            if (stmtTeacher != null) try { stmtTeacher.close(); } catch (Exception e) { e.printStackTrace(); }
	        }
	    %>
	</select>
	    

    <!-- 달력 -->
    <%
    Calendar today = Calendar.getInstance();
    int todayYear = today.get(Calendar.YEAR);
    int todayMonth = today.get(Calendar.MONTH) + 1;
    int todayDay = today.get(Calendar.DAY_OF_MONTH);
	%>
    <div id="calendar">
        <table>
            <thead>
                <tr>
                    <th onclick="prevMonth()">&lt;</th>
                    <th colspan="5" id="currentMonth"></th>
                    <th onclick="nextMonth()">&gt;</th>
                </tr>
                <tr>
                    <th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
                </tr>
            </thead>
            <tbody id="calendar-body">
                <!-- 일정이 여기에 추가됨 -->
            </tbody>
        </table>
    </div>

    <!-- 일정 목록 테이블 -->
    <div id="scheduleList">
    <div style="margin-top: 10px; font-weight: bold;">
    선택된 날짜: <span id="selectedDateDisplay">-</span>
	</div>
    
        <h3>📅 일정 목록</h3>
        <table>
            <thead>
                <tr>
                    <th>날짜</th>
                    <th>시간</th>
                    <th>지점</th>
                    <th>수업명</th>
                    <th>강사</th>
                    <th>수강 인원</th>
                    <th>대기 인원</th>                    
                </tr>
            </thead>
            <tbody id="scheduleTable">
                <!-- AJAX로 일정 데이터 로드 -->
            </tbody>
        </table>
    </div>

    <!-- 일정 추가 버튼 -->
    <%
	    Object adminCdObj2 = session.getAttribute("ADMIN_CD");
	    int adminCd2 = 0;
	    if (adminCdObj2 != null) {
	        try {
	            adminCd2 = Integer.parseInt(adminCdObj2.toString());
	        } catch (NumberFormatException e) {
	            adminCd2 = 0;
	        }
	    }
	
	    if (adminCd2 == 2 || adminCd2 == 3) {
	%>
	    <!-- ✅ 조건에 따라 수업 추가 버튼 표시 -->
	    <button id="addSchedule" onclick="window.location.href='admin_create_class.do'">+ 수업 추가</button>
	<%
	    }
	%>
</div>

<script>
    let currentDate = new Date();
    let selectedDay = null;
    // 페이지 로드 시 달력 & 일정 로드
    $(document).ready(function() {
        loadCalendar();
        loadSchedule(currentDate.getDate());
    });

    function loadCalendar() {
        const monthNames = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
        document.getElementById("currentMonth").innerText =
            currentDate.getFullYear() + "년 " + monthNames[currentDate.getMonth()];

        let firstDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1).getDay();
        let lastDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 0).getDate();
        let calendarBody = document.getElementById("calendar-body");
        calendarBody.innerHTML = "";

        let row = document.createElement("tr");
        for (let i = 0; i < firstDay; i++) {
            row.appendChild(document.createElement("td"));
        }

        for (let day = 1; day <= lastDate; day++) {
            let cell = document.createElement("td");

            // ✅ 선택된 날짜에는 클래스 추가
            let classes = "day-cell";
            if (selectedDay === day) classes += " selected";

            cell.innerHTML = "<div class='" + classes + "'>" + day + "</div>";

            // ✅ 클릭 이벤트 처리
            cell.onclick = function () {
			    selectedDay = day;
			
			    // ✅ 선택된 날짜 표시 업데이트
			    let year = currentDate.getFullYear();
			    let month = currentDate.getMonth() + 1;
			    document.getElementById("selectedDateDisplay").innerText =
			        year + "년 " + month + "월 " + selectedDay + "일";
			
			    loadSchedule(day);   // 기존 일정 불러오기
			    loadCalendar();      // 다시 그려서 선택 반영
			};

            row.appendChild(cell);

            if ((firstDay + day) % 7 === 0) {
                calendarBody.appendChild(row);
                row = document.createElement("tr");
            }
        }

        calendarBody.appendChild(row);
    }



    function prevMonth() {
        currentDate.setMonth(currentDate.getMonth() - 1);
        loadCalendar();
        loadSchedule();
    }

    function nextMonth() {
        currentDate.setMonth(currentDate.getMonth() + 1);
        loadCalendar();
        loadSchedule();
    }

    function loadSchedule(day = null) {
        let location = document.getElementById("location").value;
        let teacher = document.getElementById("teacher").value;
        let year = currentDate.getFullYear();
        let month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
        if (day) day = day.toString().padStart(2, '0');

        $.ajax({
            url: "/getSchedule.do",  // 변경된 URL (Controller에서 처리)
            type: "GET",
            data: { location: location, teacher: teacher, year: year, month: month, day: day },
            dataType: "json",
            success: function(response) {
                let tableContent = "";
                response.forEach(schedule => {
                	 tableContent += '<tr onclick="goToClassDetail('+schedule.BOOK_ID+')" >';
                     tableContent += '<td>'+schedule.DATE+'</td>';
                     tableContent += '<td>'+schedule.TIME+'</td>';
                     tableContent += '<td>'+schedule.LOCATION+'</td>';
                     tableContent += '<td>'+schedule.className+'</td>';
                     tableContent += '<td>'+schedule.TEACHER+'</td>';
                     tableContent += '<td>'+schedule.PEOPLE+' / '+schedule.MAXPEOPLE+'</td>';
                     tableContent += '<td>'+schedule.waitNumber+'</td>';
                     tableContent += '</tr>';
                });
                $("#scheduleTable").html(tableContent);
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 오류:", error);
            }
        });
    }
 // 강좌 상세 페이지 이동
    function goToClassDetail(bookId) {
        window.location.href = '/admin_class_detail.do?bookId='+bookId;
    }


</script>

</body>
</html>
