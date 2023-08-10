package music;

import java.sql.Date;

public class MusicVO {	//이제 이 클래스는 db의 스토어드 프로시저에 넣을 매개 변수들을 저장하는 용도.
	
	private String album;
	private boolean isTitle;
	private String title;
	private String singer;
	private Date now;
	private int price;
	private String sign;
	private String song;
	
	
	
	public MusicVO(String album, Boolean isTitle, String title, String singer, Date now, String sign, int price, String song) {
		super();
		this.album = album;
		this.isTitle = isTitle;
		this.title = title;
		this.singer = singer;
		this.now = now;
		this.price = price;
		this.sign = sign;
		this.song = song;
	}
	
	public MusicVO(String album, String title, String singer, Date now, String sign) {
		super();
		this.album = album;
		this.title = title;
		this.singer = singer;
		this.now = now;
		this.sign = sign;
		
	}
	
	public boolean getisTitle() { return isTitle; }
	public void setisTitle(boolean isTitle) { this.isTitle = isTitle; }
	
	public String getTitle() { return title; }
	public void setTitle(String title) { this.title = title; }
	
	public String getSinger() { return singer; }
	public void setSinger(String singer) { this.singer = singer; }
	
	public Date getNow() { return now; }
	public void setNow(Date now) { this.now = now; }
	
	public int getPrice() { return price; }
	public void setPrice(int price) { this.price = price; }
	
	public String getSign() { return sign; }
	public void setSign(String sign) { this.sign = sign; }
	
	public String getSong() { return song; }
	public void setSong(String song) { this.song = song; }

	public String getAlbum() {
		return album;
	}

	public void setAlbum(String album) {
		this.album = album;
	}
	
}

