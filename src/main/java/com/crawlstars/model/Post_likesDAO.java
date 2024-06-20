package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class Post_likesDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int insert(Post_likes post_like) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt =session.insert("com.crawlstars.database.Post_likesMapper.insert",post_like);
		session.close();
		return cnt;
	}

}
