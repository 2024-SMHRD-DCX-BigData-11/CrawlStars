package com.crawlstars.model;	

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

import lombok.NonNull;

public class PostsDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public List<Posts> getPost(String sp_id){
		SqlSession session = sqlSessionFactory.openSession(true);
		
		List<Posts> result = session.selectList("com.crawlstars.database.PostsMapper.getPost",sp_id);
		session.close();
		return result;
	}
	public List<Posts> ResearchgetPost(String sp_id){
		SqlSession session = sqlSessionFactory.openSession(true);
		
		List<Posts> result = session.selectList("com.crawlstars.database.PostsMapper.RgetPost",sp_id);
		session.close();
		return result;
	}

	public Posts getmyPost(String post_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		Posts result = session.selectOne("com.crawlstars.database.PostsMapper.getmyPost",post_id);
		session.close();
		return result;
	}

	public int newPost(Posts post) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.PostsMapper.insert", post);
		session.close();
		return cnt;
	}

	public String lastPost(@NonNull String sp_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		String result = session.selectOne("com.crawlstars.database.PostsMapper.findone",sp_id);
		session.close();
		return result;
	}
	public List<Posts> LikePost(String sp_id){
		SqlSession session = sqlSessionFactory.openSession(true);
		List<Posts> result = session.selectList("com.crawlstars.database.PostsMapper.LikePost",sp_id);
		session.close();
		return result;
	}
	
}
