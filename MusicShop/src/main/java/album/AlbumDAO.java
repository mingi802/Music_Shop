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
			
			//String sql = "SELECT * FROM album";
			String sql = "SELECT album.id, album.name, album.title, album.singer, album.now, album.sign, song.song, song.price FROM album, song WHERE album.title = song.name";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int id = rs.getInt("id"); //album에서의 id
				String album = rs.getString("name"); //album에서 앨범 이름
				String title = rs.getString("title"); //타이틀곡
				String singer = rs.getString("singer"); //가수
				Date now = rs.getDate("now"); //발매일
				int price = rs.getInt("price"); //가격
				String sign = rs.getString("sign"); //사진 
				String song = rs.getString("song"); //음원
				
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
	
	public List<AlbumVO> getThisWeeksTopAlbum(){
		List<AlbumVO> albumList = new ArrayList<AlbumVO>();
		try {
			
			try {
				connDB();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//String sql = "SELECT * FROM album";
			String sql =  "SELECT name, singer, sign\r\n"
						+ "FROM album\r\n"
						+ "ORDER BY (\r\n"
						+ "		SELECT count(*)\r\n"
						+ "		FROM payment \r\n"
						+ "		WHERE album_id = album.id AND\r\n"
						+ "	  		YEARWEEK(purchase_timestamp) = YEARWEEK(NOW())\r\n"
						+ "		GROUP BY album_id\r\n"
						+ "		) DESC\r\n"
						+ "LIMIT 6;"; 
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String album = rs.getString("name"); //album에서 앨범 이름
				String singer = rs.getString("singer"); //가수
				String sign = rs.getString("sign"); //사진 
				
				AlbumVO albumVO = new AlbumVO();
				
				albumVO.setAlbum(album);
				albumVO.setSinger(singer);
				albumVO.setSign(sign);
				
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
	
	public List<AlbumVO> getNewHitAlbum(){
		List<AlbumVO> albumList = new ArrayList<AlbumVO>();
		try {
			
			try {
				connDB();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			//String sql = "SELECT * FROM album";
			String sql = 
					  "SELECT name, singer, sign, (select song from song where album_id = album.id and name = album.title) as song_audio\r\n"
					+ "FROM album\r\n"
					+ "order by (\r\n"
					+ "select count(*)\r\n"
					+ "from payment \r\n"
					+ "where album_id = album.id and\r\n"
					+ "	  purchase_timestamp between DATE_SUB(NOW(), INTERVAL 1 MONTH) and now()\r\n"
					+ "group by album_id\r\n"
					+ ") desc\r\n"
					+ "limit 6;";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String album = rs.getString("name"); //album에서 앨범 이름
				String singer = rs.getString("singer"); //가수
				String sign = rs.getString("sign"); //사진 
				String song = rs.getString("song_audio"); //사진
				
				AlbumVO albumVO = new AlbumVO();
				
				albumVO.setAlbum(album);
				albumVO.setSinger(singer);
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
	
	public List<ArtistVO> getPopularArtist(){
		List<ArtistVO> artistList = new ArrayList<ArtistVO>();
		try {
			
			try {
				connDB();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String sql = 
					  	"SELECT singer, (select img from singer where id = singer_id) as singer_img\r\n"
					  + "FROM album\r\n"
					  + "order by (\r\n"
					  + "select count(*)\r\n"
					  + "from payment \r\n"
					  + "where album_id = album.id\r\n"
					  + "group by album_id\r\n"
					  + ") desc\r\n"
					  + "limit 7;";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String singer = rs.getString("singer"); //가수
				String singer_img = rs.getString("singer_img"); //사진 
				
				ArtistVO artistVO = new ArtistVO();
				
				artistVO.setName(singer);
				artistVO.setImg(singer_img);
	
				artistList.add(artistVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return artistList;
	}
	
	public List<AlbumVO> searchAlbum(String albumName){
		List<AlbumVO> albumList = new ArrayList<AlbumVO>();
		
		try {
			
			try {
				connDB();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String sql = "SELECT id, name, title, singer, now, sign, (SELECT song from song where name = title) as song FROM album WHERE singer Like '%"+albumName+"%' or name Like '%"+ albumName +"%'";
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
				String song = rs.getString("song");
				
				AlbumVO albumVO = new AlbumVO();
				
				albumVO.setId(id);
				albumVO.setAlbum(album);
				albumVO.setTitle(title);
				albumVO.setSinger(singer);
				albumVO.setNow(now);
				//albumVO.setPrice(price);
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
	
	public List<AlbumVO> selectAlbum(int album_id){ //String album 대신 int album_id로 변경
		
		List<AlbumVO> songList = new ArrayList<AlbumVO>();
		try {
			
			try {
				connDB();
			}catch (Exception e) {
				e.printStackTrace();
			}
			//String albumtitle = album;
			/*song.id, song.album_id 생략*/
			//String sql = "SELECT album.title, album.singer, song.name, song.price, song.song, album.sign FROM song, album WHERE album.id = song.album_id AND song.album_id='"+ albumtitle +"'";
			String sql = "SELECT album.name as album_name, album.title, album.singer, song.id as song_id, song.name, song.price, song.song, album.sign FROM song, album WHERE album.id = song.album_id AND album.id= ? order by FIELD(song.name, album.title) desc, song.name";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);			
			pstmt.setInt(1,album_id);
			System.out.println(pstmt);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String album_name = rs.getString("album_name"); 
				String title = rs.getString("title"); //타이틀곡
				String singer = rs.getString("singer"); // 가수
				int song_id = rs.getInt("song_id");
				String name = rs.getString("name"); //타이틀곡명, 수록곡명
				int price = rs.getInt("price"); //가격
				String song = rs.getString("song"); //음원 파일(.mp3)
				String sign = rs.getString("sign"); //앨범 일러스트(.jpg)
				
				AlbumVO albumVO = new AlbumVO();
				albumVO.setAlbum(album_name);
				albumVO.setTitle(title);
				albumVO.setSinger(singer);
				albumVO.setSong_id(song_id);
				albumVO.setPrice(price);
				albumVO.setName(name);
				albumVO.setSong(song);
				albumVO.setSign(sign);
				
				songList.add(albumVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return songList;
	}
	
}
