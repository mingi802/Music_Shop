<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<%@page session="true"%>

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
//String user_id = "곽두팔"; // 로그그인 된 경우, 예시 아이디
//String code = "100";	// 로그인이 된 경우, 예시 구분 코드 / 100 : 소비자, 200 : 관리자 , 300 : 아티스트
%>
<script>

/*1분 미리듣기 함수
function limitPlayTime(audio) {
    if (audio.currentTime > 60) { // 1분(60초)로 제한
        audio.pause();
        audio.currentTime = 0; // 음악이 끝난 후 처음으로 돌아감
        alert("1분 미리듣기가 종료되었습니다.");
    }
}
*/
function cart(){
	if(confirm('장바구니로 이동하시겠습니까?')){
		window.location.href="cart.jsp";
		return true;
	} else{
		return false;
	}
}
/*
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
  */
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
                        <a href="../main.jsp" class="nav-brand"><img src="../img/core-img/logo.png" alt=""></a>

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
                                    <li><a href="../main.jsp">Home</a></li>
                                    <li><a href="../album.jsp">Album</a></li>
                                    <li><a href="#">Manage</a>
                                        <ul class="dropdown">
                                            <li><a href="../main.jsp">Home</a></li>
                                            <li><a href="../album.jsp">Album</a></li>
                                            <!--  
                                            <li><a href="event.html">Events</a></li>
                                            <li><a href="blog.html">News</a></li>
                                            -->
                                            <li><a href="../connection.jsp">Contact</a></li>
                                            <!--  
                                            <li><a href="elements.html">Elements</a></li>
                                            -->
                                            <li><a href="../login/login.jsp">Login</a></li>
                                            <li><a href="#">Manage</a>
                                                <ul class="dropdown">
                                                    <li><a href="admin.jsp">Membership</a></li>
                                                    <li><a href="#">NoName</a></li>
                                                    <li><a href="#">NoName</a></li>
                                                    <li><a href="#">Even Dropdown</a>
                                                        <ul class="dropdown">
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                            <li><a href="#">Deeply Dropdown</a></li>
                                                        </ul>
                                                    </li>
                                                    <li><a href="#">Even Dropdown</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <!--  
                                    <li><a href="event.html">Events</a></li>
                                    <li><a href="blog.html">News</a></li>
                                    -->
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
                                        <a href="../mypage.jsp" id="loginBtn"><%=user_id %> 님</a>
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
                                        <a href="admin.jsp" id="loginBtn"><%=user_id %> 관리자님</a>
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
                                        <a href="../artist/atist.jsp" id="loginBtn"><%=user_id %> 아티스트</a>
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
            <h2><%=user_id %>님 페이지</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->
    <aside class="admin-category">
    	<ul style="padding-left:5px;padding-top:20px;">
			<li><a href="myinfo.jsp"><b>내정보</b></a></li><br>  
			<li><a href="../cart.jsp"><b>장바구니</b></a></li><br>
			<li><a href="#"><b>구매내역</b></a></li><br>
    	</ul>
    </aside>
    <!-- ##### Login Area Start ##### -->
<%
	String editId = user_id;
	String editPwd = null;
	String editName = null;
	String editEmail = null;
	String editAddr = null;
	String editNum = null;
	String editYear = null;
	String editMonth = null;
	String editDay = null;
	String editGen = null;
	String editPos = null;
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM member WHERE id = '" + editId + "'";
	
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	
	if(rs.next()){
		editPwd = rs.getString("pwd");
		editName = rs.getString("name");
		editEmail = rs.getString("email");
		editAddr = rs.getString("addr");
		editNum = rs.getString("phone");
		String[] birth = rs.getString("birth").split("-");
		if(birth.length == 3){
			editYear = birth[0];
			editMonth = birth[1];
			editDay = birth[2];
		}
		editGen = rs.getString("gender");
		editPos = rs.getString("code");
		
	}
%>
    <section class="login-area section-padding-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="login-content">
                        <h3>Membership</h3>
                        <!-- Login Form -->
                        <div class="login-form">
                            <form name="Registform_Upate" action="update_ok.jsp" method="post" onSubmit="return confirmform()" encType="UTF-8">
                                <div class="form-group">
                                    <label for="exampleId">아이디(Id)</label>
                                    <input type="text" class="form-control" id="InputId" aria-describedby="emailHelp" name="user_id" value='<%=editId %>' placeholder="Enter ID">
                                    </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">비밀번호(Password)</label>
                                    <input type="password" class="form-control" id="InputPwd" name="user_pwd" value='<%=editPwd %>'  placeholder="Enter Password">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1Check">비밀번호 확인(Password Confirm)</label>
                                    <input type="password" class="form-control" id="InputPwdCheck" name="user_pwd_c" value='<%=editPwd %>' placeholder="Password Check">
                                </div>                            
                                <div class="form-group">
                                    <label for="exampleInputName1">이름(Name)</label>
                                    <input type="text" class="form-control" id="InputName" aria-describedby="emailHelp"  name="user_name" value='<%=editName %>' placeholder="Enter name">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>We'll never share your name with anyone else.</small>
                                    <!-- email을 text로 바꾸면 끝 -->
                                </div>
                                <div class="form-group">
                                    <label for="InputBirth">생년월일(Birth)</label><br>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>                                  
										<select name="birthYear" class="form-year" >
										<option value="">선택</option>
											<script>
												for(var i = 2023 ; i >=1920 ; i--){
													if(i == <%=editYear%>){
														document.write("<option selected=''selected>"+i+"</option>");
													} else{
														document.write("<option>"+i+"</option>");
													}
												}
											</script>
										</select>년
										<span class="spacing"></span> 
										<select name="birthMonth" class="form-birth" >
										<option value="">선택</option>
											<script>
												for(var i = 12 ; i >=1 ; i--){
													if(i == <%=editMonth%>){
														document.write("<option selected=''selected>"+i+"</option>");
													} else{
														document.write("<option>"+i+"</option>");
													}
												}
											</script>
										</select>월
										<span class="spacing"></span> 
										<select name="birthDay" class="form-day" >
										<option value="">선택</option>
											<script>
												for(var i = 31 ; i >=1 ; i--){
													if(i == <%=editDay%>){
														document.write("<option selected=''selected>"+i+"</option>");
													} else{
														document.write("<option>"+i+"</option>");
													}
												}
											</script>
										</select>일										
                                </div>                                             
                                <div class="form-group">
                                    <label for="InputGender">성별(Gender)</label><br>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputGender" name="user_gen" value="남자" 
                                    	<%if(editGen.equals("남자")) out.print("checked");%> >남자
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputGender" name="user_gen" value="여자"
                                    	<%if(editGen.equals("여자")) out.print("checked");%> >여자
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName1">전화번호(Number)</label>
                                    <input type="text" class="form-control" id="InputNum" name="user_num" value='<%=editNum %>' placeholder="Enter number(except dash)">
                                </div>                                                                                                              
                                <div class="form-group">
                                    <label for="InputEmail">이메일(Email)</label>
                                    <input type="email" class="form-control" id="InputEmail" name="user_email" value='<%=editEmail %>' placeholder="Enter email">
                                </div>       
                                <div class="form-group">
                                    <label for="InputAddress">주소(Address)</label>
                                    <input type="text" class="form-control" id="InputAddr" name="user_addr" value='<%=editAddr %>' placeholder="Enter address">
                                </div>                                                           
                                <div class="form-group">
                                    <label for="InputPosition">구분(Position)</label><br>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputPosition" name="user_pos" value="100"
                                    	<%if(editPos.equals("100")) out.print("checked"); %>>소비자
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputPosition" name="user_pos" value="200"
                                    	<%if(editPos.equals("200")) out.print("checked"); %>>관리자
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputPosition" name="user_pos" value="300"
                                    	<%if(editPos.equals("300")) out.print("checked"); %>>아티스트
                                </div>                                  
                                <input type="submit" class="btn oneMusic-btn mt-30" value="수정하기">
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
                    <a href="#"><img src="../img/core-img/logo.png" alt=""></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                </div>

                <div class="col-12 col-md-6">
                    <div class="footer-nav">
                        <ul>
                            <li><a href="../main.jsp">Home</a></li>
                            <li><a href="../album.jsp">Albums</a></li>
                            <!--  
                            <li><a href="#">Events</a></li>
                            <li><a href="#">News</a></li>
                            -->
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