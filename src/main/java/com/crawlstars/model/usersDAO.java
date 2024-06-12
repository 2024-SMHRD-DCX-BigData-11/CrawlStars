package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class usersDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int join(users member) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("", member);
		session.close();
		return cnt;
	}

	public boolean NickCheck(String inputNick) {
		SqlSession session = sqlSessionFactory.openSession(true);
		boolean result = session.selectOne("", inputNick);
		session.close();
		return result;
	}
	
	
	
}
