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
	
	String id = request.getParameter("id"); //댓글 작성한 사람
	String reply = request.getParameter("reply"); //댓글 내용
	
	String songName = request.getParameter("title"); //노래 제목
	String writer = request.getParameter("writer"); // 게시판에 글 작성자
	
	
	try{
		
		String sql = "DELETE FROM replyboard WHERE user_id = ? AND reply = ?";
		String sql2 = "UPDATE board set board.id = @cnt:=@cnt+1";
		String sql3 = "set @cnt = 0";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		PreparedStatement pstmt3 = conn.prepareStatement(sql3);
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);	

		pstmt.setString(1, id);
		pstmt.setString(2, reply);
		
		pstmt.executeUpdate();
		pstmt3.executeUpdate();
		pstmt2.executeUpdate();
		
        String redirectURL = "./review_detail.jsp?id=" + writer + "&title=" + songName;
        out.println("<script>alert('삭제되었습니다.'); location.replace('" + redirectURL + "');</script>");
    } catch(SQLException e) {
        // Redirect to the review.jsp page in case of an error
        out.println("<script>alert('삭제 중 오류가 발생했습니다.'); location.replace('./review.jsp');</script>");
        e.printStackTrace();
    }

%>
</body>
</html>