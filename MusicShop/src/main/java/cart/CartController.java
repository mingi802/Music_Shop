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
		PrintWriter out = response.getWriter();
		Map<String,Object> result = new HashMap<>(){
			{
				put("status", false);
				put("msg", "default");
			}
		};
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		
		String path = request.getPathInfo();
		String action = path.substring(path.lastIndexOf("/"));
		System.out.println("path: "+path+"\naction: "+action);
		
		//nextpage = path.substring(path.indexOf("/"), path.lastIndexOf("/"))+".jsp"; 		
		
		
		if(action.equals("/addToCart.do")) {
			int song_id = -1;
			String member_id = null;
			if(request.getParameter("song_id") != null && request.getParameter("member_id") != null) {
				try {
					song_id = Integer.parseInt(request.getParameter("song_id")); 
				} catch (NumberFormatException e) {
					result.put("status", false);
				    result.put("msg", "song_id is not a number");
					JSONObject json =  new JSONObject(result); 	//HashMap 형태의 값을 JSON 타입으로 돌려주기 위해 JSONObject 사용
					System.out.printf( "ResultJSON: %s", json);	//디버깅용 값 찍어보기
					out.print(json);
					out.flush();
					return;	//song_id가 숫자로만 구성된 문자열이 아니면 int로 형변환하다가 오류가 발생함. 이 오류를 캐치해 바로 종료
				}
				member_id = request.getParameter("member_id");
			}
			System.out.println("음원 고유 번호: "+song_id);
			System.out.println("회원 고유 아이디: "+member_id);
			if(member_id.equals("not login")) {	//아직 로그인하지 않은 경우 장바구니 이용 못하게 종료
				result.put("status", false);
				result.put("msg", "user is not logged in");
				JSONObject json =  new JSONObject(result); 	//HashMap 형태의 값을 JSON 타입으로 돌려주기 위해 JSONObject 사용
				System.out.printf( "ResultJSON: %s", json);	//디버깅용 값 찍어보기
				out.print(json);
				out.flush();
				return;
			} else {
				result = cartDAO.addToCart(member_id, song_id);
			}
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
		
		JSONObject json =  new JSONObject(result); 	//HashMap 형태의 값을 JSON 타입으로 돌려주기 위해 JSONObject 사용
		System.out.printf("ResultJSON: %s", json);	//디버깅용 값 찍어보기
		out.print(json);
		out.flush();
		return;
	}
}