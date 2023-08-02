<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>Cart</title>

    <!-- Favicon -->
    <link rel="icon" href="img/core-img/shoppingBasket.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="style.css">
  <%
	String user_id = (String) session.getAttribute("id");
	String code = (String) session.getAttribute("code");
  %> 
    <script>
    function limitPlayTime(audio) {
        if (audio.currentTime > 60) { // 1분(60초)로 제한
            audio.pause();
            audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
            alert("1분 미리듣기가 종료되었습니다.");
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
<body class="d-flex flex-column min-vh-100">
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
                        <a href="main.jsp" class="nav-brand"><img src="img/core-img/logo.png" alt=""></a>

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
						<!--</div>  -->
                            <!-- Nav Start -->
                            <div class="classynav">
                                <ul>
                                    <li><a href="main.jsp">Home</a></li>
                                    <li><a href="album.jsp">Album</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="main.jsp">Home</a></li>
                                            <li><a href="album.jsp">Album</a></li>
                                            <!--  
                                            <li><a href="event.html">Events</a></li>
                                            <li><a href="blog.html">News</a></li>
                                            -->
                                            <li><a href="connection.jsp">Contact</a></li>
                                            <!--  
                                            <li><a href="elements.html">Elements</a></li>
                                            -->
                                            <li><a href="login/login.jsp">Login</a></li>
                                            <li><a href="#">Dropdown</a>
                                                <ul class="dropdown">
                                                    <li><a href="#">Even Dropdown</a></li>
                                                    <li><a href="#">Even Dropdown</a></li>
                                                    <li><a href="#">Even Dropdown</a></li>
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
                                    <li><a href="connection.jsp">Contact</a></li>
                                </ul>
                          <!--  </div>--> 
<% 
	//String user_id = "곽두팔"; // 로그그인 된 경우, 예시 아이디
	//String code = "100";	// 로그인이 된 경우, 예시 구분 코드 / 100 : 소비자, 200 : 관리자 , 300 : 아티스트
	if(user_id == null) {
%>
							<!-- Login/Register & Cart Button -->
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="login/login.jsp" id="loginBtn">Login / Register</a>
                                    </div>
<% 
	} else {
		if(code.equals("100")){
%>
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="mypage.jsp" id="loginBtn"><%=user_id %> 님</a>
                                    </div>
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="login/logout.jsp" id="loginBtn">Logout</a>
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
                                        <a href="admin/admin.jsp" id="loginBtn"><%=user_id %> 관리자님</a>
                                    </div>
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="login/logout.jsp" id="loginBtn">Logout</a>
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
                                        <a href="atist.jsp" id="loginBtn"><%=user_id %> 아티스트</a>
                                    </div>	
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="login/logout.jsp" id="loginBtn">Logout</a>
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
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(./img/bg-img/blog1.jpg);">
        <div class="bradcumbContent">
            <p>Cart Page</p>
            <h2>장바구니</h2>
        </div>
    </section>
<!-- ##### Buy Now Area Start ##### -->
    <section class="oneMusic-buy-now-area has-fluid bg-gray section-padding-100">
        <div class="container-fluid">        

            <div class="row d-flex">
                <!-- Single Album Area -->
                <div class="col-12 align-content-around">
                    <div class="single-album-area d-flex flex-row">
                    	<div class="align-self-center">
	                		<input type="checkbox" id="cart-item" name="cart-item">
	                	</div>
                        <div class="album-thumb col-1">
                            <label for="cart-item">
                            <img src="img/bg-img/younha.jpg" alt="">
                            </label>
                            <div class="album-price">
                                <p>$0.90</p>
                            </div>
                        </div>                        
	  					<div class="album-info align-self-end">
						<!-- 윤하 앨범 정보를 클릭했을 때 album.jsp 페이지로 이동 -->
							<a href="album.jsp?filter=y">
	 							 <h5>윤하</h5>
							</a>	
	                        	<p>사건의 지평선</p>
	                    </div>
	                    <div class="col-9 align-self-center">
	                    	<audio preload="auto" controls ontimeupdate="limitPlayTime(this);">
                            <source src="resource/audio/eventhorizon.mp3">
                            </audio>
	                    </div>
	                    <div class="align-self-center">
	                    	<span>0.90$</span>
	                    </div>
  						</div>
                    </div>
                </div>
            <div class="mr-auto ">
            		<span>총 결제 금액: </span>
            </div>
            <hr>
            <div class="d-flex flex-row justify-content-center align-items-center">
            	<div>
            		<input type="button" class="btn btn-outline-dark btn-lg" type="button" value="선택된 음원 구매">
    				<input type="button" class="btn btn-outline-danger btn-lg" type="button" value="전체 음원 구매">
            	</div>
    		</div>
    		<hr>
    </section>
    <!-- ##### Buy Now Area End ##### -->
    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area navbar-fixed-bottom">
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
                            <li><a href="main.jsp">Home</a></li>
                            <li><a href="album.jsp">Albums</a></li>
                            <!--  
                            <li><a href="#">Events</a></li>
                            <li><a href="#">News</a></li>
                            -->
                            <li><a href="connection.jsp">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ##### Footer Area Start ##### -->
    <!-- ##### Header Area End ##### -->
       <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="js/active.js"></script>
</body>
</html>