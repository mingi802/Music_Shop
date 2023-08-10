package music;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MusicDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private DataSource dataFactory;
	
//	private static String dbURL = "";
//	private static String dbID = "";
//	private static String dbPassword = "";
//	private static String driver = "";


	
	public MusicDAO() {
		
//		driver = "com.mysql.jdbc.Driver";
//		dbURL = "jdbc:mysql://localhost:3306/musicshop?serverTimezone=UTC&useSSL=false";
//		dbID = "root";
//		dbPassword = "jinsang1027#";
	}
	
	public List<MusicVO> listMusic(){
		List<MusicVO> musicList = new ArrayList<>();
		
		try {
			try {
				connDB();
			}catch (Exception e) {
				e.printStackTrace();
			}
			String sql = "SELECT * FROM album";
			System.out.println(sql);
			
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String album = rs.getString("name");
				String title = rs.getString("title");
				String singer = rs.getString("singer");
				String now = rs.getString("now");
				String sign = rs.getString("sign");
				
				//MusicVO musicVO = new MusicVO(album, title, singer, now, sign);
				
				//musicList.add(musicVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return musicList;
		
	}
	
	public void addMusic(MusicVO m){
		
		try {
			
			try {
				connDB();
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			String album_name = m.getAlbum(); //앨범명
			boolean isTitle = m.getisTitle(); //타이틀곡 여부
			String song_name = m.getTitle(); //타이틀곡명
			String singer_name = m.getSinger(); //가수
			Date now = m.getNow(); // 발매일
			int price = m.getPrice(); //음원 가격
			String sign = m.getSign(); //앨범 이미지 경로
			String song = m.getSong(); //음원 경로
			
			String sql = "call insert_song(?, ?, ?, ?, ?, ?, ?, ?);";
//				(in album_name varchar(60), in singer_name varchar(60), in now date, in sign varchar(60), in song_name varchar(60), in price int, in song varchar(60), in isTitle boolean)	
			PreparedStatement pstmt = conn.prepareStatement(sql);
			/*
			in album_name varchar(60), 
			in singer_name varchar(60), 
			in now date, 
			in sign varchar(60), 
			in song_name varchar(60), 
			in price int, 
			in song varchar(60), 
			in isTitle boolean
			*/
			pstmt.setString(1, album_name);
			pstmt.setString(2, singer_name);
			pstmt.setDate(3, now);
			pstmt.setString(4, sign);
			pstmt.setString(5, song_name);
			pstmt.setInt(6, price);
			pstmt.setString(7, song);
			pstmt.setBoolean(8, isTitle);
			pstmt.executeUpdate();
			
			pstmt.close();
			
			conn.close();
		
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
	}
	
	private void connDB() {

		try {
//			Class.forName(driver);
//			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataFactory = (DataSource) envContext.lookup("jdbc/mysql");
			conn = dataFactory.getConnection();
			System.out.println("DB 접속 성공");
			
			System.out.println("Connection 이 성공적으로 되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
