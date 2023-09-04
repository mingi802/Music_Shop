package cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.json.simple.JSONObject;

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
					+ "		where S.id = ? and not exists (select * from storage where member_id = ? and song_id = ?) \r\n" //장바구니 테이블 중복 허용 X
					+ "                    and not exists (select * from payment where member_id = ? and song_id = ? and status = 'DONE');"; //구매 기록 있을 시 안담겨야함
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1,member_id);
			pstmt.setInt(2,song_id);
			pstmt.setString(3,member_id);
			pstmt.setInt(4,song_id);
			pstmt.setString(5,member_id);
			pstmt.setInt(6,song_id);
			System.out.println(pstmt);
			int rows = pstmt.executeUpdate(); //executeUpdate메서드는 변경된 행의 개수를 리턴해준다.
			if(rows > 0) { 					  //즉, rows가 0보다 크지 않다는 것은 모종의 이유로 위 SQL문이 정상적으로 작동하지 않았음을 뜻한다.
				result.put("status", true);
				result.put("msg", "Insert Query Successed");
			} else {
				result.put("msg", "Insert Query Failed(This Song is already exist in Storage Table or Payment Table)");
			}
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			result.put("msg", "Insert Query Failed(SQLError)");
			e.printStackTrace();
		}
		return result;
	}
	
public Map<String,Object> addAllSongInAlbumToCart(String member_id, String song_ids) {	//성공 여부 리턴
		
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
					+ "		where S.id in ("+song_ids+") "
					+ "			and S.id not in (select song_id from storage where member_id = ? and song_id in ("+song_ids+"))" //장바구니 테이블 중복 허용 X
					+ "     	and S.id not in (select song_id from payment where member_id = ? and song_id in ("+song_ids+") and status = 'DONE');"; //구매 기록 있을 시 안담겨야댐
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1,member_id);
			pstmt.setString(2,member_id);
			pstmt.setString(3,member_id);
			System.out.println(pstmt);
			int rows = pstmt.executeUpdate(); //executeUpdate메서드는 변경된 행의 개수를 리턴해준다.
			if(rows > 0) { 					  //즉, rows가 0보다 크지 않다는 것은 모종의 이유로 위 SQL문이 정상적으로 작동하지 않았음을 뜻한다.
				result.put("status", true);
				result.put("msg", "Insert Multiple Rows Successed");
			} else {
				result.put("msg", "Insert Multiple Rows Failed(This Song is already exist in Storage Table or Payment Table)");
			}
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			result.put("msg", "Insert Query Failed(SQLError)");
			e.printStackTrace();
		}
		return result;
	}

	public Map<String, Object> delCartItem(String member_id, List<Integer> song_id_list) {	//성공 여부 리턴
		
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
			String sql = "delete from storage WHERE song_id in (";
			for(int i = 0; i < song_id_list.size(); i++) {
				if (i < song_id_list.size()-1) {
					sql += song_id_list.get(i)+",";
				} else {
					sql += song_id_list.get(i)+") and member_id = '"+member_id+"'";
				}
			}
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);	
			
			System.out.println(pstmt);
			
			int rows = pstmt.executeUpdate(); //executeUpdate메서드는 변경된 행의 개수를 리턴해준다.
			if(rows > 0) { 					  //즉, rows가 0보다 크지 않다는 것은 모종의 이유로 위 SQL문이 정상적으로 작동하지 않았음을 뜻한다.
				result.put("status", true);
				result.put("msg", "Delete Query Successed");
			} else {
				result.put("msg", "Delete Query Failed(This Song is not exist in "+member_id+"'s Storage Table or Unknown Error)");
			}
			
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			result.put("msg", "Delete Query Failed(SQLError)");
			e.printStackTrace();
		}
		return result;
		
	}
	
public Map<String, Object> delCartItem(String member_id, String song_ids) {	//성공 여부 리턴
		
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
			String sql = "delete from storage WHERE song_id in ("+song_ids+") and member_id = ?;";
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1, member_id);
			System.out.println(pstmt);
			
			int rows = pstmt.executeUpdate(); //executeUpdate메서드는 변경된 행의 개수를 리턴해준다.
			if(rows > 0) { 					  //즉, rows가 0보다 크지 않다는 것은 모종의 이유로 위 SQL문이 정상적으로 작동하지 않았음을 뜻한다.
				result.put("status", true);
				result.put("msg", "Delete Query Successed");
			} else {
				result.put("msg", "Delete Query Failed(This Song is not exist in "+member_id+"'s Storage Table or Unknown Error)");
			}
			
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			result.put("msg", "Delete Query Failed(SQLError)");
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
			pstmt = conn.prepareStatement(sql);			
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
	
	public int getTotalAmount(String se_member_id, String CartItemIds) { //request의 member_id
		int price = 0;
		try {
			try {
				connDB();	
			} catch (Exception e) {
				//result.put("msg", "DB Connect Failed");
				e.printStackTrace();
			}
			String sql = "SELECT ifnull(sum(price), 0) as price FROM storage WHERE member_id = '"+se_member_id+"' and song_id in ("+CartItemIds+")";
			Statement stmt = conn.createStatement();			
			ResultSet cart_items = stmt.executeQuery(sql);
			if(cart_items.next()) {
				price = cart_items.getInt("price");
			}
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return price;
	}
	
//https://docs.tosspayments.com/reference#v1paymentspaymentkeyget-paymentkey
public Map<String,Object> insertPaymentData(JSONObject payment_data, String member_id, int song_id) {	//성공 여부 리턴
		
		Map<String,Object> result = new HashMap<>(){
			{
				put(song_id+"-status", false);
				put(song_id+"-msg", "Unknown Error");
			}
		};
		try {
			try {
				connDB();	
			} catch (Exception e) {
				result.put(song_id+"-msg", "DB Connect Failed");
				e.printStackTrace();
			}
			String sql = "INSERT INTO payment"	//고객의 결제 정보 저장
							+ "(order_id, "			//주문 아이디 String
							+ "payment_key, "		//결제 키: 결제 승인, 조회, 취소 api에 사용 String
							+ "member_id, "			//구매자의 아이디 String
							+ "album_id, "			//구매한 곡의 앨범 아이디 int
							+ "song_id, "			//구매한 곡의 아이디 int
							+ "song_price, "		//구매한 곡의 원가 int
							+ "total_amount, "		//총 결제 금액 int (한 번에 여러 개의 곡을 구매한 경우 song_amount보다 큰 값을 가질 수 있음. 추후에 쿠폰 등으로 할인받아 구매한 경우 원가와 비교해보는등 쓸 곳이 없지는 않아보여 저장하기로 결정)
							+ "payment_method, "	//결제수단: 카드, 가상계좌, 간편결제, 휴대폰, 계좌이체, 문화상품권, 도서문화상품권, 게임문화상품권 중 하나 String
							+ "status) "			//결제 처리 상태. 자세한 내용은 208줄의 주소로 String
						+"VALUES("
							+ "?,"	// 1
							+ "?,"	// 2
							+ "?,"	// 3
							+ "(SELECT album_id FROM song WHERE id = ?),"// 4
							+ "?,"	// 5
							+ "(SELECT price FROM song WHERE id = ?),"	// 6
							+ "?,"	// 7
							+ "?,"	// 8
							+ "?"	// 9
							+ ")"; 
					  
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1, payment_data.get("orderId").toString());
			pstmt.setString(2, payment_data.get("paymentKey").toString());
			pstmt.setString(3, member_id);
			pstmt.setInt(4, song_id);	
			pstmt.setInt(5, song_id);	
			pstmt.setInt(6, song_id);	
			pstmt.setInt(7, Integer.parseInt(payment_data.get("totalAmount").toString()));
			pstmt.setString(8, payment_data.get("method").toString());
			pstmt.setString(9, payment_data.get("status").toString());
			System.out.println(pstmt);
			int rows = pstmt.executeUpdate(); //executeUpdate메서드는 변경된 행의 개수를 리턴해준다.
			if(rows > 0) { 					  //즉, rows가 0보다 크지 않다는 것은 모종의 이유로 위 SQL문이 정상적으로 작동하지 않았음을 뜻한다.
				result.put(song_id+"-status", true);
				result.put(song_id+"-msg", "Insert Query Successed");
			} else {
				result.put(song_id+"-msg", "Insert Query Failed(This PaymentData is already exist in payment Table or Unknown Error)");
			}
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			result.put(song_id+"-msg", "Insert Query Failed(SQLError)");
			e.printStackTrace();
		}
		return result;
	}
}
