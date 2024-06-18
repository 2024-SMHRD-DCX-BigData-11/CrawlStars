package com.crawlstars.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crawlstars.model.playlists;
import com.crawlstars.model.playlistsDAO;

import se.michaelthelin.spotify.SpotifyApi;

/**
 * Servlet implementation class GetPLCon
 */
public class GetPLCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String pl_id = request.getParameter("PL_ID");
		HttpSession session = request.getSession();
		SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
		playlists playlist = new playlistsDAO().getpl(pl_id); 
	
	
	
	}
}
