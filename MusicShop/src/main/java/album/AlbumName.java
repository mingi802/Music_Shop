package album;

public class AlbumName {
	private static final String[] HANGUL_CHOSUNG = 
		{"¤¡", "¤¢", "¤¤", "¤§", "¤¨", "¤©", "¤±", "¤²", "¤³", 
		"¤µ", "¤¶", "¤·", "¤¸", "¤¹", "¤º", "¤»", "¤¼", "¤½", "¤¾"};
	
	/**
	 * @return the hangulChosung
	 */
	public static String[] getHangulChosung() {
		return HANGUL_CHOSUNG;
	}

	public String getClassNameByAlbumName(String albumName) {
		char firstChar = albumName.charAt(0);	//¾Ù¹ü ÀÌ¸§ Ã¹ ±ÛÀÚ
		String firstCharToStr = String.valueOf(firstChar); //.matches()ÇÔ¼ö »ç¿ëÇÏ±â À§ÇØ  StringÀ¸·Î ¼±¾ğ
		String className = ""; 
		
		if(firstCharToStr.matches(".*[°¡-ÆR]+.*")) {	
			//¾Ù¹ü ÀÌ¸§ Ã¹ ±ÛÀÚ°¡ ÇÑ±ÛÀÌ¸ç ÀÚÀ½+¸ğÀ½ÀÎ °æ¿ì
			char cho = (char)((firstChar-0xAC00)/28/21);
			//À¯´ÏÄÚµå¸¦ È°¿ëÇØ ÃÊ¼º(ÀÚÀ½)À» ºĞ¸®ÇØ¿Â´Ù.
			System.out.println(firstChar+ " => " + HANGUL_CHOSUNG[cho]);
			
			className = HANGUL_CHOSUNG[cho];
		}
		
		else if(firstCharToStr.matches(".*[¤¿-¤Ó]+.*")) {
			//¾Ù¹ü ÀÌ¸§ Ã¹ ±ÛÀÚ°¡ ¸ğÀ½¸¸ ÀÖ´Â ÇÑ±ÛÀÎ °æ¿ì << ÇÊÈ÷ ¿ÀÅ¸¿©¾ß¸¸ ÇÒ °Í
			className = "ERROR";
		}
		
		else if(firstCharToStr.matches(".*[A-Z]+.*")){
			//A~Z´Â ÇÊÅÍ¸µÀÌ ¸ÔÈ÷Áö ¾ÊÀ½ -> ´ë¹®ÀÚ ÇÊÅÍ¸µ ÈÄ ¼Ò¹®ÀÚ·Î º¯Çü
			className = firstCharToStr.toLowerCase();
		} else {
			//¼Ò¹®ÀÚ·Î¸¸ ±¸¼ºµÈ ¿µ¾î ¶Ç´Â ÀÚÀ½À¸·Î¸¸ ±¸¼ºµÈ ÇÑ±Û
			className = firstCharToStr;
		}
		return className;
	}
}
