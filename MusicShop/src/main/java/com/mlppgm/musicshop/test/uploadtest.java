package com.mlppgm.musicshop.test;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
/**
 * Servlet implementation class FileUpload
 */
@WebServlet("/upload.do")
public class uploadtest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public uploadtest() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		DiskFileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);   //요청 처리 객체
	      
	    List<FileItem> list = null;
		try {
			list = upload.parseRequest(request);
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	      
	      for(int i = 0; i < list.size(); i++) { //11개
	         FileItem fileItem = list.get(i);
	         if(fileItem.isFormField()) {
	             String name=fileItem.getFieldName();
	             String value=fileItem.getString("utf-8");
	             System.out.println("it's formfield"+i);
	         } else {
	           
	            	 if(fileItem.getName()==null||fileItem.getName().equals("")) 
	            		 continue;
	            	 String fileName = System.currentTimeMillis() + "_"+fileItem.getName();
	        	  
	            	 byte[] returnValue = null;
	            	 ByteArrayOutputStream baos = new ByteArrayOutputStream();
	            	 InputStream fis = fileItem.getInputStream();
	            	 byte[] buffer = new byte[(int) fileItem.getSize()];
	            	 System.out.println(buffer.length);
	 				 int read = -1;
		        	 try {
		        		 while ((read=fis.read(buffer)) != -1) {
		 					baos.write(buffer, 0, read);
		        		 }
		        		 returnValue = baos.toByteArray();
					} catch (Exception e) {
					    e.printStackTrace();
					} finally {
					    if(baos!=null) 
					    	baos.close();
					    if(fis!=null) 
					    	fis.close();
					}
		        	 
		        	System.out.println(returnValue); 
		 			try {
		 				String insert = "Insert into songtest (image) values(?)";
		 				PreparedStatement pstmt = conn.prepareStatement(insert);
		 				pstmt.setBytes(1, returnValue);
		 				System.out.println(pstmt);
		 				int rows = pstmt.executeUpdate();
		 				pstmt.close();
		 				System.out.println(rows);
		 			} catch (Exception e) {
		 				e.printStackTrace();
		 			}
	             }
	         }
	      		 String url = "/impTest/blobview.jsp";
	      		 RequestDispatcher dispatcher = request.getRequestDispatcher(url);
	    		 dispatcher.forward(request, response);
	      
	    }
	
		
		/*
		request.setCharacterEncoding("UTF-8");
		String  encoding = "UTF-8";
		File currentDirPath = new File("D:\\JavaProgram\\fileupload\\src\\main\\webapp\\resource\\img");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024*1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		
		try {
			List<FileItem> items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
                FileItem fileItem = (FileItem) items.get(i);

                if (fileItem.isFormField()) {
                    System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
                } else {
                    System.out.println("파라미터명:" + fileItem.getFieldName());
                    System.out.println("파일명:" + fileItem.getName());
                    System.out.println("파일크기:" + fileItem.getSize() + "bytes");

                    if (fileItem.getSize() > 0) {
                        int idx = fileItem.getName().lastIndexOf("\\");
                        if (idx == -1) {
                            idx = fileItem.getName().lastIndexOf("/");
                        }
                        String fileName = fileItem.getName().substring(idx + 1);
                        File uploadFile = new File(currentDirPath + "\\" + fileName);
                        fileItem.write(uploadFile);
                    } // end if
                } // end if
            } // end for
        } catch (Exception e) {
            e.printStackTrace();
        }
        */
}