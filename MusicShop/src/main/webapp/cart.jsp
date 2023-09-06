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
	    if(${empty cartItemList} && ${not empty isFirstEntry ? isFirstEntry : true}) {
			 alert("첫 입장, 장바구니에 담긴 음원 리스트 가져오기");
			 window.location.href="${contextPath}/Cart/cart/goToCart.do?member_id="+"${empty id ? 'not login' : id}";
		}
		var jstlContextPath = "${contextPath}";
		var jstlMemberId = "${id}";
		var jstlMemberName = "${name}";
	</script>
    <c:choose>
		<c:when test="${not empty cartItemList}">
			<script src="https://js.tosspayments.com/v1/payment-widget"></script>
			<script src="${contextPath}/js/cartItemListNotEmptyCase.js"></script>
		</c:when>
		<c:otherwise>
			<script src="${contextPath}/js/cartItemListEmptyCase.js" defer></script>
		</c:otherwise>
	</c:choose>
	
  <%
	String user_id = (String) session.getAttribute("id");
	String code = (String) session.getAttribute("code");
	String name = (String) session.getAttribute("name");
  %>
			
	    
	    
	    <script>
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
		      
		function limitPlayTime(audio) {
		    if (audio.currentTime > 60) { // 1분(60초)로 제한
		        audio.pause();
		        audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
		        alert("1분 미리듣기가 종료되었습니다.");
		    }
		}    
      	
		/*장바구니로 이동하는 함수 추가하기*/
		function cart(){
			if(confirm('장바구니로 이동하시겠습니까?')){
				window.location.href="${contextPath}/cart.jsp";
				return true;
			}else{
				return false;
			}
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
            <p>Cart Page</p>
            <h2>장바구니</h2>
        </div>
    </section>
<!-- ##### Buy Now Area Start ##### -->
    <section class="oneMusic-cart-area has-fluid bg-gray section-padding-100">    	
        <div class="container-fluid">
        	<c:choose>
	        	<c:when test="${not empty cartItemList}">
	        		<div class="row d-flex ">
		        			<div class="col-2">
				        		<input type="checkbox" class="cart-item-checked" id="check-all" name="cart-item-check-all">
							   	<label for="check-all" class="check-emoticon"></label>
							   	<label for="check-all" class="check-all-text"><h5>전체 선택</h5> </label>
							</div>
						   	<div class="cart-choose-delete ml-auto">
				        		<input type="button" id="chosen-song-del-btn" class="btn btn-outline-danger" type="button" value="선택 삭제">
						   	</div>
					</div>
	        		<hr>       
	            	<div class="row d-flex cart-item-list" id="cart-item-list">
	                <!-- Single Album Area -->
	                	<c:forEach items="${cartItemList}" var="cartItem">
			                <div class="col-12">
			                    <div class="d-flex flex-row cart-item">
			                    	<div class="align-self-center">
				                		<input type="checkbox" class="cart-item-checked" id="${cartItem.song_id}" name="cart-item-checked">
				                		<label for="${cartItem.song_id}" class="check-emoticon"></label>
				                	</div>
			                        <div class="col-1 album-thumb album-img-place">
			                        <!--앨범 이미지를 클릭했을 때 해당 앨범 상세 페이지로 이동 -->
			                            <a href="${contextPath}/Album/album_songs/showOneAlbum.do?album_id=${cartItem.album_id}">
			                            	<img src="${contextPath}/resource/img/${cartItem.album_sign}" alt="">
			                            </a>
			                        </div>
				  					<div class="col-1 album-info align-self-end">
									<!--가수 이름을 클릭했을 때 그 이름으로 검색된 album.jsp 페이지로 이동 -->
										<a href="${contextPath}/Album/album/albumSearch.do?searchBar=${cartItem.singer}">
				 							 <h5>${cartItem.singer}</h5>
										</a>	
				                        	<p class="cart-item-song-name">${cartItem.song_name}</p>
				                    </div>
				                    <div class="col-8 song-play-area align-self-center">
				                        <audio preload="auto" controls ontimeupdate="limitPlayTime(this);">
				                           <source src="${contextPath}/resource/audio/${cartItem.song_audio}">
				                        </audio>
				                    </div>
				                    <div class="col-1 align-self-price-end">
				                    	<span class="cart-item-price"><b>${cartItem.price}</b></span>
				                    	<span><b>￦</b></span>
				                    	<p></p> <!-- 이 태그가 없으면 모양이 조금 깨지네요.. -->
				                    </div>
			  					</div>
			                </div>
	               		</c:forEach>  
		                <div class="col-3 mr-auto">
			            	<span>총 결제 금액: </span>
			            	<span id="total-payment">0</span>
			            	<span>￦</span>
			           	</div>
	            	</div>            
	           		<hr>
	            	<div class="d-flex flex-row align-items-center justify-content-sm-around">
	            		<div class="">
	            			<input type="button" id="chosen-song-buy-btn" class="btn btn-outline-dark btn-lg" type="button" value="선택 구매">
	            		</div>
	            		<div class="">
	    					<input type="button" id="all-song-buy-btn" class="btn btn-outline-dark btn-lg" type="button" value="전체 구매">
	            		</div>
	    			</div>
	    			<hr>
		    		<div id="payment-method"></div>
					<div id="agreement"></div>
					<div class="d-flex justify-content-center bg-white align-self-center" id="payment-div" style="position: relative; display: block; border: 0px; width: 100%; height: 90px;">
					<div>
						<input type="button" id="payment-btn" class="btn btn-outline-dark btn-lg" type="button" value="결제하기">
					</div>
				</div>
				</c:when>
			<c:otherwise>
				<div class="col-12 justify-content-center single-album-item">
					<div class="no-album">
						<img src="${contextPath}/resource/img/not found.png" alt="">
						<div class="no-info">
				        	<h5>
				        	장바구니에 담긴 음원이 없습니다.
				        	</h5>
				        </div>
					</div>
					<hr>
					<div class="d-flex flex-row align-items-center justify-content-sm-around">
	            		<div class="">
	            			<input type="button" id="more-song-btn" class="btn btn-outline-dark btn-lg" type="button" value="음원 더 둘러보기">
	            		</div>
	            		<div class="">
	    					<input type="button" id="my-song-btn" class="btn btn-outline-dark btn-lg" type="button" value="구매 음원 확인">
	            		</div>
	    			</div>
				</div>
			</c:otherwise>
		</c:choose>
        </div>
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
			 