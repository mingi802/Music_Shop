<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout Complete</title>
</head>
<body>
<%
	session.removeAttribute("id");
	session.removeAttribute("code");
%>
	<script>
		alert('로그아웃이 되었습니다.');
		window.location.href="../main.jsp";
	</script>
</body>
</html>