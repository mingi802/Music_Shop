package album;

import java.sql.Date;

public class AlbumVO {
	
	private int id;
	private String album;
	private String title;
	private String singer;
	private Date now;
	private int price;
	private String sign;
	private String song;
	private String name;
	
	public AlbumVO() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}

	/**
	 * @return the album
	 */
	public String getAlbum() {
		return album;
	}

	/**
	 * @param album the album to set
	 */
	public void setAlbum(String album) {
		this.album = album;
	}

	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @return the singer
	 */
	public String getSinger() {
		return singer;
	}

	/**
	 * @param singer the singer to set
	 */
	public void setSinger(String singer) {
		this.singer = singer;
	}

	/**
	 * @return the now
	 */
	public Date getNow() {
		return now;
	}

	/**
	 * @param now the now to set
	 */
	public void setNow(Date now) {
		this.now = now;
	}

	/**
	 * @return the price
	 */
	public int getPrice() {
		return price;
	}

	/**
	 * @param price the price to set
	 */
	public void setPrice(int price) {
		this.price = price;
	}

	/**
	 * @return the sign
	 */
	public String getSign() {
		return sign;
	}

	/**
	 * @param sign the sign to set
	 */
	public void setSign(String sign) {
		this.sign = sign;
	}

	/**
	 * @return the song
	 */
	public String getSong() {
		return song;
	}

	/**
	 * @param song the song to set
	 */
	public void setSong(String song) {
		this.song = song;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}
