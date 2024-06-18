package com.crawlstars.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class PL_REPLIESDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int insert(PL_REPLIES pl_reply) {	
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.PL_REPLIESMapper.insert", pl_reply);
		return cnt;	
	}
	public List<PL_REPLIES> getPL(String pl_reply) {	
		SqlSession session = sqlSessionFactory.openSession(true);
		List<PL_REPLIES> result = session.selectList("com.crawlstars.database.PL_REPLIESMapper.getPlReply", pl_reply);
		return result;	
	}
}
