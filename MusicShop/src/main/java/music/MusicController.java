package music;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
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
    
    protected void service (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    	response.setContentType("text/html; charset=UTF-8");
    	String nextPage = null;
    	String action = request.getPathInfo();
    	HttpSession session = request.getSession();
    	String name = (String)session.getAttribute("name");
    	//String id = (String)session.getAttribute("id");
    	
    	System.out.println(action);
    	
    	if(action.equals("/listMusic.do")) {
    		List<MusicVO> MusicList = musicDAO.listMusic(name);
    		request.setAttribute("MusicList", MusicList);
    		request.setAttribute("isFirstEntry", false);
    		System.out.println(response.isCommitted());
    		System.out.println(MusicList);

    		nextPage = "/artist/artist.jsp";
    		System.out.println(nextPage);
    		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
    		
    		dispatch.forward(request, response);
    		return;
    	} else {
    		doHandle(request,response);
    		return;
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

	private static boolean isNumeric(String str){
        return str != null && str.matches("[0-9.]+");
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
			//File currentDirPath_I = new File("C:\\Users\\yach3\\Desktop\\최종프로젝트\\Music_Shop-main\\MusicShop\\MusicShop\\src\\main\\webapp\\resource\\img");
			//File currentDirPath_M = new File("C:\\Users\\yach3\\Desktop\\최종프로젝트\\Music_Shop-main\\MusicShop\\MusicShop\\src\\main\\webapp\\resource\\audio");
			File currentDirPath_I = new File("C:\\Users\\yach3\\Desktop\\최종프로젝트\\Music_Shop-main\\MusicShop\\MusicShop\\src\\main\\webapp\\resource\\img");
			File currentDirPath_M = new File("C:\\Users\\yach3\\Desktop\\최종프로젝트\\Music_Shop-main\\MusicShop\\MusicShop\\src\\main\\webapp\\resource\\audio");
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			factory.setRepository(currentDirPath_I);
			factory.setSizeThreshold(1024 * 1024);
			
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<FileItem> items = upload.parseRequest(request);
				System.out.println(items.size());
				String[] param = new String[items.size()];
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
							param[param.length-2] = fileName;
						} 

							else if(item.getContentType().startsWith("audio/")) {
							uploadedMusicFile = new File(currentDirPath_M, fileName);
							item.write(uploadedMusicFile);
							param[param.length-1] = fileName;
						}
						
					}
				}		
				String album = param[0];
				boolean isTitle;
				String title;
				String singer;
				Date now;
				int price;
				String sign;
				String song;
				
				if(param[1].equals("isTitle")) {
					isTitle = Boolean.parseBoolean(param[2]);
					title = param[3];
					singer = param[4];
					now = Date.valueOf(param[5]);
					price = (isNumeric(param[6])) ? Integer.parseInt(param[6]) : 0;
					sign = param[7];
					song = param[8];
				} else {
					isTitle = Boolean.parseBoolean(param[1]);
					title = param[2];
					singer = param[3];
					now = Date.valueOf(param[4]);
					price = (isNumeric(param[5])) ? Integer.parseInt(param[5]) : 0;
					sign = param[6];
					song = param[7];
				}
				System.out.println(
						"album: "+album+"\n"+
						"isTitle: "+isTitle+"\n"+
						"title: "+title+"\n"+
						"singer: "+singer+"\n"+
						"now: "+now+"\n"+
						"price: "+price+"\n"+
						"sign: "+sign+"\n"+
						"song: "+song);
				AlbumVO albumVO = new AlbumVO();
				albumVO.setName(album);
				albumVO.setTitle(title);
				MusicVO musicVO = new MusicVO(
						album,
						isTitle,
						title, 
						singer, 
						now, 
						sign, 
						price, 
						song);
				musicDAO.addMusic(musicVO);
			}catch (Exception e) {
				e.printStackTrace();
			}
    		nextPage = "/Music/listMusic.do";
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
    		
    		dispatch.forward(request, response);
		} else if (action.equals("/showMySongList.do")) {
			String se_member_id = "";
			if(session != null) {
				se_member_id = (String) session.getAttribute("id");
			}
			List<MySongVO> mySongList = musicDAO.getMySongList(se_member_id);
    		request.setAttribute("mySongList", mySongList);
    		request.setAttribute("isFirstEntry", false);
			nextPage = "/my_song.jsp";
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
			return;
		}
		
	}

}
