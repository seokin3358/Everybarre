<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    String mode = request.getParameter("mode");
    String message = "";

    if ("add".equals(mode)) {
        String newAddress = request.getParameter("newAddress");
        if (newAddress != null && !newAddress.trim().isEmpty()) {
            PreparedStatement addStmt = conn.prepareStatement("INSERT INTO VIDEO_LIST (ADDRESS) VALUES (?)");
            addStmt.setString(1, newAddress.trim());
            addStmt.executeUpdate();
            addStmt.close();
            message = "✅ 영상이 추가되었습니다.";
        }
    }

    if ("delete".equals(mode)) {
        int deleteId = Integer.parseInt(request.getParameter("id"));
        PreparedStatement delStmt = conn.prepareStatement("DELETE FROM VIDEO_LIST WHERE ID = ?");
        delStmt.setInt(1, deleteId);
        delStmt.executeUpdate();
        delStmt.close();
        message = "🗑️ 영상이 삭제되었습니다.";
    }

    if ("update".equals(mode)) {
        int updateId = Integer.parseInt(request.getParameter("id"));
        String newVal = request.getParameter("updatedAddress");
        if (newVal != null && !newVal.trim().isEmpty()) {
            PreparedStatement updStmt = conn.prepareStatement("UPDATE VIDEO_LIST SET ADDRESS = ? WHERE ID = ?");
            updStmt.setString(1, newVal.trim());
            updStmt.setInt(2, updateId);
            updStmt.executeUpdate();
            updStmt.close();
            message = "✏️ 영상이 수정되었습니다.";
        }
    }

    // 영상 리스트 조회
    List<Map<String, String>> videos = new ArrayList<>();
    PreparedStatement listStmt = conn.prepareStatement("SELECT ID, ADDRESS FROM VIDEO_LIST ORDER BY ID DESC");
    ResultSet rs = listStmt.executeQuery();
    while (rs.next()) {
        Map<String, String> row = new HashMap<>();
        row.put("id", rs.getString("ID"));
        row.put("address", rs.getString("ADDRESS"));
        videos.add(row);
    }
    rs.close();
    listStmt.close();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>슬라이드 이미지 업로드</title>
    <link rel="stylesheet" href="css/admin_style.css">
    <script src="js/jquery-1.12.3.min.js"></script>
</head>
<body>
<style>
.slide-container {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    flex-wrap: wrap;
    margin-bottom: 30px;
}
.slide-box {
    flex: 1 1 30%;
    min-width: 250px;
    max-width: 300px;
    text-align: center;
    border: 1px solid #eee;
    padding: 15px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}
</style>

<%@ include file="admin_nav.jsp" %>
<h2 style="margin-top:40px;">📝 메인 텍스트 수정</h2>
<div style="margin-top: 20px; padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
    <form id="textUpdateForm">
        <label for="mainTitle">🎯 메인 제목</label><br>
        <input type="text" id="mainTitleInput" name="main_title" style="width: 100%; padding: 8px;"><br><br>

        <label for="mainDesc">📌 메인 설명</label><br>
        <textarea id="mainDescInput" name="main_description" rows="4" style="width: 100%; padding: 8px;"></textarea><br><br>

        <label for="blogTitle">📰 블로그 제목</label><br>
        <input type="text" id="blogTitleInput" name="blog_title" style="width: 100%; padding: 8px;"><br><br>

        <label for="blogDesc">🗒 블로그 설명</label><br>
        <textarea id="blogDescInput" name="blog_description" rows="4" style="width: 100%; padding: 8px;"></textarea><br><br>

        <button type="button" onclick="saveSiteTexts()" style="padding: 10px 20px;">💾 저장</button>
    </form>
</div>
<h2>🎬 유튜브 영상 관리</h2>

<% if (!message.isEmpty()) { %>
    <p style="color:green;"><%= message %></p>
<% } %>

<!-- 영상 추가 -->
<form method="post" style="margin-bottom:20px;">
    <input type="hidden" name="mode" value="add">
    🔗 유튜브 ID: 
    <input type="text" name="newAddress" placeholder="예: Y_wjzyHcR2g" required>
    <button type="submit">➕ 추가</button>
</form>

<!-- 영상 목록 -->
<table border="1" cellpadding="8" cellspacing="0" width="100%">
    <tr>
        <th>썸네일</th>
        <th>주소 (영상 ID)</th>
        <th>수정</th>
        <th>삭제</th>
    </tr>
<% for (Map<String, String> video : videos) {
    String id = video.get("id");
    String address = video.get("address");
%>
    <tr>
        <td><img src="https://img.youtube.com/vi/<%= address %>/hqdefault.jpg" width="120"></td>
        <td><%= address %></td>
        <td>
            <form method="post" style="display:inline;">
                <input type="hidden" name="mode" value="update">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="text" name="updatedAddress" value="<%= address %>">
                <button type="submit">수정</button>
            </form>
        </td>
        <td>
            <form method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');" style="display:inline;">
                <input type="hidden" name="mode" value="delete">
                <input type="hidden" name="id" value="<%= id %>">
                <button type="submit">삭제</button>
            </form>
        </td>
    </tr>
<% } %>
</table>
    <h2>📸 메인 슬라이드 이미지 업로드</h2>
    <form action="/uploadSlideImage.do" method="post" enctype="multipart/form-data">
   
<div class="slide-container">
    <div class="slide-box">
        <label>에사회 1 :</label><br>
        <input type="file" name="slide1" accept="image/*" onchange="previewImage(this, 'preview1')"><br>
        <img id="preview1" src="/static_uploads/img/에사회1.jpg" width="250">
    </div>
    <div class="slide-box">
        <label>에사회 2 :</label><br>
        <input type="file" name="slide2" accept="image/*" onchange="previewImage(this, 'preview2')"><br>
        <img id="preview2" src="/static_uploads/img/에사회2.jpg" width="250">
    </div>
    <div class="slide-box">
        <label>에사회 3 :</label><br>
        <input type="file" name="slide3" accept="image/*" onchange="previewImage(this, 'preview3')"><br>
        <img id="preview3" src="/static_uploads/img/에사회3.jpg" width="250">
    </div>
</div>
    <button type="submit">업로드</button>
</form>

<script>
function previewImage(input, previewId) {
    const file = input.files[0];
    if (file && file.type.startsWith("image/")) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById(previewId).src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
}
function loadSiteTexts() {
    $.get("/getSiteContent.do", { id: "main_title" }, function(data) {
        $("#mainTitleInput").val(data);
    });
    $.get("/getSiteContent.do", { id: "main_description" }, function(data) {
        $("#mainDescInput").val(data);
    });
    $.get("/getSiteContent.do", { id: "blog_title" }, function(data) {
        $("#blogTitleInput").val(data);
    });
    $.get("/getSiteContent.do", { id: "blog_description" }, function(data) {
        $("#blogDescInput").val(data);
    });
}

function saveSiteTexts() {
    const texts = {
        main_title: $("#mainTitleInput").val(),
        main_description: $("#mainDescInput").val(),
        blog_title: $("#blogTitleInput").val(),
        blog_description: $("#blogDescInput").val()
    };

    for (const id in texts) {
        $.post("/updateSiteContent.do", { id: id, content: texts[id] }, function(result) {
            console.log(id + " 저장 완료:", result);
        });
    }

    alert("메인 텍스트가 저장되었습니다!");
}

$(document).ready(function() {
    loadSiteTexts();
});
</script>
</body>
</html>
