<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>문자 전송</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>문자 보내기</h1>
    
    <label for="receiver">받는 번호:</label>
    <input type="text" id="receiver" placeholder="01012345678"><br>

    <label for="sender">보내는 번호:</label>
    <input type="text" id="sender" placeholder="01087654321"><br>

    <label for="message">메시지:</label>
    <textarea id="message"></textarea><br>

    <button onclick="sendSms()">문자 전송</button>

    <script>
        function sendSms() {
            const receiver = document.getElementById("receiver").value;
            const sender = document.getElementById("sender").value;
            const message = document.getElementById("message").value;
            console.log(message);

            $.ajax({
                type: "POST",
                url: "/sendSms",
                contentType: "application/json",
                data: JSON.stringify({
                    RECEIVER: receiver,
                    SENDER: sender,
                    MESSAGE: message
                }),
                success: function(response) {
                    if (response.success) {
                        alert("문자 전송 성공!");
                    } else {
                        alert("문자 전송 실패: " + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    alert("문자 전송 중 오류 발생: " + error);
                }
            });
        }
    </script>
</body>
</html>
