package com.crawlstars.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crawlstars.model.blocksDAO;


public class BlockCancelController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sp_id = request.getParameter("sp_id");
		String block_sp_id = request.getParameter("block_sp_id");
		
		blocksDAO blocksDAO = new blocksDAO();
		boolean deleted = new blocksDAO().deleteBlockuser(sp_id, block_sp_id);
        
        if (deleted) {
            response.getWriter().write("차단 취소 성공");
        } else {
            response.getWriter().write("차단 취소 실패");
        }
		
	}
	

}
