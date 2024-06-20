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
import com.crawlstars.model.Post_likes;
import com.crawlstars.model.Post_likesDAO;
import com.crawlstars.model.users;

/**
 * Servlet implementation class PostlikeCon
 */
public class PostlikeCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	request.setCharacterEncoding("UTF-8");
	String post_id=request.getParameter("post_id");
	HttpSession session =request.getSession();
	users user =(users)session.getAttribute("user");
	Post_likes post_like = new Post_likes(user.getSP_id(),post_id);
	int cnt = new Post_likesDAO().insert(post_like);
	PrintWriter out = response.getWriter();
	if(cnt==1) {
		out.print("True");
	}else {
		out.print("false");
	}
	
	}}

