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
				String album = rs.getString("album");
				String title = rs.getString("title");
				String singer = rs.getString("singer");
				String now = rs.getString("now");
				String sign = rs.getString("sign");
				
				MusicVO musicVO = new MusicVO(album, title, singer, now, sign);
				
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
	
	public void addMusicImg(MusicVO m){
		
		try {
			
			try {
				connDB();
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			int id = m.getId();	//������ȣ
			String album = m.getAlbum(); //�ٹ���
			String title = m.getTitle(); //Ÿ��Ʋ��D
			String singer = m.getSinger(); //����
			String now = m.getNow(); // �߸���
			String sign = m.getSign(); //�ٹ� �̹��� ���
						
			String sql = "INSERT INTO album(id, album, title, singer, now, sign)" + "VALUES(?,?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			pstmt.setString(2, album);
			pstmt.setString(3, title);
			pstmt.setString(4, singer);
			pstmt.setString(5, now);
			pstmt.setString(6, sign);
			
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
			System.out.println("DB ���� ����");
			
			System.out.println("Connection �� ���������� �Ǿ����ϴ�.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
