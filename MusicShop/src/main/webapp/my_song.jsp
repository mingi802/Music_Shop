<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="icon" href="${contextPath}/img/core-img/shoppingBasket.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="${contextPath}/style.css">
    <script>
    	
	    if(${empty mySongList} && ${not empty isFirstEntry ? isFirstEntry : true}) {
			 console.log("첫 입장, 구매 내역에 담긴 음원 리스트 가져오기");
			 window.location.href="${contextPath}/Music/showMySongList.do";
		}
	    
  <%
	String user_id = (String) session.getAttribute("id");
	String code = (String) session.getAttribute("code");
	String name = (String) session.getAttribute("name");
  %> 
	    
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
      	
		/*장바구니로 이동하는 함수 추가하기*/
		function cart(){
			if(confirm('장바구니로 이동하시겠습니까?')){
				window.location.href="${contextPath}/cart.jsp";
				return true;
			}else{
				return false;
		
			}
		}
		
		window.onload = function() {
			var mySongList = document.querySelectorAll("div.my-song");
			mySongList.forEach(function(mySong) {
				var songSrc = mySong.querySelector("div.song-play-area audio source").src;
				var downBtn = mySong.querySelector("div.down-btn p span");
				downBtn.addEventListener('click', (event) => songDownload(event, songSrc));
			});
		}
		function songDownload(event, songSrc) {
			console.log();
		}
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
	<jsp:include page="header.jsp"></jsp:include>
    <!-- ##### Header Area End ##### -->
        <!-- ##### Breadcumb Area Start ##### -->
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(${contextPath}/img/bg-img/blog1.jpg);">
        <div class="bradcumbContent">
            <p>My Song</p>
            <h2>구매 음원</h2>
        </div>
    </section>
<!-- ##### Buy Now Area Start ##### -->
    <section class="oneMusic-cart-area has-fluid bg-gray section-padding-100">    	
        <div class="container-fluid">
        	<hr>
        	<c:choose>        		
        		<c:when test="${not empty mySongList}">
		            <div class="row d-flex cart-item-list" id="cart-item-list">
		                <!-- Single Album Area -->
	                	<c:forEach items="${mySongList}" var="mySong">
			                <div class="col-12">
			                    <div class="d-flex flex-row cart-item my-song">
			                        <div class="col-1 album-thumb album-img-place">
			                        <!--앨범 이미지를 클릭했을 때 해당 앨범 상세 페이지로 이동 -->
			                            <a href="${contextPath}/Album/album_songs/showOneAlbum.do?album_id=${mySong.album_id}">
			                            	<img src="${contextPath}/resource/img/${mySong.album_sign}" alt="">
			                            </a>
			                        </div>
				  					<div class="col-1 album-info align-self-end">
									<!--가수 이름을 클릭했을 때 그 이름으로 검색된 album.jsp 페이지로 이동 -->
										<a href="${contextPath}/Album/album/albumSearch.do?searchBar=${mySong.singer}">
				 							 <h5>${mySong.singer}</h5>
										</a>	
				                        	<p class="cart-item-song-name">${mySong.song_name}</p>
				                    </div>
				                    <div class="col-9 song-play-area align-self-center">
				                        <audio preload="auto" controls>
				                           <source src="${contextPath}/resource/audio/${mySong.song_audio}">
				                        </audio>
				                    </div>
				                    <div class="col-1 align-self-around down-btn">														                    	
				                    	<p>
				                    		<a href="${contextPath}/resource/audio/${mySong.song_audio}" download="${mySong.song_audio}">
				                    		<span class="icon-download">
				                    			
				                    		</span>
				                    		</a>
				                    	<p>
				                    </div>
			  					</div>
			                </div>
	               		</c:forEach>
	               		</div>
	                </c:when>
	                <c:otherwise>
	                	<div class="col-12 d-flex justify-content-center single-album-item">
							<div class="no-album">
								<img src="${contextPath}/resource/img/not found.png" alt="">
								<div class="no-info">
				                    <h5>구매한 음원이 없습니다.</h5>
				                </div>
							</div>
						</div>
	                </c:otherwise>
	            	</c:choose>
	            </div>            
	           	<hr>
    </section>
    <!-- ##### Buy Now Area End ##### -->
    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area navbar-fixed-bottom">
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