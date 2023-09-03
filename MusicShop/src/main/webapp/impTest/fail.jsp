<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%
 String message = request.getParameter("message");
  String code = request.getParameter("code");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>결제 실패</title>
    <script>
		alert("결제 실패\n<%= message %>\n에러코드: <%= code %>");
		window.location.href="${contextPath}/cart.jsp";
	</script>
</head>
<body>
</body>
</html>