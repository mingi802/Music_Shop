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
	
    <script>
		/*
	    const clientKey = "test_ck_jExPeJWYVQlOdp6pRbQ349R5gvNL";
	    const customerKey = self.crypto.randomUUID(); // 내 상점에서 고객을 구분하기 위해 발급한 고객의 고유 ID
	    const paymentWidget = PaymentWidget(clientKey, customerKey); // 회원 결제
    
	    if(${empty cartItemList} && ${not empty isFirstEntry ? isFirstEntry : true}) {
			 alert("첫 입장, 장바구니에 담긴 음원 리스트 가져오기");
			 window.location.href="${contextPath}/Cart/cart/goToCart.do?member_id="+"${empty id ? 'not login' : id}";
		}
	    
		function delCartItem(delCartItemRequest, CartItemMap) {
			const data = JSON.stringify({
				  member_id: '${id}',
				  checked_cart_item_list: Array.from(CartItemMap.keys())
				});
			console.log(data, typeof(data));
			delCartItemRequest.open("POST", "${contextPath}/Cart/delCartItem.do");
			delCartItemRequest.setRequestHeader("Content-Type", "application/json");
		    delCartItemRequest.responseType="json";
		    delCartItemRequest.send(data);
	    }

	    window.onload = function () {
	    	var delCartItemRequest = new XMLHttpRequest();
	    	delCartItemRequest.onreadystatechange = function () {
			    var result = this.response;
			    if(this.readyState == this.DONE) {
			    	console.log(result);
			    	console.log(this.getAllResponseHeaders());
			    	alert("제거되었습니다.");
			    	window.location.reload("true");
			    } else {
			    	console.log(this.readyState);
			    	console.log(result);
			    }
		    };
		    
		    var paymentMethodWidget = null;
		    var paydiv = document.getElementById('payment-div');
		    var paybtn = document.getElementById('payment-btn');
	    	var cmdbtn = document.getElementById('chosen-song-del-btn');
	    	var cmbbtn = document.getElementById('chosen-song-buy-btn');
	    	var ambbtn = document.getElementById('all-song-buy-btn');
	      	var cart_items = document.querySelectorAll("div.cart-item");
	    	var total_payment = document.getElementById('total-payment');
	    	var cart_item_all_check = document.getElementById('check-all');
			
	    	var CartItemMap = new Map();
	    	
	    	<c:choose>
	    		<c:when test="${not empty cartItemList}">
	    			paydiv.style.visibility = 'hidden';
	    		</c:when>
	    		<c:otherwise>
	    			var more_song_btn = document.getElementById('more-song-btn');
	    			var my_song_btn = document.getElementById('my-song-btn');
	    			more_song_btn.addEventListener('click', function() {
	    				window.location.href="${contextPath}/album.jsp";
	    			});
	    			my_song_btn.addEventListener('click', function() {
	    				window.location.href="${contextPath}/my_song.jsp";
	    			});
	    		</c:otherwise>
	    	</c:choose>
	    	
	    	
	    	paybtn.addEventListener('click', function(event) {
	    		paymentMethodWidget.updateAmount(parseInt(total_payment.innerText));
	    		if(CartItemMap.size < 1) {
	    			alert('선택된 음원이 없습니다.');
	    			return;
	    		}
	    		const map1stIter = CartItemMap.values().next();
	  			console.log(map1stIter.value[0].song_name);
	    		let orderId = self.crypto.randomUUID();
	    		let orderName = (CartItemMap.size > 1) ? (map1stIter.value[0].song_name+" 외 "+(CartItemMap.size-1)+"건") :map1stIter.value[0].song_name;
	    		let escrowProducts = new Array();
	    		let keyIterList = CartItemMap.keys();
	    		let cartItemIds = "";
	    		for(let key of keyIterList) {
	    			cartItemIds += (key+",");
	    		}
	    		cartItemIds = cartItemIds.slice(0, -1);
	    		console.log("cartItemIds: "+cartItemIds);
	    		CartItemMap.forEach(function(cartItem) {
	    			escrowProducts.push({
		    			id: cartItem[0].song_id,
		    			name: cartItem[0].song_name,
		    			code: cartItem[0].song_id,
		    			unitPrice: cartItem[0].song_price,
		    			quantity: 1
		    		});	
	    		})
	    		console.log(escrowProducts);
	    		paymentWidget
			   		.requestPayment({
				        orderId: orderId,            // 주문 ID(직접 만들어주세요)
				        orderName: orderName,                 // 주문명
				        successUrl: "http://localhost:8060/${contextPath}/Cart/impTest/success/cartItemPayment.do?cartItemIds="+cartItemIds,  // 결제에 성공하면 이동하는 페이지(직접 만들어주세요)
				        failUrl: "http://localhost:8060/${contextPath}/impTest/fail.jsp",        // 결제에 실패하면 이동하는 페이지(직접 만들어주세요)
				        customerName: "${name}",
				        escrowProducts: escrowProducts
			      	})
			      	.catch(function (error) {
					    if (error.code === 'INVALID_ORDER_NAME') {
					      	// 유효하지 않은 'orderName' 처리하기
					      	console.log(error.code);
					    } else if (error.code === 'INVALID_ORDER_ID') {
					      	// 유효하지 않은 'orderId' 처리하기
					      	console.log(error.code);
					    } else {
					    	console.log(error.code);
					    }
			  	  	})
	      		const selectedPaymentMethod = paymentMethodWidget.getSelectedPaymentMethod();
	      		console.log(selectedPaymentMethod);
	    	});
	    	
	    	cmdbtn.addEventListener('click', function(event) {
	    		if(CartItemMap.size > 0) {
	    			var message = "선택된 "+CartItemMap.size+"개의 음원을 장바구니에서 제거하시겠습니까?";
		    		if(confirm(message)) {
		    			delCartItem(delCartItemRequest, CartItemMap);	
		    		}	
	    		} else {
	    			alert("선택된 음원이 없습니다.");
	    		}
	    	});
	    	
	    	
	    	cart_item_all_check.addEventListener('change', function(event) {	//전체 선택 체크박스 이벤트 할당
	    		cart_items.forEach(function(cart_item) {
	    			var cart_item_checkbox = cart_item.getElementsByClassName("cart-item-checked")[0];
	    			if(cart_item_all_check.checked && !cart_item_checkbox.checked) {
	    			  	cart_item_checkbox.click();  
	    		  	} else if(!cart_item_all_check.checked) {
	    		  	  	cart_item_checkbox.click();
	    		  	}
	    		});
	    	});
	  	  
	  	  	console.log(cart_items);
	  	  	
	  	  	cart_items.forEach(function(cart_item) {
	  		  	var cart_item_checkbox = cart_item.getElementsByClassName("cart-item-checked")[0];
	  		 	console.log(cart_item_checkbox);
	  		 	var cart_item_price = cart_item.getElementsByClassName("cart-item-price")[0].innerText;
	  		  	var cart_item_name = cart_item.getElementsByClassName("cart-item-song-name")[0].innerText;
	  		 	
	  		  	cart_item_price = parseInt(cart_item_price);
	  		  
	  		  	cart_item_checkbox.addEventListener('change', function (event){	//각 체크박스마다 이벤트 할당
	  				console.log(event.target.checked);
	  				if(event.target.checked) {
	  					CartItemMap.set(cart_item_checkbox.id ,[{song_id: cart_item_checkbox.id, song_name: cart_item_name, song_price: cart_item_price}]);
	  					console.log(CartItemMap);
	  					
	  					if(isAllChecked(cart_items)) {
	  						cart_item_all_check.checked = event.target.checked;
	  					}
	  					total_payment.innerText = parseInt(total_payment.innerText) + cart_item_price;
	  				} 
	  				else {
	  					console.log("[Before Delete] CartItemMap.has("+cart_item_checkbox.id+"): "+CartItemMap.has(cart_item_checkbox.id));
	  					if(CartItemMap.has(cart_item_checkbox.id)) {
	  						CartItemMap.delete(cart_item_checkbox.id);
	  						console.log(CartItemMap);
	  					}
	  					console.log("[After Delete] CartItemMap.has("+cart_item_checkbox.id+"): "+CartItemMap.has(cart_item_checkbox.id));
	  					cart_item_all_check.checked = event.target.checked;
	  					total_payment.innerText = parseInt(total_payment.innerText) - cart_item_price;
	  				}
	  				console.log("[Result] CartItemMap.has("+cart_item_checkbox.id+"): "+CartItemMap.has(cart_item_checkbox.id));
	  		  	});
	  	  	});
	  	  
	  	  	cmbbtn.addEventListener('click', function(){
	  	  		paymentMethodWidget = paymentWidget.renderPaymentMethods("#payment-method", { value: 0 }); //가격은 결제 버튼을 누른 순간 정해진다. 78줄 참조
	  	  		const paymentAgreement = paymentWidget.renderAgreement('#agreement');
			  	if(paymentAgreement.getAgreementStatus().agreedRequiredTerms && paydiv.style.visibility == 'hidden') {
			  		paydiv.style.visibility = 'visible';
			  	}
	  	  	});
	  	  	
	  	  	ambbtn.addEventListener('click', function(){
	  			cart_item_all_check.click(); //전체 선택
	  			paymentMethodWidget = paymentWidget.renderPaymentMethods("#payment-method", { value: 0 }); //가격은 결제 버튼을 누른 순간 정해진다. 78줄 참조
	  	  		const paymentAgreement = paymentWidget.renderAgreement('#agreement');
			  	if(paymentAgreement.getAgreementStatus().agreedRequiredTerms && paydiv.style.visibility == 'hidden') {
			  		paydiv.style.visibility = 'visible';
			  	}
		  	});
	  	}
		function isAllChecked(cart_item_list) {
			cart_item_list = Array.from(cart_item_list); //NodeList에는 some 함수가 없어서 Array로 바꿔야했음
			var is_all_checked = true;
			console.log(cart_item_list);
			
			cart_item_list.some(function (cart_item) {	//한 번이라도  true를 리턴하면 멈추는 함수 some
														
				var cart_item_checked = cart_item.getElementsByClassName("cart-item-checked")[0].checked;
				if(!cart_item_checked) {
					is_all_checked = false;
					return true; //체크가 안되어있는 체크박스가 있는 경우 true 리턴 == 전체 선택이 되어있지 않은 상태
				}
			});
			console.log("is all checked: "+ is_all_checked);
			return is_all_checked;
		} */
  <%
	String user_id = (String) session.getAttribute("id");
	String code = (String) session.getAttribute("code");
	String name = (String) session.getAttribute("name");
  %> 	/*
	    function limitPlayTime(audio) {
	        if (audio.currentTime > 60) { // 1분(60초)로 제한
	            audio.pause();
	            audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
	            alert("1분 미리듣기가 종료되었습니다.");
	        }
	    } */
	    </script>
	    
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
                                                    <li><a href="${contextPath}/customer/mypage.jsp">내정보</a></li>
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
                                            <li><a href="#">Manager</a>
                                                <ul class="dropdown">
                                                    <li><a href="${contextPath}/customer/mypage.jsp">내정보</a></li>
                                                    <li><a href="${contextPath}/admin/admin.jsp">회원목록</a></li>
                                                    <li><a href="${contextPath}/admin/artist.jsp">아티스트목록</a></li>
                                                    <li><a href="${contextPath}/admin/host.jsp">관리자목록</a></li>
                                                    <li><a href="${contextPath}/review/review.jsp">게시판관리</a></li>
                                                    <li><a href="${contextPath}/admin/musicManage.jsp">앨범관리</a></li>
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
                                                    <li><a href="${contextPath}/customer/mypage.jsp">내정보</a></li>
                                                    <li><a href="${contextPath}/artist/artist.jsp">음원등록</a></li>
                                                    <li><a href="${contextPath}/artist/music_delete.jsp">음원관리</a></li>
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
                                        <p><span class="icon-shopping-cart" onclick="return cart()"></span></p>
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
                                        <p><span class="icon-shopping-cart" onclick="return cart()"></span></p>
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
                                        <p><span class="icon-shopping-cart" onclick="return cart()"></span></p>
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
	        		<div class="row d-flex">
		        			<div class="col-2">
				        		<input type="checkbox" class="cart-item-checked" id="check-all" name="cart-item-check-all">
							   	<label for="check-all" class="check-emoticon"></label>
							   	<label for="check-all" class="check-all-text"><h5>전체 선택</h5> </label>
							</div>
						   	<div class="cart-choose-delete">
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
				                    <div class="col-9 song-play-area align-self-center">
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
		                <div class="col-2 mr-auto">
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
			 