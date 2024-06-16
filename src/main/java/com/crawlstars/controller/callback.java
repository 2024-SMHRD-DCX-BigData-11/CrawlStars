package com.crawlstars.controller;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;

import com.crawlstars.controller.UserProfile;
import com.crawlstars.pkce.AuthorizationCodeExample;
import com.neovisionaries.i18n.CountryCode;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;


@WebServlet("/callback")
public class callback extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		String code = request.getParameter("code");
		PrintWriter out = response.getWriter();
		out.print("<html>");
		out.print("<body bgcolor =DarkGray>");
		out.println(code);
		SpotifyApi spotifyApi = new AuthorizationCodeExample().authorizationCode_Sync(code);
		String accessToken = spotifyApi.getAccessToken();
		String refreshToken = spotifyApi.getRefreshToken();
		HttpSession session = request.getSession();
		session.setAttribute("spotifyApi", spotifyApi);
		out.println(accessToken);
		out.println(refreshToken);
		SpotifyApi spotifyApiSession = (SpotifyApi) session.getAttribute("spotifyApi");
		GetAlbumRequest getAlbumRequest = spotifyApi.getAlbum("4aawyAB9vmqN3uQ7FjRGTy").market(CountryCode.ES).build();
		new UserProfile().getCurrentUsersProfile_Sync(spotifyApi);
		try {
			Album album = getAlbumRequest.execute();
			out.println(album.getName());
			out.println("<a href='"+album.getHref()+"'>");
			GetCurrentUsersProfileRequest getCurrentUsersProfileRequest = spotifyApi.getCurrentUsersProfile()
	    		    .build();
	       User user = getCurrentUsersProfileRequest.execute();

	      out.println(user.getBirthdate()+"<br>");
	      out.println(user.getId()+"<br>");
	      out.println(user.getEmail()+"<br>");
	      response.sendRedirect("UserIdCheckCon");
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (SpotifyWebApiException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 나중에 user-ID DB유무에 따라서 sendRedirect로 보내줌 
		out.println("<a href='Mainpage.jsp'>메인페이지</a><br>");
		out.println("<a href='FirstLogin.jsp'>처음로그인</a><br>");
		out.print("</body>");

		out.print("</html>");
	}

}
