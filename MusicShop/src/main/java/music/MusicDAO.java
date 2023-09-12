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
	
	public List<MusicVO> listMusic(String singer_id){
		List<MusicVO> musicList = new ArrayList<>();
		
		try {
			try {
				connDB();
			}catch (Exception e) {
				e.printStackTrace();
			}
			/*
			 * 
			 *  case ~ end : if{}���� ����.
			 *  when ~ then ~ else : 
			 *  as ~ : ������ �� �÷����� ~�� �Ѵ�.
			 *  as title ���� �������� �����ϸ� case ~ end������ �ķ������� ���
			 *  ifnull(a,b) : a�� null�̶�� b�� ���� ��ü 
			 *  ó�� ifnull : ��� ���̵� �����ͼ� �������� �ְ� �����ؼ� ���� �ٹ� ���̵��� ���� ������ ���� ����
			 * */
			String sql ="SELECT name,\n" +	//�ٹ� �̸� ��������
						"		CASE\n" +   //sql�� if�������� 
						"			WHEN title = '' or title is null THEN\n"+ //title�÷� ���� ����ְų� null�̶�� 
						"				'no title'\n"+						  //'no title'�̶�� ������ ���ڿ��� ��������
						"			ELSE\n"+								  //�ƴϸ� title�÷� ���� �����Ѵٴ� ���̹Ƿ�
						"				title\n"+							  //�� ���� �����´�
						"		END as title, singer,\n"+ 					  //END: CASE ����, as title�� �ȴ޾��ָ� ���� CASE���� �÷������� ��µȴ�, ������ �������� 
						"		IFNULL((select sum(price) from song where song.album_id = album.id), 0) as price, now, sign,\n"+
								//IFNULL(a, b)�� a�� null�̶�� b�� ���� ��ü���ش�.
								//song���̺���album_id�÷� ���� album���̺���id�÷� ���� ���� song���̺� ����� price ��, �߸���, �̹��� ���� ��� �������ְ�   
						"		IFNULL((select song from song where song.album_id = album.id and song.name = album.title), 'no audio file') as song\n"+ 
								//song���̺���album_id�÷� ���� album���̺���id�÷� ���� ������ album���̺��� title�÷��� song���̺��� name�÷��� ���� song���̺��� song�÷��� �����´� 
						"FROM album WHERE singer_id = '"+ singer_id +"'\n"; 
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
	
	public List<MySongVO> getMySongList(String se_member_id){
		List<MySongVO> mySongList = new ArrayList<>();
		try {
			try {
				connDB();
			}catch (Exception e) {
				e.printStackTrace();
			}
		
			String sql =  "SELECT A.id as album_id, \r\n"
						+ "	  	  A.name as album_name, \r\n"
						+ "       A.sign as album_sign, \r\n"
						+ "       A.singer, \r\n"
						+ "       S.id as song_id, \r\n"
						+ "       S.name as song_name, \r\n"
						+ "       S.song as song_audio \r\n"
						+ "FROM album A JOIN song S ON A.id = S.album_id \r\n"
						+ "WHERE S.id IN (SELECT song_id FROM payment WHERE member_id = ? AND status = 'done');";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, se_member_id);
			System.out.println(pstmt);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int album_id = rs.getInt("album_id");
				String album_name = rs.getString("album_name");
				String album_sign = rs.getString("album_sign");
				String singer = rs.getString("singer");
				int song_id = rs.getInt("song_id");
				String song_name = rs.getString("song_name");
				String song_audio = rs.getString("song_audio");
				
				MySongVO mySongVO = new MySongVO();
				
				mySongVO.setAlbum_id(album_id);
				mySongVO.setAlbum_name(album_name);
				mySongVO.setAlbum_sign(album_sign);
				mySongVO.setSinger(singer);
				mySongVO.setSong_id(song_id);
				mySongVO.setSong_name(song_name);
				mySongVO.setSong_audio(song_audio);
				
				mySongList.add(mySongVO);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(mySongList.size() == 0) {
			System.out.println("No Result");
			return null;
		}
		return mySongList;
		
	}
	
	public void addMusic(MusicVO m){
		
		try {
			
			try {
				connDB();
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			String album_name = m.getAlbum(); //�ٹ���
			boolean isTitle = m.getisTitle(); //Ÿ��Ʋ�� ����
			String song_name = m.getTitle(); //Ÿ��Ʋ���
			String singer_name = m.getSinger(); //����
			String singer_id = m.getSinger_id();
			Date now = m.getNow(); // �߸���
			int price = m.getPrice(); //���� ����
			String sign = m.getSign(); //�ٹ� �̹��� ���
			String song = m.getSong(); //���� ���
			
			String sql = "call insert_song(?, ?, ?, ?, ?, ?, ?, ?, ?);";	
			PreparedStatement pstmt = conn.prepareStatement(sql);
			/*
			in album_name varchar(60), 
			in singer_name varchar(60), 
			in singer_id varchar(60),
			in now date, 
			in sign varchar(60), 
			in song_name varchar(60), 
			in price int, 
			in song varchar(60), 
			in isTitle boolean
			*/
			pstmt.setString(1, album_name);
			pstmt.setString(2, singer_name);
			pstmt.setString(3, singer_id);
			pstmt.setDate(4, now);
			pstmt.setString(5, sign);
			pstmt.setString(6, song_name);
			pstmt.setInt(7, price);
			pstmt.setString(8, song);
			pstmt.setBoolean(9, isTitle);
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
