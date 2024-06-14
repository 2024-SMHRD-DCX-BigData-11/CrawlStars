package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class usersDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int join(users users) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.usersMapper.join", users);
		session.close();
		return cnt;
	}

	public boolean NickCheck(String inputNick) {
		SqlSession session = sqlSessionFactory.openSession(true);
		boolean result = session.selectOne("com.crawlstars.database.usersMapper.nickCheck", inputNick);
		session.close();
		return result;
	}
	
	
	
}
