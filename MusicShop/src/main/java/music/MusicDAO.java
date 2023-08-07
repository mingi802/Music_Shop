package music;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
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
		dbPassword = "1234";
	}
	
	public List<MusicVO> listMusic(){
		List<MusicVO> musicList = new ArrayList<>();
		
		try {
			try {
				connDB();
			}catch (Exception e) {
				e.printStackTrace();
			}
			String sql = "SELECT * FROM song";
			System.out.println(sql);
			
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String album = rs.getString("album");
				String title = rs.getString("title");
				String singer = rs.getString("singer");
				String now = rs.getString("now");
				String price = rs.getString("price");
				String sign = rs.getString("sign");
				String song = rs.getString("song");
				
				MusicVO musicVO = new MusicVO(album, title, singer, now, price, sign, song);
				
				musicList.add(musicVO);
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
			int id = m.getId();
			String album = m.getAlbum();
			String title = m.getTitle();
			String singer = m.getSinger();
			String now = m.getNow();
			String price = m.getPrice();
			String sign = m.getSign();
			String song = m.getSong();
						
			String sql = "INSERT INTO song(id, album, title, singer, now, price, sign, song)" + "VALUES(?,?,?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			pstmt.setString(2, album);
			pstmt.setString(3, title);
			pstmt.setString(4, singer);
			pstmt.setString(5, now);
			pstmt.setString(6, price);
			pstmt.setString(7, sign);
			pstmt.setString(8, song);
			
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
