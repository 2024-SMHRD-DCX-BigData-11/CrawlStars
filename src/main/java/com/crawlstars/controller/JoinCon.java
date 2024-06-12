package com.crawlstars.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.crawlstars.model.playlists;
import com.crawlstars.model.playlistsDAO;
import com.crawlstars.model.users;
import com.crawlstars.model.usersDAO;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

import org.apache.hc.core5.http.ParseException;


public class JoinCon extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		String SP_name = request.getParameter("SP_name");
		String nick = request.getParameter("nick");
		String gender = request.getParameter("gender");
		
		String birthdate_year = request.getParameter("birthdate_year");
        String birthdate_month = request.getParameter("birthdate_month");
        String birthdate_day = request.getParameter("birthdate_day");
        String birthdate = birthdate_year + "/" + birthdate_month + "/" + birthdate_day;
        //유저타입 구분
        
		//프로필 이미지 업로드 방식
		//String user_img = request.getParameter("user_img");
        
        String Sync_Playlist = request.getParameter("Sync_Playlist");
       
        users users = new users(SP_name, nick, gender, birthdate, birthdate);
        
        int cnt = new usersDAO().join(users);
        
        if(cnt==1) {
        	System.out.println("정보입력 성공");
        	if(request.getParameter("Sync_Playlist").equals("Y")){
        	    SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
        	    if (spotifyApi != null) {
        	    	GetListOfCurrentUsersPlaylistsRequest GetListOfCurrentUsersPlaylistsRequest = spotifyApi.getListOfCurrentUsersPlaylists()
        	                .build();
        	        try {
        	            GetListOfCurrentUsersPlaylistsRequest.execute();
        	            
        	        } catch (SpotifyWebApiException | ParseException e) {
        	            e.printStackTrace();
        	        }
        	    } else {
        	        
        	    }
        	} else {
        		
        	}
        }else {
        	System.out.println("정보입력 실패");
        }

        }		
	

}
