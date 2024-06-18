package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;

import com.crawlstars.model.playlists;
import com.crawlstars.model.playlistsDAO;
import com.crawlstars.model.users;

import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

/**
 * Servlet implementation class AddReplyCon
 */
public class AddReplyCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out =  response.getWriter();
		HttpSession session = request.getSession();
		String pl_id = request.getParameter("PL_ID");
		String post_id = request.getParameter("post_id");
		String reply_body = request.getParameter("reply_body");
		String[] reply_body_split =  reply_body.split("#");
		if(pl_id!=null) {
		if(reply_body_split.length>1) {
			String[] hashtags = new String[reply_body_split.length-1];
			for(String hashtag :hashtags) {
				
			}
		}else {
			
		}
		}else if(post_id!=null) {
			
		}
		users user = (users)session.getAttribute("user");
		String SP_name = user.getSP_name();
		if(true) {
			out.print("True");
		}else {
			out.print("False");
		}
	
	
	
	}
	}
