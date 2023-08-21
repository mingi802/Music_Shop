<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" import="java.util.ArrayList" import="java.util.List" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="album.AlbumVO" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
    <title>MLP Music:: </title>

    <!-- Favicon -->
    <link rel="icon" href="${contextPath}/img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="${contextPath}/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>console.log("${contextPath}", "${songList.size()}");</script>
<%
String user_id = (String) session.getAttribute("id");
String code = (String) session.getAttribute("code");
String name = (String) session.getAttribute("name");
%>
<script>

	function goBack() {
		window.history.back();
	}
	
	if(${empty songList}) {
		alert("ERROR: 앨범이 없거나 불러오지 못했습니다.");
		goBack();
	} else{
		console.log("${songList[0].album}");
	}

	if(${not empty songList}){
		console.log("검색 결과 있음");
		var songList = new Array();
	<c:forEach items="${songList}" var="song">
		songList.push({
			album_name: "${song.album}",
			title: "${song.title}",
			singer: "${song.singer}",
			price: "${song.price}",
			name: "${song.name}",
			song: "${song.song}",
			sign: "${song.sign}"		
		});
		console.log(songList.slice(-1)); //앨범리스트의 마지막 요소 출력
	</c:forEach>
	} else{
		console.log("검색결과 없음");
	}
	
/*1분 미리듣기 함수*/
function limitPlayTime(audio) {
    if (audio.currentTime > 60) { // 1분(60초)로 제한
        audio.pause();
        audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
        alert("1분 미리듣기가 종료되었습니다.");
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
     <header class="header-area">
         <!-- Navbar Area -->
         <div class="oneMusic-main-menu">
             <div class="classy-nav-container breakpoint-off">
                 <div class="container">
                     <!-- Menu -->
                     <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                        <!-- Nav brand -->
                        <a href="${contextPath}/main.jsp" class="nav-brand"><img src="${contextPath}/img/core-img/logo.png" alt=""></a>

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

                            <div class="classynav">
                                <ul>
                                    <li><a href="${contextPath}/main.jsp">Home</a></li>
                                    <li><a href="${contextPath}/album.jsp">Album</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="${contextPath}/main.jsp">Home</a></li>
                                            <li><a href="${contextPath}/album.jsp">Album</a></li>
                                            <li><a href="${contextPath}/connection.jsp">Contact</a></li>
                                            <%
                                            if(code != null){
                                            	if(code.equals("100")){
                                            %>
                                            <li><a href="#">소비자</a>
                                                <ul class="dropdown">
                                                    <li><a href="${contextPath}/costomer/mypage.jsp">내정보</a></li>
                                                    <li><a href="${contextPath}/cart.jsp">장바구니</a></li>
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
                                            <li><a href="#">관리자</a>
                                                <ul class="dropdown">
                                                    <li><a href="${contextPath}/customer/mypage.jsp">내정보</a></li>
                                                    <li><a href="${contextPath}/admin/admin.jsp">회원목록</a></li>
                                                    <li><a href="${contextPath}/admin/artist.jsp">아티스트목록</a></li>
                                                    <li><a href="${contextPath}/admin/host.jsp">관리자목록</a></li>
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
                                            <li><a href="#">아티스트</a>
                                                <ul class="dropdown">
                                                    <li><a href="${contextPath}/artist/artist.jsp">음원 등록 및 목록</a></li>
                                                    <li><a href="${contextPath}/customer/mypage.jsp">내정보</a></li>
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
                                            }
                                            %>                                            
                                        </ul>
                                    </li>
                                    <li><a href="${contextPath}/connection.jsp">Contact</a></li>
                                </ul>
<% 
	//String user_id = "곽두팔"; // 로그그인 된 경우, 예시 아이디
	//String code = "100";	// 로그인이 된 경우, 예시 구분 코드 / 100 : 소비자, 200 : 관리자 , 300 : 아티스트
	if(user_id == null) {
%>
                                <!-- Login/Register & Cart Button -->
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="${contextPath}/login/login.jsp" id="loginBtn">Login / Register</a>
                                    </div>
								
<% 
	} else {
		if(code.equals("100")){
%>
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="${contextPath}/customer/mypage.jsp" id="loginBtn"><%=user_id %> 님</a>
                                    </div>
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="${contextPath}/login/logout.jsp" id="loginBtn">Logout</a>
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
                                        <a href="${contextPath}/admin/admin.jsp" id="loginBtn"><%=user_id %> 관리자님</a>
                                    </div>
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="${contextPath}/login/logout.jsp" id="loginBtn">Logout</a>
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
                                        <a href="${contextPath}/artist/atist.jsp" id="loginBtn">아티스트 <%=name %> 님</a>
                                    </div>	
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="${contextPath}/login/logout.jsp" id="loginBtn">Logout</a>
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
    
	<section class="featured-artist-area section-padding-100-50 bg-img bg-overlay bg-fixed" style="background-image: url(${contextPath}/img/bg-img/piano.jpg);">
	<!-- 타이틀 곡 -->
        <div class="container">
            <div class="row align-items-end">
                <div class="col-12 col-md-5 col-lg-4">
                    <div class="featured-artist-thumb">
                        <img src="${contextPath}/resource/img/${songList[0].sign}" alt="">
                    </div>
                </div>
                <div class="col-12 col-md-7 col-lg-8">
                    <div class="featured-artist-content">
                        <!-- Section Heading -->
                        <div class= "section-heading white text-left mb-30">
                            <h2>${songList[0].singer}</h2>
                            <p>${songList[0].album}</p><!-- songList -->
                            <div>
			            		<input type="button" id="album-buy-btn" class="btn btn-outline-light btn-lg" value="앨범 구매">
			    				&nbsp;&nbsp;&nbsp;&nbsp;
			    				<input type="button" id="album-like-btn" class="btn btn-outline-danger btn-lg" value="좋아요">
			            	</div>
                        </div>
                        <div class="song-play-area">
                        	<div class="song-name">
                                <p>${songList[0].name}</p>
                            </div>
                            <audio preload="auto" controls ontimeupdate="limitPlayTime(this);">
                            	<source src="${contextPath}/resource/audio/${songList[0].song}">
                            </audio>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <section class="gray-background section-padding-50-0">
    <!-- 타이틀곡 및 수록곡 -->
        <div class="container">
            <div class="row">
            <c:if test="${not empty songList}">
            <c:forEach items="${songList}" var="song">
				<div class="col-12 align-content-around row padding-bottom-20">
					<hr style="background-color: #000000; height: 1px !important; display: block !important; width: 100% !important;">
                    <div class="col-8 song-play-area-white">
						<div class="song-name">                               
							<p>${song.name}</p>
						</div>
                        <audio preload="auto" controls ontimeupdate="limitPlayTime(this);">
                           <source src="${contextPath}/resource/audio/${song.song}">
                        </audio>
                    </div>
	               	<div class="col-1 align-self-center mt-4">
	                   	<span class="cart-item-price"><b>${song.price}</b></span>
	                   	<span><b>￦</b></span>
					</div>
					<div class="col-3 align-self-center mt-4">
	                   	<input type="button" id="a-song-of-album-buy-btn" class="btn btn-outline-success btn-lg" value="음원 구매">
			   			&nbsp;&nbsp;&nbsp;&nbsp;
			    		<input type="button" id="a-song-of-album-like-btn" class="btn btn-outline-danger btn-lg" value="좋아요">
					</div>    
				</div>
				</c:forEach>
				</c:if>
            </div>
        </div>
    </section>
    <!-- ##### Miscellaneous Area End ##### -->
    
    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area navbar-fixed-bottom">
        <div class="container">
            <div class="row d-flex flex-wrap align-items-center">
                <div class="col-12 col-md-6">
                    <a href="#"><img src="${contextPath}/img/core-img/logo.png" alt=""></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                </div>

                <div class="col-12 col-md-6">
                    <div class="footer-nav">
                        <ul>
                            <li><a href="${contextPath}/main.jsp">Home</a></li>
                            <li><a href="${contextPath}/album.jsp">Albums</a></li>
                            <li><a href="${contextPath}/connection.jsp">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- ##### Featured Artist Area End ##### -->
        <!-- ##### Footer Area Start ##### -->
    <!-- ##### Header Area End ##### -->
       <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="${contextPath}/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="${contextPath}/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="${contextPath}/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="${contextPath}/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="${contextPath}/js/active.js"></script>
</body>
</html>