<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/> <!-- ${contextPath} -->
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

function cart(){
	if(confirm('장바구니로 이동하시겠습니까?')){
		window.location.href="{contextPath}/cart.jsp";
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
	<jsp:include page="../header.jsp"></jsp:include>
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
    <section class="login-area section-padding-100">
        <div class="admin-container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="member-content">
                        <h3>Membership Management</h3><br>
                        <!-- Membership manage Form -->
                        <div class="member-manage-form">
                        
                        <table>
                        <tr>
                        	<th>앨범명</th>
                        	<td>The 1st Mini Album '광화문에서 (At Gwanghwamun)'</td>
                        </tr>
                        <tr>
                        	<th>아티스트</th>
                        	<td>규현 (KYUHYUN)</td>
                        </tr>
                        <tr>
                        	<th>기획사</th>
                        	<td>SM ENTERTAINMENT</td>
                        </tr>
                        <tr>
                        	<th>앨범소개</th>
                        	<td>
                        	규현, 첫 솔로 앨범 ‘광화문에서’ 발표<br>
							감성 발라드 선사! 차세대 발라드 황태자 예고! <br>
							슈퍼주니어 규현이 첫 솔로 앨범을 발표하고 감성 발라더로 변신한다.<br> 
							규현은 첫 미니앨범 ‘광화문에서’를 발매, 본격적인 활동에 나서, 규현 특유의 감미로운 보이스와 뛰어난 곡 소화력, 감성적인 음악 색깔이 어우러진 앨범으로 차세대 발라드 황태자로 주목받을 것으로 기대된다.<br>
							특히, 이번 앨범에는 다수의 히트곡을 만든 작곡가 Kenzie, 피아니스트 이루마, Honeydew’O (브라운아이드소울 정엽 & 에코브릿지),
							‘두사람’ ‘좋을텐데’의 작곡가 윤영준, 인기 작사가 양재선, 동방신기 최강창민 등 유명 작곡, 작사진이 참여, 규현과 환상적인 호흡을 맞춘 총 7곡이 수록되어 있어 완성도 높은 발라드 음악을 만나기에 충분하다.
                       		감성적인 색깔의 최고의 가을송! 타이틀 곡 ‘광화문에서’
                        	타이틀 곡 ‘광화문에서(At Gwanghwamun)’는 서정적인 멜로디와 규현의 감미로운 보이스가 완벽한 조화를 이룬 발라드 곡으로, 연인과의 이별을 계절이 주는 아름다움과 변화에 빗대어 담담하게 표현한 독백체의 가사가 폭넓은 세대의 감성과 공감을 자아내, 올 가을 최고의 발라드로 사랑받기 충분하다.
                       		또한 피아니스트 이루마와 2FACE가 작곡한 ‘Eternal Sunshine’은 영화 장면을 떠오르게 하는 매력적인 가사와 이루마의 감성 짙은 피아노 선율이 곡 특유의 쓸쓸함과 애잔함을 더하며, Honeydew’O (브라운아이드소울 정엽 & 에코브릿지)가 공동 작업한 ‘뒷모습이 참 예뻤구나(At close)’는 아픈 이별을 담은 발라드 곡으로 규현의 애절한 감성과 서정성을 만날 수 있다. 
							더불어 ‘이별을 말할 때(Moment of farewell)’는 이별의 말을 들은 순간을 현실적으로 표현한 가사가 인상적인 발라드 곡이며, ‘사랑이 숨긴 말들(One confession)’은 사랑하는 마음을 숨기고 바라만 보고 있는 남자의 가슴 시린 고백을 감성적으로 풀어낸 곡으로 규현 특유의 감성 보컬이 곡의 매력을 한층 배가시킨다.
							게다가 이문세의 히트곡을 새롭게 편곡한 리메이크 곡 ‘깊은 밤을 날아서’, 슈퍼주니어 월드 투어 ‘슈퍼쇼6’에서 선공개한 규현의 자작곡으로 동방신기 최강창민이 작사에 참여한 ‘나의 생각, 너의 기억(My thoughts, Your memories)’ 역시 보컬리스트 규현의 뛰어난 역량과 음악 색깔을 확실히 보여준다.
                        	</td>
                        </tr>
                                                                                                
                        </table>
                        
                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Member Control Area End ##### -->        
        
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