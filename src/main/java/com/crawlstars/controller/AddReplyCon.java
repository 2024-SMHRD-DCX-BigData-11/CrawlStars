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
import com.crawlstars.model.PL_REPLY_HASHTAGS;
import com.crawlstars.model.PL_REPLY_HASHTAGSDAO;
import com.crawlstars.model.users;


/**
 * Servlet implementation class AddReplyCon
 */
public class AddReplyCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PrintWriter out =  response.getWriter();
		HttpSession session = request.getSession();
		String pl_id = request.getParameter("PL_ID");
		String post_id = request.getParameter("post_id");
		String reply_body = request.getParameter("reply_body");
		String[] reply_body_split =  reply_body.split("#");
		users user = (users)session.getAttribute("user");
		String SP_name = user.getSP_id();
		if(pl_id!=null) {
			PL_REPLIES pl_reply = new PL_REPLIES(pl_id,reply_body_split[0].trim(),SP_name);
			System.out.println(pl_reply.toString());
			int result = new PL_REPLIESDAO().insert(pl_reply);
			if(result!=0) {
				if(reply_body_split.length>1) {
					String[] hashtags = new String[reply_body_split.length-1];
					for(int i=1;i<reply_body_split.length;i++) {
						PL_REPLY_HASHTAGS pl_reply_hashtag = new PL_REPLY_HASHTAGS(result, result,reply_body_split[i].trim());
						System.out.println(pl_reply_hashtag);
						int result2 = new PL_REPLY_HASHTAGSDAO().insert(pl_reply_hashtag);
						if(result2==1) {
							System.out.println("해쉬태그 입력완료");
						}else {
							System.out.println("해쉬태그 입력실패");
						}
					}
					out.print("True");
				}
				else {
					System.out.println("해쉬태그 입력없음");
				}
				
			}else {
				out.print("False");;
				System.out.println("pl_reply실패");
			}
		}else if(post_id!=null) {
			
		}	
	
	}
	}
