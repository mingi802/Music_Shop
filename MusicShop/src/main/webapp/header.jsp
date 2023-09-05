
  <%
	String user_id = (String) session.getAttribute("id");
	String code = (String) session.getAttribute("code");
	String name = (String) session.getAttribute("name");
  %> 

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
                                                    <li><a href="${contextPath}/admin/artist.jsp">아티스트목록</a></li>
                                                    <li><a href="${contextPath}/admin/host.jsp">관리자목록</a></li>
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
                                                    <li><a href="${contextPath}/artist/artist.jsp">음원등록</a></li>
                                                    <li><a href="${contextPath}/artist/music_delete.jsp">음원관리</a></li>
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