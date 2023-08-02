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
	out.println("<script>location.replace('../main.jsp')</script>");
%>
</body>
</html>