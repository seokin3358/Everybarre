package com;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



@Service
public class bareServiceImpl implements bareService{
	@Autowired
	bareMapper mapper;
	
	@Override
	public int save(Map<String, Object> resMap) throws Exception{
		return mapper.save(resMap);
	}
	
	@Override
	public int waitClass(Map<String, Object> resMap) throws Exception{
		return mapper.waitClass(resMap);
	}
	
	@Override
	public int checkMail(Map<String, Object> resMap) throws Exception{
		return mapper.checkMail(resMap);
	}
	
	@Override
	public List<Map<String, Object>> getschedule(Map<String, Object> resMap) throws Exception{
		return mapper.getschedule(resMap);
	}
	
	@Override
	public List<Map<String, Object>> getClassList(Map<String, Object> resMap) throws Exception{
		return mapper.getClassList(resMap);
	}
	
	@Override
	public int getTotalClassCount(Map<String, Object> params) throws Exception {
	    int totalClasses = mapper.getTotalClassCount(params);
	    int pageSize = 10;
	    return (int) Math.ceil((double) totalClasses / pageSize);
	}
	
	@Override
	public Map<String, Object> login(Map<String, Object> resMap) throws Exception {
	    Map<String, Object> result = mapper.login(resMap);
	    return (result != null) ? result : new HashMap<>();
	}
	
	@Override
	public int deleteClass(int bookId) throws Exception {
	    return mapper.deleteClass(bookId);
	}

	@Override
	public int updateClass(Map<String, Object> params) throws Exception {
	    return mapper.updateClass(params);
	}
	
	@Override
	public int updateUserCash(Map<String, Object> map){
		mapper.updateUserCash(map);
		
		return mapper.getUserCash(map);
	}
	
	@Override
	public Map<String, Object> getUser(int ID) throws Exception{
		return mapper.getUser(ID);
	}
	
	@Override
	public int checkID(Map<String, Object> resMap) throws Exception{
		return mapper.checkID(resMap);
	}
	
	@Override
	public int updatePassword(Map<String, Object> resMap) throws Exception{
		return mapper.updatePassword(resMap);
	}
	
	@Override
	public int updateOneday(Map<String, Object> resMap) throws Exception{
		return mapper.updateOneday(resMap);
	}

	@Override
	public Map<String, Object> getPaymentKey(String place) throws Exception{
		return mapper.getPaymentKey(place);
	}
	
	@Override
	public List<Map<String, String>> getStoreList() throws Exception{
		return mapper.getStoreList();
	}
	
	@Override
	public List<Map<String, String>> getticketList() throws Exception{
		return mapper.getticketList();
	}
	
	@Override
	public List<Map<String, String>> getuserWaitList(int userID) throws Exception{
		return mapper.getuserWaitList(userID);
	}
	
	@Override
	public int deletewaitList(Map<String, Object> map) throws Exception{
		mapper.decreaseWaitPeople(Integer.parseInt((String) map.get("bookId")));
		return mapper.deletewaitList(map);
	}
	
	@Override
	public int ticketsave(Map<String, Object> resMap) throws Exception{
		return mapper.ticketsave(resMap);
	}
	
	@Override
	public int updateCancelTicket(Map<String, Object> resMap) throws Exception{
		int res = mapper.getuserTicket(resMap);
		if(res < 1) {
			res = mapper.updateCancelTicket(resMap);
		}
		return res;
	}
	
	@Override
	public int addClasses(Map<String, Object> resMap) throws Exception{
		return mapper.addClasses(resMap);
	}
	
	@Override
	public Integer getticketDate(Map<String, Object> resMap) throws Exception{
		return mapper.getticketDate(resMap);
	}
	
	@Override
	public List<Map<String, String>> getuserticketList(int ID) throws Exception{
		return mapper.getuserticketList(ID);
	}
	
	@Override
	public List<Map<String, Object>> getMemberList(String name, String phone, int limit, int offset) {
        return mapper.getMemberList(name, phone, limit, offset);
    }

	@Override
    public int getTotalMemberPages(String name, String phone, int limit) {
        int totalCount = mapper.getTotalMemberCount(name, phone);
        return (int) Math.ceil((double) totalCount / limit);
    }

	@Override
    public void deleteMember(int userId) {
        mapper.deleteMember(userId);
    }
	
	@Override
    public Map<String, Object> getMemberDetail(int userId) {
        return mapper.getMemberDetail(userId);
    }

    @Override
    public List<Map<String, Object>> getMemberTickets(int userId) {
        return mapper.getMemberTickets(userId);
    }

    @Override
    public int updateMember(Map<String, Object> memberData) {
        return mapper.updateMember(memberData);
    }
    @Override
    public void decreasePeople(int bookId) {
    	mapper.decreasePeople(bookId);
    	return;
    }

    @Override
    public int addTicket(Map<String, Object> ticketData) {
    	// 수강권 추가
        int ticketResult = mapper.addTicket(ticketData);

        // 결제 정보 추가 (결제 내역이 있는 경우)
        if (ticketResult > 0) {
            int paymentResult = mapper.addPayment(ticketData);
            return paymentResult;
        }
        return 0;
    }
    
    @Override
    public List<Map<String, Object>> getAllUsedTickets(int userId) {
        return mapper.getAllUsedTickets(userId);
    }
    
    @Transactional
    @Override
    public boolean cancelReservation(int bookId, int userId) throws Exception {
        // 1️⃣ 예약 취소 (MEMBER_BOOK에서 삭제)
        int cancelResult = mapper.cancelReservation(bookId, userId);
        if (cancelResult <= 0) {
            return false; // 취소 실패
        }
        
        // 2️⃣ 현재 수업 정보 가져오기 (PEOPLE, MAXPEOPLE, WAITNUMBER)
        Map<String, Object> classInfo = mapper.getClassInfo(bookId);
        
        int currentPeople = Integer.parseInt(convertToString(classInfo.get("PEOPLE")));
        int maxPeople = Integer.parseInt(convertToString(classInfo.get("MAXPEOPLE")));
        int waitNumber = Integer.parseInt(convertToString(classInfo.get("WAITNUMBER")));       

        // 4️⃣ 만약 기존 PEOPLE == MAXPEOPLE였다면, 대기자 리스트 확인
        if (currentPeople == maxPeople && waitNumber > 0) {
            // 4-1️⃣ 대기자 중 가장 오래된 사람 가져오기
            Map<String, Object> waitingUser = mapper.getOldestWaitUser(bookId);
            if (waitingUser != null) {
                int waitUserId = Integer.parseInt(waitingUser.get("USER_ID").toString());

                mapper.decreaseWaitPeople(bookId);
                // 4-2️⃣ 대기자를 MEMBER_BOOK으로 이동하여 자동 등록
                mapper.moveWaitUserToMemberBook(waitingUser);

                // 4-3️⃣ WAIT_LIST에서 해당 대기자 삭제
                mapper.deleteWaitUser(waitUserId, bookId);
                waitingUser.put("STORE", convertToString(waitingUser.get("LOCATION")));
                waitingUser.put("CLASS_DATE",waitingUser.get("DATE"));

                mapper.reserveUser2(waitingUser);
                // 4-4️⃣ 알림 전송 (추후 구현 가능)
                Map<String, Object> rtnMap = new HashMap<String, Object>();
                rtnMap = mapper.getUser(waitUserId);
                
                String smsMessage = "[에블바레 대기 예약 확정 안내]\n"
                        + "지점: " + convertToString(waitingUser.get("LOCATION")) + "\n"
                        + "일시: " + convertToString(waitingUser.get("DATE")) + " " + convertToString(waitingUser.get("TIME")) + "\n"
                        + "클래스: " + convertToString(waitingUser.get("CLASS")) + "\n\n"
                        + "대기 중이던 수업이 예약 확정되었습니다!\n"
                        + "수업 5분 전까지 도착 부탁드립니다.\n"
                        + "※ 당일 취소 및 노쇼 시 패널티가 적용될 수 있습니다.";
                
                Map<String, Object> responseMap = new HashMap<>();

                try {
                    final String encodingType = "utf-8";
                    final String boundary = "____boundary____";

                    String smsUrl = "https://apis.aligo.in/send/"; // 문자 전송 API URL

                    // 문자 API 인증 정보
                    Map<String, String> sms = new HashMap<>();
                    String msg = smsMessage;
                    String receiver = convertToString(rtnMap.get("USER_PHONE"));

                    sms.put("user_id", "jo7220"); // SMS 아이디
                    sms.put("key", "vohosnyxutrxazfujqwmj47h6x2tykld"); // 인증키

                    // 전송할 문자 데이터 (프론트엔드에서 전달받음)
                    sms.put("msg", msg); // 메시지 내용
                    sms.put("receiver",receiver); // 수신번호
                    sms.put("destination", "01046624797|고객"); // 수신자 이름
                    sms.put("sender", "01046624797"); // 발신번호
                    //sms.put("rdate", smsData.get("rdate")); // 예약 전송 날짜
                    //sms.put("rtime", smsData.get("rtime")); // 예약 전송 시간
                    sms.remove("rdate");
            		sms.remove("rtime");
                    sms.put("testmode_yn", "Y"); // 테스트 모드 여부
                    sms.put("title", "test"); // LMS 제목

                    MultipartEntityBuilder builder = MultipartEntityBuilder.create();
                    builder.setBoundary(boundary);
                    builder.setMode(HttpMultipartMode.BROWSER_COMPATIBLE);
                    builder.setCharset(Charset.forName(encodingType));

                    for (Map.Entry<String, String> entry : sms.entrySet()) {
                        builder.addTextBody(entry.getKey(), entry.getValue(), ContentType.create("Multipart/related", encodingType));
                    }

                    HttpEntity entity = builder.build();
                    HttpClient client = HttpClients.createDefault();
                    HttpPost post = new HttpPost(smsUrl);
                    post.setEntity(entity);

                    HttpResponse res = client.execute(post);
                    String result = "";

                    if (res != null) {
                        BufferedReader in = new BufferedReader(new InputStreamReader(res.getEntity().getContent(), encodingType));
                        String buffer;
                        while ((buffer = in.readLine()) != null) {
                            result += buffer;
                        }
                        in.close();
                    }

                    responseMap.put("success", true);
                    responseMap.put("message", "문자 전송 완료");
                    responseMap.put("result", result);

                } catch (Exception e) {
                    responseMap.put("success", false);
                    responseMap.put("message", "문자 전송 실패: " + e.getMessage());
                }
                
                
                System.out.println("📢 대기자 " + waitUserId + "에게 수업 신청 가능 알림 전송");
            }
        }else {
        	// 3️⃣ BARE_BOOK 테이블의 PEOPLE -1 감소
            mapper.decreasePeople(bookId);
        }

        return true;
    }
    
    private static String convertToString(Object data) {
        if (data instanceof byte[]) {
            return new String((byte[]) data, StandardCharsets.UTF_8);
        } else if (data instanceof char[]) {
            return new String((char[]) data);
        } else if (data != null) {
            return data.toString();
        } else {
            return "";
        }
    }
    
    @Override
    public int addTeacher(String name, String phone) {
        return mapper.addTeacher(name, phone);
    }

    @Override
    public int updateTeacher(String oldName, String newName, String phone) {
        return mapper.updateTeacher(oldName, newName, phone);
    }

    @Override
    public int deleteTeacher(String name) {
        return mapper.deleteTeacher(name);
    }
    
    @Override
    public int getLastInsertedTicketId() {
        return mapper.getLastInsertedTicketId();
    }

    @Override
    public int addPayment(Map<String, Object> map) {
        return mapper.addPayment(map);
    }
    
	@Override
	public List<Map<String, String>> getuserBookList(int ID) throws Exception{
		return mapper.getuserBookList(ID);
	}
	
	@Override
    public Map<String, Object> getPaymentInfo(int ticketId) {
        return mapper.getPaymentInfo(ticketId);
    }

    @Override
    public int updateTicketPayment(Map<String, Object> ticketData) {
        int result = mapper.updateTicket(ticketData);
        if (result > 0) {
            return mapper.updatePayment(ticketData);
        }
        return 0;
    }

    @Override
    public int deleteTicket(int ticketId) {
        // 1. MEMBER_TICKET 삭제
        int result = mapper.deleteTicket(ticketId);

        // 2. MEMBER_PAYMENT에 CANCEL_YN = 'Y'로 업데이트
        mapper.cancelPayment(ticketId);  // 🔸 cancelPayment는 새로 추가해야 함

        return result;
    }
	
	@Override
	public int updateUserInfo(Map<String, Object> resMap) throws Exception{
		return mapper.updateUserInfo(resMap);
	}
	
	@Override
	public int reserveClass(Map<String, Object> resMap) throws Exception{
		return mapper.reserveClass(resMap);
	}
	
	@Override
	public int reserveUser(Map<String, Object> resMap) throws Exception{
		return mapper.reserveUser(resMap);
	}
	
	@Override
	public int reserveUser2(Map<String, Object> resMap) throws Exception{
		return mapper.reserveUser2(resMap);
	}
	
	@Override
	public int waitBook(Map<String, Object> resMap) throws Exception{
		return mapper.waitBook(resMap);
	}
	
	@Override
	public int userTicketCheck(Map<String, Object> resMap) throws Exception{
		return mapper.userTicketCheck(resMap);
	}
	
	@Override
	public int userBookCheck(Map<String, Object> resMap) throws Exception{
		return mapper.userBookCheck(resMap);
	}
	
	@Override
	public int waitClassCheck(Map<String, Object> resMap) throws Exception{
		return mapper.waitClassCheck(resMap);
	}
	
	@Override
	public int deleteBook(Map<String, Object> resMap) throws Exception{
		return mapper.deleteBook(resMap);
	}
	
	@Override
    public List<Map<String, Object>> getScheduleAdmin(Map<String, Object> params) {
        return mapper.getScheduleAdmin(params);
    }
	
	@Override
	public List<Map<String, Object>> getClassMembers(int bookId) throws Exception{
		return mapper.getClassMembers(bookId);
	}
	
	@Override
	public Map<String, String> memberDetail(int USER_ID) throws Exception{
		return mapper.memberDetail(USER_ID);
	}
	
	@Override
	public Map<String, Object> getClassDetail(int bookId) throws Exception{
		return mapper.getClassDetail(bookId);
	}
	
	@Override
    public int addTicketadmin(Map<String, Object> ticketData) {
        return mapper.addTicketadmin(ticketData);
    }

    @Override
    public int updateTicketadmin(Map<String, Object> ticketData) {
        return mapper.updateTicketadmin(ticketData);
    }

    @Override
    public int deleteTicketadmin(String name) {
        return mapper.deleteTicketadmin(name);
    }
    
    @Override
    public int addLocation(Map<String, Object> location) {
        return mapper.addLocation(location);
    }

    @Override
    public int updateLocation(Map<String, Object> location) {
        return mapper.updateLocation(location);
    }

    @Override
    public int deleteLocation(String location) {
        return mapper.deleteLocation(location);
    }
    
	// 일정 조회 (특정 월 & 지점)
    @Override
    public List<Map<String, Object>> getScheduleList(Map<String, Object> map) throws Exception {
        return mapper.getScheduleList(map);
    }

    // 일정 추가
    @Override
    public int insertSchedule(Map<String, Object> map) throws Exception {
        return mapper.insertSchedule(map);
    }

    // 일정 수정
    @Override
    public int updateSchedule(Map<String, Object> map) throws Exception {
        return mapper.updateSchedule(map);
    }

    // 일정 삭제
    @Override
    public int deleteSchedule(Map<String, Object> map) throws Exception {
        return mapper.deleteSchedule(map);
    }
    
    @Override
    public List<Map<String, Object>> getSalesList(Map<String, Object> params) throws Exception {
        return mapper.getSalesList(params);
    }

    @Override
    public int getSalesCount(Map<String, Object> params) throws Exception {
        return mapper.getSalesCount(params);
    }
    
    @Override
    public Map<String, Object> getSalesSummary(Map<String, String> params){
    	return mapper.getSalesSummary(params);
    }
    
    @Override
    public List<Map<String, Object>> getFilteredMemberList(Map<String, Object> filter) {
        return mapper.getFilteredMemberList(filter);
    }

    @Override
    public List<Map<String, Object>> getFilteredClassList(Map<String, Object> filter) {
        return mapper.getFilteredClassList(filter);
    }
    
    @Override
    public String getContent(String id) {
        return mapper.getContentById(id);
    }

    @Override
    public void updateContent(String id, String content) {
        Map<String, String> param = new HashMap<>();
        param.put("id", id);
        param.put("content", content);
        mapper.updateContent(param);
    }
}
