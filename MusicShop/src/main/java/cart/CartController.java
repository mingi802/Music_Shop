package cart;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

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
	
	private static boolean isNumeric(String str){
        return str != null && str.matches("[0-9.]+");
    }
	
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		
		String path = request.getPathInfo();
		String action = path.substring(path.lastIndexOf("/"));
		System.out.println("path: "+path+"\naction: "+action);
		
		String nextpage = path.substring(path.indexOf("/"), path.lastIndexOf("/"))+".jsp"; 		
		String member_id = null;
		if(action.equals("/addToCart.do")) {
			addToCart(request, response); //장바구니에 물품 추가는 페이지 이동이 필요없음
			return;
		}
		else if(action.equals("/goToCart.do")) {
			if(request.getParameter("member_id") != null) {
				member_id = request.getParameter("member_id");
				List<CartVO> cartItemList = cartDAO.getCartItems(member_id);
				request.setAttribute("cartItemList", cartItemList);
				request.setAttribute("isFirstEntry", false);
			}
		} else if(action.equals("/delCartItem.do")) {
			delCartItem(request, response);
			return;
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
		System.out.println("음원 고유 번호: "+song_id);
		System.out.println("회원 고유 아이디: "+member_id);
		if(member_id.equals("not login")) {	//아직 로그인하지 않은 경우 장바구니 이용 못하게 종료
			result.put("status", false);
			result.put("msg", "user is not logged in");
		} else {
			result = cartDAO.addToCart(member_id, song_id);
		}
		JSONObject json =  new JSONObject(result); 	//HashMap 형태의 값을 JSON 타입으로 돌려주기 위해 JSONObject 사용
		System.out.printf("ResultJSON: %s\n", json);	//디버깅용 값 찍어보기
		out.print(json);
		out.flush();
	}
	
	protected void delCartItem(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=utf-8");
		PrintWriter out = response.getWriter();
		Map<String,Object> result = new HashMap<>(){
			{
				put("status", false);
				put("msg", "default");
			}
		};
		StringBuffer sb = new StringBuffer();
		BufferedReader br = request.getReader();
		String line = null;
		
		while((line = br.readLine()) != null) {
			sb.append(line);
		}
		System.out.println(sb.toString());
		JSONParser parser = new JSONParser();
		Object obj = null;
		try {
			obj = parser.parse(sb.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		JSONObject jsonObj = (JSONObject) obj;
		JSONArray jArray = new JSONArray();			
		jArray = (JSONArray)jsonObj.get("checked_cart_item_list");
		List<Integer> song_id_list = new ArrayList<Integer>();
		
		String member_id = jsonObj.get("member_id").toString();
		System.out.println(member_id);
		for(int i = 0; i < jArray.size(); i++) {
			System.out.println(jArray.get(i).toString());
			if(isNumeric(jArray.get(i).toString())) {
				song_id_list.add(Integer.parseInt(jArray.get(i).toString()));
			}
		}
		result = cartDAO.delCartItem(member_id, song_id_list);
		JSONObject json =  new JSONObject(result); 	//HashMap 형태의 값을 JSON 타입으로 돌려주기 위해 JSONObject 사용
		System.out.printf("ResultJSON: %s\n", json);	//디버깅용 값 찍어보기
		out.print(json);
		out.flush();
	}
}