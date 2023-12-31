<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../mydbcon.jsp" %> <!-- 본인 아이디와 비밀번호로 변경하세요. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	
	LocalDateTime now = LocalDateTime.now();
	String formattedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

	int num = 1;
	
	String user_id = request.getParameter("user_id");
	String album = request.getParameter("album");
	
	int albumId = Integer.parseInt(request.getParameter("albumId"));
	
	String songName = request.getParameter("song_name");
	String singer = request.getParameter("singer");
	
	String star = request.getParameter("reviewStar");
	String review = request.getParameter("content");
	
	//out.println("<script>alert('"+songName+"');</script>");

	
	try{
		String sql = "INSERT INTO board (user_id, album_name,singer, date, star, review) VALUES (?, ?, ?, ?, ?, ?)";
		String sql_renew1 = "set @cnt = 0";
		String sql_renew2 = "UPDATE board SET board.id = @cnt:=@cnt+1";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		PreparedStatement pstmt_renew1 = conn.prepareStatement(sql_renew1);
		PreparedStatement pstmt_renew2 = conn.prepareStatement(sql_renew2);
		
		//pstmt.setInt(1, num);
		pstmt.setString(1, user_id);
		pstmt.setString(2, songName);
		pstmt.setString(3, singer);
		pstmt.setString(4, formattedNow);
		pstmt.setString(5, star);
		pstmt.setString(6, review);
		pstmt.executeUpdate();
		pstmt_renew1.executeUpdate();
		pstmt_renew2.executeUpdate();
		
	}catch(SQLException e){
		e.printStackTrace();
	} 
%>

<script>
	alert("리뷰가 작성되었습니다.");
	window.location.href="../Album/album_songs/showOneAlbum.do?album_id=" + <%=albumId%>;
</script>
</body>
</html>