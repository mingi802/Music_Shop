package music;
import java.sql.Date;

public class AlbumVO {	//테스트용으로 만들어놓음
	private int id;
	private String name;
	private String title;
	private String singer;
	private Date now;
	private String sign;
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @return the singer
	 */
	public String getSinger() {
		return singer;
	}
	/**
	 * @return the now
	 */
	public Date getNow() {
		return now;
	}
	/**
	 * @return the sign
	 */
	public String getSign() {
		return sign;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @param singer the singer to set
	 */
	public void setSinger(String singer) {
		this.singer = singer;
	}
	/**
	 * @param now the now to set
	 */
	public void setNow(Date now) {
		this.now = now;
	}
	/**
	 * @param sign the sign to set
	 */
	public void setSign(String sign) {
		this.sign = sign;
	}
}
