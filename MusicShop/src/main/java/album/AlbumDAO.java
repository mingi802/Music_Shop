package album;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;
import java.util.ArrayList;

public class AlbumDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	
	private static String dbURL = "";
	private static String dbID = "";
	private static String dbPassword = "";
	private static String driver = "";
	
	public AlbumDAO() {
		driver = "com.mysql.jdbc.Driver";
		dbURL = "jdbc:mysql://localhost:3306/musicshop?serverTimezone=UTC&useSSL=false";
		dbID = "root";
		dbPassword = "1234";
	}
	
	private void connDB() {

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
			System.out.println("Connection �� ���������� �Ǿ����ϴ�.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	public List<AlbumVO> showAllAlbum(){
		List<AlbumVO> albumList = new ArrayList<AlbumVO>();
		try {
			
			try {
				connDB();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String sql = "SELECT * FROM song";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int id = rs.getInt("id");
				String album = rs.getString("album");
				String title = rs.getString("title");
				String singer = rs.getString("singer");
				Date now = rs.getDate("now");
				String price = rs.getString("price");
				String sign = rs.getString("sign");
				String song = rs.getString("song");
				
				AlbumVO albumVO = new AlbumVO();
				
				if(String.valueOf(album.charAt(0)).matches(".*[��-����-�Ӱ�-�R]+.*")) {	//�ٹ� �̸� ù ���ڰ� �ѱ��� ���
					char uniVal = album.charAt(0);
					char cho = (char)((uniVal-0xAC00)/28/21);
					System.out.println(String.valueOf(cho));
				}
				
				albumVO.setId(id);
				albumVO.setAlbum(album);
				albumVO.setTitle(title);
				albumVO.setSinger(singer);
				albumVO.setNow(now);
				albumVO.setPrice(price);
				albumVO.setSign(sign);
				albumVO.setSong(song);
				
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
			
			String sql = "SELECT * FROM song WHERE album Like '%"+albumName+"%'";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int id = rs.getInt("id");
				String album = rs.getString("album");
				String title = rs.getString("title");
				String singer = rs.getString("singer");
				Date now = rs.getDate("now");
				String price = rs.getString("price");
				String sign = rs.getString("sign");
				String song = rs.getString("song");
				
				AlbumVO albumVO = new AlbumVO();
				
				albumVO.setId(id);
				albumVO.setAlbum(album);
				albumVO.setTitle(title);
				albumVO.setSinger(singer);
				albumVO.setNow(now);
				albumVO.setPrice(price);
				albumVO.setSign(sign);
				albumVO.setSong(song);
				
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