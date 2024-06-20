package com.crawlstars.model;	

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class PostsDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public List<Posts> getPost(String sp_id){
		SqlSession session = sqlSessionFactory.openSession(true);
		
		List<Posts> result = session.selectList("com.crawlstars.database.PostsMapper.getPost",sp_id);
		session.close();
		return result;
	}

	public Posts getmyPost(String post_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		Posts result = session.selectOne("com.crawlstars.database.PostsMapper.getmyPost",post_id);
		session.close();
		return result;
	}
	
}
