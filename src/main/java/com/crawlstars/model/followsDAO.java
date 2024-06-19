package com.crawlstars.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class followsDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	public List<follows> getFollowers(String followee){
		SqlSession session = sqlSessionFactory.openSession(true);
		List<follows> followers = session.selectList("com.crawlstars.database.followsMapper.getFollowers", followee);
		session.close();
		return followers;
    }
	
	public int follower_cnt() {
		SqlSession session = sqlSessionFactory.openSession(true);
		int FLcnt = session.insert("com.crawlstars.database.followsMapper.follower_cnt");
		session.close();
		return FLcnt;
	}
	
	public List<follows> getFollowees(String follower){
		SqlSession session = sqlSessionFactory.openSession(true);
		List<follows> followees = session.selectList("com.crawlstars.database.followsMapper.getFollowees", follower);
		session.close();
		return followees;
    }
	
	public String getNickByfolloweeId(String follower) {
        SqlSession session = sqlSessionFactory.openSession(true);
        String follower_nick = session.selectOne("com.crawlstars.database.followsMapper.getNickByfolloweeId", follower);
        session.close();
        return follower_nick;
	}
	
	public String getNickByfollowerId(String followee) {
        SqlSession session = sqlSessionFactory.openSession(true);
        String followee_nick = session.selectOne("com.crawlstars.database.followsMapper.getNickByfollowerId", followee);
        session.close();
        return followee_nick;
	}
	
	public boolean deleteFollower(String follower, String followee) {
        SqlSession session = sqlSessionFactory.openSession(true);
        try {
            int FLdlt = session.delete("com.crawlstars.database.followsMapper.followCancel", new follows(follower, followee));
            System.out.println(follower);
    		System.out.println(followee);
            return FLdlt > 0;
        } finally {
            session.close();
        }
    }

}
