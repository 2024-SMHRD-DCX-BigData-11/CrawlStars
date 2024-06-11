package com.crawlstars.database;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SqlSessionManager {    
	public static SqlSessionFactory sqlSessionFactory;

   static {
      String resource = "com/crawlstars/database/mybatis-config.xml";       
      Reader reader;
      try {
         reader = Resources.getResourceAsReader(resource);
         //SqlSessionFactory : SqlSession(db연결, Sql 실행, 트랜잭션 관리) 생성
         sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
      } catch (IOException e) {
         e.printStackTrace();
      }
   }
   
   // DAO에서 호출해서 쓸거임
   public static SqlSessionFactory getSqlSession() {
      return sqlSessionFactory;
   }
}