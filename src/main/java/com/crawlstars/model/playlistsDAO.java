package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class playlistsDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public void linkPL() {
		
		
	}

	public int Insertuserpl(playlists playlists) {
		
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.playlistsMapper.insert", playlists);
		session.close();
		return cnt;		
	}

}
