<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" import="java.util.ArrayList" import="java.util.List" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="album.AlbumVO" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<jsp:useBean id="ALBUM" class="album.AlbumName"/>
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
    <link rel="icon" href="${contextPath}/img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="${contextPath}/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>console.log("${contextPath}", "${albumList.size()}");</script>
<%
String user_id = (String) session.getAttribute("id");
String code = (String) session.getAttribute("code");
String name = (String) session.getAttribute("name");
//String user_id = "곽두팔"; // 로그그인 된 경우, 예시 아이디
//String code = "100";	// 로그인이 된 경우, 예시 구분 코드 / 100 : 소비자, 200 : 관리자 , 300 : 아티스트
%>
<script>
	function showAllAlbum() {
		  window.location.href="${contextPath}/Album/album/showAllAlbum.do";
	}
	  
	if(${empty albumList} && !${empty isSearch ? false : isSearch}) {
		  //alert("첫 입장, 전체 앨범 리스트 가져오기");
		  showAllAlbum();
	  }

	$(document).ready(function() {  
	  var $grid = $('.oneMusic-albums').isotope({
          itemSelector: '.single-album-item',
          percentPosition: true,
          masonry: {
              columnWidth: '.single-album-item'
          }
      });
  
  	//검색 바 기능 구현
    if(${not empty albumList}) {
    	console.log("검색 결과 있음");
    	var albumList = new Array();
    	<c:forEach items="${albumList}" var="album">
    		albumList.push({
    			id: "${album.id}",
    			album: "${album.album}",
    			title: "${album.title}",
    			singer: "${album.singer}",
    			now: "${album.now}",
    			//price: "${album.price}",
    			sign: "${album.sign}",
    			song: "${album.song}"
    		});
    		console.log(albumList.slice(-1)); //앨범리스트의 마지막 요소 출력
    	</c:forEach>
    	$grid.isotope({ 
    		//검색한 앨범명에 맞는 앨범만 보여주기 위해 filter에 함수를 집어넣었음.
    		filter: function() {
    			var albumName = $(this).find('.album-info p').text(); //앨범 명 추출
    			var filterValue = false;	
    			albumList.some(function (album) {	
    				//some은 foreach와 비슷하나 foreach는 반복을 멈추기 힘드나 some은 콜백함수가 1번이라도 true를 리턴하면 멈춘다.
    				console.log(filterValue, albumName);
    				if(album.album == albumName) {
    					//albumList를 돌면서 추출한 앨범명과 일치한 앨범명이 있으면 페이지에 보여지도록 filterValue를 true로 변경 후 반복 종료
    					filterValue = true;
    					return true;
    				}
    			});
    			console.log(filterValue);
    			return filterValue;
    		}
    		
		});
    } else {
    	console.log("검색 결과 없음");
    }
    
    $(".browse-by-catagories").on("click", "a", function(e) {
      e.preventDefault();
      if($(this).prop("id")=="browse-all" && !${empty isAll ? false : isAll}) //첫 입장 시 isAll은 비어있는데 그러면 ${isAll}로 할 경우 스크립트가 작성되다가 에러가 잡혀 페이지가 정상 작동하지않아 비어있다면 false를 넣어주어 막았다.
    	//isAll은 가져온 앨범이 db에 저장된 앨범 전체인지 알려주는 변수임. 만약 isAll이 false라면 browse all은 모든 앨범 목록을 보여줘야하기 때문에
    	//showAllAlbum()함수를 호출하는 것
      	showAllAlbum();
      else {
    	//반대로 isAll이 true이면 isotope의 filter로 모든 앨범을 보여줄 수 있기 때문에 굳이 showAllAlbum()함수를 호출할 필요가 없음.
    	//showAllAlbum()함수는 서블릿에게 요청하고 다시 받아와 페이지가 전체 갱신되기에 필요한 때만 사용하기 위함.
    	  $(".browse-by-catagories a.active").removeClass("active");
          $(this).addClass("active");
          var filterValue = $(this).attr("data-filter");
          console.log(typeof($(this).attr("data-filter")));
          $grid.isotope({ filter: filterValue });  
      }
    });
	
    // URL 쿼리 기준 필터 활성화
    const urlParams = new URLSearchParams(window.location.search);
    const filterValue = urlParams.get("filter");
    
    if (filterValue) {
      const filterLink = $(".browse-by-catagories a[data-filter='." + filterValue + "']");
      if (filterLink.length > 0) {
        filterLink.trigger("click");
      }
    }
    
  });
	
  function cart(){
		if(confirm('장바구니로 이동하시겠습니까?')){
			window.location.href="${contextPath}/cart.jsp";
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
    <header class="header-area">
        <!-- Navbar Area -->
        <div class="oneMusic-main-menu">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="oneMusicNav">

                        <!-- Nav brand -->
                        <a href="${contextPath}/main.jsp" class="nav-brand"><img src="${contextPath}/img/core-img/lologo.png" alt=""></a>

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
                                	<%
                                    if(code != null){
                                    %>
                                		<li><a href="${contextPath}/my_song.jsp">MySong</a></li>
                                	<%} 
                                	%>
                                    <li><a href="${contextPath}/main.jsp">Home</a></li>
                                    <li><a href="${contextPath}/album.jsp">Album</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="${contextPath}/main.jsp">Home</a></li>
                                            <li><a href="${contextPath}/album.jsp">Album</a></li>
                                            <li><a href="${contextPath}/connection.jsp">Contact</a></li>
                                            <li><a href="${contextPath}/review/review.jsp">Review</a></li>                                            
                                            <%
                                            if(code != null){
                                            	if(code.equals("100")){
                                            %>
                                            <li><a href="#">User</a>
                                                <ul class="dropdown">
                                                    <li><a href="${contextPath}/customer/mypage.jsp">내 정보</a></li>
                                                    <li><a href="${contextPath}/cart.jsp">장바구니</a></li>
                                                    <li><a href="${contextPath}/my_song.jsp">구매내역</a></li>
                                                </ul>
                                            </li> 
                                            <%
                                            } else if(code.equals("200")){
                                            %> 
                                            <li><a href="#">Manager</a>
                                                <ul class="dropdown">
                                                	<li><a href="${contextPath}/customer/mypage.jsp">내정보</a></li>
                                                    <li><a href="${contextPath}/admin/admin.jsp">회원목록</a></li>
                                                    <li><a href="${contextPath}/admin/host.jsp">관리자목록</a></li>
                                                    <li><a href="${contextPath}/admin/artist.jsp">아티스트목록</a></li>
                                                    <li><a href="${contextPath}/review/review.jsp">게시판관리</a></li>
                                                    <li><a href="${contextPath}/admin/musicManage.jsp">앨범관리</a></li>
                                                </ul>
                                            </li>
                                            <%
                                            } else if(code.equals("300")) {
                                            %>
                                            <li><a href="#">Artist</a>
                                                <ul class="dropdown">
                                                    <li><a href="${contextPath}/customer/mypage.jsp">내정보</a></li>
                                                    <li><a href="${contextPath}/artist/artist.jsp">음원 등록</a></li>
                                                    <li><a href="${contextPath}/artist/music_delete.jsp">음원관리</a></li>
                                                </ul>
                                            </li>                                            
                                            <%
                                            	}
                                            }
                                            %>                                            
                                        </ul>
                                    </li>
                                    <!--  
                                    <li><a href="event.html">Events</a></li>
                                    <li><a href="blog.html">News</a></li>
                                    -->
                                    <li><a href="${contextPath}/connection.jsp">Contact</a></li>
                                </ul>
<% 
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
                                        <a href="${contextPath}/artist/artist.jsp" id="loginBtn">아티스트 <%=name %> 님</a>
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
    <!-- ##### Header Area End ##### -->

    <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${contextPath}/img/bg-img/breadcumb3.jpg);">
        <div class="bradcumbContent">
            <p>See what’s new</p>
            <h2>Latest Albums</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Album Catagory Area Start ##### -->
    <section class="album-catagory section-padding-100-0">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="browse-by-catagories d-flex flex-wrap align-items-center mb-30">
                        <a id="browse-all" href="#" data-filter="*">Browse All</a>
                        <a href="#" data-filter=".a">A</a>
                        <a href="#" data-filter=".b">B</a>
                        <a href="#" data-filter=".c">C</a>
                        <a href="#" data-filter=".d">D</a>
                        <a href="#" data-filter=".e">E</a>
                        <a href="#" data-filter=".f">F</a>
                        <a href="#" data-filter=".g">G</a>
                        <a href="#" data-filter=".h">H</a>
                        <a href="#" data-filter=".i">I</a>
                        <a href="#" data-filter=".j">J</a>
                        <a href="#" data-filter=".k">K</a>
                        <a href="#" data-filter=".l">L</a>
                        <a href="#" data-filter=".m">M</a>
                        <a href="#" data-filter=".n">N</a>
                        <a href="#" data-filter=".o">O</a>
                        <a href="#" data-filter=".p">P</a>
                        <a href="#" data-filter=".q">Q</a>
                        <a href="#" data-filter=".r">R</a>
                        <a href="#" data-filter=".s">S</a>
                        <a href="#" data-filter=".t">T</a>
                        <a href="#" data-filter=".u">U</a>
                        <a href="#" data-filter=".v">V</a>
                        <a href="#" data-filter=".w">W</a>
                        <a href="#" data-filter=".x">X</a>
                        <a href="#" data-filter=".y">Y</a>
                        <a href="#" data-filter=".z">Z</a>
                    </div>
                    <div class="browse-by-catagories d-flex flex-wrap align-items-center mb-30">
                    	<a id="browse-all" href="#" data-filter="*" style="visibility: hidden">Browse All</a>
                        <a href="#" data-filter=".ㄱ">ㄱ</a>
                        <a href="#" data-filter=".ㄲ">ㄲ</a>
                        <a href="#" data-filter=".ㄴ">ㄴ</a>
                        <a href="#" data-filter=".ㄷ">ㄷ</a>
                        <a href="#" data-filter=".ㄸ">ㄸ</a>
                        <a href="#" data-filter=".ㄹ">ㄹ</a>
                        <a href="#" data-filter=".ㅁ">ㅁ</a>
                        <a href="#" data-filter=".ㅂ">ㅂ</a>
                        <a href="#" data-filter=".ㅃ">ㅃ</a>
                        <a href="#" data-filter=".ㅅ">ㅅ</a>
                        <a href="#" data-filter=".ㅆ">ㅆ</a>
                        <a href="#" data-filter=".ㅇ">ㅇ</a>
                        <a href="#" data-filter=".ㅈ">ㅈ</a>
                        <a href="#" data-filter=".ㅉ">ㅉ</a>
                        <a href="#" data-filter=".ㅊ">ㅊ</a>
                        <a href="#" data-filter=".ㅋ">ㅋ</a>
                        <a href="#" data-filter=".ㅌ">ㅌ</a>
                        <a href="#" data-filter=".ㅍ">ㅍ</a>
                        <a href="#" data-filter=".ㅎ">ㅎ</a>
                        <a href="#" data-filter=".number">0-9</a>
                    </div>
                </div>
            </div>
            
			<div class="row">
			    <form id="search-form" class="w-100 me-3" method="post" action="${contextPath}/Album/album/albumSearch.do">
			    <!--
			     
			    ${contextPath}/Album/album/albumSearch.do 이 부분이 
			    String action = path.substring(path.lastIndexOf("/")); 때문에 /albumSearch.do로 되는 건가요?
			    
			     -->
					<div class="d-flex flex-row align-items-center mb-30">
				        <div class="col-11 pe-0">
				        <input type="search" class="form-control" id="searchBar" name="searchBar" placeholder="Search..." required aria-label="Search">
						</div>
						<div>				        
				        <input type="submit" class="form-submit img-btn" id="searchBtn" name="searchBtn">
				        </div>
					</div>                	
				</form>
            </div>
			
			
            <div class="row oneMusic-albums">
                <!-- Single Album -->
				<c:choose>
					<c:when test="${not empty albumList}">
						<c:forEach items="${albumList}" var="album">
							<c:set var="classForFiltering" value="${ALBUM.getClassNameByAlbumName(album.album)}"/>
							<div class="col-12 col-sm-4 col-md-3 col-lg-2 single-album-item ${classForFiltering}">
			                    <div class="single-album">
			                        <img src="${contextPath}/resource/img/${album.sign}" alt="${album.title}"> <!-- 앨범 이미지 -->
			                    <audio>
			                    	<source src="${contextPath}/resource/audio/${album.song}">
			                    </audio>
			                        <div class="album-info">
			                            <a href="${contextPath}/Album/album_songs/showOneAlbum.do?album_id=${album.id}"> <!-- 경로(수정) -->
			                                <h6 class="singer">${album.singer}</h6> <!-- 가수 -->
			                            </a>
			                            <p class="album">${album.album}</p><!-- 앨범 이름 -->
			                        </div>
			                    </div>
			                </div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<div class="col-12 d-flex justify-content-center single-album-item">
							<div class="no-album">
								<img src="${contextPath}/resource/img/not found.png" alt="">
								<div class="no-info">
			                    	<h5>검색 결과가 없습니다.</h5>
			                    </div>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
            </div>
        </div>
    </section>
    <!-- ##### Album Catagory Area End ##### -->

    <!-- ##### Buy Now Area Start ##### 
    <div class="oneMusic-buy-now-area mb-100">
        <div class="container">
            <div class="row">

                
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="single-album-area">
                        <div class="album-thumb">
                            <img src="${contextPath}/img/bg-img/b1.jpg" alt="">
                            <div class="album-price">
                                <p>$0.90</p>
                            </div>
                            <div class="play-icon">
                                <a href="#" class="video--play--btn"><span class="icon-play-button"></span></a>
                            </div>
                        </div>
                        <div class="album-info">
                            <a href="#">
                                <h5>Garage Band</h5>
                            </a>
                            <p>Radio Station</p>
                        </div>
                    </div>
                </div>

                
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="single-album-area">
                        <div class="album-thumb">
                            <img src="${contextPath}/img/bg-img/b2.jpg" alt="">
                        </div>
                        <div class="album-info">
                            <a href="#">
                                <h5>Noises</h5>
                            </a>
                            <p>Buble Gum</p>
                        </div>
                    </div>
                </div>

                
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="single-album-area">
                        <div class="album-thumb">
                            <img src="${contextPath}/img/bg-img/b3.jpg" alt="">
                        </div>
                        <div class="album-info">
                            <a href="#">
                                <h5>Jess Parker</h5>
                            </a>
                            <p>The Album</p>
                        </div>
                    </div>
                </div>

               
                <div class="col-12 col-sm-6 col-md-3">
                    <div class="single-album-area">
                        <div class="album-thumb">
                            <img src="${contextPath}/img/bg-img/b4.jpg" alt="">
                        </div>
                        <div class="album-info">
                            <a href="#">
                                <h5>Noises</h5>
                            </a>
                            <p>Buble Gum</p>
                        </div>
                    </div>
                </div>

            </div>

            <div class="row">
                <div class="col-12">
                    <div class="load-more-btn text-center">
                        <a href="#" class="btn oneMusic-btn">Load More <i class="fa fa-angle-double-right"></i></a>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    	 ##### Buy Now Area End ##### -->

    <!-- ##### Add Area Start ##### 
    <div class="add-area mb-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="adds">
                        <a href="#"><img src="${contextPath}/img/bg-img/add3.gif" alt=""></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Add Area End ##### -->

    <!-- ##### Song Area Start ##### 
    <div class="one-music-songs-area mb-70">
        <div class="container">
            <div class="row">

                <!-- Single Song Area 
                <div class="col-12">
                    <div class="single-song-area mb-30 d-flex flex-wrap align-items-end">
                        <div class="song-thumbnail">
                            <img src="${contextPath}/img/bg-img/s1.jpg" alt="">
                        </div>
                        <div class="song-play-area">
                            <div class="song-name">
                                <p>01. Main Hit Song</p>
                            </div>
                            <audio preload="auto" controls>
                                <source src="${contextPath}/resource/audio/dummy-audio.mp3">
                            </audio>
                        </div>
                    </div>
                </div>

                <!-- Single Song Area 
                <div class="col-12">
                    <div class="single-song-area mb-30 d-flex flex-wrap align-items-end">
                        <div class="song-thumbnail">
                            <img src="${contextPath}/img/bg-img/s2.jpg" alt="">
                        </div>
                        <div class="song-play-area">
                            <div class="song-name">
                                <p>01. Main Hit Song</p>
                            </div>
                            <audio preload="auto" controls>
                                <source src="${contextPath}/resource/audio/dummy-audio.mp3">
                            </audio>
                        </div>
                    </div>
                </div>

                <!-- Single Song Area 
                <div class="col-12">
                    <div class="single-song-area mb-30 d-flex flex-wrap align-items-end">
                        <div class="song-thumbnail">
                            <img src="${contextPath}/img/bg-img/s3.jpg" alt="">
                        </div>
                        <div class="song-play-area">
                            <div class="song-name">
                                <p>01. Main Hit Song</p>
                            </div>
                            <audio preload="auto" controls>
                                <source src="${contextPath}/resource/audio/dummy-audio.mp3">
                            </audio>
                        </div>
                    </div>
                </div>

                <!-- Single Song Area 
                <div class="col-12">
                    <div class="single-song-area mb-30 d-flex flex-wrap align-items-end">
                        <div class="song-thumbnail">
                            <img src="${contextPath}/img/bg-img/s4.jpg" alt="">
                        </div>
                        <div class="song-play-area">
                            <div class="song-name">
                                <p>01. Main Hit Song</p>
                            </div>
                            <audio preload="auto" controls>
                                <source src="${contextPath}/resource/audio/dummy-audio.mp3">
                            </audio>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- ##### Song Area End ##### -->

    <!-- ##### Contact Area Start ##### 
    <section class="contact-area section-padding-100 bg-img bg-overlay bg-fixed has-bg-img" style="background-image: url(${contextPath}/img/bg-img/bg-2.jpg);">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading white">
                        <p>See what’s new</p>
                        <h2>Get In Touch</h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <!-- Contact Form Area 
                    <div class="contact-form-area">
                        <form action="#" method="post">
                            <div class="row">
                                <div class="col-md-6 col-lg-4">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="name" placeholder="Name">
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4">
                                    <div class="form-group">
                                        <input type="email" class="form-control" id="email" placeholder="E-mail">
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <input type="text" class="form-control" id="subject" placeholder="Subject">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-group">
                                        <textarea name="message" class="form-control" id="message" cols="30" rows="10" placeholder="Message"></textarea>
                                    </div>
                                </div>
                                <div class="col-12 text-center">
                                    <button class="btn oneMusic-btn mt-30" type="submit">Send <i class="fa fa-angle-double-right"></i></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Contact Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area">
        <div class="container">
            <div class="row d-flex flex-wrap align-items-center">
                <div class="col-12 col-md-6">
                    <a href="${contextPath}/main.jsp"><img src="${contextPath}/img/core-img/lologo.png" alt=""></a>
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
    <!-- ##### Footer Area Start ##### -->

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