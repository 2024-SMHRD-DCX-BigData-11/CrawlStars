package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crawlstars.model.usersDAO;


public class NickCheckCon extends HttpServlet {

	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String inputNick = request.getParameter("inputNick");
		
		System.out.println(inputNick);
		
		boolean result = new usersDAO().NickCheck(inputNick);
		
		System.out.println(result);
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return;
	}

}
