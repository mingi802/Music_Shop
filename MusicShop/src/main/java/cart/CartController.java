package cart;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.OutputStream;
import java.io.InputStream; 
import java.io.InputStreamReader; 
import java.io.Reader;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Base64;
import java.util.Base64.Encoder;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
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
		HttpSession session = request.getSession(false);
		request.setCharacterEncoding("UTF-8");
		String contextPath = request.getContextPath();
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
		} 
		else if(action.equals("/delCartItem.do")) {
			delCartItem(request, response);
			return;
		} 
		else if(action.equals("/cartItemPayment.do")) {
			String orderId = request.getParameter("orderId");
			String paymentKey = request.getParameter("paymentKey");
			String amount = request.getParameter("amount");
			String cartItemIds = request.getParameter("cartItemIds");
			String se_member_id = "";
			String message = "";
			Encoder encoder = Base64.getEncoder(); 
			
			if(session != null) {
				se_member_id = (String) session.getAttribute("id");
			}
		
		    System.out.println(cartItemIds);
		    int db_amount = cartDAO.getTotalAmount(se_member_id,cartItemIds);
		    if(Integer.parseInt(amount) != db_amount) {
		    	message = "수정된 가격으로 결제 시도";
		    	message = URLEncoder.encode(message, StandardCharsets.UTF_8);
		    	System.out.println(message);
		    	response.sendRedirect(contextPath+"/impTest/fail.jsp?code=REJECT_CARD_COMPANY&message="+message+"&orderId="+orderId);
		    	return;
		    } else {
		    	String secretKey = "test_sk_GePWvyJnrKbmGXKg2w7VgLzN97Eo:";	//클라이언트 측에서 절대 알아선 안될 정보
				byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
				String authorizations = "Basic "+ new String(encodedBytes, 0, encodedBytes.length);				
				paymentKey = URLEncoder.encode(paymentKey, StandardCharsets.UTF_8);
				
				URI uri = null;
				URL url = null;
				try {
					uri = new URI("https://api.tosspayments.com/v1/payments/confirm");
					url = uri.toURL();
				} catch (URISyntaxException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				//URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				connection.setRequestProperty("Authorization", authorizations);
				connection.setRequestProperty("Content-Type", "application/json");
				connection.setRequestMethod("POST");
				connection.setDoOutput(true);
				JSONObject obj = new JSONObject();
				obj.put("paymentKey", paymentKey);
				obj.put("orderId", orderId);
				obj.put("amount", amount);
				
				OutputStream outputStream = connection.getOutputStream();
				outputStream.write(obj.toString().getBytes("UTF-8"));
				
				int code = connection.getResponseCode();
				boolean isSuccess = code == 200 ? true : false;
				
				InputStream responseStream = isSuccess? connection.getInputStream(): connection.getErrorStream();
				
				Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
				JSONParser parser = new JSONParser();
				JSONObject jsonObject = null;
				try {
					jsonObject = (JSONObject) parser.parse(reader);
				} catch (IOException | ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				responseStream.close();
				System.out.println(jsonObject);
				if(isSuccess) {
					Map<String, Object> result = new HashMap<>();
					String[] song_id_arr_str = cartItemIds.split(",");
					int[] song_id_arr_int = new int[song_id_arr_str.length];
					int idx = 0;
					for(String song_id : song_id_arr_str) {
						song_id_arr_int[idx] = Integer.parseInt(song_id);
						idx++;
					}
					for(int song_id : song_id_arr_int) {
						result.putAll(cartDAO.insertPaymentData(jsonObject, se_member_id, song_id));
					}
					JSONObject json =  new JSONObject(result); 
					System.out.printf("insertPaymentDataResultJSON: %s\n", json);	//디버깅용 값 찍어보기
					request.setAttribute("isSuccess", isSuccess);
					request.setAttribute("jsonObject", jsonObject);
					List<Integer> song_id_list = Arrays.stream(song_id_arr_int)
                            						   .boxed()
                            						   .collect(Collectors.toList());
					result = cartDAO.delCartItem(se_member_id, song_id_list);
					json =  new JSONObject(result); 
					System.out.printf("delCartItemResultJSON: %s\n", json);	//디버깅용 값 찍어보기
				} else {
					System.out.println("code: "+jsonObject.get("code")+"\n"
									+  "message: "+jsonObject.get("message")+"\n"
									+  "orderId: "+orderId);
					response.sendRedirect(contextPath+"/impTest/fail.jsp?code="+jsonObject.get("code")+"&message="+URLEncoder.encode(jsonObject.get("message").toString(), StandardCharsets.UTF_8)+"&orderId="+orderId);
			    	return;
				}
		    }
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