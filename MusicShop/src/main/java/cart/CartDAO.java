package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.util.ArrayList;
import java.util.HashMap;

public class CartDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private DataSource dataFactory;
	
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
	
	public Map<String,Object> addToCart(String member_id, int song_id) {	//성공 여부 리턴
		
		Map<String,Object> result = new HashMap<>(){
			{
				put("status", false);
				put("msg", "Unknown Error");
			}
		};
		try {
			try {
				connDB();	
			} catch (Exception e) {
				result.put("msg", "DB Connect Failed");
				e.printStackTrace();
			}
			String sql = 
					  "insert into storage(member_id, album_id, album_sign, singer, song_id, song_name, price, song_audio) \r\n"
					+ "		select\r\n"
					+ "		   (select id from member where id = ?), \r\n"	//member id
					+ "        A.id, \r\n"
					+ "        A.sign, \r\n"
					+ "        A.singer, \r\n"
					+ "        S.id, \r\n"
					+ "        S.name, \r\n"
					+ "        S.price, \r\n"
					+ "        S.song \r\n"
					+ "		from song S join album A on S.album_id = A.id \r\n"
					+ "		where S.id = ? and not exists (select * from storage where member_id = ? and song_id = ?);"; //장바구니 테이블 중복 허용 X
			PreparedStatement pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1,member_id);
			pstmt.setInt(2,song_id);
			pstmt.setString(3,member_id);
			pstmt.setInt(4,song_id);
			System.out.println(pstmt);
			int rows = pstmt.executeUpdate(); //executeUpdate메서드는 변경된 행의 개수를 리턴해준다.
			if(rows > 0) { 					  //즉, rows가 0보다 크지 않다는 것은 모종의 이유로 위 SQL문이 정상적으로 작동하지 않았음을 뜻한다.
				result.put("status", true);
				result.put("msg", "Insert Query Successed");
			} else {
				result.put("msg", "Insert Query Failed(This Song is already exist in Storage Table or Unknown Error)");
			}
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			result.put("msg", "Insert Query Failed(SQLError)");
			e.printStackTrace();
		}
		return result;
	}

	public List<CartVO> getCartItems(String req_member_id) { //request의 member_id
		List<CartVO> cartItemList = new ArrayList<CartVO>();
		try {
			try {
				connDB();	
			} catch (Exception e) {
				//result.put("msg", "DB Connect Failed");
				e.printStackTrace();
			}
			String sql = "SELECT * FROM storage WHERE member_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, req_member_id);
			ResultSet cart_items = pstmt.executeQuery(); //executeUpdate메서드는 변경된 행의 개수를 리턴해준다.
			while(cart_items.next()) {
				int id = cart_items.getInt("id");
				String member_id = cart_items.getString("member_id"); //storage테이블의 member_id컬럼
				int album_id = cart_items.getInt("album_id");
				String album_sign = cart_items.getString("album_sign");
				String singer = cart_items.getString("singer");
				int song_id = cart_items.getInt("song_id");
				String song_name = cart_items.getString("song_name");
				int price = cart_items.getInt("price");
				String song_audio = cart_items.getString("song_audio");
				
				CartVO cartVO = new CartVO();
				
				cartVO.setId(id);
				cartVO.setMember_id(member_id);
				cartVO.setAlbum_id(album_id);
				cartVO.setAlbum_sign(album_sign);
				cartVO.setSinger(singer);
				cartVO.setSong_id(song_id);
				cartVO.setSong_name(song_name);
				cartVO.setPrice(price);
				cartVO.setSong_audio(song_audio);
				
				cartItemList.add(cartVO);
			}
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			//result.put("msg", "Insert Query Failed(SQLError)");
			e.printStackTrace();
		}
		
		return cartItemList;
	}
}
