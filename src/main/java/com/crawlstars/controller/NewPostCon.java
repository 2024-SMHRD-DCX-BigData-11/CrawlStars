package com.crawlstars.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.crawlstars.model.Post_hashtag;
import com.crawlstars.model.Post_hashtagDAO;
import com.crawlstars.model.Posts;
import com.crawlstars.model.PostsDAO;
import com.crawlstars.model.users;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class NewPostCon
 */
public class NewPostCon extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	response.setCharacterEncoding("UTF-8");
	request.setCharacterEncoding("UTF-8");
	HttpSession session = request.getSession();
	users user = (users)session.getAttribute("user");
	String path = request.getServletContext().getRealPath("/ProfileImg");
    int maxSize = 10*1024*1024; // 10MB
    String encoding = "UTF-8";
    DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
    MultipartRequest multi = null;
	
    try {
        multi = new MultipartRequest(request, path, maxSize, encoding, rename);
     } catch (IOException e) {
        
        e.printStackTrace();
     }
	String post_title = multi.getParameter("post_title");
	String post_body = multi.getParameter("post_body");
	Posts post = new Posts(post_title,user.getSP_id(),post_body);
	String post_img = multi.getFilesystemName("post_img");
	System.out.println("이미지경로 : " + multi.getOriginalFileName("post_img"));
	
	
	String file_path = "ProfileImg/"+post_img;
	
	
	if(post_img !=null) {
		System.out.println("낫널");
		post.setPost_img(file_path);
	}else {
		System.out.println("널");
		post.setPost_img("");
	}
	String pl_info = multi.getParameter("pl_info");
	System.out.println("멀티"+pl_info);
	
	if(pl_info!=null) {
	String[] pl_split=pl_info.split("!#");
	String pl_id = pl_split[0];
	String pl_title = pl_split[1];
	post.setPl_id(pl_id);
	post.setPl_title(pl_title);
	}else {
		post.setPl_id(" ");
		post.setPl_title(" ");
	}
	System.out.println("객체"+ post);
	int result = new PostsDAO().newPost(post);
	
	
	
	
	if(result==1) {
		System.out.println("Post 입력 성공");
		String post_id = new PostsDAO().lastPost(user.getSP_id());
		String post_hashtags = multi.getParameter("post_hashtag");
		System.out.println(post_hashtags);
		if(post_hashtags!=null) {
			String[] hashtags = post_hashtags.split("#");
			System.out.println(hashtags.toString());
			for(int i=1;i<hashtags.length;i++) {
				Post_hashtag hashtag1 = new Post_hashtag(post_id,hashtags[i].trim());
				System.out.println(hashtags[i]);
				int cnt = new Post_hashtagDAO().newHash(hashtag1);
				if(cnt==1) {
					System.out.println("해쉬태그입력성공");
				}else {
					System.out.println("해쉬태그입력실패");
				}
			}
		}
	}else {
		System.out.println("Post 입력 실패");
	}
	response.sendRedirect("Mainpage.jsp");
	}
}
