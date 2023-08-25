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
	
	String star = request.getParameter("reviewStar");
	String review = request.getParameter("album_review");
	
	String sql = "INSERT INTO board VALUES(?,?,?,?,?,?)"; 
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	try{
		pstmt.setInt(1, num);
		pstmt.setString(2, user_id);
		pstmt.setString(3, album);
		pstmt.setString(4, formattedNow);
		pstmt.setString(5, star);
		pstmt.setString(6, review);
		
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
	window.location.href="";
</script>
</body>
</html>