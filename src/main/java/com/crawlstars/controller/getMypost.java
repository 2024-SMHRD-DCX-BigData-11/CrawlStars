package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crawlstars.model.Post_hashtag;
import com.crawlstars.model.Post_hashtagDAO;
import com.crawlstars.model.Post_replies;
import com.crawlstars.model.Post_repliesDAO;
import com.crawlstars.model.Posts;
import com.crawlstars.model.PostsDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

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
	List<String> post_hashtag = new Post_hashtagDAO().GetPosthashtag(post_id);
	List<Post_replies> post_replies = new Post_repliesDAO().getreply(post_id);
	Gson gson = new GsonBuilder().setPrettyPrinting().create();

	JsonObject jsonObject = new JsonObject();

	// Posts 객체 추가
	jsonObject.add("Post", gson.toJsonTree(Post));

	// post_hashtag 리스트 추가
	jsonObject.add("post_hashtag", gson.toJsonTree(post_hashtag));

	// post_replies 리스트 추가
	jsonObject.add("post_replies", gson.toJsonTree(post_replies));

	// JsonObject를 JSON 문자열로 변환
	String combinedJson = gson.toJson(jsonObject);

    PrintWriter out = response.getWriter();
    out.print(combinedJson);
    out.flush();

	}

}
