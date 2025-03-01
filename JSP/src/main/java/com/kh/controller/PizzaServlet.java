package com.kh.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PizzaServlet
 */
@WebServlet("/confirmPizza.do")
public class PizzaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PizzaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//피자주문요청 처리 -> 결제페이지
		//얼마를 결제해야 하는지 계산해서 응답
		
		//요청시 전달값 추출, 데이터를 가공 -> 변수나 객체에 넘겨받은 값을 기록
		String name = request.getParameter("userName");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String message = request.getParameter("message");
		
		String pizza = request.getParameter("pizza");
		String[] toppingList = request.getParameterValues("topping");
		String[] sideList = request.getParameterValues("side");
		String payment = request.getParameter("payment");
		
		//요청처리(service > dao > db)
		
		int price = 0;
		switch(pizza) {
		case "콤비네이션": price += 20000; break;
		case "포테이토":
		case "치즈피자": price += 23000; break;
		default : price += 25000;
		}
		
		if(toppingList != null) {
			for(String topping : toppingList) {
				switch(topping) {
				case "베이컨/소세지":
				case "파인애플": price += 3000; break;
				case "치즈크러스트":
				case "치즈바이트": price += 2000; break;
				default : price += 1000;
				}
			}
		}
		
		if(sideList != null) {
			for(String side : sideList) {
				switch(side) {
				case "환타":
				case "콜라": price += 3000; break;
				case "핫소스":
				case "파마산":
				case "피클": price += 2000; break;
				default : price += 1000;
				}
			}
		}
		
		//요청처리 후 사용자가 보게될 응답페이지를 만들어서 전달
		//jsp로 응답페이지를 넘김
		request.setAttribute("name", name);
		request.setAttribute("phone", phone);
		request.setAttribute("address", address);
		request.setAttribute("message", message);
		
		request.setAttribute("pizza", pizza);
		request.setAttribute("toppingList", toppingList);
		request.setAttribute("sideList", sideList);
		request.setAttribute("payment", payment);
		request.setAttribute("price", price);
		
		//응답할 뷰 선택 후 응답을 넘김
		RequestDispatcher view = request.getRequestDispatcher("views/pizza/pizzaPayment.jsp");
		view.forward(request, response);
	

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
