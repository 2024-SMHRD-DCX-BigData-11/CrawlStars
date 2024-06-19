package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crawlstars.model.Posts;
import com.crawlstars.model.PostsDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class getMypost
 */
public class getMypost extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String post_id = request.getParameter("Post_id");
	Posts Post = new PostsDAO().getmyPost(post_id);
	Gson gson = new GsonBuilder().setPrettyPrinting().create();
    String jsonPlaylist = gson.toJson(Post);
    PrintWriter out = response.getWriter();
    System.out.println(jsonPlaylist);
    out.print(jsonPlaylist);
    out.flush();

	}

}
