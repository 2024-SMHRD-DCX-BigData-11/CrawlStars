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

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;

/**
 * Servlet implementation class insertSonglist
 */
public class insertSonglist extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
		String pl_id = request.getParameter("PL_ID");
		String track_id = request.getParameter("track_id");
		PrintWriter out =  response.getWriter();
		GetTrackRequest getTrackRequest = spotifyApi.getTrack(track_id).build();
		try {
			Track track= getTrackRequest.execute();
        			String song =track.getName();
        			String singer = track.getArtists()[0].getName();
        			for(int r=1;r<track.getArtists().length;r++ ) {
        				singer += ","+track.getArtists()[r].getName();
        			}
        			Playlist_songs Playlistsongs = new Playlist_songs(pl_id, song, singer);
        			int result_song = new Playlist_songsDAO().insertplsong(Playlistsongs);
        			if (result_song == 1) {
        	            out.println("True");
        	        } else {
        	            out.println("False");
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
