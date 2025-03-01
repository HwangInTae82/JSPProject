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
		//요청된 회원정보 -> 정보수정 -> int -> 성공(myPage), 실패(errorPage) 
		String userId = request.getParameter("userId");
		String userName= request.getParameter("userName");
		String phone= request.getParameter("phone"); // "010~~" || ""
		String email= request.getParameter("email"); // "gdfef~`" || ""
		String address= request.getParameter("address"); // "경기도~~" || ""
		String[] interestArr= request.getParameterValues("interest"); // ["운동"...] || null
		
		//String[] -> String
		String interest = "";
		if(interestArr != null) {
			interest = String.join(",", interestArr);
		}
		
		Member m = new Member();
		m.setUserId(userId);
		m.setPhone(phone);
		m.setEmail(email);
		m.setAddress(address);
		m.setInterest(interest);
		
		//sql요청 -> service
		Member updateMember = new MemberService().updateMember(m);
		if(updateMember != null) { //수정성공
			HttpSession session= request.getSession();
			session.setAttribute("loginUser", updateMember);
			session.setAttribute("alertMsg", "성공적으로 회원정보수정이 완료되었습니다.");
			
			response.sendRedirect(request.getContextPath() + "/myPage.me");
		
		} else { //수정실패
			//에러문구가 있는 에러페이지
			request.setAttribute("errorMsg", "회원정보수정에 실패하였습니다");
			
			request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);
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
