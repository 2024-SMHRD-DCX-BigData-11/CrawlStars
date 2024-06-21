package com.crawlstars.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crawlstars.model.users;
import com.crawlstars.model.usersDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class UpdateprofileCon
 */
public class UpdateprofileCon extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     request.setCharacterEncoding("UTF-8");  
     String path = request.getServletContext().getRealPath("./ProfileImg");
     HttpSession session = request.getSession();
     users user = (users)session.getAttribute("user");
     int maxSize = 10*1024*1024; // 10MB
     String encoding = "UTF-8";
     DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
     MultipartRequest multi = null;
     
     try {
         multi = new MultipartRequest(request, path, maxSize, encoding, rename);
         
      } catch (IOException e) {
         
         e.printStackTrace();
      }
     String nick = multi.getParameter("inputname");    
     String user_img= multi.getFilesystemName("user_img");
     System.out.println("유저이미지"+user_img);
     System.out.println("오류난곳"+user.toString());
     
     if(!nick.equals("")) {
    	 if(nick!="") {
    		 System.out.println("notNull"+nick);
    	 user.setNick(nick);}
     }else {
    	 System.out.println("nullNick");
     }
     if(user_img!=null) {
    	 if(user_img!="") {
    	 String file_path = "ProfileImg/"+user_img;
    	 user.setUser_img(file_path);
    	 System.out.println("notnull"+file_path);}
     }else {
    	 System.out.println("fileNull");
     }
     int cnt = new usersDAO().updateNick(user);
     if(cnt==1) {
    	 session.setAttribute("user", user);
     }
     response.sendRedirect("MyPage.jsp");
     
     
	}
}
