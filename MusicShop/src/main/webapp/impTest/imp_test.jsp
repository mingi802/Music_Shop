<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
IMP.init("imp73513207"); // 예: imp00000000a
function requestPay() {
    IMP.request_pay({
      pg: "kakaopay",
      pay_method: "card",
      merchant_uid: "ORD20180131-1110101",   // 주문번호
      name: "노르웨이 회전 의자",
      amount: 64900,                         // 숫자 타입
      buyer_email: "gildong@gmail.com",
      buyer_name: "홍길동",
      buyer_tel: "010-4242-4242",
      buyer_addr: "서울특별시 강남구 신사동",
      buyer_postcode: "01181"
    }, function(response) {
    	//결제 후 호출되는 callback함수
    	if (response.success) { //결제 성공
    		console.log(response);
    	} else {
    		alert('결제실패 : ' + response.error_msg);
    	}
    })
  }
</script>
</head>
<body>
<input type="button" onclick="requestPay()" value="결제 테스트">
</body>
</html>