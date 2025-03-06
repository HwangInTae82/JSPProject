package com.kh.board.controller;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.List;

import org.apache.commons.fileupload2.core.DiskFileItemFactory;
import org.apache.commons.fileupload2.core.FileItem;
import org.apache.commons.fileupload2.jakarta.JakartaServletFileUpload;

import com.kh.board.model.vo.Attachment;
import com.kh.board.model.vo.Board;
import com.kh.board.service.BoardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BoardUpdateController
 */
@WebServlet("/update.bo")
public class BoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardUpdateController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(JakartaServletFileUpload.isMultipartContent(request)) {
			int fileMaxSize = 1024 * 1024 * 50; //50MB
			int requestMaxSize = 1024 * 1024 * 60; //전체요청 크기제한
			
			String savePath = request.getServletContext().getRealPath("/resources/board-upfile/");
		
			//3. DiskFileItemFactory(파일을 임시로 저장) 객체 생성
			DiskFileItemFactory factory = DiskFileItemFactory.builder().get();
			
			//JakartaServletFileUpload http요청으로 들어온 파일데이터 파싱 -> 개별 FileItem 객체로 변환
			JakartaServletFileUpload upload = new JakartaServletFileUpload(factory);
			
			upload.setFileSizeMax(fileMaxSize);
			upload.setSizeMax(requestMaxSize);
			
			List<FileItem> formItems = upload.parseRequest(request);
			
			Board b = new Board();
			Attachment at = null;
			String originFileNo = null;
			
			for(FileItem item : formItems) {
				System.out.println(item);
				if(item.isFormField()) { //일반파라미터
					switch(item.getFieldName()) {
						case "bno":
							int bno = Integer.parseInt(item.getString(Charset.forName("UTF-8")));
							b.setBoardNo(bno);
						case "category":
							int categryNo = Integer.parseInt(item.getString(Charset.forName("UTF-8")));
							b.setCategoryNo(categryNo);
							break;
						case "title":
							b.setBoardTitle(item.getString(Charset.forName("UTF-8")));
							break;
						case "content":
							b.setBoardContent(item.getString(Charset.forName("UTF-8")));
							break;
						case "originFileNo":
							originFileNo = item.getString(Charset.forName("UTF-8"));
							break;
					}
				} else {//파일
					String originName = item.getName(); //업로드 요청한 새로운 파일명
					
					if(originName.length() > 0) { 
						String tmpName = "kh_" + System.currentTimeMillis() + ((int)(Math.random() * 100000) + 1);
						String type = originName.substring(originName.lastIndexOf("."));
						String chageName = tmpName + type; //서버에 저장할 파일명
						
						File f = new File(savePath, chageName);
						item.write(f.toPath()); //지정한 경로에 파일 업로드
						
						at = new Attachment();
						at.setOriginName(originName);
						at.setChangeName(chageName);
						at.setFilePath("resources/board-upfile/");
					}
				}
			}
			
			if(at != null) {//업로드할 첨부파일이 있을 때
				if(originFileNo != null) { //기존첨부파일 존재
					at.setFileNo(Integer.parseInt(originFileNo));
				} else { //기존첨부파일 없을 때
					at.setRefBoardNo(b.getBoardNo());
				}
			}
			
			int result = new BoardService().updateBoard(b, at);
			//새로운 첨부파일 x 			   b, null -> board update
			//새로운 첨부파일 o, 기존첨부파일 o   b, fileNo -> board update, attchment update
			//새로운 첨부파일 o, 기존첨부파일 x   b, refBoardNo -> board update, attchment insert
			
			if(result > 0) {
				request.getSession().setAttribute("alertMsg", "일반 게시글 수정 성공");
				response.sendRedirect(request.getContextPath() + "/detail.bo?bno=" + b.getBoardNo());
			} else {
				if(at != null) {
					new File(savePath + at.getChangeName()).delete();
				}
				
				request.setAttribute("errorMsg", "게시글 수정 실패.");
				request.getRequestDispatcher("views/common/errorPage.jsp").forward(request, response);	
			}
			
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
