package com.crawlstars.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crawlstars.model.users;

import se.michaelthelin.spotify.SpotifyApi;

/**
 * Servlet implementation class getMyPage
 */
public class getMyPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
        SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
	String sp_id = request.getParameter("UserId");
	if(sp_id==null) {
		users user= (users)session.getAttribute("user");
				sp_id = user.getSP_id();
	}
	}

}
