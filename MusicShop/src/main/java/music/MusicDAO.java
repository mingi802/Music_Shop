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
	
	public List<MusicVO> listMusic(String name){
		List<MusicVO> musicList = new ArrayList<>();
		
		try {
			try {
				connDB();
			}catch (Exception e) {
				e.printStackTrace();
			}
			/*
			 * 
			 *  case ~ end : if{}문과 같다.
			 *  when ~ then ~ else : 
			 *  as ~ : 가져올 때 컬럼명을 ~로 한다.
			 *  as title 없이 쿼리문을 실행하면 case ~ end까지가 컴럼명으로 출력
			 *  ifnull(a,b) : a가 null이라면 b로 값을 대체 
			 *  처음 ifnull : 얼범 아이디를 가져와서 쿼리문에 넣고 실행해서 같은 앨범 아이디의 음원 가격의 합을 구함
			 * */
			String sql ="SELECT name,\n" +	//앨범 이름 가져오고
						"		CASE\n" +   //sql의 if문같은거 
						"			WHEN title = '' or title is null THEN\n"+ //title컬럼 값이 비어있거나 null이라면 
						"				'no title'\n"+						  //'no title'이라는 내용의 문자열로 가져오고
						"			ELSE\n"+								  //아니면 title컬럼 값이 존재한다는 것이므로
						"				title\n"+							  //그 값을 가져온다
						"		END as title, singer,\n"+ 					  //END: CASE 종료, as title을 안달아주면 위의 CASE문이 컬럼명으로 출력된다, 가수명 가져오고 
						"		IFNULL((select sum(price) from song where song.album_id = album.id), 0) as price, now, sign,\n"+
								//IFNULL(a, b)은 a가 null이라면 b로 값을 대체해준다.
								//song테이블의album_id컬럼 값이 album테이블의id컬럼 값과 같은 song테이블 행들의 price 합, 발매일, 이미지 파일 경로 가져와주고   
						"		IFNULL((select song from song where song.album_id = album.id and song.name = album.title), 'no audio file') as song\n"+ 
								//song테이블의album_id컬럼 값이 album테이블의id컬럼 값과 같으며 album테이블의 title컬럼과 song테이블의 name컬럼이 같은 song테이블의 song컬럼을 가져온다 
						"FROM album WHERE singer = '"+ name +"'\n"; 
						//"WHERE singer = ?";
			pstmt = conn.prepareStatement(sql);
			//pstmt.setString(1, singer_name);
			System.out.println(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String album_name = rs.getString("name");
				String title = rs.getString("title");
				String singer = rs.getString("singer");
				int price = rs.getInt("price");
				Date now = rs.getDate("now");
				String sign = rs.getString("sign");
				String song = rs.getString("song");
				
				MusicVO musicVO = new MusicVO();
				
				musicVO.setAlbum(album_name);
				musicVO.setTitle(title);
				musicVO.setSinger(singer);
				musicVO.setPrice(price);
				musicVO.setNow(now);
				musicVO.setSign(sign);
				musicVO.setSong(song);
				
				musicList.add(musicVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(musicList.size() == 0) {
			System.out.println("No Result");
			return null;
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
