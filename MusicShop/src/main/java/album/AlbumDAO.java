package album;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.util.ArrayList;

public class AlbumDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private DataSource dataFactory;	
	//private static String dbURL = "";
	//private static String dbID = "";
	//private static String dbPassword = "";
	//private static String driver = "";
	
	public AlbumDAO() {
		//driver = "com.mysql.jdbc.Driver";
		//dbURL = "jdbc:mysql://localhost:3306/musicshop?serverTimezone=UTC&useSSL=false";
		//dbID = "root";
		//dbPassword = "jinsang1027#";
	}
	
	private void connDB() {

		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/mysql");
			conn = dataFactory.getConnection();
			System.out.println("DB 접속 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public int searchAlbumRows() {
		int rows = 0;
		try {
			try {
				connDB();
			} catch (Exception e) {
				e.printStackTrace();
			}
			String sql = "SELECT count(*) FROM album";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				rows = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rows;
	}
	
	public List<AlbumVO> searchAllAlbum(){
		List<AlbumVO> albumList = new ArrayList<AlbumVO>();
		try {
			
			try {
				connDB();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String sql = "SELECT * FROM album";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int id = rs.getInt("id");
				String album = rs.getString("name");
				String title = rs.getString("title");
				String singer = rs.getString("singer");
				Date now = rs.getDate("now");
				//String price = rs.getString("price");
				String sign = rs.getString("sign");
				//String song = rs.getString("song");
				
				AlbumVO albumVO = new AlbumVO();
				
				albumVO.setId(id);
				albumVO.setAlbum(album);
				albumVO.setTitle(title);
				albumVO.setSinger(singer);
				albumVO.setNow(now);
				//albumVO.setPrice(price);
				albumVO.setSign(sign);
				//albumVO.setSong(song);
				
				albumList.add(albumVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return albumList;
	}

	
	public List<AlbumVO> searchAlbum(String albumName){
		List<AlbumVO> albumList = new ArrayList<AlbumVO>();
		
		try {
			
			try {
				connDB();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String sql = "SELECT * FROM album WHERE singer Like '%"+albumName+"%' or name Like '%"+ albumName +"%'";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int id = rs.getInt("id");
				String album = rs.getString("name");
				String title = rs.getString("title");
				String singer = rs.getString("singer");
				Date now = rs.getDate("now");
				//String price = rs.getString("price");
				String sign = rs.getString("sign");
				//String song = rs.getString("song");
				
				AlbumVO albumVO = new AlbumVO();
				
				albumVO.setId(id);
				albumVO.setAlbum(album);
				albumVO.setTitle(title);
				albumVO.setSinger(singer);
				albumVO.setNow(now);
				//albumVO.setPrice(price);
				albumVO.setSign(sign);
				//albumVO.setSong(song);
				
				albumList.add(albumVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return albumList;
	}
}
