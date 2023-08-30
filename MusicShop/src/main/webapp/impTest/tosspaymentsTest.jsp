<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <!-- 결제위젯 SDK 추가 -->
  <script src="https://js.tosspayments.com/v1/payment-widget"></script>
  <script>
  	console.log("${contextPath}");
  </script>
</head>
<body>
  <!-- 결제위젯, 이용약관 영역 -->
  <div id="payment-method"></div>
  <div id="agreement"></div>
  <!-- 결제하기 버튼 -->
  <button id="payment-button">결제하기</button>
  <script>
    const clientKey = "test_ck_jExPeJWYVQlOdp6pRbQ349R5gvNL"
    const customerKey = self.crypto.randomUUID(); // 내 상점에서 고객을 구분하기 위해 발급한 고객의 고유 ID
    const button = document.getElementById("payment-button")
    // ------  결제위젯 초기화 ------ 
    // 비회원 결제에는 customerKey 대신 ANONYMOUS를 사용하세요.
    const paymentWidget = PaymentWidget(clientKey, customerKey) // 회원 결제
    // const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS) // 비회원 결제
    // ------  결제위젯 렌더링 ------ 
    // 결제수단 UI를 렌더링할 위치를 지정합니다. `#payment-method`와 같은 CSS 선택자와 결제 금액 객체를 추가하세요.
    // DOM이 생성된 이후에 렌더링 메서드를 호출하세요.
    // https://docs.tosspayments.com/reference/widget-sdk#renderpaymentmethods선택자-결제-금액-옵션
    const paymentMethodWidget = paymentWidget.renderPaymentMethods("#payment-method", { value: 15000 })
    // ------  이용약관 렌더링 ------
    // 이용약관 UI를 렌더링할 위치를 지정합니다. `#agreement`와 같은 CSS 선택자를 추가하세요.
    // https://docs.tosspayments.com/reference/widget-sdk#renderagreement선택자
    paymentWidget.renderAgreement('#agreement')
    // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
    // 더 많은 결제 정보 파라미터는 결제위젯 SDK에서 확인하세요.
    // https://docs.tosspayments.com/reference/widget-sdk#requestpayment결제-정보
    button.addEventListener("click", function () {
    	let orderId = self.crypto.randomUUID();
    	paymentWidget
	      	.requestPayment({
		        orderId: orderId,            // 주문 ID(직접 만들어주세요)
		        orderName: "토스 티셔츠 외 2건",                 // 주문명
		        successUrl: "http://localhost:8060/${contextPath}/impTest/success.jsp",  // 결제에 성공하면 이동하는 페이지(직접 만들어주세요)
		        failUrl: "http://localhost:8060/${contextPath}/impTest/fail.jsp",        // 결제에 실패하면 이동하는 페이지(직접 만들어주세요)
		        customerEmail: "customer123@gmail.com",
		        customerName: "김토스"
	      	})
	      	.catch(function (error) {
			    if (error.code === 'INVALID_ORDER_NAME') {
			      	// 유효하지 않은 'orderName' 처리하기
			      	alert(error.code);
			    } else if (error.code === 'INVALID_ORDER_ID') {
			      	// 유효하지 않은 'orderId' 처리하기
			      	alert(error.code);
			    } else {
			    	alert(error.code);
			    }
	  	  	})
      	const selectedPaymentMethod = paymentMethodWidget.getSelectedPaymentMethod();
      	console.log(selectedPaymentMethod);
   	})
  </script>
</body>
</html>