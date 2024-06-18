package com.crawlstars.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;

import com.crawlstars.model.users;
import com.crawlstars.model.usersDAO;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

public class UserIdCheckCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session = request.getSession();
		SpotifyApi spotifyapi =  (SpotifyApi)session.getAttribute("spotifyApi");
		GetCurrentUsersProfileRequest getCurrentUsersProfileRequest = spotifyapi.getCurrentUsersProfile()
    		    .build();
       try {
		User user = getCurrentUsersProfileRequest.execute();
		String sp_id = user.getId();
		users CheckId = new usersDAO().CheckId(sp_id);
		if(CheckId!=null) {
			session.setAttribute("user", CheckId);
			response.sendRedirect("Mainpage.jsp");
		}else {
			response.sendRedirect("FirstLogin.jsp");
			
		}
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SpotifyWebApiException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
		
		
	}
}
