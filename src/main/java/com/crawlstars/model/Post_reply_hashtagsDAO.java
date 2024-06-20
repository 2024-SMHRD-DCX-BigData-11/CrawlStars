package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class Post_reply_hashtagsDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	
	public int insert(Post_reply_hashtags post_reply_hashtag) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.Post_reply_hashtagMapper.insert",post_reply_hashtag);
		session.close();
		return cnt;
	}

}
