package com.crawlstars.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.crawlstars.model.PL_REPLIES;
import com.crawlstars.model.PL_REPLIESDAO;

/**
 * Servlet implementation class GetPlReplyCon
 */
public class GetPlReplyCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	String pl_id = request.getParameter("PL_ID");
	
	List<PL_REPLIES> result = new PL_REPLIESDAO().getPL(pl_id); 
	
	}

}
