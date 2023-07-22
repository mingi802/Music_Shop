<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.util.Enumeration"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="org.apache.commons.io.output.ByteArrayOutputStream"%>
<%@ page import="org.apache.commons.codec.binary.Base64"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset=UTF-8">
<title>Insert title here</title>
<script>
function imgsrcblob(blob) {
		var reader = new FileReader();
		reader.onload = function(e) {
			document.getElementsByName('myimg')[i].src = reader.result;
		}
		reader.readAsDataURL(blob);
	}
</script>
</head>
<body>
<%
Connection conn = null;
try {
	String dbURL = "jdbc:mysql://localhost:3306/MusicShop?serverTimezone=UTC";
	String dbID = "root";
	String dbPassword = "1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
	
	System.out.println("MySql Connected");
	
	//System.out.println("수행된 열 수: " + rows);
} catch (ClassNotFoundException e) {
	e.printStackTrace();
} catch(SQLException e) {
	e.printStackTrace();
}

try {
	String sql = "SELECT image FROM songtest WHERE image is not null";
    PreparedStatement statement = conn.prepareStatement(sql);

    ResultSet result = statement.executeQuery();
    int count = 0;
    while (result.next()) {
        Blob blob = result.getBlob("image");
        InputStream inputStream = blob.getBinaryStream();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        OutputStream outputStream = new FileOutputStream("D:/Photos/test"+count+".jpg");
        count++;
       
        int bytesRead = -1;
        byte[] buffer = new byte[(int) blob.length()];
        while ((bytesRead = inputStream.read(buffer)) != -1) {
        	System.out.println(bytesRead);
        	baos.write(buffer, 0, bytesRead);
        	String base64str = "";
        	base64str = Base64.encodeBase64String(baos.toByteArray());
        	%>
        		<img name='myimg' src="data:image/*;base64,<%=base64str%>">
        	<%
            outputStream.write(buffer, 0, bytesRead);
        }
		
        inputStream.close();
        outputStream.close();
        System.out.println("File saved");
    }
} catch (Exception e) {
	e.printStackTrace();
}
%>
</body>
</html>