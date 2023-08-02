<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page session="true"%>
    <%@ include file="../mydbcon.jsp"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	String user_id = request.getParameter("login_id");
	
	String sql = "SELECT id, code FROM member,dept WHERE id= '"+ user_id +"' AND member.code = dept.dept_code";
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	
	if(rs.next()){
		do{
			session.setAttribute("id", rs.getString("id"));
			session.setAttribute("code", rs.getString("code"));
			
		} while(rs.next());
		
	}

%>
</body>
</html>