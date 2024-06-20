package com.crawlstars.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class playlistsDAO {
	
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int Insertuserpl(playlists playlists) {
		
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.playlistsMapper.insert", playlists);
		session.close();
		return cnt;
	}

	public List<playlists> getpl(String sp_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		List<playlists> playlist = session.selectList("com.crawlstars.database.playlistsMapper.getpl",sp_id);
		session.close();
		return playlist;
	}

}
