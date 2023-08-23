package cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.json.simple.JSONObject;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import album.AlbumDAO;
import album.AlbumVO;


/**
 * Servlet implementation class AlbumController
 */
@WebServlet("/Cart/*")
public class CartController extends HttpServlet {
    /**
     * @see HttpServlet#HttpServlet()
     */

	CartDAO cartDAO;
	
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		 cartDAO = new CartDAO();
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
		request.setCharacterEncoding("UTF-8");
		
		String path = request.getPathInfo();
		String action = path.substring(path.lastIndexOf("/"));
		System.out.println("path: "+path+"\naction: "+action);
		
		String nextpage = path.substring(path.indexOf("/"), path.lastIndexOf("/"))+".jsp"; 		
		
		if(action.equals("/addToCart.do")) {
			addToCart(request, response); //��ٱ��Ͽ� ��ǰ �߰��� ������ �̵��� �ʿ����
			return;
		}
		else if(action.equals("/goToCart.do")) {
			String member_id = null;
			if(request.getParameter("member_id") != null) {
				member_id = request.getParameter("member_id");
				List<CartVO> cartItemList = cartDAO.getCartItems(member_id);
				request.setAttribute("cartItemList", cartItemList);
			}
		} else if(action.equals("/showOneAlbum.do")) {
			
		}
		System.out.println(nextpage);
		request.getRequestDispatcher(nextpage).forward(request, response);
	}
	
	protected void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		Map<String,Object> result = new HashMap<>(){
			{
				put("status", false);
				put("msg", "default");
			}
		};
		
		int song_id = -1;
		String member_id = null;
		if(request.getParameter("song_id") != null && request.getParameter("member_id") != null) {
			try {
				song_id = Integer.parseInt(request.getParameter("song_id")); 
			} catch (NumberFormatException e) {
				result.put("status", false);
			    result.put("msg", "song_id is not a number");
			}
			member_id = request.getParameter("member_id");
		}
		System.out.println("���� ���� ��ȣ: "+song_id);
		System.out.println("ȸ�� ���� ���̵�: "+member_id);
		if(member_id.equals("not login")) {	//���� �α������� ���� ��� ��ٱ��� �̿� ���ϰ� ����
			result.put("status", false);
			result.put("msg", "user is not logged in");
		} else {
			result = cartDAO.addToCart(member_id, song_id);
		}
		JSONObject json =  new JSONObject(result); 	//HashMap ������ ���� JSON Ÿ������ �����ֱ� ���� JSONObject ���
		System.out.printf( "ResultJSON: %s", json);	//������ �� ����
		out.print(json);
		out.flush();
	}
}