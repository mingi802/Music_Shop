package cart;
import java.sql.Timestamp;
public class paymentVO {
	private int id;
	private String order_id;
	private String payment_key;
	private String member_id;
	private int album_id;
	private int song_id;
	private int song_price;
	private int total_amount;
	private String payment_method;
	private String status;
	private Timestamp purchase_timestamp;
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @return the order_id
	 */
	public String getOrder_id() {
		return order_id;
	}
	/**
	 * @return the payment_key
	 */
	public String getPayment_key() {
		return payment_key;
	}
	/**
	 * @return the member_id
	 */
	public String getMember_id() {
		return member_id;
	}
	/**
	 * @return the album_id
	 */
	public int getAlbum_id() {
		return album_id;
	}
	/**
	 * @return the song_id
	 */
	public int getSong_id() {
		return song_id;
	}
	/**
	 * @return the song_price
	 */
	public int getSong_price() {
		return song_price;
	}
	/**
	 * @return the total_amount
	 */
	public int getTotal_amount() {
		return total_amount;
	}
	/**
	 * @return the payment_method
	 */
	public String getPayment_method() {
		return payment_method;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @return the purchase_timestamp
	 */
	public Timestamp getPurchase_timestamp() {
		return purchase_timestamp;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @param order_id the order_id to set
	 */
	public void setOrder_id(String order_id) {
		this.order_id = order_id;
	}
	/**
	 * @param payment_key the payment_key to set
	 */
	public void setPayment_key(String payment_key) {
		this.payment_key = payment_key;
	}
	/**
	 * @param member_id the member_id to set
	 */
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	/**
	 * @param album_id the album_id to set
	 */
	public void setAlbum_id(int album_id) {
		this.album_id = album_id;
	}
	/**
	 * @param song_id the song_id to set
	 */
	public void setSong_id(int song_id) {
		this.song_id = song_id;
	}
	/**
	 * @param song_price the song_price to set
	 */
	public void setSong_price(int song_price) {
		this.song_price = song_price;
	}
	/**
	 * @param total_amount the total_amount to set
	 */
	public void setTotal_amount(int total_amount) {
		this.total_amount = total_amount;
	}
	/**
	 * @param payment_method the payment_method to set
	 */
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @param purchase_timestamp the purchase_timestamp to set
	 */
	public void setPurchase_timestamp(Timestamp purchase_timestamp) {
		this.purchase_timestamp = purchase_timestamp;
	}
	
	
}
