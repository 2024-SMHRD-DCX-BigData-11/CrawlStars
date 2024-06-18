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

import com.crawlstars.model.Playlist_songs;
import com.crawlstars.model.Playlist_songsDAO;
import com.crawlstars.model.playlists;
import com.crawlstars.model.playlistsDAO;
import com.crawlstars.model.users;
import com.crawlstars.model.usersDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Paging;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;
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
        session.setAttribute("user", users);
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
        	            Paging<PlaylistSimplified> playlistsA = GetListOfCurrentUsersPlaylistsRequest.execute();
        	            for(int i=0;i<playlistsA.getTotal();i++) {
        	            	String pl_title = playlistsA.getItems()[i].getName();
        	            	String pl_id = playlistsA.getItems()[i].getId();
        	            	String pl_image = "images/플리픽도안2.png";
        	            	String status = "O";
        	        		if(playlistsA.getItems()[i].getImages()!=null){
        	        			pl_image = playlistsA.getItems()[i].getImages()[0].getUrl();}
        	        		playlists playlists =  new playlists(pl_id,pl_title,SP_name,pl_image);
        	        		int result = new playlistsDAO().Insertuserpl(playlists);
        	            	GetPlaylistRequest getPlaylistRequest = spotifyApi.getPlaylist(pl_id)
        	                .build();
        	            	Playlist pl= getPlaylistRequest.execute();
        	            	if(pl.getTracks().getTotal() != 0) {
        	            		for(int j=0; j<pl.getTracks().getTotal(); j++) {
        	            			String song =pl.getTracks().getItems()[j].getTrack().getName();
        	            			GetTrackRequest getTrackRequest =  spotifyApi.getTrack(pl.getTracks().getItems()[j].getTrack().getId()).build();
        	            			Track trackA= getTrackRequest.execute();
        	            			String singer = trackA.getArtists()[0].getName();
        	            			for(int r=1;r<trackA.getArtists().length;r++ ) {
        	            				singer += ","+trackA.getArtists()[r].getName();
        	            			}
        	            			
        	            			Playlist_songs Playlistsongs = new Playlist_songs(pl_id, song, singer);
        	            			int result_song = new Playlist_songsDAO().insertplsong(Playlistsongs);
        	            			if (result_song == 1) {
        	            	            System.out.println("플레이리스트 입력 성공");
        	            	        } else {
        	            	            System.out.println("플레이리스트 입력 실패");
        	            	        }
        	            			
        	            		}
        	            	}
        	            	
        	            }
        	            response.sendRedirect("MainPage.jsp");
        	        } catch (SpotifyWebApiException | ParseException e) {
        	            e.printStackTrace();
        	            response.sendRedirect("FirstLogin.jsp");
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