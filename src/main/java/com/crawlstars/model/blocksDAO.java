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
	
	public List<blocks> getBlockusers(String myuser){
		SqlSession session = sqlSessionFactory.openSession(true);
		List<blocks> blocks = session.selectList("com.crawlstars.database.blocksMapper.getBlockusers", myuser);
		session.close();
		return blocks;
    }
	
	public List<String> getNickByBlockuserId(String myuser) {
        SqlSession session = sqlSessionFactory.openSession(true);
        List<String> blockuser_nick = session.selectList("com.crawlstars.database.blocksMapper.getNickByBlockuserId", myuser);
        session.close();
        return blockuser_nick;
	}
	
	public boolean deleteBlockuser(String sp_id, String block_sp_id) {
        SqlSession session = sqlSessionFactory.openSession(true);
        try {
            int BLdlt = session.delete("com.crawlstars.database.blocksMapper.blockCancel", new blocks(sp_id, block_sp_id));
            System.out.println(sp_id);
    		System.out.println(block_sp_id);
            return BLdlt > 0;
        } finally {
            session.close();
        }
    }
}
