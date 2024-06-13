package com.crawlstars.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.crawlstars.model.playlists;
import com.crawlstars.model.playlistsDAO;
import com.crawlstars.model.users;
import com.crawlstars.model.usersDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;

import org.apache.hc.core5.http.ParseException;

@WebServlet("/JoinCon")
public class JoinCon extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
		
        
        String path = request.getServletContext().getRealPath("./ProfileImg");
        int maxSize = 10*1024*1024; // 10MB
        String encoding = "UTF-8";
        DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
        MultipartRequest multi = null;
        
        try {
            multi = new MultipartRequest(request, path, maxSize, encoding, rename);
         } catch (IOException e) {
            
            e.printStackTrace();
         }
        String SP_name = multi.getParameter("SP_name");
        String nick = multi.getParameter("nick");
        String gender = multi.getParameter("gender");
        
        String birthdate_year = multi.getParameter("birthdate_year");
        String birthdate_month = multi.getParameter("birthdate_month");
        String birthdate_day = multi.getParameter("birthdate_day");
        String birthdate = birthdate_year + "/" + birthdate_month + "/" + birthdate_day;
        
        String user_img= multi.getFilesystemName("user_img");
        String user_type="u";
        
        
        String Sync_Playlist = multi.getParameter("Sync_Playlist");
        
        System.out.println(user_img);
        
        if (multi.getFilesystemName("user_img") == null) {
            user_img = "defaultemp.png";
        }

        System.out.println(user_img);
        users users = new users(SP_name, nick, gender, birthdate , user_img , user_type);
        
        System.out.println("X");
        int cnt = new usersDAO().join(users);
        System.out.println("O");
        
        if(cnt==1) {
        	System.out.println("정보입력 성공");
        	if(multi.getParameter("Sync_Playlist").equals("Y")){
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
