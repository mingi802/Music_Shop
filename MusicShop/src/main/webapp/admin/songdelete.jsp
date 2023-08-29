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
	String sql_song = "DELETE FROM song where album_id= ?";
	String sql_album = "DELETE FROM album WHERE id = ?";
	
	PreparedStatement pstmt_song = conn.prepareStatement(sql_song);
	PreparedStatement pstmt_album = conn.prepareStatement(sql_album);
	
	pstmt_song.setString(1, id);
	pstmt_album.setString(1, id);
	
	pstmt_song.executeUpdate();
	pstmt_album.executeUpdate();
	
	out.println("<script>alert('삭제되었습니다.'); location.replace('./musicManage.jsp');</script>");
	
%>
</body>
</html>