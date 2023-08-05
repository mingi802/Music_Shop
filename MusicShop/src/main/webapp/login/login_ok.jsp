<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page session="true"%>
    <%@ include file="../mydbcon.jsp"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login complete</title>
</head>
<body>
<%

	String user_id = request.getParameter("login_id");
	String user_pwd = request.getParameter("login_pwd");	

	String sql = "SELECT id, pwd, code, name FROM member,dept WHERE member.code = dept.dept_code AND id= '"+ user_id +"' AND pwd = '" + user_pwd + "'";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	if(rs.next()){
		session.setAttribute("id", rs.getString("id"));
		session.setAttribute("code", rs.getString("code"));
		session.setAttribute("name", rs.getString("name"));
%>
	<script>
		alert('로그인에 성공했습니다.');
		window.location.href="../main.jsp";
	</script>
<%			
	} else{
%>
	<script>
		alert('아이디와 비밀번호를 다시 확인하세요.');
		history.back();
	</script>		
<% 
	}

%>
</body>
</html>