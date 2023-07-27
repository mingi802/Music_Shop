<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 확인</title>
</head>
<body>
<%
	String id = request.getParameter("user_id");
	String pwd = request.getParameter("user_pwd");
	String name = request.getParameter("user_name");
	
	String y = request.getParameter("birthYear");
	String m = request.getParameter("birthMonth");
	String d = request.getParameter("birthDay");
	String birth = y+ "-" + m + "-" +d;
	
	String gender = request.getParameter("user_gen");
	
	String email = request.getParameter("user_email");
	String address = request.getParameter("user_addr");
	String position = request.getParameter("user_pos");
	
	out.println("<script>alert('"+id+"');</script>");
	out.println("<script>alert('"+pwd+"');</script>");
	out.println("<script>alert('"+name+"');</script>");
	out.println("<script>alert('"+birth+"');</script>");
	out.println("<script>alert('"+gender+"');</script>");
	out.println("<script>alert('"+email+"');</script>");
	out.println("<script>alert('"+address+"');</script>");
	out.println("<script>alert('"+position+"');</script>");
%>








</body>
</html>