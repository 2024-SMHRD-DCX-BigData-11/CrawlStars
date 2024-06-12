-- 테이블 순서는 관계를 고려하여 한 번에 실행해도 에러가 발생하지 않게 정렬되었습니다.

-- users Table Create SQL
-- 테이블 생성 SQL - users
CREATE TABLE users
(
    sp_id     VARCHAR2(50)      NOT NULL, 
    nick         VARCHAR2(30)      NOT NULL, 
    gender       CHAR(1)           NOT NULL, 
    birthdate    VARCHAR(50)       NOT NULL, 
    user_img     VARCHAR2(1000)    NOT NULL, 
    joined_at    DATE              DEFAULT SYSDATE NOT NULL, 
    user_type    CHAR(1)           NOT NULL, 
     PRIMARY KEY (sp_id)
);

-- 테이블 Comment 설정 SQL - users
COMMENT ON TABLE users IS '회원';

-- 컬럼 Comment 설정 SQL - users.sp_id
COMMENT ON COLUMN users.sp_id IS '회원 이메일';

-- 컬럼 Comment 설정 SQL - users.nick
COMMENT ON COLUMN users.nick IS '회원 닉네임';

-- 컬럼 Comment 설정 SQL - users.gender
COMMENT ON COLUMN users.gender IS '회원 성별';

-- 컬럼 Comment 설정 SQL - users.birthdate
COMMENT ON COLUMN users.birthdate IS '회원 생년월일';

-- 컬럼 Comment 설정 SQL - users.user_img
COMMENT ON COLUMN users.user_img IS '회원 프로필 이미지';

-- 컬럼 Comment 설정 SQL - users.joined_at
COMMENT ON COLUMN users.joined_at IS '회원 가입일자';

-- 컬럼 Comment 설정 SQL - users.user_type
COMMENT ON COLUMN users.user_type IS '회원 유형';

-- Unique Index 설정 SQL - users(nick)
CREATE UNIQUE INDEX UQ_users_1
    ON users(nick);


-- posts Table Create SQL
-- 테이블 생성 SQL - posts
CREATE TABLE posts
(
    post_id       NUMBER(18, 0)     NOT NULL, 
    post_title    VARCHAR(800)      NOT NULL, 
    pl_id         NUMBER(18, 0)     NULL, 
    pl_title      VARCHAR2(800)     NOT NULL, 
    sp_id      VARCHAR2(50)      NOT NULL, 
    post_body     CLOB              NOT NULL, 
    post_img      VARCHAR2(1000)    NOT NULL, 
    created_at    DATE              DEFAULT SYSDATE NOT NULL, 
    updated_at    DATE              NULL, 
     PRIMARY KEY (post_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - posts.post_id
CREATE SEQUENCE posts_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - posts.post_id
CREATE OR REPLACE TRIGGER posts_AI_TRG
BEFORE INSERT ON posts 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT posts_SEQ.NEXTVAL
    INTO :NEW.post_id
    FROM DUAL
END;

-- DROP TRIGGER posts_AI_TRG; 

-- DROP SEQUENCE posts_SEQ; 

-- 테이블 Comment 설정 SQL - posts
COMMENT ON TABLE posts IS '게시글';

-- 컬럼 Comment 설정 SQL - posts.post_id
COMMENT ON COLUMN posts.post_id IS '글 식별자';

-- 컬럼 Comment 설정 SQL - posts.post_title
COMMENT ON COLUMN posts.post_title IS '글 제목';

-- 컬럼 Comment 설정 SQL - posts.pl_id
COMMENT ON COLUMN posts.pl_id IS '플레이리스트 식별자';

-- 컬럼 Comment 설정 SQL - posts.pl_title
COMMENT ON COLUMN posts.pl_title IS '플레이리스트 제목';

-- 컬럼 Comment 설정 SQL - posts.sp_id
COMMENT ON COLUMN posts.sp_id IS '회원 이메일';

-- 컬럼 Comment 설정 SQL - posts.post_body
COMMENT ON COLUMN posts.post_body IS '글 내용';

-- 컬럼 Comment 설정 SQL - posts.post_img
COMMENT ON COLUMN posts.post_img IS '첨부 이미지';

-- 컬럼 Comment 설정 SQL - posts.created_at
COMMENT ON COLUMN posts.created_at IS '등록 일자';

-- 컬럼 Comment 설정 SQL - posts.updated_at
COMMENT ON COLUMN posts.updated_at IS '수정 일자';

-- Index 설정 SQL - posts(post_title)
CREATE INDEX IX_posts_1
    ON posts(post_title);

-- Foreign Key 설정 SQL - posts(sp_id) -> users(sp_id)
ALTER TABLE posts
    ADD CONSTRAINT FK_posts_sp_id_users_sp_ema FOREIGN KEY (sp_id)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - posts(sp_id)
-- ALTER TABLE posts
-- DROP CONSTRAINT FK_posts_sp_id_users_sp_ema;


-- playlists Table Create SQL
-- 테이블 생성 SQL - playlists
CREATE TABLE playlists
(
    pl_id         NUMBER(18, 0)     NOT NULL, 
    song          VARCHAR2(100)     NOT NULL, 
    pl_title      VARCHAR2(500)     NOT NULL, 
    sp_id      VARCHAR2(50)      NOT NULL, 
    singer        VARCHAR2(100)     NOT NULL, 
    status        CHAR(1)           NOT NULL, 
    pl_image      VARCHAR2(1000)    NOT NULL, 
    created_at    DATE              DEFAULT SYSDATE NOT NULL, 
    updated_at    DATE              NULL, 
     PRIMARY KEY (pl_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - playlists.pl_id
CREATE SEQUENCE playlists_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - playlists.pl_id
CREATE OR REPLACE TRIGGER playlists_AI_TRG
BEFORE INSERT ON playlists 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT playlists_SEQ.NEXTVAL
    INTO :NEW.pl_id
    FROM DUAL
END;

-- DROP TRIGGER playlists_AI_TRG; 

-- DROP SEQUENCE playlists_SEQ; 

-- 테이블 Comment 설정 SQL - playlists
COMMENT ON TABLE playlists IS '플레이리스트';

-- 컬럼 Comment 설정 SQL - playlists.pl_id
COMMENT ON COLUMN playlists.pl_id IS '플레이리스트 아이디';

-- 컬럼 Comment 설정 SQL - playlists.song
COMMENT ON COLUMN playlists.song IS '노래';

-- 컬럼 Comment 설정 SQL - playlists.pl_title
COMMENT ON COLUMN playlists.pl_title IS '플레이리스트 제목';

-- 컬럼 Comment 설정 SQL - playlists.sp_id
COMMENT ON COLUMN playlists.sp_id IS '회원 이메일';

-- 컬럼 Comment 설정 SQL - playlists.singer
COMMENT ON COLUMN playlists.singer IS '가수명';

-- 컬럼 Comment 설정 SQL - playlists.status
COMMENT ON COLUMN playlists.status IS '상태';

-- 컬럼 Comment 설정 SQL - playlists.pl_image
COMMENT ON COLUMN playlists.pl_image IS '플레이리스트 이미지';

-- 컬럼 Comment 설정 SQL - playlists.created_at
COMMENT ON COLUMN playlists.created_at IS '등록 일자';

-- 컬럼 Comment 설정 SQL - playlists.updated_at
COMMENT ON COLUMN playlists.updated_at IS '수정 일자';

-- Index 설정 SQL - playlists(song)
CREATE INDEX IX_playlists_1
    ON playlists(song);

-- Foreign Key 설정 SQL - playlists(sp_id) -> users(sp_id)
ALTER TABLE playlists
    ADD CONSTRAINT FK_playlists_sp_id_users_sp FOREIGN KEY (sp_id)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - playlists(sp_id)
-- ALTER TABLE playlists
-- DROP CONSTRAINT FK_playlists_sp_id_users_sp;


-- pl_replies Table Create SQL
-- 테이블 생성 SQL - pl_replies
CREATE TABLE pl_replies
(
    pl_reply_id         NUMBER(18, 0)    NOT NULL, 
    pl_id               NUMBER(18, 0)    NOT NULL, 
    pl_reply_content    VARCHAR2(900)    NOT NULL, 
    replied_at          DATE             NOT NULL, 
    sp_id            VARCHAR2(50)     NOT NULL, 
     PRIMARY KEY (pl_reply_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - pl_replies.pl_reply_id
CREATE SEQUENCE pl_replies_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - pl_replies.pl_reply_id
CREATE OR REPLACE TRIGGER pl_replies_AI_TRG
BEFORE INSERT ON pl_replies 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT pl_replies_SEQ.NEXTVAL
    INTO :NEW.pl_reply_id
    FROM DUAL
END;

-- DROP TRIGGER pl_replies_AI_TRG; 

-- DROP SEQUENCE pl_replies_SEQ; 

-- 테이블 Comment 설정 SQL - pl_replies
COMMENT ON TABLE pl_replies IS '플레이리스트 댓글';

-- 컬럼 Comment 설정 SQL - pl_replies.pl_reply_id
COMMENT ON COLUMN pl_replies.pl_reply_id IS '플레이리스트 댓글 아이디';

-- 컬럼 Comment 설정 SQL - pl_replies.pl_id
COMMENT ON COLUMN pl_replies.pl_id IS '플레이리스트  아이디';

-- 컬럼 Comment 설정 SQL - pl_replies.pl_reply_content
COMMENT ON COLUMN pl_replies.pl_reply_content IS '플레이리스트 댓글 내용';

-- 컬럼 Comment 설정 SQL - pl_replies.replied_at
COMMENT ON COLUMN pl_replies.replied_at IS '댓글 작성일자';

-- 컬럼 Comment 설정 SQL - pl_replies.sp_id
COMMENT ON COLUMN pl_replies.sp_id IS '댓글 작성자';

-- Foreign Key 설정 SQL - pl_replies(pl_id) -> playlists(pl_id)
ALTER TABLE pl_replies
    ADD CONSTRAINT FK_pl_replies_pl_id_playlists_ FOREIGN KEY (pl_id)
        REFERENCES playlists (pl_id) ;

-- Foreign Key 삭제 SQL - pl_replies(pl_id)
-- ALTER TABLE pl_replies
-- DROP CONSTRAINT FK_pl_replies_pl_id_playlists_;


-- post_replies Table Create SQL
-- 테이블 생성 SQL - post_replies
CREATE TABLE post_replies
(
    post_reply_id    NUMBER(18, 0)    NOT NULL, 
    post_id          NUMBER(18, 0)    NOT NULL, 
    reply_content    VARCHAR2(900)    NOT NULL, 
    replied_at       DATE             DEFAULT SYSDATE NOT NULL, 
    sp_id         VARCHAR2(50)     NOT NULL, 
     PRIMARY KEY (post_reply_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - post_replies.post_reply_id
CREATE SEQUENCE post_replies_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - post_replies.post_reply_id
CREATE OR REPLACE TRIGGER post_replies_AI_TRG
BEFORE INSERT ON post_replies 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT post_replies_SEQ.NEXTVAL
    INTO :NEW.post_reply_id
    FROM DUAL
END;

-- DROP TRIGGER post_replies_AI_TRG; 

-- DROP SEQUENCE post_replies_SEQ; 

-- 테이블 Comment 설정 SQL - post_replies
COMMENT ON TABLE post_replies IS '댓글';

-- 컬럼 Comment 설정 SQL - post_replies.post_reply_id
COMMENT ON COLUMN post_replies.post_reply_id IS '댓글 아이디';

-- 컬럼 Comment 설정 SQL - post_replies.post_id
COMMENT ON COLUMN post_replies.post_id IS '원글 아이디';

-- 컬럼 Comment 설정 SQL - post_replies.reply_content
COMMENT ON COLUMN post_replies.reply_content IS '댓글 내용';

-- 컬럼 Comment 설정 SQL - post_replies.replied_at
COMMENT ON COLUMN post_replies.replied_at IS '댓글 작성일자';

-- 컬럼 Comment 설정 SQL - post_replies.sp_id
COMMENT ON COLUMN post_replies.sp_id IS '댓글 작성자';

-- Foreign Key 설정 SQL - post_replies(post_id) -> posts(post_id)
ALTER TABLE post_replies
    ADD CONSTRAINT FK_post_replies_post_id_posts_ FOREIGN KEY (post_id)
        REFERENCES posts (post_id) ;

-- Foreign Key 삭제 SQL - post_replies(post_id)
-- ALTER TABLE post_replies
-- DROP CONSTRAINT FK_post_replies_post_id_posts_;

-- Foreign Key 설정 SQL - post_replies(sp_id) -> users(sp_id)
ALTER TABLE post_replies
    ADD CONSTRAINT FK_post_replies_sp_id_users FOREIGN KEY (sp_id)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - post_replies(sp_id)
-- ALTER TABLE post_replies
-- DROP CONSTRAINT FK_post_replies_sp_id_users;


-- block_users Table Create SQL
-- 테이블 생성 SQL - block_users
CREATE TABLE block_users
(
    block_id          NUMBER(18, 0)    NOT NULL, 
    sp_id          VARCHAR2(50)     NOT NULL, 
    block_sp_id    VARCHAR2(50)     NOT NULL, 
    blocked_at        DATE             NOT NULL, 
     PRIMARY KEY (block_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - block_users.block_id
CREATE SEQUENCE block_users_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - block_users.block_id
CREATE OR REPLACE TRIGGER block_users_AI_TRG
BEFORE INSERT ON block_users 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT block_users_SEQ.NEXTVAL
    INTO :NEW.block_id
    FROM DUAL
END;

-- DROP TRIGGER block_users_AI_TRG; 

-- DROP SEQUENCE block_users_SEQ; 

-- 테이블 Comment 설정 SQL - block_users
COMMENT ON TABLE block_users IS '차단 회원';

-- 컬럼 Comment 설정 SQL - block_users.block_id
COMMENT ON COLUMN block_users.block_id IS '차단 아이디';

-- 컬럼 Comment 설정 SQL - block_users.sp_id
COMMENT ON COLUMN block_users.sp_id IS '회원 아이디';

-- 컬럼 Comment 설정 SQL - block_users.block_sp_id
COMMENT ON COLUMN block_users.block_sp_id IS '차단 회원 아이디';

-- 컬럼 Comment 설정 SQL - block_users.blocked_at
COMMENT ON COLUMN block_users.blocked_at IS '차단 날짜';

-- Foreign Key 설정 SQL - block_users(sp_id) -> users(sp_id)
ALTER TABLE block_users
    ADD CONSTRAINT FK_block_users_sp_id_users_ FOREIGN KEY (sp_id)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - block_users(sp_id)
-- ALTER TABLE block_users
-- DROP CONSTRAINT FK_block_users_sp_id_users_;


-- pl_reply_hashtags Table Create SQL
-- 테이블 생성 SQL - pl_reply_hashtags
CREATE TABLE pl_reply_hashtags
(
    pl_reply_hashtag_id    NUMBER(18, 0)    NOT NULL, 
    pl_reply_id            NUMBER(18, 0)    NOT NULL, 
    hashtag                VARCHAR2(100)    NOT NULL, 
     PRIMARY KEY (pl_reply_hashtag_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - pl_reply_hashtags.pl_reply_hashtag_id
CREATE SEQUENCE pl_reply_hashtags_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - pl_reply_hashtags.pl_reply_hashtag_id
CREATE OR REPLACE TRIGGER pl_reply_hashtags_AI_TRG
BEFORE INSERT ON pl_reply_hashtags 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT pl_reply_hashtags_SEQ.NEXTVAL
    INTO :NEW.pl_reply_hashtag_id
    FROM DUAL
END;

-- DROP TRIGGER pl_reply_hashtags_AI_TRG; 

-- DROP SEQUENCE pl_reply_hashtags_SEQ; 

-- 테이블 Comment 설정 SQL - pl_reply_hashtags
COMMENT ON TABLE pl_reply_hashtags IS '플레이리스트 댓글 해시태그';

-- 컬럼 Comment 설정 SQL - pl_reply_hashtags.pl_reply_hashtag_id
COMMENT ON COLUMN pl_reply_hashtags.pl_reply_hashtag_id IS '해시태그 아이디';

-- 컬럼 Comment 설정 SQL - pl_reply_hashtags.pl_reply_id
COMMENT ON COLUMN pl_reply_hashtags.pl_reply_id IS '플레이리스트  댓글 아이디';

-- 컬럼 Comment 설정 SQL - pl_reply_hashtags.hashtag
COMMENT ON COLUMN pl_reply_hashtags.hashtag IS '해시태그 이름';

-- Foreign Key 설정 SQL - pl_reply_hashtags(pl_reply_id) -> pl_replies(pl_reply_id)
ALTER TABLE pl_reply_hashtags
    ADD CONSTRAINT FK_pl_reply_hashtags_pl_reply_ FOREIGN KEY (pl_reply_id)
        REFERENCES pl_replies (pl_reply_id) ;

-- Foreign Key 삭제 SQL - pl_reply_hashtags(pl_reply_id)
-- ALTER TABLE pl_reply_hashtags
-- DROP CONSTRAINT FK_pl_reply_hashtags_pl_reply_;


-- pl_hashtags Table Create SQL
-- 테이블 생성 SQL - pl_hashtags
CREATE TABLE pl_hashtags
(
    pl_hashtag_id    NUMBER(18, 0)    NOT NULL, 
    pl_id            NUMBER(18, 0)    NOT NULL, 
    hashtag          VARCHAR2(100)    NOT NULL, 
     PRIMARY KEY (pl_hashtag_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - pl_hashtags.pl_hashtag_id
CREATE SEQUENCE pl_hashtags_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - pl_hashtags.pl_hashtag_id
CREATE OR REPLACE TRIGGER pl_hashtags_AI_TRG
BEFORE INSERT ON pl_hashtags 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT pl_hashtags_SEQ.NEXTVAL
    INTO :NEW.pl_hashtag_id
    FROM DUAL
END;

-- DROP TRIGGER pl_hashtags_AI_TRG; 

-- DROP SEQUENCE pl_hashtags_SEQ; 

-- 테이블 Comment 설정 SQL - pl_hashtags
COMMENT ON TABLE pl_hashtags IS '플레이리스트 해시태그';

-- 컬럼 Comment 설정 SQL - pl_hashtags.pl_hashtag_id
COMMENT ON COLUMN pl_hashtags.pl_hashtag_id IS '해시태그 아이디';

-- 컬럼 Comment 설정 SQL - pl_hashtags.pl_id
COMMENT ON COLUMN pl_hashtags.pl_id IS '플레이리스트 아이디';

-- 컬럼 Comment 설정 SQL - pl_hashtags.hashtag
COMMENT ON COLUMN pl_hashtags.hashtag IS '해시태그 이름';

-- Foreign Key 설정 SQL - pl_hashtags(pl_id) -> playlists(pl_id)
ALTER TABLE pl_hashtags
    ADD CONSTRAINT FK_pl_hashtags_pl_id_playlists FOREIGN KEY (pl_id)
        REFERENCES playlists (pl_id) ;

-- Foreign Key 삭제 SQL - pl_hashtags(pl_id)
-- ALTER TABLE pl_hashtags
-- DROP CONSTRAINT FK_pl_hashtags_pl_id_playlists;


-- post_reply_hashtags Table Create SQL
-- 테이블 생성 SQL - post_reply_hashtags
CREATE TABLE post_reply_hashtags
(
    hashtag_id       NUMBER(18, 0)    NOT NULL, 
    post_reply_id    NUMBER(18, 0)    NOT NULL, 
    hashtag          VARCHAR2(100)    NOT NULL, 
     PRIMARY KEY (hashtag_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - post_reply_hashtags.hashtag_id
CREATE SEQUENCE post_reply_hashtags_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - post_reply_hashtags.hashtag_id
CREATE OR REPLACE TRIGGER post_reply_hashtags_AI_TRG
BEFORE INSERT ON post_reply_hashtags 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT post_reply_hashtags_SEQ.NEXTVAL
    INTO :NEW.hashtag_id
    FROM DUAL
END;

-- DROP TRIGGER post_reply_hashtags_AI_TRG; 

-- DROP SEQUENCE post_reply_hashtags_SEQ; 

-- 테이블 Comment 설정 SQL - post_reply_hashtags
COMMENT ON TABLE post_reply_hashtags IS '댓글 해시태그';

-- 컬럼 Comment 설정 SQL - post_reply_hashtags.hashtag_id
COMMENT ON COLUMN post_reply_hashtags.hashtag_id IS '해시태그 아이디';

-- 컬럼 Comment 설정 SQL - post_reply_hashtags.post_reply_id
COMMENT ON COLUMN post_reply_hashtags.post_reply_id IS '댓글 아이디';

-- 컬럼 Comment 설정 SQL - post_reply_hashtags.hashtag
COMMENT ON COLUMN post_reply_hashtags.hashtag IS '해시태그 이름';

-- Foreign Key 설정 SQL - post_reply_hashtags(post_reply_id) -> post_replies(post_reply_id)
ALTER TABLE post_reply_hashtags
    ADD CONSTRAINT FK_post_reply_hashtags_post_re FOREIGN KEY (post_reply_id)
        REFERENCES post_replies (post_reply_id) ;

-- Foreign Key 삭제 SQL - post_reply_hashtags(post_reply_id)
-- ALTER TABLE post_reply_hashtags
-- DROP CONSTRAINT FK_post_reply_hashtags_post_re;


-- post_hashtags Table Create SQL
-- 테이블 생성 SQL - post_hashtags
CREATE TABLE post_hashtags
(
    hashtag_id    NUMBER(18, 0)    NOT NULL, 
    post_id       NUMBER(18, 0)    NOT NULL, 
    hashtag       VARCHAR2(100)    NOT NULL, 
     PRIMARY KEY (hashtag_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - post_hashtags.hashtag_id
CREATE SEQUENCE post_hashtags_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - post_hashtags.hashtag_id
CREATE OR REPLACE TRIGGER post_hashtags_AI_TRG
BEFORE INSERT ON post_hashtags 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT post_hashtags_SEQ.NEXTVAL
    INTO :NEW.hashtag_id
    FROM DUAL
END;

-- DROP TRIGGER post_hashtags_AI_TRG; 

-- DROP SEQUENCE post_hashtags_SEQ; 

-- 테이블 Comment 설정 SQL - post_hashtags
COMMENT ON TABLE post_hashtags IS '포스트 해시 태그';

-- 컬럼 Comment 설정 SQL - post_hashtags.hashtag_id
COMMENT ON COLUMN post_hashtags.hashtag_id IS '해시태그 아이디';

-- 컬럼 Comment 설정 SQL - post_hashtags.post_id
COMMENT ON COLUMN post_hashtags.post_id IS '포스트 아이디';

-- 컬럼 Comment 설정 SQL - post_hashtags.hashtag
COMMENT ON COLUMN post_hashtags.hashtag IS '해시태그 이름';

-- Foreign Key 설정 SQL - post_hashtags(post_id) -> posts(post_id)
ALTER TABLE post_hashtags
    ADD CONSTRAINT FK_post_hashtags_post_id_posts FOREIGN KEY (post_id)
        REFERENCES posts (post_id) ;

-- Foreign Key 삭제 SQL - post_hashtags(post_id)
-- ALTER TABLE post_hashtags
-- DROP CONSTRAINT FK_post_hashtags_post_id_posts;


-- post_likes Table Create SQL
-- 테이블 생성 SQL - post_likes
CREATE TABLE post_likes
(
    like_id       NUMBER(18, 0)    NOT NULL, 
    sp_id      VARCHAR2(50)     NOT NULL, 
    post_id       NUMBER(18, 0)    NOT NULL, 
    created_at    DATE             DEFAULT SYSDATE NOT NULL, 
     PRIMARY KEY (like_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - post_likes.like_id
CREATE SEQUENCE post_likes_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - post_likes.like_id
CREATE OR REPLACE TRIGGER post_likes_AI_TRG
BEFORE INSERT ON post_likes 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT post_likes_SEQ.NEXTVAL
    INTO :NEW.like_id
    FROM DUAL
END;

-- DROP TRIGGER post_likes_AI_TRG; 

-- DROP SEQUENCE post_likes_SEQ; 

-- 테이블 Comment 설정 SQL - post_likes
COMMENT ON TABLE post_likes IS '포스트 좋아요';

-- 컬럼 Comment 설정 SQL - post_likes.like_id
COMMENT ON COLUMN post_likes.like_id IS '좋아요 아이디';

-- 컬럼 Comment 설정 SQL - post_likes.sp_id
COMMENT ON COLUMN post_likes.sp_id IS '회원 이메일';

-- 컬럼 Comment 설정 SQL - post_likes.post_id
COMMENT ON COLUMN post_likes.post_id IS '포스트 아이디';

-- 컬럼 Comment 설정 SQL - post_likes.created_at
COMMENT ON COLUMN post_likes.created_at IS '등록 일자';

-- Foreign Key 설정 SQL - post_likes(post_id) -> posts(post_id)
ALTER TABLE post_likes
    ADD CONSTRAINT FK_post_likes_post_id_posts_po FOREIGN KEY (post_id)
        REFERENCES posts (post_id) ;

-- Foreign Key 삭제 SQL - post_likes(post_id)
-- ALTER TABLE post_likes
-- DROP CONSTRAINT FK_post_likes_post_id_posts_po;

-- Foreign Key 설정 SQL - post_likes(sp_id) -> users(sp_id)
ALTER TABLE post_likes
    ADD CONSTRAINT FK_post_likes_sp_id_users_s FOREIGN KEY (sp_id)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - post_likes(sp_id)
-- ALTER TABLE post_likes
-- DROP CONSTRAINT FK_post_likes_sp_id_users_s;


-- block_posts Table Create SQL
-- 테이블 생성 SQL - block_posts
CREATE TABLE block_posts
(
    block_id      NUMBER(18, 0)    NOT NULL, 
    sp_id      VARCHAR2(50)     NOT NULL, 
    post_id       NUMBER(18, 0)    NOT NULL, 
    blocked_at    DATE             DEFAULT SYSDATE NOT NULL, 
     PRIMARY KEY (block_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - block_posts.block_id
CREATE SEQUENCE block_posts_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - block_posts.block_id
CREATE OR REPLACE TRIGGER block_posts_AI_TRG
BEFORE INSERT ON block_posts 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT block_posts_SEQ.NEXTVAL
    INTO :NEW.block_id
    FROM DUAL
END;

-- DROP TRIGGER block_posts_AI_TRG; 

-- DROP SEQUENCE block_posts_SEQ; 

-- 테이블 Comment 설정 SQL - block_posts
COMMENT ON TABLE block_posts IS '포스트 차단';

-- 컬럼 Comment 설정 SQL - block_posts.block_id
COMMENT ON COLUMN block_posts.block_id IS '차단 아이디';

-- 컬럼 Comment 설정 SQL - block_posts.sp_id
COMMENT ON COLUMN block_posts.sp_id IS '회원 아이디';

-- 컬럼 Comment 설정 SQL - block_posts.post_id
COMMENT ON COLUMN block_posts.post_id IS '포스트 아이디';

-- 컬럼 Comment 설정 SQL - block_posts.blocked_at
COMMENT ON COLUMN block_posts.blocked_at IS '차단 일자';

-- Foreign Key 설정 SQL - block_posts(post_id) -> posts(post_id)
ALTER TABLE block_posts
    ADD CONSTRAINT FK_block_posts_post_id_posts_p FOREIGN KEY (post_id)
        REFERENCES posts (post_id) ;

-- Foreign Key 삭제 SQL - block_posts(post_id)
-- ALTER TABLE block_posts
-- DROP CONSTRAINT FK_block_posts_post_id_posts_p;

-- Foreign Key 설정 SQL - block_posts(sp_id) -> users(sp_id)
ALTER TABLE block_posts
    ADD CONSTRAINT FK_block_posts_sp_id_users_ FOREIGN KEY (sp_id)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - block_posts(sp_id)
-- ALTER TABLE block_posts
-- DROP CONSTRAINT FK_block_posts_sp_id_users_;


-- follows Table Create SQL
-- 테이블 생성 SQL - follows
CREATE TABLE follows
(
    follow_id      NUMBER(18, 0)    NOT NULL, 
    follower       VARCHAR2(50)     NOT NULL, 
    followee       VARCHAR2(50)     NOT NULL, 
    flowered_at    DATE             NOT NULL, 
     PRIMARY KEY (follow_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - follows.follow_id
CREATE SEQUENCE follows_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - follows.follow_id
CREATE OR REPLACE TRIGGER follows_AI_TRG
BEFORE INSERT ON follows 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT follows_SEQ.NEXTVAL
    INTO :NEW.follow_id
    FROM DUAL
END;

-- DROP TRIGGER follows_AI_TRG; 

-- DROP SEQUENCE follows_SEQ; 

-- 테이블 Comment 설정 SQL - follows
COMMENT ON TABLE follows IS '팔로잉';

-- 컬럼 Comment 설정 SQL - follows.follow_id
COMMENT ON COLUMN follows.follow_id IS '팔로우 아이디';

-- 컬럼 Comment 설정 SQL - follows.follower
COMMENT ON COLUMN follows.follower IS '팔로워';

-- 컬럼 Comment 설정 SQL - follows.followee
COMMENT ON COLUMN follows.followee IS '팔로위';

-- 컬럼 Comment 설정 SQL - follows.flowered_at
COMMENT ON COLUMN follows.flowered_at IS '팔로우 날짜';

-- Foreign Key 설정 SQL - follows(follower) -> users(sp_id)
ALTER TABLE follows
    ADD CONSTRAINT FK_follows_follower_users_sp_e FOREIGN KEY (follower)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - follows(follower)
-- ALTER TABLE follows
-- DROP CONSTRAINT FK_follows_follower_users_sp_e;


-- like_pls Table Create SQL
-- 테이블 생성 SQL - like_pls
CREATE TABLE like_pls
(
    like_id     NUMBER(18, 0)    NOT NULL, 
    sp_id    VARCHAR2(50)     NOT NULL, 
    pl_id       NUMBER(18, 0)    NOT NULL, 
    liked_at    VARCHAR(50)      DEFAULT 'SYSDATE' NOT NULL, 
     PRIMARY KEY (like_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - like_pls.like_id
CREATE SEQUENCE like_pls_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - like_pls.like_id
CREATE OR REPLACE TRIGGER like_pls_AI_TRG
BEFORE INSERT ON like_pls 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT like_pls_SEQ.NEXTVAL
    INTO :NEW.like_id
    FROM DUAL
END;

-- DROP TRIGGER like_pls_AI_TRG; 

-- DROP SEQUENCE like_pls_SEQ; 

-- 테이블 Comment 설정 SQL - like_pls
COMMENT ON TABLE like_pls IS '선호 플레이리스트';

-- 컬럼 Comment 설정 SQL - like_pls.like_id
COMMENT ON COLUMN like_pls.like_id IS '선호 아이디';

-- 컬럼 Comment 설정 SQL - like_pls.sp_id
COMMENT ON COLUMN like_pls.sp_id IS '회원 이메일';

-- 컬럼 Comment 설정 SQL - like_pls.pl_id
COMMENT ON COLUMN like_pls.pl_id IS '플레이리스트 식별자';

-- 컬럼 Comment 설정 SQL - like_pls.liked_at
COMMENT ON COLUMN like_pls.liked_at IS '선호 일자';

-- Foreign Key 설정 SQL - like_pls(sp_id) -> users(sp_id)
ALTER TABLE like_pls
    ADD CONSTRAINT FK_like_pls_sp_id_users_sp_ FOREIGN KEY (sp_id)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - like_pls(sp_id)
-- ALTER TABLE like_pls
-- DROP CONSTRAINT FK_like_pls_sp_id_users_sp_;

-- Foreign Key 설정 SQL - like_pls(pl_id) -> playlists(pl_id)
ALTER TABLE like_pls
    ADD CONSTRAINT FK_like_pls_pl_id_playlists_pl FOREIGN KEY (pl_id)
        REFERENCES playlists (pl_id) ;

-- Foreign Key 삭제 SQL - like_pls(pl_id)
-- ALTER TABLE like_pls
-- DROP CONSTRAINT FK_like_pls_pl_id_playlists_pl;


-- block_pls Table Create SQL
-- 테이블 생성 SQL - block_pls
CREATE TABLE block_pls
(
    block_id      NUMBER(18, 0)    NOT NULL, 
    sp_id      VARCHAR2(50)     NOT NULL, 
    pl_id         NUMBER(18, 0)    NOT NULL, 
    blocked_at    VARCHAR(50)      DEFAULT 'SYSDATE' NOT NULL, 
     PRIMARY KEY (block_id)
);

-- Auto Increment를 위한 Sequence 추가 SQL - block_pls.block_id
CREATE SEQUENCE block_pls_SEQ
START WITH 1
INCREMENT BY 1;

-- Auto Increment를 위한 Trigger 추가 SQL - block_pls.block_id
CREATE OR REPLACE TRIGGER block_pls_AI_TRG
BEFORE INSERT ON block_pls 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT block_pls_SEQ.NEXTVAL
    INTO :NEW.block_id
    FROM DUAL
END;

-- DROP TRIGGER block_pls_AI_TRG; 

-- DROP SEQUENCE block_pls_SEQ; 

-- 테이블 Comment 설정 SQL - block_pls
COMMENT ON TABLE block_pls IS '차단 플레이리스트';

-- 컬럼 Comment 설정 SQL - block_pls.block_id
COMMENT ON COLUMN block_pls.block_id IS '차단 아이디';

-- 컬럼 Comment 설정 SQL - block_pls.sp_id
COMMENT ON COLUMN block_pls.sp_id IS '회원 이메일';

-- 컬럼 Comment 설정 SQL - block_pls.pl_id
COMMENT ON COLUMN block_pls.pl_id IS '플레이리스트 식별자';

-- 컬럼 Comment 설정 SQL - block_pls.blocked_at
COMMENT ON COLUMN block_pls.blocked_at IS '차단 일자';

-- Foreign Key 설정 SQL - block_pls(sp_id) -> users(sp_id)
ALTER TABLE block_pls
    ADD CONSTRAINT FK_block_pls_sp_id_users_sp FOREIGN KEY (sp_id)
        REFERENCES users (sp_id) ;

-- Foreign Key 삭제 SQL - block_pls(sp_id)
-- ALTER TABLE block_pls
-- DROP CONSTRAINT FK_block_pls_sp_id_users_sp;

-- Foreign Key 설정 SQL - block_pls(pl_id) -> playlists(pl_id)
ALTER TABLE block_pls
    ADD CONSTRAINT FK_block_pls_pl_id_playlists_p FOREIGN KEY (pl_id)
        REFERENCES playlists (pl_id) ;

-- Foreign Key 삭제 SQL - block_pls(pl_id)
-- ALTER TABLE block_pls
-- DROP CONSTRAINT FK_block_pls_pl_id_playlists_p;


select*from users;