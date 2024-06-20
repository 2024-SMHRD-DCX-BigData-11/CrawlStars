package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crawlstars.model.Posts;
import com.crawlstars.model.PostsDAO;
import com.crawlstars.model.playlists;
import com.crawlstars.model.playlistsDAO;
import com.crawlstars.model.users;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;


/**
 * Servlet implementation class GetSearchResultCon
 */
public class GetSearchResultCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String value = request.getParameter("search");
		List<playlists> playlists = new playlistsDAO().Researchgetpl(value);
		List<Posts> posts = new PostsDAO().ResearchgetPost(value);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();

		JsonObject jsonObject = new JsonObject();

		// Posts 객체 추가
		jsonObject.add("Post", gson.toJsonTree(posts));

		// post_hashtag 리스트 추가
		jsonObject.add("playlist", gson.toJsonTree(playlists));
		String combinedJson = gson.toJson(jsonObject);

	    PrintWriter out = response.getWriter();
	    out.print(combinedJson);
	    out.flush();
	
	
	
	}

}
