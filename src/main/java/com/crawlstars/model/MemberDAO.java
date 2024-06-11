package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class MemberDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int join(Member member) {
		
		return 0;
	}
	
	
	
}
