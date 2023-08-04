package music;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class MusicController
 */
@WebServlet("/Music/*")
public class MusicController extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
	MusicDAO musicDAO;
	
    public void init() throws ServletException {
    	musicDAO = new MusicDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	response.setContentType("text/html; charset=UTF-8");
    	String nextPage = null;
    	String action = request.getPathInfo();
    	HttpSession session = request.getSession();
    	//String id = (String)session.getAttribute("id");
    	
    	System.out.println(action);
    	
    	if(action.equals("/listMusic.do")) {
    		//List<MusicVO> MusicList = MusicDAO.listMusic(); 진행 중
    		
    	}
    	
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doHandle(request, response);
	}

	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nextPage = null;
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		String encoding = "UTF-8";
		String action = request.getPathInfo();
		HttpSession session = request.getSession();
		if(action.equals("/addMusic.do")) {
			File currentDirPath_I = new File("C:\\Users\\yach3\\Desktop\\최종프로젝트\\Music_Shop-main\\MusicShop\\MusicShop\\src\\main\\webapp\\resource\\img");
			File currentDirPath_M = new File("C:\\Users\\yach3\\Desktop\\최종프로젝트\\Music_Shop-main\\MusicShop\\MusicShop\\src\\main\\webapp\\resource\\audio");
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			factory.setRepository(currentDirPath_I);
			factory.setSizeThreshold(1024 * 1024);
			
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<FileItem> items = upload.parseRequest(request);
				String[] param = new String[7];
				File uploadedImgFile = null;
				File uploadedMusicFile = null;
				
				for(FileItem item : items) {
					if(item.isFormField()) {
						for(int i = 0 ; i < param.length ; i++) {
							if(param[i] == null) {
								param[i] = item.getString(encoding);
								break;
							}
						}
					} else {
						String fileName = item.getName();
						int idx = fileName.lastIndexOf("\\");
						if(idx == -1) {
							idx = fileName.lastIndexOf("/");
						}
						fileName = fileName.substring(idx + 1);
						
						if(item.getContentType().startsWith("image/")) {
							uploadedImgFile = new File(currentDirPath_I, fileName);
							item.write(uploadedImgFile);
							param[5] = fileName;
						} else if(item.getContentType().startsWith("audio/")) {
							uploadedMusicFile = new File(currentDirPath_M, fileName);
							item.write(uploadedMusicFile);
							param[6] = fileName;
						}
					}
				}
				int id = 0;				
				String album = param[0];
				String title = param[1];
				String singer = param[2];
				String now = param[3];
				String price = param[4];
				String sign = param[5];
				String song = param[6];
				
				MusicVO musicVO = new MusicVO(id, album, title, singer, now, price, sign, song);
				musicDAO.addMusic(musicVO);
			}catch (Exception e) {
				e.printStackTrace();
			}
			nextPage = "/Music/listMusic.do";
		}
		
	}

}
