package music;

public class MusicVO {

	private int id;
	private String album;
	private String title;
	private String singer;
	private String now;
	private String price;
	private String sign;
	private String song;
	
	public MusicVO(int id, String album, String title, String singer, String now, String price, String sign, String song) {
		super();
		this.id = id;
		this.album = album;
		this.title = title;
		this.singer = singer;
		this.now = now;
		this.price = price;
		this.sign = sign;
		this.song = song;
	}
	public MusicVO(String album, String title, String singer, String now, String price, String sign, String song) {
		super();
		this.album = album;
		this.title = title;
		this.singer = singer;
		this.now = now;
		this.price = price;
		this.sign = sign;
		this.song = song;
		
	}
	
	public int getId() { return id;}
	public void setId(int id) { this.id = id; }
	
	public String getTitle() { return title; }
	public void setTitle(String title) { this.title = title; }
	
	public String getSinger() { return singer; }
	public void setSinger(String singer) { this.singer = singer; }
	
	public String getNow() { return now; }
	public void setNow(String now) { this.now = now; }
	
	public String getPrice() { return price; }
	public void setPrice(String price) { this.price = price; }
	
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

