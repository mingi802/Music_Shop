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
		window.location.href="${contextPath}/cart.jsp";
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
    <section class="login-area rev-section-padding-100">
        <div class="review-container">
            <div class="row justify-content-center">
                <div class="col-12 col-lg-8">
                    <div class="review-content">
                        <h3>게시판</h3><br>
                        <!-- Membership manage Form -->
                        <div class="review-board-form">
                        <table>
                        	<tr>
                        		<th>번호</th><th>음원</th><th>가수</th><th>작성자</th><th>작성일</th><th>별점</th>
                        	</tr>
							<%
							String sql = "SELECT * FROM board";
							PreparedStatement pstmt = conn.prepareStatement(sql);
							ResultSet rs = pstmt.executeQuery();
							
							while(rs.next()){
							String star = "";
							switch(rs.getString("star")){
								
								case "5" : star = "★★★★★"; break;
								case "4" : star = "★★★★"; break;
								case "3" : star = "★★★"; break;
								case "2" : star = "★★"; break;
								case "1" : star = "★"; break;
							
								}
							%>
							<tr>
								<td><%=rs.getInt("id") %></td> <!-- 글 번호 -->
								<td><a href="review_detail.jsp?id=<%=rs.getString("user_id")%>&title=<%=rs.getString("album_name")%>"><%=rs.getString("album_name")%></a></td> <!-- 음원 이름 -->
								<td><%=rs.getString("singer") %></td>
								<td><%=rs.getString("user_id") %></td> <!-- 작성자 -->
								<td><%=rs.getString("date") %></td> <!-- 작성일 -->
								<td><%=star%><td> <!-- 별점 -->
							</tr>
							<%
							}
							%>
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