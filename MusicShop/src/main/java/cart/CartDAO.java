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
			System.out.println("DB ���� ����");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public Map<String,Object> addToCart(String member_id, int song_id) {	//���� ���� ����
		
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
					+ "		where S.id = ? and not exists (select * from storage where member_id = ? and song_id = ?) \r\n" //��ٱ��� ���̺� �ߺ� ��� X
					+ "                    and not exists (select * from payment where member_id = ? and song_id = ? and status = 'DONE');"; //���� ��� ���� �� �ȴ�ܾ���
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1,member_id);
			pstmt.setInt(2,song_id);
			pstmt.setString(3,member_id);
			pstmt.setInt(4,song_id);
			pstmt.setString(5,member_id);
			pstmt.setInt(6,song_id);
			System.out.println(pstmt);
			int rows = pstmt.executeUpdate(); //executeUpdate�޼���� ����� ���� ������ �������ش�.
			if(rows > 0) { 					  //��, rows�� 0���� ũ�� �ʴٴ� ���� ������ ������ �� SQL���� ���������� �۵����� �ʾ����� ���Ѵ�.
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
	
public Map<String,Object> addAllSongInAlbumToCart(String member_id, String song_ids) {	//���� ���� ����
		
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
					+ "			and S.id not in (select song_id from storage where member_id = ? and song_id in ("+song_ids+"))" //��ٱ��� ���̺� �ߺ� ��� X
					+ "     	and S.id not in (select song_id from payment where member_id = ? and song_id in ("+song_ids+") and status = 'DONE');"; //���� ��� ���� �� �ȴ�ܾߴ�
			pstmt = conn.prepareStatement(sql);	
			pstmt.setString(1,member_id);
			pstmt.setString(2,member_id);
			pstmt.setString(3,member_id);
			System.out.println(pstmt);
			int rows = pstmt.executeUpdate(); //executeUpdate�޼���� ����� ���� ������ �������ش�.
			if(rows > 0) { 					  //��, rows�� 0���� ũ�� �ʴٴ� ���� ������ ������ �� SQL���� ���������� �۵����� �ʾ����� ���Ѵ�.
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

	public Map<String, Object> delCartItem(String member_id, List<Integer> song_id_list) {	//���� ���� ����
		
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
			
			int rows = pstmt.executeUpdate(); //executeUpdate�޼���� ����� ���� ������ �������ش�.
			if(rows > 0) { 					  //��, rows�� 0���� ũ�� �ʴٴ� ���� ������ ������ �� SQL���� ���������� �۵����� �ʾ����� ���Ѵ�.
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
	
public Map<String, Object> delCartItem(String member_id, String song_ids) {	//���� ���� ����
		
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
			
			int rows = pstmt.executeUpdate(); //executeUpdate�޼���� ����� ���� ������ �������ش�.
			if(rows > 0) { 					  //��, rows�� 0���� ũ�� �ʴٴ� ���� ������ ������ �� SQL���� ���������� �۵����� �ʾ����� ���Ѵ�.
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
	
	
	public List<CartVO> getCartItems(String req_member_id) { //request�� member_id
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
			ResultSet cart_items = pstmt.executeQuery(); //executeUpdate�޼���� ����� ���� ������ �������ش�.
			while(cart_items.next()) {
				int id = cart_items.getInt("id");
				String member_id = cart_items.getString("member_id"); //storage���̺��� member_id�÷�
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
	
	public int getTotalAmount(String se_member_id, String CartItemIds) { //request�� member_id
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
public Map<String,Object> insertPaymentData(JSONObject payment_data, String member_id, int song_id) {	//���� ���� ����
		
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
			String sql = "INSERT INTO payment"	//���� ���� ���� ����
							+ "(order_id, "			//�ֹ� ���̵� String
							+ "payment_key, "		//���� Ű: ���� ����, ��ȸ, ��� api�� ��� String
							+ "member_id, "			//�������� ���̵� String
							+ "album_id, "			//������ ���� �ٹ� ���̵� int
							+ "song_id, "			//������ ���� ���̵� int
							+ "song_price, "		//������ ���� ���� int
							+ "total_amount, "		//�� ���� �ݾ� int (�� ���� ���� ���� ���� ������ ��� song_amount���� ū ���� ���� �� ����. ���Ŀ� ���� ������ ���ι޾� ������ ��� ������ ���غ��µ� �� ���� ������ �ʾƺ��� �����ϱ�� ����)
							+ "payment_method, "	//��������: ī��, �������, �������, �޴���, ������ü, ��ȭ��ǰ��, ������ȭ��ǰ��, ���ӹ�ȭ��ǰ�� �� �ϳ� String
							+ "status) "			//���� ó�� ����. �ڼ��� ������ 208���� �ּҷ� String
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
			int rows = pstmt.executeUpdate(); //executeUpdate�޼���� ����� ���� ������ �������ش�.
			if(rows > 0) { 					  //��, rows�� 0���� ũ�� �ʴٴ� ���� ������ ������ �� SQL���� ���������� �۵����� �ʾ����� ���Ѵ�.
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
