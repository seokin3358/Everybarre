<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>📍 지점 관리</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .container { margin: auto; padding: 20px; }
        .section { margin-bottom: 20px; padding: 15px; background: #f9f9f9; border-radius: 5px; }
        .table-container { overflow-x: auto; }
		table {
		    width: 100%;
		    border-collapse: collapse;
		    table-layout: fixed; /* 📌 열 너비를 고정 */
		}
		
		th, td {
		    padding: 10px;
		    text-align: center;
		    border: 1px solid #ddd;
		    white-space: nowrap; /* 📌 자동 줄바꿈 방지 */
		    overflow: hidden;
		    text-overflow: ellipsis; /* 📌 글자 길면 "..." 표시 */
		}
        th { background-color: #f1f1f1; }
        .btn { padding: 5px 10px; border: none; cursor: pointer; border-radius: 3px; }
        .edit-btn { background-color: #ffc107; color: #333; }
        .delete-btn { background-color: #dc3545; color: white; }
        .add-btn { background-color: #28a745; color: white; margin-top: 10px; }
        .modal { display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%);
                 background: white; padding: 20px; border-radius: 5px; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); }
        th:nth-child(1) { width: 10%; } /* 지점명 */
		th:nth-child(2) { width: 25%; } /* 주소 */
		th:nth-child(3) { width: 15%; } /* 인스타그램 */
		th:nth-child(4) { width: 15%; } /* 장소명 */
		th:nth-child(5) { width: 10%; } /* 인스타 링크 */
		th:nth-child(6) { width: 10%; } /* 네이버 링크 */
		th:nth-child(7), th:nth-child(8) { width: 7%; } /* 수정, 삭제 버튼 */
		
		button {
		    padding: 5px 10px;
		    font-size: 14px;
		}
    </style>
</head>
<body>

<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>📍 지점 관리</h2>

    <!-- 지점 목록 테이블 -->
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>지점명</th>
                    <th>주소</th>
                    <th>인스타그램</th>
                    <th>장소명</th>
                    <th>인스타 링크</th>
                    <th>네이버 링크</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
            </thead>
            <tbody id="locationTable">
                <%
                    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM BARE_LOCATION ORDER BY LOCATION");
                    ResultSet rs = pstmt.executeQuery();
                    while (rs.next()) {
                %>
                    <tr>
                        <td><%= rs.getString("LOCATION") %></td>
                        <td><%= rs.getString("ADDRESS") %></td>
                        <td><%= rs.getString("INSTAGRAM") %></td>
                        <td><%= rs.getString("PLACE") %></td>
                        <td><a href="<%= rs.getString("INSTA_LINK") %>" target="_blank">📷 보기</a></td>
                        <td><a href="<%= rs.getString("NAVER_LINK") %>" target="_blank">📍 보기</a></td>
                        <td><button class="btn edit-btn" onclick="openEditModal('<%= rs.getString("LOCATION") %>', '<%= rs.getString("ADDRESS") %>', '<%= rs.getString("INSTAGRAM") %>', '<%= rs.getString("PLACE") %>', '<%= rs.getString("INSTA_LINK") %>', '<%= rs.getString("NAVER_LINK") %>','<%= rs.getString("CLIENT_KEY") %>','<%= rs.getString("SECRET_KEY") %>')">수정</button></td>
                        <td><button class="btn delete-btn" onclick="deleteLocation('<%= rs.getString("LOCATION") %>')">삭제</button></td>
                    </tr>
                <%
                    }
                    rs.close();
                    pstmt.close();
                %>
            </tbody>
        </table>
    </div>

    <!-- 추가 버튼 -->
    <button class="btn add-btn" onclick="openAddModal()">+ 지점 추가</button>
</div>

<!-- 지점 추가 모달 -->
<div id="addLocationModal" class="modal">
    <h3>📍 지점 추가</h3>
    <label>지점명:</label> <input type="text" id="newLocation"><br>
    <label>주소:</label> <input type="text" id="newAddress"><br>
    <label>인스타그램:</label> <input type="text" id="newInstagram"><br>
    <label>장소명:</label> <input type="text" id="newPlace"><br>
    <label>인스타 링크:</label> <input type="text" id="newInstaLink"><br>
    <label>네이버 링크:</label> <input type="text" id="newNaverLink"><br>
    <label>클라이언트 키:</label> <input type="text" id="newCLIENTKEY"><br>
    <label>시크릿 키:</label> <input type="text" id="newSECRETKEY"><br>
    <button onclick="addLocation()">추가</button>
    <button onclick="closeAddModal()">닫기</button>
</div>

<!-- 지점 수정 모달 -->
<div id="editLocationModal" class="modal">
    <h3>📍 지점 수정</h3>
    <input type="hidden" id="editOriginalLocation">
    <label>지점명:</label> <input type="text" id="editLocation"><br>
    <label>주소:</label> <input type="text" id="editAddress"><br>
    <label>인스타그램:</label> <input type="text" id="editInstagram"><br>
    <label>장소명:</label> <input type="text" id="editPlace"><br>
    <label>인스타 링크:</label> <input type="text" id="editInstaLink"><br>
    <label>네이버 링크:</label> <input type="text" id="editNaverLink"><br>
    <label>클라이언트 키:</label> <input type="text" id="editCLIENTKEY"><br>
    <label>시크릿 키:</label> <input type="text" id="editSECRETKEY"><br>
    <button onclick="updateLocation()">수정</button>
    <button onclick="closeEditModal()">닫기</button>
</div>

<script>
function openAddModal() {
    $("#addLocationModal").show();
}

function closeAddModal() {
    $("#addLocationModal").hide();
}

function openEditModal(location, address, instagram, place, instaLink, naverLink, clientKey, secretKey) {
    $("#editOriginalLocation").val(location);
    $("#editLocation").val(location);
    $("#editAddress").val(address);
    $("#editInstagram").val(instagram);
    $("#editPlace").val(place);
    $("#editInstaLink").val(instaLink);
    $("#editNaverLink").val(naverLink);
    $("#editCLIENTKEY").val(clientKey);
    $("#editSECRETKEY").val(secretKey);
    $("#editLocationModal").show();
}

function closeEditModal() {
    $("#editLocationModal").hide();
}

function addLocation() {
    let locationData = {
        location: $("#newLocation").val(),
        address: $("#newAddress").val(),
        instagram: $("#newInstagram").val(),
        place: $("#newPlace").val(),
        instaLink: $("#newInstaLink").val(),
        naverLink: $("#newNaverLink").val(),
        clientKey: $("#newCLIENTKEY").val(),
        secretKey: $("#newSECRETKEY").val()
    };
    
    if (!$("#newLocation").val() || !$("#newAddress").val() || !$("#newInstagram").val() || !$("#newPlace").val() || !$("#newInstaLink").val() || !$("#newNaverLink").val() || !$("#newCLIENTKEY").val() || !$("#newSECRETKEY").val()) {
    	console.log(locationData);
        alert("⚠️ 모든 항목을 입력해야 합니다.");
        return;
    }

    $.ajax({
        url: "/addLocation.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(locationData),
        success: function(response) {
            alert(response.message);
            location.reload();
        }
    });
}

function updateLocation() {
    let locationData = {
        originalLocation: $("#editOriginalLocation").val(),
        location: $("#editLocation").val(),
        address: $("#editAddress").val(),
        instagram: $("#editInstagram").val(),
        place: $("#editPlace").val(),
        instaLink: $("#editInstaLink").val(),
        naverLink: $("#editNaverLink").val(),
        clientKey: $("#editCLIENTKEY").val(),
        secretKey: $("#editSECRETKEY").val()
    };

    $.ajax({
        url: "/updateLocation.do",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(locationData),
        success: function(response) {
            alert(response.message);
            location.reload();
        }
    });
}

function deleteLocation(location) {
    if (confirm("해당 지점을 삭제하시겠습니까?")) {
        $.ajax({
            url: "/deleteLocation.do",
            type: "POST",
            data: { location: location },
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
