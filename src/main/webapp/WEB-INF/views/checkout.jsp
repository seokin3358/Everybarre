<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>결제 페이지</title>
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <%
    String orderName = (String) session.getAttribute("orderName");
	String value = (String) session.getAttribute("value");
	String customerEmail = (String) session.getAttribute("customerEmail");
	String customerName = (String) session.getAttribute("customerName");
	String customerMobilePhone = (String) session.getAttribute("customerMobilePhone");
	String Place = (String) session.getAttribute("Place");
	String client_key = (String) session.getAttribute("client_key");
	%>
  </head>
  <body>

    <!-- 결제 UI -->
    <div id="payment-method"></div>
    <!-- 이용약관 UI -->
    <div id="agreement"></div>
    <!-- 결제하기 버튼 -->
    <div id="payment-button" class="btn primary w-100" >
    <button class="button" id="payment-button" style="margin-top: 30px; background-color: #3282f6; color: #f9fcff; width: 100%; padding: 11px 22px; border: none; border-radius: 8px; font-weight: 600; font-size: 17px; cursor: pointer;">결제하기</button>
    </div>

    <script>
      document.addEventListener("DOMContentLoaded", async function () {
          // URL 파라미터 가져오기
          const urlParams = new URLSearchParams(window.location.search);
          const orderName = "<%=orderName%>";
          const value = "<%=value%>";
          const customerEmail = "<%=customerEmail%>";
          const customerName = "<%=customerName%>";
          const customerMobilePhone = "<%=customerMobilePhone%>";
          const Place = "<%=Place%>";
          const client_key = "<%=client_key%>";
			console.log(client_key);

          // 토스 결제 위젯 초기화
          const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
          const tossPayments = TossPayments(client_key);

          const customerKey = "a18yxip23X73kxKnPAkDx";
          const widgets = tossPayments.widgets({ customerKey });

          await widgets.setAmount({
              currency: "KRW",
              value: parseInt(value),
          });

          await Promise.all([
              widgets.renderPaymentMethods({
                  selector: "#payment-method",
                  variantKey: "DEFAULT",
              }),
              widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
          ]);

          document.getElementById("payment-button").addEventListener("click", async function () {
              const orderId = generateOrderId();

              await widgets.requestPayment({
                  orderId: orderId,
                  orderName: orderName,
                  successUrl: window.location.origin + "/success",
                  failUrl: window.location.origin + "/fail",
                  customerEmail: customerEmail,
                  customerName: customerName,
                  customerMobilePhone: customerMobilePhone,
              });
          });
      });

      function generateOrderId() {
          const timestamp = Date.now();
          const randomString = Math.random().toString(36).substring(2, 10);
          return 'ORD_'+timestamp+'_'+randomString.substring(0, 64);
      }
    </script>
  </body>
</html>