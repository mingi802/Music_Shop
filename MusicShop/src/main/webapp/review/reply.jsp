<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../mydbcon.jsp" %> <!-- 본인 아이디와 비밀번호로 변경하세요. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 작성</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	LocalDateTime now = LocalDateTime.now();
	String formattedNow = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

	int num = 1;

	String songName = request.getParameter("songName"); //노래제목
	String user_id = request.getParameter("user"); //댓글 작성자
	String reply = request.getParameter("songReply"); //댓글 내용
	String writer = request.getParameter("writer"); // 게시판에 글 작성자
	/*
	out.println("<script>alert('"+songName+"');</script>");
	out.println("<script>alert('"+user_id+"');</script>");
	out.println("<script>alert('"+reply+"');</script>");
	out.println("<script>alert('"+writer+"');</script>");
	*/
	try{
		String sql = "INSERT INTO replyboard (user_id, date, song_name, reply, writer) VALUES(?, ?, ?, ?, ?)";
		String sql_renew1 = "set @cnt = 0";
		String sql_renew2 = "UPDATE board SET board.id = @cnt:=@cnt+1";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		PreparedStatement pstmt_renew1 = conn.prepareStatement(sql_renew1);
		PreparedStatement pstmt_renew2 = conn.prepareStatement(sql_renew2);
		
		pstmt.setString(1, user_id);
		pstmt.setString(2, formattedNow);
		pstmt.setString(3, songName);
		pstmt.setString(4, reply);
		pstmt.setString(5, writer);
		pstmt.executeUpdate();
		pstmt_renew1.executeUpdate();
		pstmt_renew2.executeUpdate();
		
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<script>
	alert("리뷰가 작성되었습니다.");
	window.location.href="review_detail.jsp?id=<%=writer%>&title=<%=songName%>";
</script>
</body>
</html>