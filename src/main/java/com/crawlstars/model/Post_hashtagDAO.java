package com.crawlstars.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class Post_hashtagDAO {
	
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

public List<String> GetPosthashtag(String post_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		List<String> result = session.selectList("com.crawlstars.database.Post_hashtagMapper.getPosthashtag", post_id);
		session.close();
	
	
	return result;
}

public int newHash(Post_hashtag hashtag) {
	SqlSession session = sqlSessionFactory.openSession(true);
	int cnt =session.insert("com.crawlstars.database.Post_hashtagMapper.insert",hashtag);
	return cnt;
}
}
