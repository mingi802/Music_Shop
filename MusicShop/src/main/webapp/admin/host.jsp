<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/> <!-- ${contextPath} -->
<%@ include file="../mydbcon.jsp" %> <!-- 본인 아이디와 비밀번호로 변경하세요. -->    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>MLP Music:: </title>

    <!-- Favicon -->
    <link rel="icon" href="../img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="../style.css">
<%
String user_id = (String) session.getAttribute("id");
String code = (String) session.getAttribute("code");
String name = (String) session.getAttribute("name");
//String user_id = "곽두팔"; // 로그그인 된 경우, 예시 아이디
//String code = "100";	// 로그인이 된 경우, 예시 구분 코드 / 100 : 소비자, 200 : 관리자 , 300 : 아티스트
%>
<script>
function cart(){
	if(confirm('장바구니로 이동하시겠습니까?')){
		window.location.href="{contextPath}/cart.jsp";
		return true;
	} else{
		return false;
	}
}
</script>

</head>
<body>
    <!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="lds-ellipsis">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>

    <!-- ##### Header Area Start ##### -->
	<jsp:include page="../header.jsp"></jsp:include>
    <!-- ##### Header Area End ##### -->
    
    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(../img/bg-img/breadcumb3.jpg);">
        <div class="bradcumbContent">
            <p>See what’s new</p>
            <h2>Admin Page</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->
    
    <aside class="admin-category">
    	<ul class="side-menu">
			<li><a href="admin.jsp"><b>회원목록</b></a></li><br>
			<li><a href="host.jsp"><b>관리자목록</b></a></li><br>
			<li><a href="artist.jsp"><b>아티스트목록</b></a></li><br>
			<li><a href="musicManage.jsp"><b>음원목록</b></a></li><br>
			<li><a href="../review/review.jsp"><b>게시판</b></a></li><br>
			<li><a href="../customer/mypage.jsp"><b>내정보</b></a></li>	    	
    	</ul>
    </aside>
    
    <!-- ##### Login Area Start ##### -->
    <section class="login-area section-padding-100">
        <div class="admin-container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="member-content">
                        <h3>Admin Management</h3><br>
                        <!-- Membership manage Form -->
                        <div class="member-manage-form">
                        <table>
                        	<tr><th>이름</th><th>아이디</th><th>비밀번호</th><th>성별</th><th>생년월일</th><th>전화번호</th><th>주소</th><th>이메일</th><th>고유번호</th></tr>
                        	<%
                        	String sql = "SELECT * FROM member WHERE code = 200";
                        	PreparedStatement pstmt = conn.prepareStatement(sql);
                        	ResultSet rs = pstmt.executeQuery();
                        	
                        	while(rs.next()){
                        	%>
                        		<tr style="test-align: center">
                        		<td><%=rs.getString("name") %></td>
                        		<td><%=rs.getString("id") %></td>
                        		<td><%=rs.getString("pwd") %></td>
                        		<td><%=rs.getString("gender") %></td>
                        		<td><%=rs.getString("birth") %></td>
                        		<td><%=rs.getString("phone") %></td>
                        		<td><%=rs.getString("addr") %></td>
                        		<td><%=rs.getString("email") %></td>
                        		<td><%=rs.getString("code") %></td>
                        		<td><button onclick="location.href='delete.jsp?id=<%= rs.getString("id") %>&code=<%=rs.getString("code")%>'">Delete</button></td>
                        		</tr>
                        	
                        	<%	
                        	}
                        	%>
                        </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Login Area End ##### -->        
        
    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area">
        <div class="container">
            <div class="row d-flex flex-wrap align-items-center">
                <div class="col-12 col-md-6">
                    <a href="../main.jsp"><img src="../img/core-img/lologo.png" alt=""></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                </div>

                <div class="col-12 col-md-6">
                    <div class="footer-nav">
                        <ul>
                            <li><a href="../main.jsp">Home</a></li>
                            <li><a href="../album.jsp">Albums</a></li>
                            <li><a href="../connection.jsp">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ##### Footer Area Start ##### -->

    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="../js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="../js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="../js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="../js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="../js/active.js"></script>
</body>
</html>