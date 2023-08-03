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
			File currentDirPath_I = new File("C:\\Users\\yach3\\Desktop\\최종프로젝트\\Music_Shop-main\\MusicShop\\MusicShop\\src\\main\\webapp\\img\\bg-img");
			File currentDirPath_M = new File("C:\\Users\\yach3\\Desktop\\최종프로젝트\\Music_Shop-main\\MusicShop\\MusicShop\\src\\main\\webapp\\resource\\audio");
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			factory.setRepository(currentDirPath_I);
			factory.setSizeThreshold(1024 * 1024);
			
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<FileItem> items = upload.parseRequest(request);
				String[] param = new String[6];
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
							param[4] = fileName;
						} else if(item.getContentType().startsWith("audio/")) {
							uploadedMusicFile = new File(currentDirPath_M, fileName);
							item.write(uploadedMusicFile);
							param[5] = fileName;
						}
					}
				}
				int id = 0;				
				String title = param[0];
				String singer = param[1];
				String now = param[2];
				String price = param[3];
				String sign = param[4];
				String song = param[5];
			
				MusicVO musicVO = new MusicVO(id, title, singer, now, price, sign, song);
				musicDAO.addMusic(musicVO);
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
	}

}
