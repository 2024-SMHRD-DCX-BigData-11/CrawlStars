package com.crawlstars.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crawlstars.model.followsDAO;

public class FollowsCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		followsDAO followsDAO = new followsDAO();
		
		String follower = request.getParameter("follower");
		String followee = request.getParameter("followee");
		
		
		int followCheck = new followsDAO().followCheck(follower, followee);
		if(followCheck == 1) {
			boolean unfollow = new followsDAO().userUnfollow(follower, followee);
			System.out.println("언팔로우 했습니다");
		}else if(followCheck == 0 ) {
			boolean follow = new followsDAO().userFollow(follower, followee);
			System.out.println("팔로우 했습니다");
		}
	}

}
