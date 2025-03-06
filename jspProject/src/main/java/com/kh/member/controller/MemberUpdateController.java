package com.kh.member.controller;

import java.io.IOException;

import com.kh.member.model.vo.Member;
import com.kh.member.service.MemberService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class MemberUpdateController
 */
@WebServlet("/update.me")
public class MemberUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//요청된 회원정보 -> 정보수정 -> int -> 성공(myPage),실패(errorPage)
		
		String userId = request.getParameter("userId");
		String phone = request.getParameter("phone"); // "010~~" || "" 
		String email = request.getParameter("email"); // "hjsbdv@nave~" || ""
		String address = request.getParameter("address"); // "경기도~" || ""
		String[] interestArr = request.getParameterValues("interest"); // ["운동"...] || null
	
		//String[] -> String
		String interest = "";
		if(interestArr != null) {
			interest = String.join(",", interestArr);
		}
		
		//업데이터정보가 담긴 Member객체
		Member m = new Member();
		m.setUserId(userId);
		m.setPhone(phone);
		m.setEmail(email);
		m.setAddress(address);
		m.setInterest(interest);
		
		Member updateMember = new MemberService().updateMember(m);
		
		if(updateMember == null) { //업데이트 실패
			request.setAttribute("errorMsg", "회원정보 수정에 실패하였습니다.");
			request.getRequestDispatcher("veiws/common/errorPage.jsp").forward(request, response);
			
		} else { //업데이트 성공
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", updateMember);
			session.setAttribute("alertMsg", "성공적으로 수정하였습니다.");
			
			response.sendRedirect(request.getContextPath() + "/myPage.me");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
