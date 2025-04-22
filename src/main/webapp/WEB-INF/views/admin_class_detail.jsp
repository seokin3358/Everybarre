<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강좌 상세 정보</title>
    <link rel="stylesheet" href="css/admin_style.css">
</head>
<body>

<!-- 네비게이션 바 -->
<%@ include file="admin_nav.jsp" %>

<div class="container">
    <h2>📖 강좌 상세 정보</h2>
    <table>
        <tr>
            <th>수업명</th>
            <td>${classDetail.className}</td>
        </tr>
        <tr>
            <th>강사</th>
            <td>${classDetail.TEACHER}</td>
        </tr>
        <tr>
            <th>지점</th>
            <td>${classDetail.LOCATION}</td>
        </tr>
        <tr>
            <th>날짜</th>
            <td>${classDetail.DATE}</td>
        </tr>
        <tr>
            <th>시간</th>
            <td>${classDetail.TIME}</td>
        </tr>
        <tr>
            <th>현재 인원</th>
            <td>${classDetail.PEOPLE}</td>
        </tr>
        <tr>
            <th>최대 인원</th>
            <td>${classDetail.MAXPEOPLE}</td>
        </tr>
        <tr>
            <th>대기 인원</th>
            <td>${classDetail.waitNumber}</td>
        </tr>
    </table>
    
    <h3>👥 수강 회원 목록</h3>
    <table>
        <thead>
            <tr>
                <th>회원 이름</th>
                <th>휴대폰 번호</th>
                <th>이메일 주소</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="member" items="${classMembers}">
                <tr>
                    <td>${member.USER_NAME}</td>
                    <td>${member.USER_PHONE}</td>
                    <td>${member.USER_MAIL}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- 뒤로가기 버튼 -->
    <button onclick="window.history.back();">뒤로 가기</button>
</div>

</body>
</html>
