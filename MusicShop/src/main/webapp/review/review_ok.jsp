<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../mydbcon.jsp" %> <!-- 본인 아이디와 비밀번호로 변경하세요. -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
	
	String star = request.getParameter("reviewStar");
	String review = request.getParameter("content");
	
	out.println("<script>alert('"+albumId+"');</script>");
	
	String sql = "INSERT INTO board (user_id, album_name, date, star, review) VALUES (?, ?, ?, ?, ?)";
	
	PreparedStatement pstmt = null;
	pstmt = conn.prepareStatement(sql);
	
	try{
		//pstmt.setInt(1, num);
		pstmt.setString(1, user_id);
		pstmt.setString(2, album);
		pstmt.setString(3, formattedNow);
		pstmt.setString(4, star);
		pstmt.setString(5, review);
		pstmt.executeUpdate();
		
	}catch(SQLException e){
		e.printStackTrace();
	} finally{
		try{
			if(pstmt !=null && !pstmt.isClosed()){
				pstmt.close();
			}
		} catch(SQLException e){
			e.printStackTrace();
		}
	}
%>

<script>
	alert("리뷰가 작성되었습니다.");
	window.location.href="../Album/album_songs/showOneAlbum.do?album_id=" + <%=albumId%>;
</script>
</body>
</html>