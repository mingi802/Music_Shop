<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

	<script>
	//1차,2차 비밀번호가 같은 확인 하는 함수
	function checkPwd(pwd1, pwd2){
		if(pwd1 === pwd2){
			return true;
		} else{
			return false;
		}
	}
	

	
	function confirmform(){
		//console.log('확인');
		/*var id = document.Registform.id(요건 name하고 무조건 같다).value;*/
		var id = document.Registform.user_id.value;
		
		var pwd1 = document.Registform.user_pwd.value;
		var pwd2 = document.Registform.user_pwd_c.value;
		
		var name = document.Registform.user_name.value;
		
		var email = document.Registform.user_email.value;
		
		var address = document.Registform.user_addr.value;
		
		var number = document.Registform.user_num.value;
		
		var year = document.Registform.birthYear.value;
		var birth = document.Registform.birthMonth.value;
		var day = document.Registform.birthDay.value;
		
		var gender = document.Registform.user_gen.value;
		
		var position = document.Registform.user_pos.value;
		

		
		/* 모든 항목 중에 입력안한 곳이 있을 시 */
		if (!id || !pwd1 || !pwd2 || !name || !email || !address || !year || !birth || !day || !gender || !position || !number) {
			alert('모든 항목을 입력해주세요!');
			return false;
		}
		else {
			if(!checkPwd(pwd1,pwd2)){
				alert("비밀번호 다시 입력해주세요");
				return false;
			}
			if (number.length !== 11) {
		        alert("전화번호를 다시 입력해주세요.");
		        return false;
		    }
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
                                    <li><a href="../album.jsp">Albums</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="../main.jsp">Home</a></li>
                                            <li><a href="../album.jsp">Albums</a></li>
                                            <!--  
                                            <li><a href="../event.html">Events</a></li>
                                            <li><a href="../blog.html">News</a></li>
                                            -->
                                            <li><a href="../connection.jsp">Contact</a></li>
                                            <!--  
                                            <li><a href="../elements.html">Elements</a></li>
                                            -->
                                            <li><a href="../login.jsp">Login</a></li>
                                            <li><a href="#">Dropdown</a>
                                                <ul class="dropdown">
                                                    <li><a href="#">Even Dropdown</a></li>
                                                    <li><a href="#">Even Dropdown</a></li>
                                                    <li><a href="#">Even Dropdown</a></li>
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

                                <!-- Login/Register & Cart Button -->
                                <div class="login-register-cart-button d-flex align-items-center">
                                    <!-- Login/Register -->
                                    <div class="login-register-btn mr-50">
                                        <a href="login.jsp" id="loginBtn">Login / Register</a>
                                    </div>

                                    <!-- Cart Button 
                                    <div class="cart-btn">
                                        <p><span class="icon-shopping-cart"></span> <span class="quantity">1</span></p>
                                    </div>
                                    -->
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
            <h2>회원가입</h2>
        </div>
    </section>
    <!-- ##### Breadcumb Area End ##### -->

    <!-- ##### Login Area Start ##### -->
    <section class="login-area section-padding-100">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="login-content">
                        <h3>Membership</h3>
                        <!-- Login Form -->
                        <div class="login-form">
                            <form name="Registform" action="regist_ok.jsp" method="post" onSubmit="return confirmform()" encType="UTF-8">
                                <div class="form-group">
                                    <label for="exampleId">아이디(Id)</label>
                                    <input type="text" class="form-control" id="InputId" aria-describedby="emailHelp" name="user_id" placeholder="Enter ID">
                                    </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">비밀번호(Password)</label>
                                    <input type="password" class="form-control" id="InputPwd" name="user_pwd" placeholder="Enter Password">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1Check">비밀번호 확인(Password Confirm)</label>
                                    <input type="password" class="form-control" id="InputPwdCheck" name="user_pwd_c" placeholder="Password Check">
                                </div>                            
                                <div class="form-group">
                                    <label for="exampleInputName1">이름(Name)</label>
                                    <input type="text" class="form-control" id="InputName" aria-describedby="emailHelp" name="user_name" placeholder="Enter name">
                                    <small id="emailHelp" class="form-text text-muted"><i class="fa fa-lock mr-2"></i>We'll never share your name with anyone else.</small>
                                    <!-- email을 text로 바꾸면 끝 -->
                                </div>
                                <div class="form-group">
                                    <label for="InputBirth">생년월일(Birth)</label><br>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>                                  
										<select name="birthYear" class="form-year">
										<option value="">선택</option>
											<script>
												for(var i = 2023 ; i >=1920 ; i--){
													document.write("<option>"+i+"</option>");
												}
											</script>
										</select>년
										<span class="spacing"></span> 
										<select name="birthMonth" class="form-birth">
										<option value="">선택</option>
											<script>
												for(var i = 1 ; i <=12 ; i--){
													document.write("<option>"+i+"</option>");
												}
											</script>
										</select>월
										<span class="spacing"></span> 
										<select name="birthDay" class="form-day">
										<option value="">선택</option>
											<script>
												for(var i = 1 ; i <=31 ; i--){
													document.write("<option>"+i+"</option>");
												}
											</script>
										</select>일										
                                </div>                                             
                                <div class="form-group">
                                    <label for="InputGender">성별(Gender)</label><br>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputGender" name="user_gen" value="남자">남자
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputGender" name="user_gen" value="여자">여자
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputName1">전화번호(Number)</label>
                                    <input type="text" class="form-control" id="InputNum" name="user_num" placeholder="Enter number(except dash)">
                                </div>                                                                                                              
                                <div class="form-group">
                                    <label for="InputEmail">이메일(Email)</label>
                                    <input type="email" class="form-control" id="InputEmail" name="user_email" placeholder="Enter email">
                                </div>       
                                <div class="form-group">
                                    <label for="InputAddress">주소(Address)</label>
                                    <input type="text" class="form-control" id="InputAddr" name="user_addr" placeholder="Enter address">
                                </div>                                                           
                                <div class="form-group">
                                    <label for="InputPosition">구분(Position)</label><br>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputPosition" name="user_pos" value="100">소비자
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputPosition" name="user_pos" value="200">관리자
                                     <span class="spacing"></span>
                                    <input type="radio" class="form-controlasd" id="InputPosition" name="user_pos" value="300">아티스트
                                </div>                                  
                                <input type="submit" class="btn oneMusic-btn mt-30" value="가입하기">
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
                    <a href="#"><img src="img/core-img/logo.png" alt=""></a>
                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                </div>

                <div class="col-12 col-md-6">
                    <div class="footer-nav">
                        <ul>
                            <li><a href="../main.jsp">Home</a></li>
                            <li><a href="../album.jsp">Albums</a></li>
                            <li><a href="#">Events</a></li>
                            <li><a href="#">News</a></li>
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