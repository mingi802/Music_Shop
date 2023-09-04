<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.Base64.Encoder"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.net.URLEncoder" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%
 	// 결제 승인 API 호출하기 
 	/*
  	String orderId = request.getParameter("orderId");
  	String paymentKey = request.getParameter("paymentKey");
  	String amount = request.getParameter("amount");
  	String secretKey = "test_sk_GePWvyJnrKbmGXKg2w7VgLzN97Eo:";
  
 	Encoder encoder = Base64.getEncoder(); 
  	byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
  	String authorizations = "Basic "+ new String(encodedBytes, 0, encodedBytes.length);

  	paymentKey = URLEncoder.encode(paymentKey, StandardCharsets.UTF_8);
  
  	URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
  
  	HttpURLConnection connection = (HttpURLConnection) url.openConnection();
  	connection.setRequestProperty("Authorization", authorizations);
  	connection.setRequestProperty("Content-Type", "application/json");
  	connection.setRequestMethod("POST");
  	connection.setDoOutput(true);
  	JSONObject obj = new JSONObject();
  	obj.put("paymentKey", paymentKey);
  	obj.put("orderId", orderId);
  	obj.put("amount", amount);
  
  	OutputStream outputStream = connection.getOutputStream();
  	outputStream.write(obj.toString().getBytes("UTF-8"));
  
  	int code = connection.getResponseCode();
  	boolean isSuccess = code == 200 ? true : false;
  
  	InputStream responseStream = isSuccess? connection.getInputStream(): connection.getErrorStream();
  
  	Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
  	JSONParser parser = new JSONParser();
  	JSONObject jsonObject = (JSONObject) parser.parse(reader);
  	responseStream.close();
 	*/
 	JSONObject jsonObject = new JSONObject();
 	jsonObject.put("message", "null");
 	jsonObject.put("code", "null");
 	
 	JSONObject BANKS = new JSONObject();
 	BANKS.put("39", "경남은행");
 	BANKS.put("34", "광주은행");
 	BANKS.put("12", "단위농협(지역농축협)");
 	BANKS.put("32", "부산은행");
 	BANKS.put("45", "새마을금고");
 	BANKS.put("64", "산림조합");
 	BANKS.put("88", "신한은행");
 	BANKS.put("48", "신협	");
 	BANKS.put("27", "씨티은행");
 	BANKS.put("20", "우리은행");
 	BANKS.put("71", "우체국예금보험");
 	BANKS.put("50", "저축은행중앙회");
 	BANKS.put("37", "전북은행");
 	BANKS.put("35", "제주은행");
 	BANKS.put("90", "카카오뱅크");
 	BANKS.put("89", "케이뱅크");
 	BANKS.put("92", "토스뱅크");
 	BANKS.put("81", "하나은행");
 	BANKS.put("54", "홍콩상하이은행");
 	BANKS.put("03", "IBK기업은행");
 	BANKS.put("06", "KB국민은행");
 	BANKS.put("31", "DGB대구은행");
 	BANKS.put("02", "KDB산업은행");
 	BANKS.put("23", "SC제일은행");
 	BANKS.put("07", "Sh수협은행");

 	boolean isSuccess = false;
 	String detail = "";
 	if(request.getAttribute("jsonObject") != null && request.getAttribute("isSuccess") != null) {
 		jsonObject = (JSONObject) request.getAttribute("jsonObject");
 	 	isSuccess = Boolean.parseBoolean(String.valueOf(request.getAttribute("isSuccess")));
 	 	if(jsonObject.get("method").equals("카드")) { 
 	 		detail = "카드번호: "+((JSONObject)jsonObject.get("card")).get("number").toString();
 	 	}
 	 	if(jsonObject.get("method").equals("가상계좌")) {
 	 		detail = "계좌번호: "+((JSONObject)jsonObject.get("virtualAccount")).get("accountNumber").toString();
 	 	} 
 	 	if(jsonObject.get("method").equals("계좌이체")) {
 	 		detail = "은행: "+BANKS.get(((JSONObject)jsonObject.get("transfer")).get("bankCode").toString()).toString();
 	 	}                           
 	 	if(jsonObject.get("method").equals("휴대폰")) { 
 	 		detail = "휴대폰 번호: "+((JSONObject)jsonObject.get("mobilePhone")).get("customerMobilePhone").toString();
 	 	} 
 	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>결제 성공</title>
    <script>
    <%
    if (isSuccess) { 
    %>
        if(confirm("결제 성공\n"
        	 	  +"주문명:<%=jsonObject.get("orderName")%>\n"
        	 	  +"결제수단:<%=jsonObject.get("method")%>\n"
        	 	  +"<%=detail%>\n"
        	 	  +"내 음악 페이지로 이동하시겠습니까?\n"
        	 	  +"('취소' 선택 시 장바구니 페이지로 이동됩니다.)")) {
        	window.location.href="${contextPath}/my_song.jsp";
        } else {
        	window.location.href="${contextPath}/cart.jsp";
        }
    <%
    } else { 
    %>
        alert("결제 실패\n"
        	+"에러코드:<%=jsonObject.get("code")%>\n"
        	+"<%=jsonObject.get("message")%>");
        window.location.href="${contextPath}/cart.jsp";
    <%
    }
    %>
    
    </script>
</head>
<body>
</body>
</html>