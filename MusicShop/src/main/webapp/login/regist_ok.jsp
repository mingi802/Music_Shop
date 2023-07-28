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
	
	String sql1 = "INSERT INTO customer VALUES(?,?,?,?,?,?,?,?,?)"; // 소비자용
	String sql2 =  "INSERT INTO host VALUES(?,?,?,?,?,?,?,?,?)"; // 관리자용
	String sql3 =  "INSERT INTO artist VALUES(?,?,?,?,?,?,?,?,?)"; //아티스트용
	String sql1_1 = "SELECT * FROM customer";
	String sql2_1 = "SELECT * FROM host";
	String sql3_1 = "SELECT * FROM artist";
	
	if(position.equals("100")){ // 소비자
		PreparedStatement pstmt = conn.prepareStatement(sql1);
		PreparedStatement pstmt2 = conn.prepareStatement(sql1_1);
		
		ResultSet rs = null;
		try{
			rs = pstmt2.executeQuery();
			
			while(rs.next()){
				String id_check = rs.getString("id");
				if(id_check.equals(id)){
					out.print("<script>alert('" + id_check + "은(는) 중복되었습니다.');</script>");
					out.print("<script> history.back();</script>");	
					conn.close();
					return;					
				}
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
		if(rs != null){
			rs.close();
			}
		}
		try{
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			pstmt.setString(3, pwd);
			pstmt.setString(4, gender);
			pstmt.setString(5, birth);
			pstmt.setString(6, number);
			pstmt.setString(7, address);
			pstmt.setString(8, email);
			pstmt.setString(9, position);
			
			pstmt.executeUpdate();
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			try{
				if (pstmt != null && !pstmt.isClosed()){
					pstmt.close();
				}
			} catch (SQLException e){
				e.printStackTrace();
			}
		}
		conn.close();
	} else if(position.equals("200")){ // 관리자
		PreparedStatement pstmt = conn.prepareStatement(sql2);
		PreparedStatement pstmt2 = conn.prepareStatement(sql2_1);
		
		ResultSet rs = null;
		try{
			rs = pstmt2.executeQuery();
			
			while(rs.next()){
				String id_check = rs.getString("h_id");
				
				if(id_check.equals(id)){
					out.print("<script>alert('" + id_check + "은(는) 중복되었습니다.');</script>");
					out.print("<script> history.back();</script>");	
					conn.close();
					return;					
				}
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
		if(rs != null){
			rs.close();
			}
		}
		try{
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			pstmt.setString(3, pwd);
			pstmt.setString(4, gender);
			pstmt.setString(5, birth);
			pstmt.setString(6, number);
			pstmt.setString(7, address);
			pstmt.setString(8, email);
			pstmt.setString(9, position);
			
			pstmt.executeUpdate();
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			try{
				if (pstmt != null && !pstmt.isClosed()){
					pstmt.close();
				}
			} catch (SQLException e){
				e.printStackTrace();
			}
		}
		conn.close();
	} else if(position.equals("300")){ // 관리자
		PreparedStatement pstmt = conn.prepareStatement(sql3);
		PreparedStatement pstmt2 = conn.prepareStatement(sql3_1);
		
		ResultSet rs = null;
		try{
			rs = pstmt2.executeQuery();
			
			while(rs.next()){
				String id_check = rs.getString("a_id");
				
				if(id_check.equals(id)){
					out.print("<script>alert('" + id_check + "은(는) 중복되었습니다.');</script>");
					out.print("<script> history.back();</script>");	
					conn.close();
					return;					
				}
			}
		} catch(SQLException e){
			e.printStackTrace();
		} finally {
		if(rs != null){
			rs.close();
			}
		}
		try{
			pstmt.setString(1, name);
			pstmt.setString(2, id);
			pstmt.setString(3, pwd);
			pstmt.setString(4, gender);
			pstmt.setString(5, birth);
			pstmt.setString(6, number);
			pstmt.setString(7, address);
			pstmt.setString(8, email);
			pstmt.setString(9, position);
			
			pstmt.executeUpdate();
		} catch(SQLException e){
			e.printStackTrace();
		} finally{
			try{
				if (pstmt != null && !pstmt.isClosed()){
					pstmt.close();
				}
			} catch (SQLException e){
				e.printStackTrace();
			}
		}
		conn.close();
	}
%>

<script>
	alert("가입이 완료되었습니다.");
	window.location.href="login.jsp";
</script>
</body>
</html>