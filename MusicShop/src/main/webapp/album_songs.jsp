<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" import="java.util.ArrayList" import="java.util.List" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="album.AlbumVO" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    <%@page session="true"%>
    <%@page import="javax.servlet.http.HttpSession" %>
    <% HttpSession al_session = request.getSession(); %>
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
String albumId = request.getParameter("album_id");
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
	
	var songList = new Array();	//앨범 구매 버튼 이벤트에서 참조하려고 전역 변수로 빼놓았다.
	if(${not empty songList}){
		console.log("검색 결과 있음");
	<c:forEach items="${songList}" var="song">
		songList.push({
			album_name: "${song.album}",
			title: "${song.title}",
			singer: "${song.singer}",
			price: "${song.price}",
			song_id: "${song.song_id}",
			name: "${song.name}",
			song: "${song.song}",
			sign: "${song.sign}"		
		});
		console.log(songList.slice(-1)); //앨범리스트의 마지막 요소 출력
	</c:forEach>
	<c:set var="detail_addr" value ="${songList[0].singer}-${songList[0].album}"/>
	console.log("detail: ${detail_addr}");
	} else{
		console.log("검색결과 없음");
	}

	window.onload = function() {
		var addToCartRequest = new XMLHttpRequest();
		addToCartRequest.onload = function () {
		    var result = this.response;
		    console.log(result);
		    if(result.status == true) {
		    	if(result.msg == "Insert Multiple Rows Successed") {
		    		askGotoCart("해당 앨범의 수록곡이 전부 장바구니에 담겼습니다. (구매했던 음원 또는 이미 장바구니에 담겨있던 음원 제외)");	
		    	}
		    	else {
		    		askGotoCart("장바구니에 음원이 담겼습니다.");	
		    	}
		    } else {
		    	if(result.msg == "Insert Query Failed(This Song is already exist in Storage Table or Payment Table)") {
		    		askGotoCart("이미 구매한 음원이거나 장바구니에 담긴 음원입니다.");
		    		return;
		    	} else if(result.msg == "Insert Multiple Rows Failed(This Song is already exist in Storage Table or Payment Table)") {
		    		askGotoCart("해당 앨범의 수록곡 전부, 혹은 일부가 구매했던 음원이거나 장바구니에 담긴 음원입니다.");
		    		return;
		    	}
		    	alert(result.msg);
		    }
	    };
	    addToCartRequest.onerror = function () {
	    	console.log('Request Error!');
	    }
		
		var songlist = document.querySelectorAll("div.songlist");
		songlist.forEach(function(song) {
			console.log(song);
			var BuyBtn = song.getElementsByClassName("buy-btn")[0];
			BuyBtn.addEventListener("click", function(){
				var song_id = song.getElementsByClassName("song-id")[0].value;
				console.log(song_id);
				addToCartRequest.open('GET', '${contextPath}/Cart/addToCart.do?song_id='+song_id+'&member_id='+"${empty id ? 'not login' : id}");
				addToCartRequest.responseType="json";
				addToCartRequest.send();
			});
		});
		var album_buy_btn = document.getElementById("album-buy-btn");
		album_buy_btn.addEventListener("click", function(event) {
			var queryString = "";
			songList.forEach(function(song) {
				queryString += (song.song_id+","); //n1,n2,n3,n3,ㆍㆍㆍ,
			})
			queryString = queryString.slice(0, -1); //마지막에 오는 , 지워주기
			console.log(queryString);
			addToCartRequest.open('GET', '${contextPath}/Cart/addToCart.do?song_id='+queryString+'&member_id='+"${empty id ? 'not login' : id}");
			addToCartRequest.responseType="json";
			addToCartRequest.send();
		});
	}

	function askGotoCart(msg) {
		var message = "장바구니 페이지로 이동하시겠습니까?";
		if(msg != null) {
			message = msg+"\n"+message;
		}
		if (confirm(message)) {
            cart();
        } else {
        }		 
	}
	
	
function cart() {
	window.location.href="${contextPath}/Cart/cart/goToCart.do?member_id="+"${empty id ? 'not login' : id}";
}
	
/*1분 미리듣기 함수*/
function limitPlayTime(audio) {
    if (audio.currentTime > 60) { // 1분(60초)로 제한
        audio.pause();
        audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
        alert("1분 미리듣기가 종료되었습니다.");
    }
}

function confirmLogin(){
	var id = document.getElementById('user_id').value;
	if(id == 'null'){
		alert("로그인 후 이용해주세요.");
		window.location.href="${contextPath}/login/login.jsp";
		return false;
	} else{
		return true;
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
	<jsp:include page="header.jsp"></jsp:include>
    <!-- ##### Header Area End ##### -->
    
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
                            <a href="${contextPath}/detail/${detail_addr}.jsp"><p>${songList[0].album}</p></a><!-- songList -->
                            <div>
			            		<input type="button" id="album-buy-btn" class="btn btn-outline-light btn-lg" value="앨범 구매">
			            	</div>
                        </div>
                        <div class="song-play-area">
                        	<input type="hidden" class="song-id" value="${songList[0].song_id}">
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
				<div class="col-12 align-content-around row padding-bottom-20 songlist">
					<hr style="background-color: #000000; height: 1px !important; display: block !important; width: 100% !important;">
                    <div class="col-8 song-play-area-white">
                    	<input type="hidden" class="song-id" value="${song.song_id}">
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
	                   	<input type="button" id="a-song-of-album-buy-btn" class="btn btn-outline-success btn-lg buy-btn" type="button" value="장바구니">
			   			&nbsp;&nbsp;&nbsp;&nbsp;
			    		<input type="button" id="a-song-of-album-like-btn" class="btn btn-outline-danger btn-lg" type="button" value="구매">
					</div>    
				</div>
				</c:forEach>
				</c:if>
            </div>
        </div>
    </section>
    <!-- ##### Miscellaneous Area End ##### -->

    <!-- ##### Contact Area Start ##### -->
    <section class="contact-area section-padding-100 bg-img bg-overlay bg-fixed has-bg-img" style="background-image: url(${contextPath}/img/bg-img/bg-2.jpg);">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-write-heading white">
                        <p>See what’s new</p>
                        <h2>Review</h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <!-- Contact Form Area -->
                    <div class="contact-form-area">
                        <form class="mb-3" name="myform" id="myform" method="post" action="${contextPath}/review/review_ok.jsp" onSubmit="return confirmLogin()" enctype="UTF-8">
                            <div class="row">					
								<div class='writeReview'> 		
                            		<div class="starReview">
                            				<input type="hidden" name="user_id" id="user_id" value='<%=user_id %>'>
                            				<input type="hidden" name="album" id="album" value="${songList[0].album}">
                            				<input type="hidden" name="albumId" id="albumId" value='<%=albumId %>'>
                            				<input type="hidden" name="singer" id="singer" value="${songList[0].singer}">
                            				
                            				<select class="song_name" id="song_name" name="song_name">
                            					<option value="">선택</option>
                            				<c:forEach items="${songList}" var="song">
                            						<option value="${song.name}">${song.name}</option>
                            				</c:forEach>
                            				</select>
										<fieldset >
											<input type="radio" name="reviewStar" value="5" id="rate1"><label for="rate1">★</label>
											<input type="radio" name="reviewStar" value="4" id="rate2"><label for="rate2">★</label>
											<input type="radio" name="reviewStar" value="3" id="rate3"><label for="rate3">★</label>
											<input type="radio" name="reviewStar" value="2" id="rate4"><label for="rate4">★</label>
											<input type="radio" name="reviewStar" value="1" id="rate5"><label for="rate5">★</label>
										</fieldset>
                            		</div>
									<tr>
										<td align = "right" valign = "top"></td>
										<td colspan = 2>
											<textarea class="writearea" id="album_review" name = "content"" rows = "10" cols = "65" maxlength="4000"></textarea>
										</td>
										<td><br><br>
											<input type="submit" class="btn-primary pull" value="리뷰 작성">
										</td>
									</tr>		
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
    <footer class="footer-area navbar-fixed-bottom">
        <div class="container">
            <div class="row d-flex flex-wrap align-items-center">
                <div class="col-12 col-md-6">
                    <a href="#"><img src="${contextPath}/img/core-img/lologo.png" alt=""></a>
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