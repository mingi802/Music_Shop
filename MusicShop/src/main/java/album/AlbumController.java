package album;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class AlbumController
 */
@WebServlet("/Album/*")
public class AlbumController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */

	AlbumDAO albumDAO;
	
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		 albumDAO = new AlbumDAO();
	}
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		String nextpage = null;
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String albumName = request.getParameter("searchBar");
		//PrintWriter writer = response.getWriter();
		//String encoding = "UTF-8";
		String path = request.getPathInfo();
		String action = path.substring(path.lastIndexOf("/"));
		System.out.println(action);
		HttpSession session = request.getSession(false);
		nextpage = path.substring(path.indexOf("/"), path.lastIndexOf("/"))+".jsp"; 
		/*
		 * path.indexOf("/")에서 /main/showAllAlbum.do까지 인거에요?
		 * Album /main/showAllAlbum.do
		 * 01234 5
		 * path.lastIndexOf("/")에서는 /main/까지
		 * 사실은 '/main/' 까지인데 substring 때문에 '/main' 까지다.
		 * */		
		if(action.equals("/albumSearch.do")) {
			List<AlbumVO> albumList = albumDAO.searchAlbum(albumName);
			boolean isAll = (albumList.size() == albumDAO.searchAlbumRows());
			System.out.println(isAll);
			request.setAttribute("albumList", albumList);
			request.setAttribute("isAll", isAll);
			request.setAttribute("isSearch", true);
		}
		else if(action.equals("/showAllAlbum.do")) {
			List<AlbumVO> albumList = albumDAO.searchAllAlbum();
			request.setAttribute("albumList", albumList);
			request.setAttribute("isAll", true);
		} else if(action.equals("/showOneAlbum.do")) {
			int album_id = -1;
			if(request.getParameter("album_id") != null) {
				album_id = Integer.parseInt(request.getParameter("album_id"));
			}
			System.out.println("album_id : " + album_id);
			List<AlbumVO> songList = albumDAO.selectAlbum(album_id);
			request.setAttribute("songList", songList);
		}
		System.out.println(nextpage);
		request.getRequestDispatcher(nextpage).forward(request, response);
	}

}
