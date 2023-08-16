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
	
	String id = request.getParameter("id");
	String code = request.getParameter("code");
	String sql = "DELETE FROM member WHERE id='"+id+"'";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate();
	if(code.equals("100")){
		out.println("<script>alert('삭제되었습니다.');location.replace('./admin.jsp');</script>");
	}else if(code.equals("200")){
		out.println("<script>alert('삭제되었습니다.');location.replace('./host.jsp');</script>");
	} else if(code.equals("300")){
		out.println("<script>alert('삭제되었습니다.');location.replace('./artist.jsp');</script>");
	}
%>
</body>
</html>