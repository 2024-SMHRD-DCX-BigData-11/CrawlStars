package com.crawlstars.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class Post_repliesDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public List<Post_replies> getreply(String post_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		List<Post_replies> result = session.selectList("com.crawlstars.database.Post_repliesMapper.getPostReply", post_id);
		session.close();
		return result;
	}
}
