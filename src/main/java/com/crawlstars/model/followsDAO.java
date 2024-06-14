package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class followsDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	public int follower_cnt() {
		SqlSession session = sqlSessionFactory.openSession(true);
		int FLcnt = session.insert("com.crawlstars.database.followsMapper.follower_cnt");
		session.close();
		return FLcnt;
	}

}
