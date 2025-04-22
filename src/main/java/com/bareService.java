package com;

import java.util.List;
import java.util.Map;

public interface bareService {

	//저장
	public int save(Map<String, Object> resMap) throws Exception;
	
	//대기자 등록
	public int waitClass(Map<String, Object> resMap) throws Exception;
	
	//대기자 조회
	public int waitClassCheck(Map<String, Object> resMap) throws Exception;
	
	//이메일 중복조회
	public int checkMail(Map<String, Object> resMap) throws Exception;
	
	//유저 티켓 조회
	public int userTicketCheck(Map<String, Object> resMap) throws Exception;
	
	//유저 예약 조회
	public int userBookCheck(Map<String, Object> resMap) throws Exception;
	
	//로그인
	public Map<String, Object> login(Map<String, Object> resMap) throws Exception;

	//스케줄 조회
	public List<Map<String, Object>> getschedule(Map<String, Object> resMap) throws Exception;
	
	//마이페이지
	public Map<String, Object> getUser(int ID) throws Exception;
	
	//계정조회
	public int checkID(Map<String, Object> resMap) throws Exception;
	
	//비밀번호 수정
	public int updatePassword(Map<String, Object> resMap) throws Exception;
	
	//일일체험권 체크
	public int updateOneday(Map<String, Object> resMap) throws Exception;
	
	//회원정보 수정
	public int updateUserInfo(Map<String, Object> resMap) throws Exception;
	
	//예약하기
	public int reserveClass(Map<String, Object> resMap) throws Exception;
	
	//예약정보 업데이트
	public int reserveUser(Map<String, Object> resMap) throws Exception;
	public int reserveUser2(Map<String, Object> resMap) throws Exception;
	
	//매장정보 조회
	public List<Map<String, String>> getStoreList() throws Exception;
	
	//티켓정보 조회
	public List<Map<String, String>> getticketList() throws Exception;
	
	//유저 예약정보 조회
	public List<Map<String, String>> getuserBookList(int ID) throws Exception;
	
	//결제저장
	public int ticketsave(Map<String, Object> resMap) throws Exception;
	
	//예약취소
	public int updateCancelTicket(Map<String, Object> resMap) throws Exception;
	
	//대기번호 업데이트
	public int waitBook(Map<String, Object> resMap) throws Exception;
	
	//티켓날짜 가져오기
	public Integer getticketDate(Map<String, Object> resMap) throws Exception;
	
	//유저 티켓정보 가져오기
	public List<Map<String, String>> getuserticketList(int ID) throws Exception;
	
	//예약정보 삭제
	public int deleteBook(Map<String, Object> resMap) throws Exception;
	
	List<Map<String, Object>> getScheduleAdmin(Map<String, Object> params);
	
	public Map<String, Object> getClassDetail(int bookId) throws Exception;
	
	public List<Map<String, Object>> getClassMembers(int bookId) throws Exception;
	
	public Map<String, String> memberDetail(int USER_ID) throws Exception;
	
	public int addClasses(Map<String, Object> resMap) throws Exception;
	
	public List<Map<String, Object>> getClassList(Map<String, Object> resMap) throws Exception;
	
	public  int getTotalClassCount(Map<String, Object> params) throws Exception;
	
	public int deleteClass(int bookId) throws Exception;
	public int updateClass(Map<String, Object> params) throws Exception;
	
    // 일정 조회 (특정 월 & 지점)
    List<Map<String, Object>> getScheduleList(Map<String, Object> map) throws Exception;

    // 일정 추가
    int insertSchedule(Map<String, Object> map) throws Exception;

    // 일정 수정
    int updateSchedule(Map<String, Object> map) throws Exception;

    // 일정 삭제
    int deleteSchedule(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getMemberList(String name, String phone, int limit, int offset);

	int getTotalMemberPages(String name, String phone, int limit);

	void deleteMember(int userId);
	
	List<Map<String, Object>> getMemberTickets(int userId);
	
	Map<String, Object> getMemberDetail(int userId);  // 회원 정보 조회
    int updateMember(Map<String, Object> memberData);  // 회원 정보 수정
    int addTicket(Map<String, Object> ticketData);  // 수강권 추가
    
    int deleteTicket(int ticketId);
    
    Map<String, Object> getPaymentInfo(int ticketId);
    int updateTicketPayment(Map<String, Object> ticketData);
    
    int getLastInsertedTicketId();
    int addPayment(Map<String, Object> map);
    
    List<Map<String, Object>> getAllUsedTickets(int userId);
    
    boolean cancelReservation(int bookId, int userId) throws Exception;
    
    int addTeacher(String name, String phone);
    int updateTeacher(String oldName, String newName, String phone);
    int deleteTeacher(String name);
    
    int addTicketadmin(Map<String, Object> ticketData);
    int updateTicketadmin(Map<String, Object> ticketData);
    int deleteTicketadmin(String name);
    
    int addLocation(Map<String, Object> location);
    int updateLocation(Map<String, Object> location);
    int deleteLocation(String location);

	public Map<String, Object> getPaymentKey(String place) throws Exception;

	public void decreasePeople(int bookId);

	public List<Map<String, String>> getuserWaitList(int userID) throws Exception;

	public int deletewaitList(Map<String, Object> map) throws Exception;
	
	// 매출 목록 조회
	List<Map<String, Object>> getSalesList(Map<String, Object> params) throws Exception;

	// 매출 데이터 개수 조회 (페이징 처리용)
	int getSalesCount(Map<String, Object> params) throws Exception;

	public int updateUserCash(Map<String, Object> map);

	public Map<String, Object> getSalesSummary(Map<String, String> params);
	
	List<Map<String, Object>> getFilteredMemberList(Map<String, Object> filter);
	
	// service.java
	List<Map<String, Object>> getFilteredClassList(Map<String, Object> filter);

    String getContent(String id);
    void updateContent(String id, String content);


} 
