<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.sql.DataSource"%>


<%
	Connection conn;
	DataSource dataFactory;
	
	Context ctx = new InitialContext();
	Context envContext = (Context) ctx.lookup("java:/comp/env");
	dataFactory = (DataSource) envContext.lookup("jdbc/mysql");
	conn = dataFactory.getConnection();
	System.out.println("DB 접속 성공");
		
%>
