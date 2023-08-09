<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../mydbcon.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	
	String album = request.getParameter("album");
	String sql = "delete from album where album='"+album+"'";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
	
	out.println("<script>alert('삭제되었습니다.'); location.replace('./admin.jsp');</script>");
	
%>
</body>
</html>