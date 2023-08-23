<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
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
/*1분 미리듣기 함수*/
function limitPlayTime(audio) {
    if (audio.currentTime > 60) { // 1분(60초)로 제한
        audio.pause();
        audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
        alert("1분 미리듣기가 종료되었습니다.");
    }
}

function cart(){
	if(confirm('장바구니로 이동하시겠습니까?')){
		window.location.href="../cart.jsp";
		return true;
	} else{
		return false;
	}
}

  function activateYFilter() {
    const iframe = document.getElementById("y-filter-iframe");
    iframe.style.display = "block";
    iframe.contentWindow.postMessage("activateYFilter", "*");
  }

  window.addEventListener("message", function(event) {
    if (event.data === "iframeLoaded") {
      const urlParams = new URLSearchParams(window.location.search);
      const filter = urlParams.get("filter");

      if (filter !== null && filter === "y") {
        activateYFilter();
      }
    }
  });
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
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="oneMusic-main-menu">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                        <!-- Nav brand -->
                        <a href="../main.jsp" class="nav-brand"><img src="../img/core-img/logo.png" alt=""></a>

                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- Close Button -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Nav Start -->
                            <div class="classynav">
                                <ul>
                                    <li><a href="../main.jsp">Home</a></li>
                                    <li><a href="../album.jsp">Album</a></li>
                                    <li><a href="#">Manage</a>
                                        <ul class="dropdown">
                                            <li><a href="../main.jsp">Home</a></li>
                                            <li><a href="../album.jsp">Album</a></li>
                                            <li><a href="../connection.jsp">Contact</a></li>
                                            <li><a href="#">매니저</a>
                                                <ul class="dropdown">
                                                    <li><a href="../customer/mypage.jsp">내정보</a></li>                                                
                                                    <li><a href="admin.jsp">회원목록</a></li>
                                                    <li><a href="artist.jsp">아티스트목록</a></li>
                                                    <li><a href="host.jsp">관리자목록</a></li>
                                                    <li><a href="#">Even Dropdown</a>
                                                        <ul class="dropdown">
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="#">Even Dropdown</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <!--  
                                    <li><a href="event.html">Events</a></li>
                                    <li><a href="blog.html">News</a></li>
                                    -->
                                    <li><a href="../connection.jsp">Contact</a></li>
                                </ul>
<% 
	if(user_id == null) {
%>
                                <!-- Login/Register & Cart Button -->
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../login/login.jsp" id="loginBtn">Login / Register</a>
                                    </div>
								
<% 
	} else {
		if(code.equals("100")){
%>
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../customer//mypage.jsp" id="loginBtn"><%=user_id %> 님</a>
                                    </div>
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../login/logout.jsp" id="loginBtn">Logout</a>
                                    </div>
                                    <!-- Cart Button -->
                                    <div class="cart-btn">
                                        <p><span class="icon-shopping-cart" onclick="return cart()"></span> </p>
                                    </div>                                                                  
<% 
		} else if(code.equals("200")){
%>
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../admin/admin.jsp" id="loginBtn"><%=user_id %> 관리자님</a>
                                    </div>
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../login/logout.jsp" id="loginBtn">Logout</a>
                                    </div>
                                    <!-- Cart Button -->
                                    <div class="cart-btn">
                                        <p><span class="icon-shopping-cart" onclick="return cart()"></span> </p>
                                    </div>                                                                        	
<% 
		} else if(code.equals("300")){
%>
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../artist/atist.jsp" id="loginBtn">아티스트 <%=name %> 님</a>
                                    </div>	
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../login/logout.jsp" id="loginBtn">Logout</a>
                                    </div>
                                    <!-- Cart Button -->
                                    <div class="cart-btn">
                                        <p><span class="icon-shopping-cart" onclick="return cart()"></span> </p>
                                    </div>                                                                        
<%			
		}
	}
%>
                                </div>
                            </div>
                            <!-- Nav End -->

                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </header>
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
    	<ul style="padding-top:20px;">
			<li><a href="admin.jsp"><b>회원목록</b></a></li><br>
			<li><a href="host.jsp"><b>관리자목록</b></a></li><br>
			<li><a href="artist.jsp"><b>아티스트목록</b></a></li><br>
			<li><a href="musicManage.jsp"><b>음원목록</b></a></li><br>
			<li><a href="../customer/mypage.jsp"><b>내정보</b></a></li>	    	
    	</ul>
    </aside>
    
    <!-- ##### Login Area Start ##### -->
    <section class="login-area section-padding-100">
        <div class="admin-container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="member-content">
                        <h3>Artist Management</h3><br>
                        <!-- Membership manage Form -->
                        <div class="member-manage-form">
                        <table>
                        	<tr><th>이름</th><th>아이디</th><th>비밀번호</th><th>성별</th><th>생년월일</th><th>전화번호</th><th>주소</th><th>이메일</th><th>고유번호</th></tr>
                        	<%
                        	String sql = "SELECT * FROM member WHERE code = 300";
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
                        		<td><button onclick="location.href='delete.jsp?id=<%=rs.getString("id")%>&code=<%=rs.getString("code")%>'">Delete</button></td>
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
                    <a href="#"><img src="../img/core-img/logo.png" alt=""></a>
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