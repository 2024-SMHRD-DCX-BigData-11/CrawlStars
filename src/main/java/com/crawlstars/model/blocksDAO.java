package com.crawlstars.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.crawlstars.database.SqlSessionManager;

public class blocksDAO {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	public int block(blocks blockusers) {
		SqlSession session = sqlSessionFactory.openSession(true);
		int cnt = session.insert("com.crawlstars.database.usersMapper.userBlock", blockusers);
		session.close();
		return cnt;
	}
	
	public List<blocks> getBlockuers(String myuser){
		SqlSession session = sqlSessionFactory.openSession(true);
		List<blocks> blocks = session.selectList("com.crawlstars.database.blocksMapper.getBlockuers", myuser);
		session.close();
		return blocks;
    }
	
	public String getNickByBlockuserId(String myuser) {
        SqlSession session = sqlSessionFactory.openSession(true);
        String blockuser_nick = session.selectOne("com.crawlstars.database.blocksMapper.getNickByBlockuserId", myuser);
        session.close();
        return blockuser_nick;
	}
	
	public boolean deleteBlockuser(String blockuser, String myuser) {
        SqlSession session = sqlSessionFactory.openSession(true);
        try {
            int BLdlt = session.delete("com.crawlstars.database.followsMapper.followCancel", new follows(blockuser, myuser));
            System.out.println(blockuser);
    		System.out.println(myuser);
            return BLdlt > 0;
        } finally {
            session.close();
        }
    }
}
