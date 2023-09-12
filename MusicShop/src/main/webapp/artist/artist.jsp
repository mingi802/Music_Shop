<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false" import=" java.util.*,music.*"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page session="true"%>

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
		
		if(${empty MusicList} && ${not empty isFirstEntry ? isFirstEntry : true}) { //첫 입장 여부 isFirstEntry에 있음. 
																					//not empty로 값이 있는 지 검사
																					//있으면 그 값을 쓰고 없으면 true를 씀. -> 값이 없는 경우가 첫 입장이기 때문
		window.location.href="${contextPath}/Music/listMusic.do";
		}	
		
		window.onload=function () {
			var isTitle = document.getElementsByName('isTitle')[0];
			var hidden_iT = document.getElementsByName('isTitle')[1]; 
			isTitle.addEventListener('change', function(e) {
				hidden_iT.value = e.target.checked;	
				console.log(hidden_iT.value);
			});
		};

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
	<jsp:include page="../header.jsp"></jsp:include>
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
                        <h3>앨범 목록</h3><br>
                        <!-- Membership manage Form -->
                        <div class="music-list-form">
                        <table>
                        	<tr>
                        		<th>앨범명</th><th>타이틀 곡</th><th>가수</th><th>발매일</th><th>가격</th><th>이미지 파일</th><th>타이틀 음원 파일</th>
                       		</tr>
		 <tbody>
		 <c:choose> <%-- JSTL을 이용해 비었는지 체크 --%>
		    <c:when test="${empty MusicList}" >
		      <tr>
		        <td colspan="7" align="center">
		          <b >음원이 없습니다.</b>
		       </td>  
		      </tr>
		   </c:when>  
		   <c:when test="${!empty MusicList}" >
		      <c:forEach  var="mus" items="${MusicList}" >
		        <tr align="center">
		          <td>${mus.album}</td>
		          <td>${mus.title }</td>
		          <td>${mus.singer }</td>     
		          <td>${mus.now }</td>       
		          <td>${mus.price }</td> 
		          <td>${mus.sign }</td> 
		          <td>${mus.song }</td> 
		       </tr>
		     </c:forEach>
		   </c:when>
		 </c:choose>
		     
		 </tbody>
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
            <div class="row justify-content-end">
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
                                    노래제목 (is title? 
                                    	<input type="checkbox" name="isTitle" value="isTitle">
                                    	<input type="hidden" id="not-checked" name="isTitle" value="false">
                                    )
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