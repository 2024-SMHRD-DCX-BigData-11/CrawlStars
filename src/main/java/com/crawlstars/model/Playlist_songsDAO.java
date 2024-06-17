package com.crawlstars.model;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class Playlist_songsDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	public int insertplsong(Playlist_songs playlistsongs) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.playlist_songsMapper.insert", playlistsongs);
		return cnt;
	}

	
}
