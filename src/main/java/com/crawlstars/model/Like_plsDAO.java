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
		return result;
		
		
		
		
		
	}
}
