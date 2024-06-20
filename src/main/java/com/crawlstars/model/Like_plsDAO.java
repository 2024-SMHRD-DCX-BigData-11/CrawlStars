package com.crawlstars.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class Like_plsDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	public List<Like_pls> GetLikePL (String sp_id){
		SqlSession session = sqlSessionFactory.openSession(true);
		List<Like_pls> result = session.selectList("com.crawlstars.database.Like_plsMapper.getPlReply", sp_id);
		session.close();
		return result;
	
	}

	public int insert(Like_pls like_pl) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt =session.insert("com.crawlstars.database.Like_plsMapper.insert",like_pl);
		session.close();
		return cnt;
	}
	public int delete(Like_pls like_pl) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt =session.delete("com.crawlstars.database.Like_plsMapper.delete",like_pl);
		session.close();
		return cnt;
	}
	public int gettotalLike(String sp_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int result = session.selectOne("com.crawlstars.database.Like_plsMapper.total",sp_id);
				session.close();
		return result;
	}
	
}
