<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../mydbcon.jsp" %> <!-- 본인 아이디와 비밀번호로 변경하세요. -->    
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
    <link rel="icon" href="../img/core-img/favicon.ico">

    <!-- Stylesheet -->
    <link rel="stylesheet" href="../style.css">
<%
String user_id = (String) session.getAttribute("id");
String code = (String) session.getAttribute("code");
String name = (String) session.getAttribute("name");
//String user_id = "곽두팔"; // 로그그인 된 경우, 예시 아이디
//String code = "100";	// 로그인이 된 경우, 예시 구분 코드 / 100 : 소비자, 200 : 관리자 , 300 : 아티스트
%>
<script>
/*1분 미리듣기 함수*/
function limitPlayTime(audio) {
    if (audio.currentTime > 60) { // 1분(60초)로 제한
        audio.pause();
        audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
        alert("1분 미리듣기가 종료되었습니다.");
    }
}

function confirmLogin(){
	var id = document.getElementById('user').value;
	if(id == 'null'){
		alert("로그인 후 이용해주세요.");
		window.location.href="../login/login.jsp";
		return false;
	} else{
		return true;
	}
		
}

function cart(){
	if(confirm('장바구니로 이동하시겠습니까?')){
		window.location.href="../cart.jsp";
		return true;
	} else{
		return false;
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
                        <a href="../main.jsp" class="nav-brand"><img src="../img/core-img/lologo.png" alt=""></a>

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
                                		<li><a href="../my_song.jsp">MySong</a></li>
                                	<%} 
                                	%>
                                    <li><a href="../main.jsp">Home</a></li>
                                    <li><a href="../album.jsp">Album</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="../main.jsp">Home</a></li>
                                            <li><a href="../album.jsp">Album</a></li>
                                            <li><a href="../connection.jsp">Contact</a></li>
                                            <li><a href="../review/review.jsp">Review</a></li>
                                    <%
                                    if(code != null){
                                    	if(code.equals("200")){	
                                    %>
                                    <li><a href="#">Manage</a>
                                        <ul class="dropdown">
                                            <li><a href="../customer/mypage.jsp">내정보</a></li>
                                            <li><a href="../admin.jsp">회원목록</a></li>
                                            <li><a href="../artist.jsp">아티스트목록</a></li>
                                            <li><a href="../host.jsp">관리자목록</a></li>
                                            <li><a href="review.jsp">게시판관리</a></li>
                                            <li><a href="../admin/musicManage.jsp">앨범관리</a></li>
                                        </ul>
                                    </li>
                                    <%
                                    } else if(code.equals("100")){   
                                    %>
                                    <li><a href="#">User</a>
                                    	<ul class="dropdown">
                                        	<li><a href="../customer/mypage.jsp">내정보</a></li>
                                        	<li><a href="../cart.jsp">장바구니</a></li>
                                        	<li><a href="../my_song.jsp">구매내역</a></li>
                                     	</ul>
                                	</li>
                                    <%
                                    } else if(code.equals("300")){
                                    %>
                            		<li><a href="#">Artist</a>
                                    	<ul class="dropdown">
                                        	<li><a href="../customer/mypage.jsp">내정보</a></li>
                                       		<li><a href="../artist/artist.jsp">음원등록</a></li>
                                        	<li><a href="../artist/music_delete.jsp">음원관리</a></li>
                                    	</ul>
                                   	</li>                           
                                    <%
                                    	}
                                    }
                                    %>                                            
                                        </ul>
                                    </li>
                                    <li><a href="../connection.jsp">Contact</a></li>
                                </ul>
<% 
	if(user_id == null) {
%>
                                <!-- Login/Register & Cart Button -->
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../login/login.jsp" id="loginBtn">Login / Register</a>
                                    </div>
								
<% 
	} else {
		if(code.equals("100")){
%>
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../customer/mypage.jsp" id="loginBtn"><%=user_id %> 님</a>
                                    </div>
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../login/logout.jsp" id="loginBtn">Logout</a>
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
                                        <a href="../admin/admin.jsp" id="loginBtn"><%=user_id %> 관리자님</a>
                                    </div>
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../login/logout.jsp" id="loginBtn">Logout</a>
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
                                        <a href="../artist/artist.jsp" id="loginBtn"><%=name %> 아티스트</a>
                                    </div>	
                                <!-- <div class="login-register-cart-button d-flex align-items-center">  -->
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="../login/logout.jsp" id="loginBtn">Logout</a>
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
    <section class="breadcumb-area bg-img bg-overlay" style="background-image: url(../img/bg-img/breadcumb3.jpg);">
        <div class="bradcumbContent">
            <p>See what’s new</p>
            <h2>Admin Page</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->
    
    <!-- ##### Member Control Area Start ##### -->
    <section class="login-area rev-section-padding-100-alter">
        <div class="review-container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="review-content-detail">
                        <h3>게시판 글보기</h3><br>
                        <!-- Membership manage Form -->
                        <div class="review-board-form">
							<%
							String user = request.getParameter("id"); //작성자
							String title = request.getParameter("title"); //작성한 음원  
							
							String sql = "SELECT * FROM board WHERE user_id = '"+ user +"' AND album_name = '"+ title +"'";
							PreparedStatement pstmt = conn.prepareStatement(sql);
							ResultSet rs = pstmt.executeQuery();
							
							if(rs.next()){
							String star = "";
							switch(rs.getString("star")){
								
								case "5" : star = "★★★★★"; break;
								case "4" : star = "★★★★"; break;
								case "3" : star = "★★★"; break;
								case "2" : star = "★★"; break;
								case "1" : star = "★"; break;
							
								}
							%>
							<table class="notice-board">
							<tr>
								<th>음원</th>
								<td><%=rs.getString("album_name") %></td>
							</tr>
							<tr>
								<th>가수</th>
								<td><%=rs.getString("singer") %></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td><%=rs.getString("user_id") %></td>
							</tr>						
							<tr>
								<th>작성일</th>
								<td><%=rs.getString("date") %></td>
							</tr>
							<tr>
								<th>별점</th>
								<td><%=star %></td>
							</tr>					
							<tr>
								<th>내용</th>
								<td name="writen-review"><%=rs.getString("review") %></td>
							</tr>
							</table>
							<!-- 경계선 -->
							<table class="reply-board">
    						<tr>
        						<th>작성자</th><th>작성일</th><th>댓글</th>
    						</tr>
    						<%
    						String sqlR = "SELECT user_id, date, reply FROM replyboard WHERE song_name = ?";
    						PreparedStatement pstmtR = conn.prepareStatement(sqlR);
    						pstmtR.setString(1, title);
    						ResultSet rsR = pstmtR.executeQuery();
    
    						while (rsR.next()) {
    							if(rsR.getString("reply") == "" ){
    						%>
    							<tr>
    								<td colspan="4">작성한 댓글이 없습니다.</td>
    							</tr>
    						<%
    							} else {
    						%>	
    							<tr>
        							<td><%=rsR.getString("user_id") %></td> <!-- 댓글 작성자 -->
        							<td><%=rsR.getString("date") %></td> <!-- 댓글 등록 날짜 -->
        							<td><%=rsR.getString("reply") %></td> <!-- 댓글 내용 -->
        							
    							<%
    								if(code != null){
    									if(code.equals("200")){
    							%>
    							<td><button onclick="location.href='Redelete.jsp?id=<%=rsR.getString("user_id") %>&reply=<%=rsR.getString("reply")%>&title=<%=rs.getString("album_name")%>&writer=<%=rs.getString("user_id")%>'">댓글삭제</button></td>
    							<%
    									} //code == 200의 끝
    								} //code != null끝  
    							%>      							
    							</tr>
								<% 
    							}
    						}
    						rsR.close();
    						pstmtR.close();
						    %>
							</table>
							
							<form class="reply" name="reply" method="post" action="reply.jsp" onSubmit="return confirmLogin()" ecntype="UTF-8">
								<input type="hidden" name="songName" id="songName" value='<%=rs.getString("album_name")%>'> <!-- 노래제목 -->
								<input type="hidden" name="user" id="user" value='<%=user_id%>'> <!-- 댓글 작성자 -->
								<input type="hidden" name="writer" id="writer" value='<%=rs.getString("user_id")%>'>
								<textarea class="write-reply" id="songRelpy" name="songReply" rows="3" cols="65" maxlength="4000"></textarea> <!-- 댓글 내용 -->
								<input type="submit" class="reply-btn" value="리뷰 작성">
								<div class="emptySpace"></div>	
							</form>	
																		
							<%
							if(code != null){
								if(code.equals("200")){
							%>
								<button onclick="location.href='delete.jsp?id=<%=rs.getString("user_id") %>&album=<%=rs.getString("album_name") %>'">삭제</button>
							<%	
									}
								}
							}
							%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Member Control Area End ##### -->        
    <div class="before">  
		<button onclick="location.href='review.jsp'">이전</button>
	</div>
    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area">
        <div class="container">
            <div class="row d-flex flex-wrap align-items-center">
                <div class="col-12 col-md-6">
                    <a href="../main.jsp"><img src="../img/core-img/lologo.png" alt=""></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                </div>

                <div class="col-12 col-md-6">
                    <div class="footer-nav">
                        <ul>
                            <li><a href="../main.jsp">Home</a></li>
                            <li><a href="../album.jsp">Albums</a></li>
                            <li><a href="../connection.jsp">Contact</a></li>
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
</body>
</html>