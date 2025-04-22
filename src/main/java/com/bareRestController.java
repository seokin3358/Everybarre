package com;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.HttpMultipartMode;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class bareRestController {
	@Autowired
	private bareService service;
	
	
	@RequestMapping(value="/usersave")
	  public  Map<String, Object> usercheck(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {

			Map<String, Object> rtnMap = new HashMap<String, Object>();

			int check =  service.checkMail(map);
			
			if(check < 1) {
			service.save(map);
			}else {
				rtnMap.put("result", "중복된아이디가 있습니다.");
			}

			return rtnMap;
		}	
	
	@RequestMapping(value="/userTicketCheck")
	public  Map<String, Object> userTicketCheck(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		map.put("USER_ID", request.getSession().getAttribute("userID"));
		
		int check =  service.userTicketCheck(map);
		
		if(check < 1) {
			rtnMap.put("success", false);
			rtnMap.put("isAvailable", false);
			rtnMap.put("message", "수강권이 존재하지 않습니다.");
		}else {
			check = service.userBookCheck(map);
			if(check >0) {
				rtnMap.put("success", false);
				rtnMap.put("isAvailable", false);
				rtnMap.put("message", "이미 이 강좌를 수강신청 하셨습니다.");
			}else {
				rtnMap.put("success", true);
				rtnMap.put("isAvailable", true);	
			}
		}
		
		return rtnMap;
	}
	
	@RequestMapping(value="/checkEmail")
	public  Map<String, Object> checkEmail(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		System.out.println(map);
		int check =  service.checkMail(map);

		if(check < 1) {
			rtnMap.put("success", true);
			rtnMap.put("isAvailable", true);
		}else {
			rtnMap.put("success", false);
			rtnMap.put("isAvailable", false);
		}
		
		return rtnMap;
	}
	
	@RequestMapping(value="/updateUserInfo")
	public  Map<String, Object> updateUserInfo(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		map.put("USER_ID", request.getSession().getAttribute("userID"));
		
		int check = service.updateUserInfo(map);
		
		if(check > 0) {
			rtnMap.put("success", true);
			rtnMap.put("isAvailable", true);
			System.out.println("유저정보수정완료");
		}else {
			rtnMap.put("success", false);
			rtnMap.put("isAvailable", false);
		}
		
		return rtnMap;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@RequestMapping(value="/reserveClass")
	public  Map<String, Object> reserveClass(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		map.put("USER_ID", request.getSession().getAttribute("userID"));
		System.out.println(map);
		 try {
		        // **1️⃣ 예약 등록**
		        int reserve = service.reserveClass(map);
		        if (reserve <= 0) {
		            throw new RuntimeException("예약 등록 실패");
		        }

		        // **2️⃣ 예약된 인원 수 증가**
		        String current = map.get("CURRENT_PEOPLE").toString();
		        int set = Integer.parseInt(current) + 1;
		        map.put("SET", Integer.toString(set));

		        int reserveUpdate = service.reserveUser(map);
		        if (reserveUpdate <= 0) {
		            throw new RuntimeException("예약 인원 업데이트 실패");
		        }

		        // **3️⃣ 회원의 티켓 차감**
		        reserveUpdate = service.reserveUser2(map);
		        if (reserveUpdate <= 0) {
		            throw new RuntimeException("수강할 수 있는 수강권이 없습니다!");
		        }

		        
		        String smsMessage = "[에블바레 예약 완료 안내]\n"
		                  + "지점: " + map.get("STORE") + "\n"
		                  + "일시: " + map.get("CLASS_DATE") + " " + map.get("CLASS_TIME") + "\n"
		                  + "클래스: " + map.get("CLASS_NAME") + "\n"
		                  + "강사: " + map.get("TEACHER") + "\n\n"
		                  + "예약이 완료되었습니다. 수업 5분 전까지 도착 부탁드립니다.\n"
		                  + "※ 당일 취소 및 노쇼 시 패널티가 적용될 수 있습니다.\n"
					      + "※ 예약취소는 수업 12시간 전까지 가능합니다.";
		        
		        Map<String, String> msg = new HashMap<String, String>();
		        System.out.println(request.getSession().getAttribute("userPhone"));
		        msg.put("MESSAGE", smsMessage);
		        msg.put("RECEIVER", request.getSession().getAttribute("userPhone").toString());
		        sendSms(msg);
		        
		        

		        // **모든 과정이 성공하면**
		        rtnMap.put("success", true);
		        rtnMap.put("isAvailable", true);

		    } catch (Exception e) {
		        // **예외 발생 시 롤백됨**
		        TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		        rtnMap.put("success", false);
		        rtnMap.put("message", e.getMessage());
		        rtnMap.put("isAvailable", false);
		    }
		
		
		return rtnMap;
	}
	
	@RequestMapping(value="/waitClass")
	public  Map<String, Object> waitClass(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();

		map.put("USER_ID", request.getSession().getAttribute("userID"));
		
		int check =  service.waitClassCheck(map);
		
		if(check > 0) {
			rtnMap.put("success", false);
			rtnMap.put("isAvailable", false);
			rtnMap.put("message", "이미 대기등록이 되어있습니다.");
		}else {
			check =  service.waitClass(map);
			if(check > 0) {
				String current = map.get("WAIT").toString();
				int set = Integer.valueOf(current).intValue();
				set++;
				map.put("SET", Integer.toString(set));
				check = service.waitBook(map);
				
				if(check > 0) {
					rtnMap.put("success", true);
					rtnMap.put("isAvailable", true);
				}else {
					rtnMap.put("success", false);
					rtnMap.put("isAvailable", false);
				}
					
			}else {
				rtnMap.put("success", false);
				rtnMap.put("isAvailable", false);
			}
		}
		
		
		
		return rtnMap;
	}
	
	@RequestMapping(value="/login")
	  public Map<String, Object> login(@RequestParam Map<String, Object> map, HttpServletRequest request, HttpSession session) throws Exception {

		Map<String, Object> rtnMap = new HashMap<String, Object>();
				
		rtnMap = service.login(map);	

		if(rtnMap != null && !rtnMap.isEmpty()) {
			String name =rtnMap.get("USER_NAME").toString();
			String email = rtnMap.get("USER_MAIL").toString();
			
	        // 로그인 성공 시 세션에 userName과 userID 저장
	        request.getSession().setAttribute("userName", name);	        
	        request.getSession().setAttribute("userID", rtnMap.get("USER_ID"));
	        request.getSession().setAttribute("userMail", email);
	        request.getSession().setAttribute("userPhone", rtnMap.get("USER_PHONE"));
	        request.getSession().setAttribute("ADMIN_CD", rtnMap.get("ADMIN_CD"));
	        
	        String prevPage = (String) session.getAttribute("prevPage");
	        session.removeAttribute("prevPage");

			rtnMap.put("success", true);
			rtnMap.put("userName", name);
			rtnMap.put("userID", rtnMap.get("USER_ID"));
			rtnMap.put("redirectUrl", prevPage != null ? prevPage : "/everybare.do");
		}else {
			rtnMap.put("success", false);
			rtnMap.put("message", "아이디 또는 비밀번호가 잘못되었습니다.");
		}
		
		return rtnMap;
	}
	
	@RequestMapping(value="/getschedule")
	  public  Map<String, Object> getschedule(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {

			Map<String, Object> rtnMap = new HashMap<String, Object>();
			List<Map<String, Object>> resMap = service.getschedule(map);
			
			List<Map<String, String>> transformedResults = new ArrayList<>();
		    for (Map<String, Object> row : resMap) {
		        Map<String, String> transformedRow = new HashMap<>();
		        transformedRow.put("LOCATION", new String((byte[]) row.get("LOCATION")));
		        transformedRow.put("TIME", row.get("TIME").toString().substring(0, 5));
		        transformedRow.put("PEOPLE", new String((byte[]) row.get("PEOPLE")));
		        transformedRow.put("CLASS", new String((byte[]) row.get("CLASS")));
		        transformedRow.put("TEACHER", new String((byte[]) row.get("TEACHER")));
		        transformedRow.put("WAITNUMBER", new String((byte[]) row.get("WAITNUMBER")));
		        transformedRow.put("BOOK_ID", convertToString(row.get("BOOK_ID")));
		        transformedResults.add(transformedRow);
		    }
			
			rtnMap.put("result", transformedResults);
			System.out.println(transformedResults);
			
			return rtnMap;
		}
	
	@RequestMapping(value="/ticketsave")
	  public  Map<String, Object> ticketsave(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {

			Map<String, Object> rtnMap = new HashMap<String, Object>();
			map.put("USER_ID", request.getSession().getAttribute("userID"));
			if(map.get("UNLIMITED").equals("true")) {
				map.put("OREGINAL_LOCATION", map.get("LOCATION"));
				map.put("LOCATION", "전지점");		
			}else {
				map.put("OREGINAL_LOCATION", map.get("LOCATION"));
			}
			//int setDate = service.getticketDate(map.get("TICKET_NAME").toString());
			String[] ticketname= map.get("TICKET_NAME").toString().split("-");
			map.put("TICKET_NAME", ticketname[0].trim());
			
			int Cash;
			
			if(ticketname[0].trim().equals("1회체험권 (계정당한번만 가능)")) {
				int Oneday = service.updateOneday(map);
				if(Oneday <= 0) {
					rtnMap.put("result", "error");
		        	System.out.println("체험권 업데이트 실패");
					return rtnMap;
				}
				Cash = 0;
			}else {
				Cash = service.updateUserCash(map);
			}

	        LocalDate today = LocalDate.now();	        
	        LocalDate nextMonthDate = today.plusMonths(service.getticketDate(map));
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        String formattedDate = nextMonthDate.format(formatter);
	        
			System.out.println(map);
	        map.put("START_DAY", today.format(formatter));
	        map.put("END_DAY", formattedDate);
	        int result = service.ticketsave(map);
	        if(result > 0) {
	            int ticketId = service.getLastInsertedTicketId(); 

	            Map<String, Object> paymentMap = new HashMap<>();
	            paymentMap.put("userId", map.get("USER_ID"));
	            paymentMap.put("TICKET_ID", ticketId);
	            paymentMap.put("location", map.get("LOCATION"));
	            paymentMap.put("OREGINAL_LOCATION", map.get("OREGINAL_LOCATION"));    
	            paymentMap.put("cardAmount", map.getOrDefault("cardAmount", "0"));
	            paymentMap.put("cashAmount", "0"); 	            
	            int totalAmount = Integer.parseInt(map.getOrDefault("cardAmount", "0").toString());
	            paymentMap.put("TOTAL_AMOUNT", totalAmount);
	            paymentMap.put("dueAmount", "0"); 
	            paymentMap.put("USER_CASH", Cash);	        

	            service.addPayment(paymentMap); // 결제 정보 추가
	            
	        	rtnMap.put("result", "success");
	        	System.out.println("결제정보 저장 완료");
	        }else {
	        	rtnMap.put("result", "error");
	        	System.out.println("결제정보 저장 실패");
	        }
			return rtnMap;
		}
	
	@RequestMapping(value="/cancelReservation")
	public  Map<String, Object> cancelReservation(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		map.put("USER_ID", request.getSession().getAttribute("userID"));
		
		int Update = service.updateCancelTicket(map);
		
		
		if(Update > 0) {
			Object bookIdObj = map.get("BOOKID");
			int bookId = (bookIdObj instanceof String) ? Integer.parseInt((String) bookIdObj) : (Integer) bookIdObj;

			Object userIdObj = map.get("USER_ID");
			int userId = (userIdObj instanceof String) ? Integer.parseInt((String) userIdObj) : (Integer) userIdObj;

			boolean set = service.cancelReservation(bookId, userId);
			//Update = service.deleteBook(map);
			if(set) {
		        //service.decreasePeople(Integer.parseInt((String) map.get("BOOKID")));
				Map<String, String> msg = new HashMap<String, String>();
				String smsCancelMessage = "[에블바레 예약 취소 안내]\n"
                        + "지점: " + map.get("LOCATION") + "\n"
                        + "일시: " + map.get("DATE") + " " + map.get("TIME") + "\n"
                        + "클래스: " + map.get("CLASS") + "\n\n"
                        + "해당 예약이 취소되었습니다.\n"
                        + "다음에 더 좋은 수업으로 찾아뵙겠습니다.";
				
				 	msg.put("MESSAGE", smsCancelMessage);
			        msg.put("RECEIVER", request.getSession().getAttribute("userPhone").toString());
			        sendSms(msg);
			        
			        
				rtnMap.put("success", true);
				rtnMap.put("result", "success");
	        	System.out.println("예약취소 완료");
			}else {
				rtnMap.put("success", false);
				rtnMap.put("result", "error");
				System.out.println("예약내역 삭제 실패(예약취소)");
			}
		}else {
			rtnMap.put("success", false);
			rtnMap.put("result", "error");
			System.out.println("예약취소 1회티켓 실패");			
		}
		
		return rtnMap;
	}
	@RequestMapping(value="/cancelWaitReservation")
	public  Map<String, Object> cancelWaitReservation(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		map.put("USER_ID", request.getSession().getAttribute("userID"));
		
		int Update = service.deletewaitList(map);
		
		if(Update > 0) {			
				rtnMap.put("success", true);
				rtnMap.put("result", "success");
		}else {
			rtnMap.put("success", false);
			rtnMap.put("result", "error");		
		}
		
		return rtnMap;
	}
	
	@RequestMapping(value="/requestTemporaryPassword")
		public  Map<String, Object> requestTemporaryPassword(@RequestParam Map<String, Object> map, HttpServletRequest request) throws Exception {

			Map<String, Object> rtnMap = new HashMap<String, Object>();

			int res = service.checkID(map);
			
			if(res>0) {
				String temporaryPassword = generateTemporaryPassword(8);
				System.out.println(temporaryPassword);
				
				map.put("PASSWORD", temporaryPassword);
				int result = service.updatePassword(map);
				if(result > 0) {
					//휴대폰번호로 임시 비밀번호 전송
					rtnMap.put("PASSWORD", "회원님의 임시 비밀번호는 ["+temporaryPassword + "]입니다. 해당 비밀번호로 로그인 후, 마이페이지에서 새로운 비밀번호로 변경 해 주세요!");
					rtnMap.put("success", true);
					rtnMap.put("message", "휴대폰 번호로 임시비밀번호가 발급되었습니다. 로그인 후 반드시 비밀번호를 변경하세요.");
				}else {
					rtnMap.put("success", false);
					rtnMap.put("message", "계정정보 업데이트 실패.");
				}
			}else {
				rtnMap.put("success", false);
				rtnMap.put("message", "이메일과 휴대폰번호에 맞는 계정이 없습니다.");
			}
										

			
			return rtnMap;
		}
	
    public static String generateTemporaryPassword(int length) {
        // 사용할 문자 집합: 영어 대소문자와 숫자
        String upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
        String numbers = "0123456789";
        String allCharacters = upperCaseLetters + lowerCaseLetters + numbers;

        // Random 객체
        Random random = new Random();

        // StringBuilder로 비밀번호 생성
        StringBuilder password = new StringBuilder();

        // 최소한 하나의 대문자, 소문자, 숫자를 포함하도록 추가
        password.append(upperCaseLetters.charAt(random.nextInt(upperCaseLetters.length())));
        password.append(lowerCaseLetters.charAt(random.nextInt(lowerCaseLetters.length())));
        password.append(numbers.charAt(random.nextInt(numbers.length())));

        // 나머지 길이를 무작위로 채움
        for (int i = 3; i < length; i++) {
            password.append(allCharacters.charAt(random.nextInt(allCharacters.length())));
        }

        // 생성된 비밀번호를 섞음
        return shuffleString(password.toString());
    }

    /**
     * 문자열을 무작위로 섞는 메서드
     * @param input 입력 문자열
     * @return 섞인 문자열
     */
    private static String shuffleString(String input) {
        char[] characters = input.toCharArray();
        Random random = new Random();
        for (int i = 0; i < characters.length; i++) {
            int randomIndex = random.nextInt(characters.length);
            // 문자 교환
            char temp = characters[i];
            characters[i] = characters[randomIndex];
            characters[randomIndex] = temp;
        }
        return new String(characters);
    }
    
    @RequestMapping(value = "/sendSms", method = RequestMethod.POST)
    public Map<String, Object> sendSms(@RequestParam Map<String, String> smsData) {
        Map<String, Object> responseMap = new HashMap<>();

        try {
            final String encodingType = "utf-8";
            final String boundary = "____boundary____";

            String smsUrl = "https://apis.aligo.in/send/"; // 문자 전송 API URL

            // 문자 API 인증 정보
            Map<String, String> sms = new HashMap<>();
            String msg = smsData.get("MESSAGE");
            String receiver = smsData.get("RECEIVER");
            System.out.println(smsData);
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

        return responseMap;
    }
    
    @GetMapping("/getSchedule.do")
    public ResponseEntity<List<Map<String, Object>>> getSchedule(
            @RequestParam("location") String location,
            @RequestParam("teacher") String teacher,
            @RequestParam("year") String year,
            @RequestParam("month") String month,
            @RequestParam(value = "day", required = false) String day) {

        Map<String, Object> params = new HashMap<>();
        params.put("year", year);
        params.put("month", month);
        if (day != null && !day.isEmpty()) {
            params.put("day", day);
        }
        if (!"all".equals(location)) {
            params.put("location", location);
        }
        if (!"all".equals(teacher)) { // 강사 필터 추가
            params.put("teacher", teacher);
        }

        List<Map<String, Object>> scheduleList = service.getScheduleAdmin(params);

     // 데이터 변환 (BLOB -> String)
        for (Map<String, Object> schedule : scheduleList) {
        	String className = convertToString(schedule.get("className"));
            String TEACHER = convertToString(schedule.get("TEACHER"));
            String PEOPLE = convertToString(schedule.get("PEOPLE"));
            String waitNumber = convertToString(schedule.get("waitNumber"));
            String LOCATION = convertToString(schedule.get("LOCATION"));
            String MAXPEOPLE = convertToString(schedule.get("MAXPEOPLE"));
        	
        	
            schedule.put("className", className);
            schedule.put("TEACHER", TEACHER);
            schedule.put("PEOPLE", PEOPLE);
            schedule.put("waitNumber", waitNumber);
            schedule.put("LOCATION", LOCATION);
            schedule.put("MAXPEOPLE", MAXPEOPLE);
        }

        return ResponseEntity.ok(scheduleList);
    }
    // 데이터 타입에 따라 String 변환
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
    
    @GetMapping("/getClassList.do")
    public ResponseEntity<Map<String, Object>> getClassList(
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "location", required = false) String location,
            @RequestParam(value = "teacher", required = false) String teacher,
            @RequestParam(value = "page", defaultValue = "1") int page) throws Exception {

        Map<String, Object> params = new HashMap<>();
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        params.put("location", location);
        params.put("teacher", teacher);

        int pageSize = 10;
        params.put("offset", (page - 1) * pageSize);
        params.put("limit", pageSize);
        
        List<Map<String, Object>> classList = service.getClassList(params);
        int totalPages = service.getTotalClassCount(params);
        
        for (Map<String, Object> schedule : classList) {
        	String className = convertToString(schedule.get("className"));
            String TEACHER = convertToString(schedule.get("TEACHER"));
            String PEOPLE = convertToString(schedule.get("PEOPLE"));
            String waitNumber = convertToString(schedule.get("waitNumber"));
            String LOCATION = convertToString(schedule.get("LOCATION"));
            String MAXPEOPLE = convertToString(schedule.get("MAXPEOPLE"));
        	
        	
            schedule.put("className", className);
            schedule.put("TEACHER", TEACHER);
            schedule.put("PEOPLE", PEOPLE);
            schedule.put("waitNumber", waitNumber);
            schedule.put("LOCATION", LOCATION);
            schedule.put("MAXPEOPLE", MAXPEOPLE);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("classes", classList);
        response.put("totalPages", totalPages);
        return ResponseEntity.ok(response);
    }
    
    // 📌 수업 삭제 API
    @PostMapping("/deleteClass.do")
    public ResponseEntity<String> deleteClass(@RequestParam("bookId") int bookId) {
        try {
            service.deleteClass(bookId);
            return ResponseEntity.ok("삭제 성공");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.SC_INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }

    // 📌 수업 수정 API
    @PostMapping("/updateClass.do")
    @ResponseBody // JSON 응답을 위해 추가
    public Map<String, Object> updateClass(@RequestBody Map<String, Object> classData) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            int result = service.updateClass(classData);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "수업이 성공적으로 수정되었습니다.");
            } else {
                response.put("status", "fail");
                response.put("message", "수업 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "오류 발생: " + e.getMessage());
        }

        return response;
    }
    
    // 회원 목록 조회
    @GetMapping("/getMemberList.do")
    public Map<String, Object> getMemberList(@RequestParam(required = false) String name,
                                             @RequestParam(required = false) String phone,
                                             @RequestParam(defaultValue = "1") int page) throws Exception {
        int limit = 10;
        int offset = (page - 1) * limit;

        List<Map<String, Object>> members = service.getMemberList(name, phone, limit, offset);
        int totalPages = service.getTotalMemberPages(name, phone, limit);
     // 각 회원의 수강권 정보 추가
        for (Map<String, Object> member : members) {
            int userId = (int) member.get("USER_ID");
            List<Map<String, Object>> tickets = service.getMemberTickets(userId);
            
            for (Map<String, Object> ticketlist : tickets) {
            String USER_NAME = convertToString(ticketlist.get("USER_NAME"));
            String LOCATION = convertToString(ticketlist.get("LOCATION"));
            String TICKET_NAME = convertToString(ticketlist.get("TICKET_NAME"));
            
            ticketlist.put("USER_NAME", USER_NAME);
            ticketlist.put("LOCATION", LOCATION);
            ticketlist.put("TICKET_NAME", TICKET_NAME);
            
            }
            
            
            member.put("tickets", tickets);
        }
        
        for (Map<String, Object> memberslist : members) {
        	String USER_NAME = convertToString(memberslist.get("USER_NAME"));
            String USER_PHONE = convertToString(memberslist.get("USER_PHONE"));
            String USER_MAIL = convertToString(memberslist.get("USER_MAIL"));
            String USER_BIRTH = convertToString(memberslist.get("USER_BIRTH"));
            String MEMO = convertToString(memberslist.get("MEMO"));
        	
            memberslist.put("USER_NAME", USER_NAME);
            memberslist.put("USER_PHONE", USER_PHONE);
            memberslist.put("USER_MAIL", USER_MAIL);
            memberslist.put("USER_BIRTH", USER_BIRTH);
            memberslist.put("USER_MEMO", MEMO);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("members", members);
        response.put("totalPages", totalPages);

        return response;
    }
    
    @PostMapping("/AdmincancelReservation")
    public Map<String, Object> AdmincancelReservation(@RequestParam("bookId") int bookId, 
                                                 @RequestParam("userId") int userId) {
        Map<String, Object> response = new HashMap<>();

        try {
            boolean isCanceled = service.cancelReservation(bookId, userId);

            if (isCanceled) {
                response.put("success", true);
                response.put("message", "예약이 성공적으로 취소되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "예약 취소에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류 발생: " + e.getMessage());
        }

        return response;
    }

    // 회원 삭제
    @PostMapping("/deleteMember.do")
    public ResponseEntity<String> deleteMember(@RequestParam int userId) throws Exception {
        service.deleteMember(userId);
        return ResponseEntity.ok("삭제 완료");
    }
    
    // 회원 정보 수정
    @PostMapping("/updateMember.do")
    public ResponseEntity<Map<String, String>> updateMember(@RequestBody Map<String, Object> memberData) {
        int result = service.updateMember(memberData);
        Map<String, String> response = new HashMap<>();
        response.put("status", (result > 0) ? "success" : "fail");
        response.put("message", (result > 0) ? "회원 정보가 수정되었습니다." : "수정에 실패하였습니다.");
        return ResponseEntity.ok(response);
    }
    
    // 수강권 결제 정보 조회
    @GetMapping("/getPaymentInfo.do")
    public Map<String, Object> getPaymentInfo(@RequestParam("ticketId") int ticketId) {
    	Map<String, Object> Info = service.getPaymentInfo(ticketId);
    	
    	String MEMO = convertToString(Info.get("memo"));
    	Info.put("memo", MEMO);
    	
        return Info;
    }

    // 회원 수강권 추가
    @PostMapping("/addTicket.do")
    public Map<String, Object> addTicket(@RequestBody Map<String, Object> ticketData) {
        Map<String, Object> response = new HashMap<>();

        try {
            int result = service.addTicket(ticketData);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "수강권이 성공적으로 추가되었습니다.");
            } else {
                response.put("status", "fail");
                response.put("message", "수강권 추가에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "오류 발생: " + e.getMessage());
        }

        return response;
    }
    
    // 수강권 및 결제 정보 수정
    @PostMapping("/updateTicketPayment.do")
    public Map<String, Object> updateTicketPayment(@RequestBody Map<String, Object> ticketData) {
        Map<String, Object> response = new HashMap<>();

        try {
            int result = service.updateTicketPayment(ticketData);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "수강권 및 결제 정보가 수정되었습니다.");
            } else {
                response.put("status", "fail");
                response.put("message", "수정에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "오류 발생: " + e.getMessage());
        }

        return response;
    }

    // 수강권 삭제
    @PostMapping("/deleteTicket.do")
    public Map<String, Object> deleteTicket(@RequestParam("ticketId") int ticketId) {
        Map<String, Object> response = new HashMap<>();

        try {
            int result = service.deleteTicket(ticketId);
            if (result > 0) {
                response.put("status", "success");
                response.put("message", "수강권이 성공적으로 삭제되었습니다.");
            } else {
                response.put("status", "fail");
                response.put("message", "수강권 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "오류 발생: " + e.getMessage());
        }

        return response;
    }
    
    // 모든 사용 완료된 수강권 조회 API
    @GetMapping("/getAllUsedTickets.do")
    public List<Map<String, Object>> getAllUsedTickets(@RequestParam("userId") int userId) {
    	
    	List<Map<String, Object>> ticket = service.getAllUsedTickets(userId);
    	    	
    	for (Map<String, Object> ticketlist : ticket) {
        	String TICKET_NAME = convertToString(ticketlist.get("TICKET_NAME"));
            String LOCATION = convertToString(ticketlist.get("LOCATION"));
        	
            ticketlist.put("TICKET_NAME", TICKET_NAME);
            ticketlist.put("LOCATION", LOCATION);
        }
    	
        
        return ticket;
    }
    
    @PostMapping("/addTeacher.do")
    public Map<String, Object> addTeacher(@RequestParam String name, @RequestParam String phone) {
        Map<String, Object> response = new HashMap<>();
        int result = service.addTeacher(name, phone);
        if (result > 0) {
            response.put("message", "강사가 추가되었습니다.");
        } else {
            response.put("message", "강사 추가에 실패했습니다.");
        }
        return response;
    }

    @PostMapping("/updateTeacher.do")
    public Map<String, Object> updateTeacher(@RequestParam String oldName, @RequestParam String newName, @RequestParam String phone) {
        Map<String, Object> response = new HashMap<>();
        int result = service.updateTeacher(oldName, newName, phone);
        if (result > 0) {
            response.put("message", "강사가 수정되었습니다.");
        } else {
            response.put("message", "강사 수정에 실패했습니다.");
        }
        return response;
    }

    @PostMapping("/deleteTeacher.do")
    public Map<String, Object> deleteTeacher(@RequestParam String name) {
        Map<String, Object> response = new HashMap<>();
        int result = service.deleteTeacher(name);
        if (result > 0) {
            response.put("message", "강사가 삭제되었습니다.");
        } else {
            response.put("message", "강사 삭제에 실패했습니다.");
        }
        return response;
    }
    
    @PostMapping("/addTicketadmin.do")
    public Map<String, Object> addTicketadmin(@RequestBody Map<String, Object> ticketData) {
        Map<String, Object> response = new HashMap<>();
        int result = service.addTicketadmin(ticketData);
        response.put("status", result > 0 ? "success" : "fail");
        response.put("message", result > 0 ? "수강권이 추가되었습니다." : "추가 실패");
        return response;
    }

    @PostMapping("/updateTicketadmin.do")
    public Map<String, Object> updateTicket(@RequestBody Map<String, Object> ticketData) {
        Map<String, Object> response = new HashMap<>();
        int result = service.updateTicketadmin(ticketData);
        response.put("status", result > 0 ? "success" : "fail");
        response.put("message", result > 0 ? "수강권이 수정되었습니다." : "수정 실패");
        return response;
    }

    @PostMapping("/deleteTicketadmin.do")
    public Map<String, Object> deleteTicket(@RequestParam String name) {
        Map<String, Object> response = new HashMap<>();
        int result = service.deleteTicketadmin(name);
        response.put("status", result > 0 ? "success" : "fail");
        response.put("message", result > 0 ? "수강권이 삭제되었습니다." : "삭제 실패");
        return response;
    }
    
 // 지점 추가
    @PostMapping("/addLocation.do")
    public Map<String, Object> addLocation(@RequestBody Map<String, Object> location) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = service.addLocation(location);
            response.put("status", result > 0 ? "success" : "fail");
            response.put("message", result > 0 ? "지점이 추가되었습니다." : "지점 추가 실패");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "오류 발생: " + e.getMessage());
        }
        return response;
    }

    // 지점 수정
    @PostMapping("/updateLocation.do")
    public Map<String, Object> updateLocation(@RequestBody Map<String, Object> location) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = service.updateLocation(location);
            response.put("status", result > 0 ? "success" : "fail");
            response.put("message", result > 0 ? "지점이 수정되었습니다." : "지점 수정 실패");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "오류 발생: " + e.getMessage());
        }
        return response;
    }

    // 지점 삭제
    @PostMapping("/deleteLocation.do")
    public Map<String, Object> deleteLocation(@RequestParam("location") String location) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = service.deleteLocation(location);
            response.put("status", result > 0 ? "success" : "fail");
            response.put("message", result > 0 ? "지점이 삭제되었습니다." : "지점 삭제 실패");
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "오류 발생: " + e.getMessage());
        }
        return response;
    }
    
    @RequestMapping("/getSalesSummary.do")
    public Map<String, Object> getSalesSummary(@RequestParam Map<String, String> params) {
    	return service.getSalesSummary(params);
    }
    
    @RequestMapping(value = "/getSalesList.do", method = RequestMethod.GET)
    public Map<String, Object> getSalesList(@RequestParam Map<String, String> params) {
        Map<String, Object> responseMap = new HashMap<>();
        List<Map<String, Object>> salesList = new ArrayList<>();
        
        try {
            // 요청된 검색 필터 값 가져오기
            String startDate = params.get("startDate");
            String endDate = params.get("endDate");
            String filterTicket = params.get("filterTicket");
            String filterLocation = params.get("filterLocation");
            int page = Integer.parseInt(params.getOrDefault("page", "1"));
            int recordsPerPage = 10;
            int start = (page - 1) * recordsPerPage;
            
            // 매출 데이터 조회 쿼리 실행
            Map<String, Object> queryParams = new HashMap<>();
            queryParams.put("startDate", startDate);
            queryParams.put("endDate", endDate);
            queryParams.put("filterTicket", filterTicket);
            queryParams.put("filterLocation", filterLocation);
            queryParams.put("start", start);
            queryParams.put("limit", recordsPerPage);
            
            
            salesList = service.getSalesList(queryParams);
            for (Map<String, Object> schedule : salesList) {
            	String USER_NAME = convertToString(schedule.get("USER_NAME"));
                String LOCATION = convertToString(schedule.get("LOCATION"));
                String TICKET_NAME = convertToString(schedule.get("TICKET_NAME"));
                String PAYMENT_DATE_KST = convertToString(schedule.get("PAYMENT_DATE_KST"));
                String CANCEL_DATE = convertToString(schedule.get("CANCEL_DATE"));
                String CANCEL_YN = convertToString(schedule.get("CANCEL_YN"));
            	
            	
                schedule.put("USER_NAME", USER_NAME);
                schedule.put("LOCATION", LOCATION);
                schedule.put("TICKET_NAME", TICKET_NAME);
                schedule.put("PAYMENT_DATE_KST", PAYMENT_DATE_KST);
                schedule.put("CANCEL_DATE", CANCEL_DATE);
                schedule.put("CANCEL_YN", CANCEL_YN);
            }
            
            int totalRecords = service.getSalesCount(queryParams);
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            responseMap.put("sales", salesList);
            responseMap.put("totalPages", totalPages);
        } catch (Exception e) {
            responseMap.put("error", "데이터 조회 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
        
        return responseMap;
    }
    @PostMapping("/updateMainText.do")
    public String updateMainText(@RequestParam String mainTitle,
                                 @RequestParam String mainDesc,
                                 @RequestParam String blogTitle,
                                 @RequestParam String blogDesc,
                                 HttpServletRequest request) {

        String path = request.getServletContext().getRealPath("/static_uploads/img/");

        try {
            Files.write(Paths.get(path + "/main_title.txt"), mainTitle.getBytes(StandardCharsets.UTF_8));
            Files.write(Paths.get(path + "/main_description.txt"), mainDesc.getBytes(StandardCharsets.UTF_8));
            Files.write(Paths.get(path + "/blog_title.txt"), blogTitle.getBytes(StandardCharsets.UTF_8));
            Files.write(Paths.get(path + "/blog_description.txt"), blogDesc.getBytes(StandardCharsets.UTF_8));
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/admin_slide_upload.jsp";
    }



}
