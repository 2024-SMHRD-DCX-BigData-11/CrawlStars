package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class PL_REPLY_HASHTAGSDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int insert(PL_REPLY_HASHTAGS pl_reply_hashtag) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int pl_reply_id = session.selectOne("com.crawlstars.database.PL_REPLIESMapper.getLastReply");
		pl_reply_hashtag.setPL_REPLY_ID(pl_reply_id);
		int cnt = session.insert("com.crawlstars.database.PL_REPLY_HASHTAGSMapper.insert", pl_reply_hashtag);
		return cnt;	
	}
	
	
	
	
}
