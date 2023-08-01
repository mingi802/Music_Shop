<%@ page language="java" contentType="text/html; charset=UTF-8"	import=" java.util.*,music.*"	pageEncoding="UTF-8"	isELIgnored="false" 
%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="mydbcon.jsp" %>
<title>실험</title>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<form name="testform" action="${contextPath}/Music/addMusic.do" method="post" enctype="multipart/form-data">
	<tr>
		<td>
		<label>노래제목 : </label>
		<input type="text" name="name" id = "id" minlength = '1' required>
		</td>
	</tr>
	<br>
	<tr>
		<td>
			<label>가수 : </label>
				<input type="text" name="singer" required>
		</td>
	</tr>
	<br>
	<tr>
		<td>
			<label>발매일자 : </label>
				<input type="date" id="test_date" name="now" required>
		</td>
	</tr>
	<br>
	<tr>
		<td>
			<label>가격 : </label>
				<input type="text" name="price" required>
		</td>
	</tr>
	<br>
	<tr>
		<td>
			<label>앨범 이미지 : </label>
				<input type="file" name="imgfile" accept="image/*" required>
		</td>
	</tr>
	<br>
	<tr>
		<td>
			<label>음악 파일 : </label>
				<input type="file" name="musicfile" accept="audio/*" required>
		</td>
	</tr>
	<br>
	<tr>
		<td>
			<button type="submit">입력</button>
		</td>
	</tr>	
	</form>
	<script> <%-- 오늘 날짜 이후는 선택 되지 않게 막는 스크립트--%>
var now_utc = Date.now()
var timeOff = new Date().getTimezoneOffset()*60000;
var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
document.getElementById("test_date").setAttribute("max", today)
</script>
</body>
</html>