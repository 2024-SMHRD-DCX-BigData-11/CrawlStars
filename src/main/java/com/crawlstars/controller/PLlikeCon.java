package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crawlstars.model.Like_pls;
import com.crawlstars.model.Like_plsDAO;
import com.crawlstars.model.users;

/**
 * Servlet implementation class PLlikeCon
 */
public class PLlikeCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	request.setCharacterEncoding("UTF-8");
	String pl_id=request.getParameter("pl_id");
	HttpSession session =request.getSession();
	users user =(users)session.getAttribute("user");
	Like_pls like_pl = new Like_pls(user.getSP_id(),pl_id);
	int cnt = new Like_plsDAO().insert(like_pl);
	PrintWriter out = response.getWriter();
	if(cnt==1) {
		out.print("True");
	}else {
		out.print("false");
	}
	
	}

}
