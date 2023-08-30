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
	String mp3 = request.getParameter("mp3");
	
	//out.println("<script>alert('"+id+"');</script>");
	//out.println("<script>alert('"+albumName+"');</script>");
	
	try{
		
		String sql = "DELETE FROM song WHERE album_id = ? AND name = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, id);
		pstmt.setString(2, mp3);
		
		pstmt.executeUpdate();
		
		out.println("<script>alert('삭제되었습니다.');location.replace('./music_delete.jsp');</script>");
	} catch(SQLException e){
		out.println("<script>alert('삭제 중 오류가 발생했습니다.');location.replace('./music_delete.jsp');</script>");
		e.printStackTrace();
	}

%>
</body>
</html>