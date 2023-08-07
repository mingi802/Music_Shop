<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page session="true"%>
<%@ include file="../mydbcon.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>      
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>One Music - Modern Music HTML5 Template</title>

    <!-- Favicon -->
    <link rel="icon" href="../img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="../style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%
String user_id = (String) session.getAttribute("id");
String code = (String) session.getAttribute("code");
String name = (String) session.getAttribute("name");
%>
	<script>
/*함수를 집어 넣는 부분*/
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
                                    <li><a href="../album.jsp">Albums</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="../main.jsp">Home</a></li>
                                            <li><a href="../album.jsp">Albums</a></li>
                                            <li><a href="../connection.jsp">Contact</a></li>
                                            <li><a href="../login/login.jsp">Login</a></li>
                                            <li><a href="#">Artist</a>
                                                <ul class="dropdown">
                                                    <li><a href="artist.jsp">음원등록</a></li>
                                                    <li><a href="#">음원목록</a></li>
                                                    <li><a href="../customer/mypage.jsp">내정보</a></li>
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
if(user_id == null){
%>
                                <!-- Login/Register & Cart Button -->
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="login.jsp" id="loginBtn">Login / Register</a>
                                    </div>
<%
} else {
	if(code.equals("300")){
%>
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="artist.jsp" id="loginBtn">아티스트 <%=name %> 님</a>
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
                                    <!-- Cart Button 
                                    <div class="cart-btn">
                                        <p><span class="icon-shopping-cart"></span> <span class="quantity">1</span></p>
                                    </div>
                                    -->
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
            <h2>음악 등록</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->
    
	<!-- ##### MusicList Area Start ##### -->
	<aside class="music-list">
    <section class="login-area section-padding-100_">
        <div class="music-list-container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="member-content">
                        <h3>음원 목록</h3><br>
                        <!-- Membership manage Form -->
                        <div class="music-list-form">
                        <table>
                        	<tr><th>앨범</th><th>제목</th><th>가수</th><th>발매일</th><th>가격</th><th>이미지 파일</th><th>음원 파일</th></tr>
                        	<%
                        	String sql = "SELECT * FROM song ";
                        	PreparedStatement pstmt = conn.prepareStatement(sql);
                        	ResultSet rs = pstmt.executeQuery();
                        	
                        	while(rs.next()){
                        	%>
                        		<tr style="test-align: center">
                        		<td><%=rs.getString("album") %></td>
                        		<td><%=rs.getString("title") %></td>
                        		<td><%=rs.getString("singer") %></td>
                        		<td><%=rs.getString("now") %></td>
                        		<td><%=rs.getString("price") %></td>
                        		<td><%=rs.getString("sign") %></td>
                        		<td><%=rs.getString("song") %></td>
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
	</aside>
	<!-- ##### MusicList Area End ##### -->
	
    <!-- ##### Login Area Start ##### -->
    <section class="login-area section-padding-100">
        <div class="upload-container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="upload-content">
                        <h3>음원 등록</h3>
                        <!-- Login Form -->
                        <div class="login-form">
                            <form name="Uploadform" action="${contextPath}/Music/addMusic.do" method="post" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="exampleAlbum">앨범</label>
                                    <input type="text" class="form-control" id="InputAlbum" aria-describedby="emailHelp" name="album" placeholder="Enter Album" minlength='1' required>
                                </div>                            
                                <div class="form-group">
                                    <label for="exampleTitle">노래제목</label>
                                    <input type="text" class="form-control" id="InputTitle" aria-describedby="emailHelp" name="title" placeholder="Enter Title" minlength='1' required>
                                </div>
                                <div class="form-group">
                                    <label for="exampleSinger">가수</label>
                                    <input type="text" class="form-control" id="InputSinger" name="singer" value="<%=name %>" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="exampleDate">발매일자</label>
                                    <input type="date" class="form-control" id="InputDate" name="date" placeholder="Password Date" required>
                                </div>                            
                                <div class="form-group">
                                    <label for="examplePrice">가격</label>
                                    <input type="text" class="form-control" id="InputPrice" aria-describedby="emailHelp" name="Price" placeholder="Enter Price" required>
                                    <!-- email을 text로 바꾸면 끝 -->
                                </div>
                                <div class="form-group">
                                    <label for="exampleImg">앨범 이미지</label>
                                    <input type="file" class="form-control" id="InputImg" name="img" accept="image/*" required>
                                </div>                                                                                                              
                                <div class="form-group">
                                    <label for="InputSong">음원</label>
                                    <input type="file" class="form-control" id="Inputsong" name="song" accept="audio/*" required>
                                </div>                                
                                <button type="submit" class="btn oneMusic-btn mt-30">등록</button>
                               </form>
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
                    <a href="#"><img src="img/core-img/logo.png" alt=""></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                </div>

                <div class="col-12 col-md-6">
                    <div class="footer-nav">
                        <ul>
                            <li><a href="../main.jsp">Home</a></li>
                            <li><a href="../album.jsp">Albums</a></li>
                            <li><a href="#">Events</a></li>
                            <li><a href="#">News</a></li>
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
    
	<script> 
	<%-- 오늘 날짜 이후는 선택 되지 않게 막는 스크립트--%>
		var now_utc = Date.now()
		var timeOff = new Date().getTimezoneOffset()*60000;
		var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
		document.getElementById("InputDate").setAttribute("max", today)
	</script>
</body>

</html>