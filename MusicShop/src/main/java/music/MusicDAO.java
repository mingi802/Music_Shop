package music;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MusicDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	
	private static String dbURL = "";
	private static String dbID = "";
	private static String dbPassword = "";
	private static String driver = "";
	
	public MusicDAO() {
		
		driver = "com.mysql.jdbc.Driver";
		dbURL = "jdbc:mysql://localhost:3306/musicshop?serverTimezone=UTC&useSSL=false";
		dbID = "root";
		dbPassword = "jinsang1027@";
	}
	public void addMusic(MusicVO m){
		
		try {
			
			try {
				connDB();
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			String title = m.getTitle();
			String singer = m.getSinger();
			String now = m.getNow();
			String price = m.getPrice();
			String sign = m.getSign();
			String song = m.getSong();
			
			String sql = "INSERT INTO song(id, title, singer, now, price, sign, song)" + "VALUES(0,?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(2, title);
			pstmt.setString(3, singer);
			pstmt.setString(4, now);
			pstmt.setString(5, price);
			pstmt.setString(6, sign);
			pstmt.setString(7, song);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			
			conn.close();
		
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		
	}
	
	private void connDB() {

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
			System.out.println("Connection 이 성공적으로 되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
