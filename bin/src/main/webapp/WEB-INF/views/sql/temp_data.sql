-- id, 비밀번호
INSERT INTO hotel_admin VALUES('ADMIN', '0000');
INSERT INTO hotel_admin VALUES('매니저', '0000');

-- id, 비밀번호, 이름, 성별, 전화번호, 주소, 이메일, 포인트, 가입일
INSERT INTO hotel_user VALUES('id1', '0000', '사용자1', '남성', '01000000000', '서울시 마포구 서교동', 'id1@naver.com', DEFAULT, SYSDATE);
INSERT INTO hotel_user VALUES('id2', '0000', '사용자2', '여성', '01011111111', '서울시 서초구 반포동', 'id2@naver.com', DEFAULT, SYSDATE);
INSERT INTO hotel_user VALUES('id3', '0000', '사용자3', '여성', '01022222222', '포항시 북구 두호동', 'id3@naver.com', DEFAULT, SYSDATE);
INSERT INTO hotel_user VALUES('id4', '0000', '사용자4', '남성', '01033333333', '인천광역시 부평구 부평동', 'id4@naver.com', DEFAULT, SYSDATE);

-- 게시물 번호, 작성자id, 제목, 내용, 조회수, 작성일
INSERT INTO info VALUES(1, 'ADMIN', '공지사항1', '공지사항1 내용', DEFAULT, SYSDATE);
INSERT INTO info VALUES(2, 'ADMIN', '공지사항2', '공지사항2 내용', DEFAULT, SYSDATE);
INSERT INTO info VALUES(3, '매니저', '공지사항3', '공지사항3 내용', DEFAULT, SYSDATE);
INSERT INTO info VALUES(4, '매니저', '공지사항4', '공지사항4 내용', DEFAULT, SYSDATE);

-- 게시물 번호, 작성자id, 제목, 내용, 원본게시물 번호, 답변 출력 순서, 작성일, 조회수, 이미지
INSERT INTO qna VALUES(1, 'id1', '질문1', '질문1 내용', 1, 0, SYSDATE, DEFAULT, 'qna1.jpg');
INSERT INTO qna VALUES(2, 'id2', '질문2', '질문2 내용', 2, 0, SYSDATE, DEFAULT, 'qna2.jpg');
INSERT INTO qna VALUES(3, 'id3', '질문3', '질문3 내용', 3, 0, SYSDATE, DEFAULT, 'qna3.jpg');
INSERT INTO qna VALUES(4, 'id4', '질문4', '질문4 내용', 4, 0, SYSDATE, DEFAULT, 'qna4.jpg');
INSERT INTO qna VALUES(5, 'ADMIN', 're:질문2', '질문2 내용에 대한 답변', 2, 1, SYSDATE, DEFAULT, 'qna2-1.jpg');
INSERT INTO qna VALUES(6, '매니저', 're:질문4', '질문4 내용에 대한 답변', 4, 1, SYSDATE, DEFAULT, 'qna4-1.jpg');

-- 방 호수, 방 이름, 가격, 방 설명, 이미지, 방 크기
INSERT INTO room VALUES(101, 'STANDARD', 400000, 'STANDARD Room', 'DELUXE_KING_POOLSIDE', 46.7);
INSERT INTO room VALUES(102, 'STANDARD', 400000, 'STANDARD Room', 'DELUXE_KING_POOLSIDE', 46.7);
INSERT INTO room VALUES(103, 'STANDARD', 400000, 'STANDARD Room', 'DELUXE_KING_POOLSIDE', 46.7);
INSERT INTO room VALUES(201, 'DELUXE', 600000, 'DELUXE Room', 'PREMIER_SUITE', 77.5);
INSERT INTO room VALUES(202, 'DELUXE', 600000, 'DELUXE Room', 'PREMIER_SUITE', 77.5);
INSERT INTO room VALUES(203, 'DELUXE', 600000, 'DELUXE Room', 'PREMIER_SUITE', 77.5);
INSERT INTO room VALUES(301, 'SUITE', 1000000, 'SUITE Room', 'HILL_STUDIO_SUITE_TWIN', 95.1);
INSERT INTO room VALUES(302, 'SUITE', 1000000, 'SUITE Room', 'HILL_STUDIO_SUITE_TWIN', 95.1);
INSERT INTO room VALUES(303, 'SUITE', 1000000, 'SUITE Room', 'HILL_STUDIO_SUITE_TWIN', 95.1);
INSERT INTO room VALUES(401, 'PRESTIGE', 2000000, 'PRESTIGE Room', 'PRESTIGE_HILL_SUITE_O', 193.1);
INSERT INTO room VALUES(402, 'PRESTIGE', 2000000, 'PRESTIGE Room', 'PRESTIGE_HILL_SUITE_O', 193.1);
INSERT INTO room VALUES(403, 'PRESTIGE', 2000000, 'PRESTIGE Room', 'PRESTIGE_HILL_SUITE_O', 193.1);

-- 예약번호, 예약id, 객실 이름, 객실 호수, 예약일, 체크인 날짜, 체크아웃 날짜, 숙박일수, 성인 인원수, 어린이 인원수, 성인 조식 수, 어린이 조식 수, 엑스트라 베드 수, 총 가격, 요청사항
-- 체크인, 체크아웃 시간은 기본적으로 정해져있으므로 날짜만 입력, 조식은 자동으로 투숙일 만큼 제공
-- 임의로 성인조식 5만, 어린이 조식 2.5만, 엑스트라베드 10만으로 계산했습니다.
INSERT INTO reserve VALUES(1, 'id1', 'STANDARD', 101, SYSDATE, '2021-06-10', '2021-06-13', 3, 1, 0, 1, 0, 0, 1350000, '요청사항');
INSERT INTO reserve VALUES(2, 'id2', 'DELUXE', 201, SYSDATE, '2021-06-10', '2021-06-13', 3, 2, 0, 2, 0, 0, 2100000, '요청사항');
INSERT INTO reserve VALUES(3, 'id3', 'SUITE', 301, SYSDATE, '2021-06-10', '2021-06-13', 3, 2, 1, 2, 1, 1, 3600000, '요청사항');
INSERT INTO reserve VALUES(4, 'id4', 'PRESTIGE', 401, SYSDATE, '2021-06-10', '2021-06-13', 3, 2, 2, 2, 2, 2, 7050000, '요청사항');
INSERT INTO reserve VALUES(5, 'id2', 'STANDARD', 102, SYSDATE, '2021-06-11', '2021-06-14', 3, 1, 0, 1, 0, 0, 1350000, '요청사항');
INSERT INTO reserve VALUES(6, 'id3', 'DELUXE', 202, SYSDATE, '2021-06-11', '2021-06-14', 3, 2, 0, 2, 0, 0, 2100000, '요청사항');
INSERT INTO reserve VALUES(7, 'id4', 'SUITE', 302, SYSDATE, '2021-06-11', '2021-06-14', 3, 2, 1, 2, 1, 1, 3600000, '요청사항');
INSERT INTO reserve VALUES(8, 'id5', 'PRESTIGE', 402, SYSDATE, '2021-06-11', '2021-06-14', 3, 2, 2, 2, 2, 2, 7050000, '요청사항');
INSERT INTO reserve VALUES(9, 'id3', 'STANDARD', 103, SYSDATE, '2021-06-12', '2021-06-15', 3, 1, 0, 1, 0, 0, 1350000, '요청사항');
INSERT INTO reserve VALUES(10, 'id4', 'DELUXE', 203, SYSDATE, '2021-06-12', '2021-06-15', 3, 2, 0, 2, 0, 0, 2100000, '요청사항');
INSERT INTO reserve VALUES(11, 'id1', 'SUITE', 303, SYSDATE, '2021-06-12', '2021-06-15', 3, 2, 1, 2, 1, 1, 3600000, '요청사항');
INSERT INTO reserve VALUES(12, 'id2', 'PRESTIGE', 403, SYSDATE, '2021-06-12', '2021-06-15', 3, 2, 2, 2, 2, 2, 7050000, '요청사항');

INSERT INTO reserve VALUES(13, 'id1', 'STANDARD', 101, SYSDATE, '2021-06-14', '2021-06-17', 3, 1, 0, 1, 0, 0, 1350000, '요청사항');
INSERT INTO reserve VALUES(14, 'id2', 'DELUXE', 201, SYSDATE, '2021-06-14', '2021-06-17', 3, 2, 0, 2, 0, 0, 2100000, '요청사항');
INSERT INTO reserve VALUES(15, 'id3', 'SUITE', 301, SYSDATE, '2021-06-14', '2021-06-17', 3, 2, 1, 2, 1, 1, 3600000, '요청사항');
INSERT INTO reserve VALUES(16, 'id4', 'PRESTIGE', 401, SYSDATE, '2021-06-14', '2021-06-17', 3, 2, 2, 2, 2, 2, 7050000, '요청사항');
INSERT INTO reserve VALUES(17, 'id2', 'STANDARD', 102, SYSDATE, '2021-06-15', '2021-06-18', 3, 1, 0, 1, 0, 0, 1350000, '요청사항');
INSERT INTO reserve VALUES(18, 'id3', 'DELUXE', 202, SYSDATE, '2021-06-15', '2021-06-18', 3, 2, 0, 2, 0, 0, 2100000, '요청사항');
INSERT INTO reserve VALUES(19, 'id4', 'SUITE', 302, SYSDATE, '2021-06-15', '2021-06-18', 3, 2, 1, 2, 1, 1, 3600000, '요청사항');
INSERT INTO reserve VALUES(20, 'id5', 'PRESTIGE', 402, SYSDATE, '2021-06-15', '2021-06-18', 3, 2, 2, 2, 2, 2, 7050000, '요청사항');
INSERT INTO reserve VALUES(21, 'id3', 'STANDARD', 103, SYSDATE, '2021-06-16', '2021-06-19', 3, 1, 0, 1, 0, 0, 1350000, '요청사항');
INSERT INTO reserve VALUES(22, 'id4', 'DELUXE', 203, SYSDATE, '2021-06-16', '2021-06-19', 3, 2, 0, 2, 0, 0, 2100000, '요청사항');
INSERT INTO reserve VALUES(23, 'id1', 'SUITE', 303, SYSDATE, '2021-06-16', '2021-06-19', 3, 2, 1, 2, 1, 1, 3600000, '요청사항');
INSERT INTO reserve VALUES(24, 'id2', 'PRESTIGE', 403, SYSDATE, '2021-06-16', '2021-06-19', 3, 2, 2, 2, 2, 2, 7050000, '요청사항');

INSERT INTO reserve VALUES(25, 'id1', 'STANDARD', 101, SYSDATE, '2021-06-09', '2021-06-10', 3, 1, 0, 1, 0, 0, 1350000, '요청사항');
