package com.crawlstars.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class PostsDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public List<Posts> getPost(){
		SqlSession session = sqlSessionFactory.openSession(true);
		
		List<Posts> result = session.selectList("com.crawlstars.database.PostsMapper.getPost");
		session.close();
		return result;
	}
	
}
