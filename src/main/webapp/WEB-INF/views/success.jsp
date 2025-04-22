<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
  </head>
  <body>
    <h2>결제 성공</h2>
    <p id="paymentKey"></p>
    <p id="orderId"></p>
    <p id="amount"></p>

    <script>
      // 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
      // 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
      const urlParams = new URLSearchParams(window.location.search);
      const paymentKey = urlParams.get("paymentKey");
      const orderId = urlParams.get("orderId");
      const amount = urlParams.get("amount");

      async function confirm() {
        const requestData = {
          paymentKey: paymentKey,
          orderId: orderId,
          amount: amount,
        };

        const response = await fetch("/confirm", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(requestData),
        });

        const json = await response.json();

        if (!response.ok) {
            // 결제 실패 비즈니스 로직
            console.error("결제 실패", json);
            alert("결제에 실패했습니다: " + json.message);
            return;
        }

        // ✅ 결제 성공 비즈니스 로직
        console.log("결제 성공", json);

        // 부모 창에 메시지 전달
        if (window.opener) {
            window.opener.postMessage(
                {
                    status: "success",
                    message: "구매가 완료되었습니다.",
                },
                window.location.origin // 보안상의 이유로 origin을 설정
            );
        }

        // 팝업 창 닫기
        window.close();
      }
      confirm();

      const paymentKeyElement = document.getElementById("paymentKey");
      const orderIdElement = document.getElementById("orderId");
      const amountElement = document.getElementById("amount");

      orderIdElement.textContent = "주문번호: " + orderId;
      amountElement.textContent = "결제 금액: " + amount;
      paymentKeyElement.textContent = "paymentKey: " + paymentKey;
    </script>
  </body>
</html>