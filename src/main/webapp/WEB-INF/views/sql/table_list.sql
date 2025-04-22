CREATE TABLE HOTEL_USER                                     -- 회원 테이블
(
    user_id       VARCHAR2(20)     PRIMARY KEY,             -- 회원 아이디
    user_pwd      VARCHAR2(20)     NOT NULL,                -- 회원 비밀번호
    user_name     VARCHAR2(30)     NOT NULL,                -- 회원 이름
    user_gen      VARCHAR2(20)     NOT NULL,                -- 회원 성별(male, female 또는 남성, 여성 - 구현하기 편한 쪽으로)
    user_phone    VARCHAR2(20)     NOT NULL,                -- 회원 전화번호
    user_addr     VARCHAR2(500)    NOT NULL,                -- 회원 주소
    user_email    VARCHAR2(100)    NOT NULL,                -- 회원 이메일
    user_point    NUMBER(10)       DEFAULT 0 NOT NULL,      -- 회원 포인트
    user_date     DATE             NOT NULL                 -- 회원 가입일(sysdate)
);
 
CREATE TABLE HOTEL_ADMIN                                    -- 관리자 테이블
(
    admin_id      VARCHAR2(20)    PRIMARY KEY,               -- 관리자 아이디
    admin_pwd     VARCHAR2(20)    NOT NULL                   -- 관리자 비밀번호
);

CREATE TABLE INFO                                           -- 공지사항 테이블
(
    info_no         NUMBER(5)       PRIMARY KEY,            -- 공지사항 번호
    admin_id        VARCHAR2(20)    NOT NULL,               -- 작성자 아이디
    info_title      VARCHAR2(100)    NOT NULL,               -- 공지사항 제목
    info_content    VARCHAR2(4000)    NOT NULL,              -- 공지사항 내용
    info_hit        NUMBER(5)       DEFAULT 0 NOT NULL,     -- 공지사항 조회수
    info_date       DATE            NOT NULL                -- 공지사항 작성일(sysdate)
);

CREATE TABLE reserve                                        -- 예약 테이블
(
    res_no          NUMBER(5)         PRIMARY KEY,          -- 예약 번호
    user_id         VARCHAR2(20)      NOT NULL,             -- 회원 아이디
    room_name       VARCHAR2(30)      NOT NULL,             -- 객실 이름
    room_number		NUMBER(5)		  NOT NULL, 			-- 객실 호수
    res_date        DATE              NOT NULL,             -- 예약 날짜(sysdate)
    res_in          VARCHAR2(50)      NOT NULL,             -- 체크인 날짜
    res_out         VARCHAR2(50)      NOT NULL,             -- 체크아웃 날짜
    res_NoD			NUMBER(5)		  NOT NULL,				-- 숙박일수(NOD : Number of Day의 약자)
    res_adult       NUMBER(5)         DEFAULT 0 NOT NULL,   -- 어른 인원수
    res_child       NUMBER(5)         DEFAULT 0 NOT NULL,   -- 어린이 인원수
    res_adult_br    NUMBER(5)         DEFAULT 0 NOT NULL,   -- 어른 조식 갯수
    res_child_br    NUMBER(5)         DEFAULT 0 NOT NULL,   -- 어린이 조식 갯수
    res_bed			NUMBER(5)		  DEFAULT 0 NOT NULL,	-- 엑스트라 베드 갯수
    res_total       NUMBER(20)        NOT NULL,             -- 총 가격
    res_request     VARCHAR2(1000)                          -- 요청사항
);

CREATE TABLE QNA                                            -- QnA 테이블
(
    qna_no         NUMBER(5)         PRIMARY KEY,           -- 게시물 번호
    user_id        VARCHAR2(20)      NOT NULL,              -- 회원 아이디
    qna_title      VARCHAR2(100)     NOT NULL,              -- 게시물 제목
    qna_content    VARCHAR2(4000)    NOT NULL,              -- 게시물 내용
    qna_group      NUMBER(5)         NOT NULL,              -- 원본 게시물 번호
    qna_step       NUMBER(5)         NOT NULL,              -- 답변 출력 순서
    qna_date       DATE              NOT NULL,              -- 게시물 작성일(sysdate)
    qna_hit        NUMBER(5)         DEFAULT 0 NOT NULL,    -- 게시물 조회수
    qna_file       VARCHAR2(500)                            -- 첨부 파일명
);

CREATE TABLE room                                           -- 객실 테이블
(
	room_number		NUMBER(5)		 PRIMARY KEY, 			-- 객실 호수
    room_name       VARCHAR2(30)     NOT NULL,           	-- 객실 이름
    room_price      NUMBER(10)       NOT NULL,              -- 가격
    room_content    VARCHAR2(100)    NOT NULL,              -- 상세정보
    room_image      VARCHAR2(500)    NOT NULL,              -- 이미지 파일명
    room_size       NUMBER(5,2)      NOT NULL               -- 객실 크기(소수점 2자리 까지)
);