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
	String albumName = request.getParameter("album");
	
	//out.println("<script>alert('"+id+"');</script>");
	//out.println("<script>alert('"+albumName+"');</script>");
	
	try{
		
		String sql = "DELETE FROM board WHERE user_id = ? AND album_name = ?";
		String sql2 = "UPDATE board set board.id = @cnt:=@cnt+1";
		String sql3 = "set @cnt = 0";
		String sql4 = "DELETE FROM replyboard WHERE writer = ? AND song_name = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		PreparedStatement pstmt3 = conn.prepareStatement(sql3);
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);	
		PreparedStatement pstmt4 = conn.prepareStatement(sql4);

		pstmt.setString(1, id);
		pstmt.setString(2, albumName);
		
		pstmt4.setString(1, id);
		pstmt4.setString(2, albumName);
		
		pstmt.executeUpdate();
		pstmt4.executeUpdate();
		pstmt3.executeUpdate();
		pstmt2.executeUpdate();
		
		out.println("<script>alert('삭제되었습니다.');location.replace('./review.jsp');</script>");
	} catch(SQLException e){
		out.println("<script>alert('삭제 중 오류가 발생했습니다.');location.replace('./review.jsp');</script>");
		e.printStackTrace();
	}

%>
</body>
</html>