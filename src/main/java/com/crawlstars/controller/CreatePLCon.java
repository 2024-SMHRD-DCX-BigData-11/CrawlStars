package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;

import com.crawlstars.model.Playlist_songs;
import com.crawlstars.model.Playlist_songsDAO;
import com.crawlstars.model.playlists;
import com.crawlstars.model.playlistsDAO;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

/**
 * Servlet implementation class CreatePLCon
 */
public class CreatePLCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
		String pl_id = request.getParameter("PL_ID");
		String pl_title = request.getParameter("PL_TITLE");
		PrintWriter out =  response.getWriter();
		GetCurrentUsersProfileRequest getUsersProfile = spotifyApi.getCurrentUsersProfile().build();
		try {
			User user= getUsersProfile.execute();
			String SP_name = user.getId();
			String pl_image = "images/플리픽도안2.png";
			playlists playlists =  new playlists(pl_id,pl_title,SP_name,pl_image);
    		int result = new playlistsDAO().Insertuserpl(playlists);
    		if(result==1) {
    			out.print("True");
    		}else {
    			out.print("False");
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
