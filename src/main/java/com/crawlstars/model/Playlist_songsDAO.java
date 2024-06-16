package com.crawlstars.model;

import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class Playlist_songsDAO {

	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();

	
}
