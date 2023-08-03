<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%@page session="true"%>    
    <%@ include file="../mydbcon.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("user_id");
	String pwd = request.getParameter("user_pwd");
	String name = request.getParameter("user_name");

	String y = request.getParameter("birthYear");
	String m = request.getParameter("birthMonth");
	String d = request.getParameter("birthDay");
	String birth = y+ "-" + m + "-" +d;

	String gender = request.getParameter("user_gen");

	String email = request.getParameter("user_email");
	String address = request.getParameter("user_addr");
	String position = request.getParameter("user_pos");

	String number = request.getParameter("user_num");
	
	String sql = "UPDATE member SET name = '"+ name +"', pwd = '"+ pwd 
			+"', gender = '"+ gender +"', birth = '"+ birth +"', phone = '"+ number +"', addr = '"+ address
			+"', email = '"+ email +"', code = '"+ position +"' WHERE id = '"+ id +"'";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	try{
		pstmt.executeUpdate();
	}catch(SQLException e){
		e.printStackTrace();
	} finally{
		try{
			if(pstmt != null && !pstmt.isClosed()){
				pstmt.close();
			}
		} catch(SQLException e){
			e.printStackTrace();
		}
	}
	
%>
	<script>
		alert("회원정보가 수정되었습니다.");
		window.location.href='mypage.jsp';
	</script>
</body>
</html>