package com.crawlstars.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crawlstars.model.Member;
import com.crawlstars.model.MemberDAO;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;


public class JoinCon extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String SP_name = request.getParameter("SP_name");
		String nick = request.getParameter("nick");
		String gender = request.getParameter("gender");
		
		String birthdate_year = request.getParameter("birthdate_year");
        String birthdate_month = request.getParameter("birthdate_month");
        String birthdate_day = request.getParameter("birthdate_day");
        String birthdate = birthdate_year + "-" + birthdate_month + "-" + birthdate_day;
        
		//프로필 이미지 업로드 방식
		//String user_img = request.getParameter("user_img");
        
        String PL_link = request.getParameter("PL_link");
        //플레이리스트 Y/N 받아오기
        
        //+프로필 이미지
        Member member = new Member(SP_name, nick, gender, birthdate, PL_link);
        
        int cnt = new MemberDAO().join(member);
        
        if(cnt==1) {
        	System.out.println("정보입력 성공");
        }else {
        	System.out.println("정보입력 실패");
        }
		

		
	}

}
