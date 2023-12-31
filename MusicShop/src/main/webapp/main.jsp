<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*" import="album.AlbumVO" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<%
String user_id = (String) session.getAttribute("id");
String code = (String) session.getAttribute("code");
String name = (String) session.getAttribute("name");


class AlbumDateComparator implements Comparator<AlbumVO> {
    @Override
    public int compare(AlbumVO a1, AlbumVO a2) {
        return a1.getNow().compareTo(a2.getNow());
    }
}

List<AlbumVO> alist = null;

if(request.getAttribute("albumList") != null) {
	alist = (List<AlbumVO>)request.getAttribute("albumList");
	alist.sort(new AlbumDateComparator().reversed());
}
/*
앨범리스트를 가져와서 발매일순으로 정렬시킨 앨범 리스트
*/


%>
<script>
		<!-- 발매일순으로 정렬된 앨범리스트 -->
<c:set var="albumListOrderByDate" value="<%=alist%>"/>
function showAllAlbum() {
	  window.location.href="${contextPath}/Album/main/showAllAlbum.do";
}

if(${empty albumList} && !${empty isSearch ? false : isSearch}) {
	 // alert("첫 입장, 전체 앨범 리스트 가져오기");
	  showAllAlbum();
}
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
	<jsp:include page="header.jsp"></jsp:include>
    <!-- ##### Header Area End ##### -->

    <!-- ##### Hero Area Start ##### -->
    <section class="hero-area">
        <div class="hero-slides owl-carousel">
            <!-- Single Hero Slide -->
            <div class="single-hero-slide d-flex align-items-center justify-content-center">
                <!-- Slide Img -->
                <div class="slide-img bg-img" style="background-image: url(${contextPath}/img/bg-img/cover_1.jpg);"></div>
                <!-- Slide Content -->
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="hero-slides-content text-center">
                                <h6 data-animation="fadeInUp" data-delay="100ms">Welcome to </h6>
                                <h2 data-animation="fadeInUp" data-delay="300ms">MLP Music <span>MLP Music</span></h2>
                                <!-- <a data-animation="fadeInUp" data-delay="500ms" href="#" class="btn oneMusic-btn mt-50">Discover <i class="fa fa-angle-double-right"></i></a>  -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Single Hero Slide -->
            <div class="single-hero-slide d-flex align-items-center justify-content-center">
                <!-- Slide Img -->
                <div class="slide-img bg-img" style="background-image: url(${contextPath}/resource/img/newjeans.jpg);"></div>
                <!-- Slide Content -->
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <div class="hero-slides-content text-center">
                                <h6 data-animation="fadeInUp" data-delay="100ms">Latest album</h6>
                                <h2 data-animation="fadeInUp" data-delay="300ms">New Jeans<span>New Jeans</span></h2>
                                <a data-animation="fadeInUp" data-delay="500ms" href="${contextPath}/Album/album_songs/showOneAlbum.do?album_id=53" class="btn oneMusic-btn mt-50">Discover <i class="fa fa-angle-double-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Hero Area End ##### -->

    <!-- ##### Latest Albums Area Start ##### -->
    <section class="latest-albums-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading style-2">
                        <p>See what’s new</p>
                        <h2>Latest Albums</h2> <!-- 최근에 나온 앨범들-->
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-12 col-lg-9">
                    <div class="ablums-text text-center mb-70"><!-- 음악과 관련된 명언들 -->
                        <p>A painter paints his pictures on canvas. But musicians paint their pictures on silence. We provide the music, and you provide the silence.</p>
                        <p>one good thing about music, when it hits you, you feel no pain</p>
                        <p>I hope that the sadness that has disappeared beyond the event horizon will not come out again in any form.</p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="albums-slideshow owl-carousel">
                        <!-- Single Album -->
                        <c:if test="${not empty albumListOrderByDate}"> <!-- 발매일순으로 정렬된 앨범리스트 -->
	                        <c:forEach items="${albumListOrderByDate}" var="album">
		                        <div class="single-album">
		                            <img src="${contextPath}/resource/img/${album.sign}" alt="${album.album}">
		                            <div class="album-info">
		                                <a href="${contextPath}/Album/album_songs/showOneAlbum.do?album_id=${album.id}">
		                                    <h5>${album.album}</h5>
		                                </a>
		                                <p>${album.now}</p>
		                            </div>
		                        </div>
	                        </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Latest Albums Area End ##### -->

    <!-- ##### Buy Now Area Start ##### -->
    <section class="oneMusic-buy-now-area has-fluid bg-gray section-padding-100">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="section-heading style-2">
                        <p>See what’s new</p>
                        <h2>Buy What’s New</h2>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Single Album Area -->
                <c:if test="${not empty albumListOrderByDate}">
                	<c:forEach items="${albumListOrderByDate}" var="album">
		                <div class="col-12 col-sm-6 col-md-4 col-lg-2">
		                    <div class="single-album-area wow fadeInUp" data-wow-delay="300ms">
		                        <div class="album-thumb">
		                            <img src="${contextPath}/resource/img/${album.sign}" alt="${album.album}">
		                        	<!-- Album Price -->
		                            <div class="album-price">
		                                <p>${album.price}￦</p>
		                            </div>
		                        	<div class="album-info">
		                            	<a href="${contextPath}/Album/album_songs/showOneAlbum.do?album_id=${album.id}">
		                                	<h5>${album.singer}</h5>
		                            	</a>
		                          	  <p>${album.title}</p>
		                        	</div>                            
		                            <!-- Play Icon -->
		                        	<!-- 해당 플레이어의 CSS는 style.css에서 '실험2'를 검색하면 볼 수 있음 -->
									<audio preload="auto" controls ontimeupdate="limitPlayTime(this);">
										<source src="${contextPath}/resource/audio/${album.song}">
		                            </audio>                            
		                        </div>
		                    </div>
		                </div>
	                </c:forEach>
				</c:if>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="load-more-btn text-center wow fadeInUp" data-wow-delay="300ms">
                        <a href="${contextPath}/album.jsp" class="btn oneMusic-btn">Load More <i class="fa fa-angle-double-right"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Buy Now Area End ##### -->

    <!-- ##### Featured Artist Area Start ##### -->
    <section class="featured-artist-area section-padding-100 bg-img bg-overlay bg-fixed" style="background-image: url(${contextPath}/img/bg-img/piano.jpg);">
        <div class="container">
            <div class="row align-items-end">
            	<!-- 가장 최근에 나온 앨범의 타이틀곡 -->
            	<c:if test="${not empty albumListOrderByDate}"> 
	                <div class="col-12 col-md-5 col-lg-4">
	                    <div class="featured-artist-thumb">
	                        <img src="${contextPath}/resource/img/${albumListOrderByDate[0].sign}" alt="">
	                    </div>
	                </div>
	                <div class="col-12 col-md-7 col-lg-8">
	                    <div class="featured-artist-content">
	                        <!-- Section Heading -->
	                        <div class="section-heading white text-left mb-30">
	                            <p>See what’s new</p>
	                            <h2>Buy What’s New</h2>
	                        </div>
		                    <div class="song-play-area">
		                        <div class="song-name">
		                            <p>${albumListOrderByDate[0].title}</p>
		                        </div>
		                        <audio preload="auto" controls ontimeupdate="limitPlayTime(this);">
		                        	<source src="${contextPath}/resource/audio/${albumListOrderByDate[0].song}">
		                        </audio>
		                    </div>
	                    </div>
	                </div>
                </c:if>
            </div>
        </div>
    </section>
    <!-- ##### Featured Artist Area End ##### -->

    <!-- ##### Miscellaneous Area Start ##### -->
    <section class="miscellaneous-area section-padding-100-0">
        <div class="container">
            <div class="row">
                <!-- ***** Weeks Top ***** -->
                <div class="col-12 col-lg-4">
                    <div class="weeks-top-area mb-100">
                        <div class="section-heading text-left mb-50 wow fadeInUp" data-wow-delay="50ms">
                            <p>See what’s new</p>
                            <h2>This week’s top</h2>
                        </div>
                        <!-- Single Top Item -->
                        <c:if test="${not empty thisWeeksTopAlbumList}">
	                        <c:forEach items="${thisWeeksTopAlbumList}" var="album" end="5">
	                        	<div class="single-top-item d-flex wow fadeInUp" data-wow-delay="100ms">
		                            <div class="thumbnail">
		                                <img src="${contextPath}/resource/img/${album.sign}" alt="${album.album}">
		                            </div>
		                            <div class="content-">
		                                <h6>${album.album}</h6>
		                                <p>${album.singer}</p>
		                            </div>
	                        	</div>
	                        </c:forEach>
						</c:if>
                    </div>
                </div>

                <!-- ***** New Hits Songs ***** -->
                <div class="col-12 col-lg-4">
                    <div class="new-hits-area mb-100">
                        <div class="section-heading text-left mb-50 wow fadeInUp" data-wow-delay="50ms">
                            <p>See what’s new</p>
                            <h2>New Hits</h2>
                        </div>

                        <!-- Single Top Item -->
                         <c:if test="${not empty newHitAlbumList}">
	                        <c:forEach items="${newHitAlbumList}" var="album" end="5">
	                        	<div class="single-new-item d-flex align-items-center justify-content-between wow fadeInUp" data-wow-delay="100ms">
		                            <div class="first-part d-flex align-items-center">
		                                <div class="thumbnail">
		                                    <img src="${contextPath}/resource/img/${album.sign}" alt="${album.album}">
		                                </div>
		                                <div class="content-">
		                                    <h6>${album.album}</h6>
		                                    <p>${album.singer}</p>
		                                </div>
		                            </div>
		                            <audio preload="auto" controls ontimeupdate="limitPlayTime(this);"> 
		                                <source src="${contextPath}/resource/audio/${album.song}">
		                            </audio>
		                        </div>
	                        </c:forEach>
						</c:if>
                    </div>
                </div>

                <!-- ***** Popular Artists ***** popularArtistList -->
                <div class="col-12 col-lg-4">
                    <div class="popular-artists-area mb-100">
                        <div class="section-heading text-left mb-50 wow fadeInUp" data-wow-delay="50ms">
                            <p>See what’s new</p>
                            <h2>Popular Artist</h2>
                        </div>

                        <!-- Single Artist -->
                        <c:if test="${not empty popularArtistList}">
	                        <c:forEach items="${popularArtistList}" var="artist">
		                        <div class="single-artists d-flex align-items-center wow fadeInUp" data-wow-delay="100ms">
		                            <div class="thumbnail">
		                                <img src="${contextPath}/resource/img/${artist.img}" alt="">
		                            </div>
		                            <div class="content-">
		                                <p>${artist.name}</p>
		                            </div>
		                        </div>
                        	</c:forEach>
						</c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Miscellaneous Area End ##### -->

    <!-- ##### Contact Area Start ##### 

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