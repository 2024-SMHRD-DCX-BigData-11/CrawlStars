package com.crawlstars.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crawlstars.model.followsDAO;


public class FollowsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String follower = request.getParameter("follower");
		String followee = request.getParameter("followee");
		
		followsDAO followsDAO = new followsDAO();
		System.out.println(follower);
		System.out.println(followee);
		boolean deleted = new followsDAO().deleteFollower(follower, followee);
		
	}

}
