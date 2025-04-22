<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %> <!-- DB 연결 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <title>📚 수업 목록</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>

<!-- 네비게이션 바 -->
<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>📚 수업 목록</h2>
    <!-- 날짜 선택 필터 -->
    <div class="filter-container">
        <div class="filter-group">
            <label for="startDate" class="filter-label">날짜 선택:</label>
            <input type="date" id="startDate">
            ~
            <input type="date" id="endDate">
        </div>
        <button id="searchBtn" onclick="loadClasses(1)">검색</button>
    </div>

    <!-- 지점 & 강사 선택 필터 -->
    <div class="filter-container">
        <div class="filter-group">
            <label for="location" class="filter-label">지점 선택:</label>
            <select id="location" onchange="loadClasses(1)">
                <option value="all">전체 지점</option>
                <%
                    Statement stmtLocation = conn.createStatement();
                    ResultSet rsLocation = stmtLocation.executeQuery("SELECT LOCATION FROM BARE_LOCATION");
                    while (rsLocation.next()) {
                        String location = rsLocation.getString("LOCATION");
                %>
                    <option value="<%= location %>"><%= location %></option>
                <%
                    }
                    rsLocation.close();
                    stmtLocation.close();
                %>
            </select>
        </div>

        <div class="filter-group">
            <label for="teacher" class="filter-label">강사 선택:</label>
            <select id="teacher" onchange="loadClasses(1)">
                <option value="all">전체 강사</option>
                <%
                    Statement stmtTeacher = conn.createStatement();
                    ResultSet rsTeacher = stmtTeacher.executeQuery("SELECT NAME FROM BARE_TEACHER");
                    while (rsTeacher.next()) {
                        String teacher = rsTeacher.getString("NAME");
                %>
                    <option value="<%= teacher %>"><%= teacher %></option>
                <%
                    }
                    rsTeacher.close();
                    stmtTeacher.close();
                %>
            </select>
        </div>
    </div>
    <button onclick="downloadClassExcel()">📥 엑셀 다운로드</button>


    <!-- 수업 목록 테이블 -->
    <table>
        <thead>
            <tr>
                <th>날짜</th>
                <th>시간</th>
                <th>지점</th>
                <th>수업명</th>
                <th>강사</th>
                <th>예약 인원</th>
                <th>대기 인원</th>
                <th>최대 인원</th>                
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody id="classTable">
            <!-- AJAX로 수업 데이터 로드 -->
        </tbody>
    </table>

    <!-- 페이지네이션 (중앙 정렬) -->
    <div id="pagination"></div>
</div>



<script>
    function loadClasses(page) {
        let startDate = document.getElementById("startDate").value;
        let endDate = document.getElementById("endDate").value;
        let location = document.getElementById("location").value;
        let teacher = document.getElementById("teacher").value;

        $.ajax({
            url: "/getClassList.do",
            type: "GET",
            data: { 
                location: location, 
                teacher: teacher, 
                startDate: startDate, 
                endDate: endDate, 
                page: page 
            },
            dataType: "json",
            success: function(response) {
                console.log("📌 JSON 응답 확인:", response);  // 📌 데이터 확인
                let tableContent = "";

                response.classes.forEach(cls => {
                    console.log(cls);  // 📌 개별 데이터 확인

                    tableContent += "<tr>";
                    tableContent += "<td>" + (cls.DATE || '') + "</td>";
                    tableContent += "<td>" + (cls.TIME || '') + "</td>";
                    tableContent += "<td>" + (cls.LOCATION || '') + "</td>";
                    tableContent += "<td><a href='/admin_class_detail.do?bookId=" + (cls.BOOK_ID || '') + "'>" + (cls.className || '') + "</a></td>";
                    tableContent += "<td>" + (cls.TEACHER || '') + "</td>";
                    tableContent += "<td>" + (cls.PEOPLE || '') + "</td>";
                    tableContent += "<td>" + (cls.waitNumber || '') + "</td>";
                    tableContent += "<td>" + (cls.MAXPEOPLE || '') + "</td>";
                    tableContent += "<td><button onclick='editClass(" + (cls.BOOK_ID || '') + ")'>수정</button></td>";
                    tableContent += "<td><button onclick='deleteClass(" + (cls.BOOK_ID || '') + ")'>삭제</button></td>";
                    tableContent += "</tr>";
                });

                $("#classTable").html(tableContent);
                
                updatePagination(response.totalPages, page);
            },
            error: function(xhr, status, error) {
                console.error("AJAX 오류:", error);
            }
        });


    }

    function updatePagination(totalPages, currentPage) {
        console.log("📌 페이지네이션 업데이트:", totalPages, currentPage); // ✅ 디버깅 로그 추가

        let paginationHtml = "";
        
        if (totalPages < 1) {
            totalPages = 1; // ✅ 최소 1페이지는 유지
        }

        for (let i = 1; i <= totalPages; i++) {
            if (i === currentPage) {
                paginationHtml += "<button onclick='loadClasses(" + i + ")' class='active'>" + i + "</button>";
            } else {
                paginationHtml += "<button onclick='loadClasses(" + i + ")'>" + i + "</button>";
            }
        }

        $("#pagination").html(paginationHtml);
    }


    $(document).ready(function() {
        let today = new Date();
        let year = today.getFullYear();
        let month = today.getMonth() + 1;

        // YYYY-MM-DD 형식으로 변환하는 함수
        function formatDate(date) {
            let d = date.getDate();
            let m = date.getMonth() + 1;
            let y = date.getFullYear();
            return y + '-' + (m < 10 ? '0' + m : m) + '-' + (d < 10 ? '0' + d : d);
        }

        let firstDay = formatDate(new Date(year, month - 1, 1));
        let lastDay = formatDate(new Date(year, month, 0));

        $("#startDate").val(firstDay);
        $("#endDate").val(lastDay);

        loadClasses(1);
    });
    
 // 📌 수업 수정
    function editClass(bookId) {
        window.location.href = "/admin_edit_class.do?bookId=" + bookId;
    }

    // 📌 수업 삭제
    function deleteClass(bookId) {
        if (confirm("해당 수업을 삭제하시겠습니까?")) {
            $.ajax({
                url: "/deleteClass.do",
                type: "POST",
                data: { bookId: bookId },
                success: function(response) {
                    alert("수업이 삭제되었습니다.");
                    loadClasses(1); // ✅ 목록 새로고침
                },
                error: function(xhr, status, error) {
                    console.error("삭제 오류:", error);
                }
            });
        }
    }
    function downloadClassExcel() {
        let startDate = document.getElementById("startDate").value;
        let endDate = document.getElementById("endDate").value;
        let location = document.getElementById("location").value;
        let teacher = document.getElementById("teacher").value;

        let queryParams = "?startDate=" + startDate + "&endDate=" + endDate + "&location=" + location + "&teacher=" + teacher;

        window.location.href = "/downloadClassExcel.do" + queryParams;
    }
</script>

<style>
    .active {
        background-color: #4CAF50;
        color: white;
    }
    /* 필터 컨테이너 (한 줄 정렬) */
	.filter-container {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	    margin-bottom: 10px;
	}
	
	/* 필터 그룹 (날짜, 지점, 강사 선택) */
	.filter-group {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	}
	
	/* 필터 레이블(날짜 선택, 지점 선택, 강사 선택) 크기 조정 */
	.filter-label {
	    font-weight: bold;
	    width: 80px;  /* 일정한 너비를 유지 */
	    text-align: right;
	}
	
	/* 입력 필드 크기 통일 */
	input[type="date"], select {
	    width: 150px;
	    padding: 5px;
	}
	
	/* 검색 버튼 오른쪽 정렬 */
	#searchBtn {
	    flex-shrink: 0;
	    padding: 8px 15px;
	    background-color: #4CAF50;
	    color: white;
	    border: none;
	    cursor: pointer;
	}
	
	/* 검색 버튼 호버 효과 */
	#searchBtn:hover {
	    background-color: #45a049;
	}
	/* 페이지네이션 중앙 정렬 */
	#pagination {
	    display: flex;
	    justify-content: center;
	    margin-top: 20px;
	}
	
	/* 페이지 버튼 스타일 */
	#pagination button {
	    margin: 0 5px;
	    padding: 8px 12px;
	    border: 1px solid #ccc;
	    background-color: white;
	    color: black;
	    cursor: pointer;
	}
	
	#pagination button.active {
	    background-color: #4CAF50;
	    color: white;
	    border: none;
	}	


	    
</style>

</body>
</html>
