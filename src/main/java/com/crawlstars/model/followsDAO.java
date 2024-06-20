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
	
	public int follower_cnt(String sp_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int FLcnt = session.selectOne("com.crawlstars.database.followsMapper.follower_cnt", sp_id);
		session.close();
		return FLcnt;
	}
	
	public int followee_cnt(String sp_id) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int FLcnt = session.selectOne("com.crawlstars.database.followsMapper.followee_cnt", sp_id);
		session.close();
		return FLcnt;
	}
	
	public List<follows> getFollowees(String follower){
		SqlSession session = sqlSessionFactory.openSession(true);
		List<follows> followees = session.selectList("com.crawlstars.database.followsMapper.getFollowees", follower);
		session.close();
		return followees;
    }
	
	public List<String> getNickByfolloweeId(String follower) {
        SqlSession session = sqlSessionFactory.openSession(true);
        List<String> follower_nick = session.selectList("com.crawlstars.database.followsMapper.getNickByfolloweeId", follower);
        session.close();
        return follower_nick;
	}
	
	public List<String> getNickByfollowerId(String followee) {
        SqlSession session = sqlSessionFactory.openSession(true);
        List<String> followee_nick = session.selectList("com.crawlstars.database.followsMapper.getNickByfollowerId", followee);
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
