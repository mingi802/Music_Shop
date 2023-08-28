package album;

public class AlbumName {
	private static final String[] HANGUL_CHOSUNG = 
		{"��", "��", "��", "��", "��", "��", "��", "��", "��", 
		"��", "��", "��", "��", "��", "��", "��", "��", "��", "��"};
	
	/**
	 * @return the hangulChosung
	 */
	public static String[] getHangulChosung() {
		return HANGUL_CHOSUNG;
	}

	public String getClassNameByAlbumName(String albumName) {
		char firstChar = albumName.charAt(0);	//�ٹ� �̸� ù ����
		String firstCharToStr = String.valueOf(firstChar); //.matches()�Լ� ����ϱ� ����  String���� ����
		String className = ""; 
		
		if(firstCharToStr.matches(".*[��-�R]+.*")) {	
			//�ٹ� �̸� ù ���ڰ� �ѱ��̸� ����+������ ���
			char cho = (char)((firstChar-0xAC00)/28/21);
			//�����ڵ带 Ȱ���� �ʼ�(����)�� �и��ؿ´�.
			System.out.println(firstChar+ " => " + HANGUL_CHOSUNG[cho]);
			
			className = HANGUL_CHOSUNG[cho];
		}
		
		else if(firstCharToStr.matches(".*[��-��]+.*")) {
			//�ٹ� �̸� ù ���ڰ� ������ �ִ� �ѱ��� ��� << ���� ��Ÿ���߸� �� ��
			className = "ERROR";
		}
		
		else if(firstCharToStr.matches(".*[A-Z]+.*")){
			//A~Z�� ���͸��� ������ ���� -> �빮�� ���͸� �� �ҹ��ڷ� ����
			className = firstCharToStr.toLowerCase();
		} else {
			//�ҹ��ڷθ� ������ ���� �Ǵ� �������θ� ������ �ѱ�
			className = firstCharToStr;
		}
		return className;
	}
}
