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

	public int insert(Post_replies post_reply) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.Post_repliesMapper.insert",post_reply);
		session.close();
		return cnt;
	}

	public int LastC(String sP_name) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int result = session.selectOne("com.crawlstars.database.Post_repliesMapper.getLastReply", sP_name);
		session.close();
		return result;
	}
}
