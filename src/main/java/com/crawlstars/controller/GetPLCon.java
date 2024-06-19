package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crawlstars.model.PL_REPLIES;
import com.crawlstars.model.PL_REPLIESDAO;
import com.crawlstars.model.playlists;
import com.crawlstars.model.playlistsDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import se.michaelthelin.spotify.SpotifyApi;

public class GetPLCon extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String pl_id = request.getParameter("PL_ID");
        System.out.println(pl_id);
        HttpSession session = request.getSession();
        SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
    	List<PL_REPLIES> result = new PL_REPLIESDAO().getPL(pl_id); 
    	JsonObject jsonObject = new JsonObject();
        jsonObject.add("replies", new Gson().toJsonTree(result));
        // Gson 객체 생성
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        // playlists 객체를 JSON으로 변환
        String jsonPlaylist = jsonObject.toString();

// 사용불가... ㅠㅠ
        // JSON 응답으로 전송
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        System.out.println(jsonPlaylist);
        out.print(jsonPlaylist);
        out.flush();
	}
}
