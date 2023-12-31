package album;

public class AlbumName {
	private static final String[] HANGUL_CHOSUNG = 
		{"ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", 
		"ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"};
	
	/**
	 * @return the hangulChosung
	 */
	public static String[] getHangulChosung() {
		return HANGUL_CHOSUNG;
	}

	public String getClassNameByAlbumName(String albumName) {
		char firstChar = albumName.charAt(0);	//앨범 이름 첫 글자
		String firstCharToStr = String.valueOf(firstChar); //.matches()함수 사용하기 위해  String으로 선언
		String className = ""; 
		
		if(firstCharToStr.matches(".*[가-힣]+.*")) {	
			//앨범 이름 첫 글자가 한글이며 자음+모음인 경우
			char cho = (char)((firstChar-0xAC00)/28/21);
			//유니코드를 활용해 초성(자음)을 분리해온다.
			System.out.println(firstChar+ " => " + HANGUL_CHOSUNG[cho]);
			
			className = HANGUL_CHOSUNG[cho];
		}
		
		else if(firstCharToStr.matches(".*[ㅏ-ㅣ]+.*")) {
			//앨범 이름 첫 글자가 모음만 있는 한글인 경우 << 필히 오타여야만 할 것
			className = "ERROR";
		}
		
		else if(firstCharToStr.matches(".*[A-Z]+.*")){
			//A~Z는 필터링이 먹히지 않음 -> 대문자 필터링 후 소문자로 변형
			className = firstCharToStr.toLowerCase();
		} else {
			//소문자로만 구성된 영어 또는 자음으로만 구성된 한글
			className = firstCharToStr;
		}
		return className;
	}
}
