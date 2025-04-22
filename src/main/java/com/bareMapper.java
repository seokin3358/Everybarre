package com;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface bareMapper {

	public int save(Map<String, Object> resMap) throws Exception;
	
	public int waitClass(Map<String, Object> resMap) throws Exception;
	
	public int checkMail(Map<String, Object> resMap) throws Exception;
	
	public Map<String, Object> login(Map<String, Object> resMap) throws Exception;
	
	public List<Map<String, Object>> getschedule(Map<String, Object> resMap) throws Exception;
	
	public Map<String, Object> getUser(int ID) throws Exception;
	
	public int checkID(Map<String, Object> resMap) throws Exception;
	
	public int updatePassword(Map<String, Object> resMap) throws Exception;
	
	public int updateOneday(Map<String, Object> resMap) throws Exception;
	
	public List<Map<String, String>> getStoreList() throws Exception;
	
	public List<Map<String, String>> getticketList() throws Exception;
	
	public int ticketsave(Map<String, Object> resMap) throws Exception;
	
	public int updateCancelTicket(Map<String, Object> resMap) throws Exception;
	
	public Integer getticketDate(Map<String, Object> resMap) throws Exception;
	
	public List<Map<String, String>> getuserticketList(int ID) throws Exception;
	
	public List<Map<String, String>> getuserBookList(int ID) throws Exception;
	
	public int updateUserInfo(Map<String, Object> resMap) throws Exception;
	
	public int reserveClass(Map<String, Object> resMap) throws Exception;
	
	public int reserveUser(Map<String, Object> resMap) throws Exception;
	
	public int reserveUser2(Map<String, Object> resMap) throws Exception;
	
	public int userTicketCheck(Map<String, Object> resMap) throws Exception;
	
	public int userBookCheck(Map<String, Object> resMap) throws Exception;
	
	public int waitBook(Map<String, Object> resMap) throws Exception;
	
	public int waitClassCheck(Map<String, Object> resMap) throws Exception;
	
	public int deleteBook(Map<String, Object> resMap) throws Exception;
	
	List<Map<String, Object>> getScheduleAdmin(Map<String, Object> params);
	
	public Map<String, Object> getClassDetail(int bookId) throws Exception;
	
	public List<Map<String, Object>> getClassMembers(int bookId) throws Exception;
	
	public List<Map<String, Object>> getClassList(Map<String, Object> resMap) throws Exception;
	
	public Map<String, String> memberDetail(int USER_ID) throws Exception;
	
	public int addClasses(Map<String, Object> resMap) throws Exception;
	
	public int getTotalClassCount(Map<String, Object> params) throws Exception;
	
	public int updateClass(Map<String, Object> params) throws Exception;
	
	 // 일정 조회 (특정 월 & 지점)
    List<Map<String, Object>> getScheduleList(Map<String, Object> map) throws Exception;

    // 일정 추가
    int insertSchedule(Map<String, Object> map) throws Exception;

    // 일정 수정
    int updateSchedule(Map<String, Object> map) throws Exception;

    // 일정 삭제
    int deleteSchedule(Map<String, Object> map) throws Exception;

	public int deleteClass(int bookId);

	public List<Map<String, Object>> getMemberList(String name, String phone, int limit, int offset);

	public int getTotalMemberCount(String name, String phone);

	public void deleteMember(int userId);
	
	Map<String, Object> getMemberDetail(int userId);
    List<Map<String, Object>> getMemberTickets(int userId);
    int updateMember(Map<String, Object> memberData);
    int addTicket(Map<String, Object> ticketData);
    
    int deleteTicket(int ticketId);
    
    int addPayment(Map<String, Object> ticketData);

	public Map<String, Object> getPaymentInfo(int ticketId);

	public int updateTicket(Map<String, Object> ticketData);

	public int updatePayment(Map<String, Object> ticketData);
	
	int getLastInsertedTicketId();
	
	List<Map<String, Object>> getAllUsedTickets(int userId);

    // 예약 취소 (MEMBER_BOOK에서 삭제)
    int cancelReservation(@Param("bookId") int bookId, @Param("userId") int userId);

    // 강좌 정보 가져오기 (PEOPLE, MAXPEOPLE, WAITNUMBER)
    Map<String, Object> getClassInfo(@Param("bookId") int bookId);

    // PEOPLE 감소
    int decreasePeople(@Param("bookId") int bookId);

    // 대기자 중 가장 오래된 사람 가져오기
    Map<String, Object> getOldestWaitUser(@Param("bookId") int bookId);

    // WAIT_LIST -> MEMBER_BOOK으로 이동 (대기자 자동 등록)
    int moveWaitUserToMemberBook(Map<String, Object> waitUserData);

    // 대기자 리스트에서 삭제
    int deleteWaitUser(@Param("userId") int userId, @Param("bookId") int bookId);

	public void decreaseWaitPeople(@Param("bookId") int bookId);
	
	int addTeacher(String name, String phone);
    int updateTeacher(String oldName, String newName, String phone);
    int deleteTeacher(String name);
    
    int addTicketadmin(Map<String, Object> ticketData);
    int updateTicketadmin(Map<String, Object> ticketData);
    int deleteTicketadmin(String name);
    
    int addLocation(Map<String, Object> location);
    int updateLocation(Map<String, Object> location);
    int deleteLocation(String location);
    
    int cancelPayment(int ticketId);
    
    public Map<String, Object> getPaymentKey(String place);

	public int getuserTicket(Map<String, Object> resMap);
	
	public List<Map<String, String>> getuserWaitList(int userID);
	
	public int deletewaitList(Map<String, Object> map) throws Exception;
	
	// 매출 목록 조회
	List<Map<String, Object>> getSalesList(Map<String, Object> params) throws Exception;

	// 매출 데이터 개수 조회
	int getSalesCount(Map<String, Object> params) throws Exception;
	
	public int updateUserCash(Map<String, Object> map);

	public int getUserCash(Map<String, Object> map);
	
	public Map<String, Object> getSalesSummary(Map<String, String> params);
	
	List<Map<String, Object>> getFilteredMemberList(Map<String, Object> filter);
	// service.java
	List<Map<String, Object>> getFilteredClassList(Map<String, Object> filter);
	
    String getContentById(String id);
    void updateContent(Map<String, String> param);

}
