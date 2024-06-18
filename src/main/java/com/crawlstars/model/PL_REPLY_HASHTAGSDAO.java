package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class PL_REPLY_HASHTAGSDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int insert(String hASHTAG) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.PL_REPLY_HASHTAGSMapper.insert", hASHTAG);
		return cnt;	
	}
	
	
	
	
}
