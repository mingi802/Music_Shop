<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <c:set var="contextPath" value="${pageContext.request.contextPath}"/> <!-- ${contextPath} -->
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
    <script>
    window.onload = function () {
  	  var cmbbtn = document.getElementById('chosen-song-buy-btn');
  	  var ambbtn = document.getElementById('all-song-buy-btn');
  	  var cart_items = document.querySelectorAll("div.cart-item");
  	  var total_payment = document.getElementById('total-payment'); 
  	  console.log(cart_items);
  	  cart_items.forEach(function(cart_item) {
  		  var cart_item_checked = cart_item.getElementsByClassName("cart-item-checked")[0];
  		  console.log(cart_item_checked);
  		  var cart_item_price = cart_item.getElementsByClassName("cart-item-price")[0].innerText;
  		  
  		  cart_item_price = parseInt(cart_item_price);
  		  
  		  cart_item_checked.addEventListener('change', function (event){
  			console.log(event.target.checked);
  			if(event.target.checked) {
  				total_payment.innerText = parseInt(total_payment.innerText) + cart_item_price;
  			} 
  			else {
  				total_payment.innerText = parseInt(total_payment.innerText) - cart_item_price;
  			}
  		  });
  	  });
  	  
  	  cmbbtn.addEventListener('click', function(){
  		//requestPay();
  	  });
  	  ambbtn.addEventListener('click', function(){
  		cart_items.forEach(function(cart_item) {
    		  var cart_item_checked = cart_item.getElementsByClassName("cart-item-checked")[0];
    		  if(!cart_item_checked.checked) {
    			  cart_item_checked.click();  
    		  }
  		});
  		//requestPay();
	  });
    }

  <%
	String user_id = (String) session.getAttribute("id");
	String code = (String) session.getAttribute("code");
	String name = (String) session.getAttribute("name");
  %> 
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
                                            <%
                                            if(code.equals("100")){
                                            %>
                                            <li><a href="#">소비자</a>
                                                <ul class="dropdown">
                                                    <li><a href="#">내정보</a></li>
                                                    <li><a href="#">장바구니</a></li>
                                                    <li><a href="#">구매내역</a></li>
                                                    <li><a href="#">소비자4</a>
                                                        <ul class="dropdown">
                                                            <li><a href="#">소비자</a></li>
                                                            <li><a href="#">소비자</a></li>
                                                            <li><a href="#">소비자</a></li>
                                                            <li><a href="#">소비자</a></li>
                                                            <li><a href="#">소비자</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="#">소비자5</a></li>
                                                </ul>
                                            </li> 
                                            <%
                                            } else if(code.equals("200")){
                                            %> 
                                            <li><a href="#">Manage</a>
                                                <ul class="dropdown">
                                                    <li><a href="customer/mypage.jsp">내정보</a></li>
                                                    <li><a href="admin/admin.jsp">회원목록</a></li>
                                                    <li><a href="admin/artist.jsp">아티스트목록</a></li>
                                                    <li><a href="admin/host.jsp">관리자목록</a></li>
                                                    <li><a href="#">몰?루</a>
                                                        <ul class="dropdown">
                                                            <li><a href="#">몰?루<</a></li>
                                                            <li><a href="#">몰?루<</a></li>
                                                            <li><a href="#">몰?루<</a></li>
                                                            <li><a href="#">몰?루<</a></li>
                                                            <li><a href="#">몰?루<</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="#">몰?루</a></li>
                                                </ul>
                                            </li>
                                            <%
                                            } else if(code.equals("300")) {
                                            %>
                                            <li><a href="#">Artist</a>
                                                <ul class="dropdown">
                                                    <li><a href="customer/mypage.jsp">내정보</a></li>
                                                    <li><a href="artist/artist.jsp">음원 등록 및 목록</a></li>
                                                    <li><a href="#"></a></li>
                                                    <li><a href="#">몰?루</a>
                                                        <ul class="dropdown">
                                                            <li><a href="#">몰?루<</a></li>
                                                            <li><a href="#">몰?루<</a></li>
                                                            <li><a href="#">몰?루<</a></li>
                                                            <li><a href="#">몰?루<</a></li>
                                                            <li><a href="#">몰?루<</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="#">몰?루</a></li>
                                                </ul>
                                            </li>                                            
                                            <%
                                            }
                                            %>                                            
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
                                        <a href="customer/mypage.jsp" id="loginBtn"><%=user_id %> 님</a>
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
                                        <a href="atist.jsp" id="loginBtn">아니트스 <%=name %> 님</a>
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
        	<hr>       
            <div class="row d-flex">
                <!-- Single Album Area -->
                <div class="col-12 align-content-around">
                    <div class="single-album-area d-flex flex-row cart-item">
                    	<div class="align-self-center">
	                		<input type="checkbox" class="cart-item-checked" id="cart-item-checked" name="cart-item-checked">
	                	</div>
                        <div class="album-thumb col-1">
                            <label for="cart-item-checked">
                            <img src="resource/img/younha.jpg" alt="">
                            </label>
                        </div>
	  					<div class="album-info align-self-end">
						<!-- 윤하 앨범 정보를 클릭했을 때 album.jsp 페이지로 이동 -->
							<a href="album.jsp?filter=y">
	 							 <h5>윤하1</h5>
							</a>	
	                        	<p>사건의 지평선</p>
	                    </div>
	                    <div class="col-9 align-self-center">
	                    	<audio preload="auto" controls>
                            <source src="resource/audio/eventhorizon.mp3">
                            </audio>
	                    </div>
	                    <div class="align-self-end">
	                    	<span class="cart-item-price"><b>900</b></span>
	                    	<span><b>원</b></span>
	                    	<p></p> <!-- 이 태그가 없으면 모양이 조금 깨지네요.. -->
	                    </div>
  						</div>
                    </div>
                </div>
                
                <div class="row d-flex">
                <!-- Single Album Area -->
                <div class="col-12 align-content-around">
                    <div class="single-album-area d-flex flex-row cart-item">
                    	<div class="align-self-center">
	                		<input type="checkbox" class="cart-item-checked" id="cart-item-checked" name="cart-item-checked">
	                	</div>
                        <div class="album-thumb col-1">
                            <label for="cart-item-checked">
                            <img src="resource/img/younha.jpg" alt="">
                            </label>
                        </div>                        
	  					<div class="album-info align-self-end">
						<!-- 윤하 앨범 정보를 클릭했을 때 album.jsp 페이지로 이동 -->
							<a href="album.jsp?filter=y">
	 							 <h5>윤하2</h5>
							</a>	
	                        	<p>사건의 지평선</p>
	                    </div>
	                    <div class="col-9 align-self-center">
	                    	<audio preload="auto" controls ontimeupdate="limitPlayTime(this);">
                            <source src="resource/audio/eventhorizon.mp3">
                            </audio>
	                    </div>
	                    <div class="align-self-end">
	                    	<span class="cart-item-price"><b>900</b></span>
	                    	<span><b>원</b></span>
	                    	<p></p> <!-- 이 태그가 없으면 모양이 조금 깨지네요.. -->
	                    </div>
  						</div>
                    </div>
                </div>
                
                <div class="row d-flex">
                <!-- Single Album Area -->
                <div class="col-12 align-content-around">
                    <div class="single-album-area d-flex flex-row cart-item">
                    	<div class="align-self-center">
	                		<input type="checkbox" class="cart-item-checked" id="cart-item-checked" name="cart-item-checked">
	                	</div>
                        <div class="album-thumb col-1">
                            <label>
                            <img src="resource/img/younha.jpg" alt="">
                            </label>
                        </div>                        
	  					<div class="album-info align-self-end">
						<!-- 윤하 앨범 정보를 클릭했을 때 album.jsp 페이지로 이동 -->
							<a href="album.jsp?filter=y">
	 							 <h5>윤하3</h5>
							</a>	
	                        	<p>사건의 지평선</p>
	                    </div>
	                    <div class="col-9 align-self-center">
	                    	<audio preload="auto" controls>
                            <source src="resource/audio/eventhorizon.mp3">
                            </audio>
	                    </div>
	                    <div class="align-self-end">
	                    	<span class="cart-item-price"><b>900</b></span>
	                    	<span><b>원</b></span>
	                    	<p></p> <!-- 이 태그가 없으면 모양이 조금 깨지네요.. -->
	                    </div>
  						</div>
                    </div>
                </div>
                
                <div class="row d-flex">
                <!-- Single Album Area -->
                <div class="col-12 align-content-around">
                    <div class="single-album-area d-flex flex-row cart-item">
                    	<div class="align-self-center">
	                		<input type="checkbox" class="cart-item-checked" id="cart-item-checked" name="cart-item-checked">
	                	</div>
                        <div class="album-thumb col-1">
                            <label for="cart-item-checked">
                            <img src="resource/img/younha.jpg" alt="">
                            </label>
                        </div>                        
	  					<div class="album-info align-self-end">
						<!-- 윤하 앨범 정보를 클릭했을 때 album.jsp 페이지로 이동 -->
							<a href="album.jsp?filter=y">
	 							 <h5>윤하4</h5>
							</a>	
	                        	<p>사건의 지평선</p>
	                    </div>
	                    <div class="col-9 align-self-center">
	                    	<audio preload="auto" controls>
                            <source src="resource/audio/eventhorizon.mp3">
                            </audio>
	                    </div>
	                    <div class="align-self-end">
	                    	<span class="cart-item-price"><b>900</b></span>
	                    	<span><b>원</b></span>
	                    	<p></p> <!-- 이 태그가 없으면 모양이 조금 깨지네요.. -->
	                    </div>
  						</div>
                    </div>
                </div>
                
                <div class="mr-auto ">
            		<span>총 결제 금액: </span>
            		<span id="total-payment">0</span>
            		<span>원</span>
           		</div>
            </div>
            <hr>
            <div class="d-flex flex-row justify-content-center align-items-center">
            	<div>
            		<input type="button" id="chosen-song-buy-btn" class="btn btn-outline-dark btn-lg" type="button" value="선택된 음원 구매">
    				<input type="button" id="all-song-buy-btn" class="btn btn-outline-danger btn-lg" type="button" value="전체 음원 구매">
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