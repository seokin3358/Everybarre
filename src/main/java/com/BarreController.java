package com;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class BarreController{	
	@Autowired
	private bareService service;
	
	  @RequestMapping(value="/") 
	  public String login() { return "index"; }
	  
	  @RequestMapping(value="/admin_schedule.do") 
	  public String admin_schedule(HttpServletRequest request) { 
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 0) {
	    	  return "admin_schedule"; // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      }}
	  
	  @RequestMapping(value="/admin_sales.do") 
	  public String admin_sales(HttpServletRequest request) {
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 2) {
	    	  return "admin_sales";  // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      }}
	  
	  @RequestMapping(value="/admin_members.do") 
	  public String admin_members(HttpServletRequest request) {
		  
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 0) {
	    	  return "admin_member_list"; // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      } }
	  
	  @RequestMapping(value="/admin_create_class.do") 
	  public String admin_create_class(HttpServletRequest request) {
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 0) {
	    	  return "admin_create_class"; // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      } }
	  
	  @RequestMapping(value="/admin_class_list.do") 
	  public String admin_class_list(HttpServletRequest request) {
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 0) {
	    	  return "admin_class_list"; // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      } }
	  
	  @RequestMapping(value="/admin_teachers.do") 
	  public String admin_teachers(HttpServletRequest request) {
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 2) {
	    	  return "admin_teacher_list"; // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      } }
	  
	  @RequestMapping(value="/admin_tickets.do") 
	  public String admin_tickets(HttpServletRequest request) {
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 2) {
	    	  return "admin_ticket_list"; // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      } }
	  
	  @RequestMapping(value="/admin_locations.do") 
	  public String admin_locations(HttpServletRequest request) {
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 2) {
	    	  return "admin_locations"; // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      }} 
	  
	  @RequestMapping(value="/admin_slide_upload.do") 
	  public String admin_slide_upload(HttpServletRequest request) {
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 2) {
	    	  return "admin_slide_upload";  // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      }}
	  
	  @RequestMapping(value="/booking.do") 
	  public String booking() { return "res_step0"; }
	  
	  @RequestMapping(value="/res.do")
	  public String res() { return "res_step0"; }
	  
	  @RequestMapping(value="/everybare.do")
	  public String everybare(HttpSession session, Model model) throws Exception { 
		  //지점 정보 가져오기
		  List<Map<String, String>> storeList = service.getStoreList();
		  System.out.println(storeList);
	        session.setAttribute("storeList", storeList); // 세션에 저장
		  return "everybare"; }
	  
	  @RequestMapping(value="/barelogin.do")
	  public String barelogin() { return "barelogin"; }
	  
	  @RequestMapping(value="/barebook.do")
	  public String barebook() { return "barebook"; }
	  
	  @GetMapping("/admin_class_detail.do")
	  public String getClassDetail(@RequestParam("bookId") int bookId, Model model) throws Exception{
		  
	     Map<String, Object> classDetail = service.getClassDetail(bookId);
	     List<Map<String, Object>> classMembers = service.getClassMembers(bookId);
	     
	     String className = convertToString(classDetail.get("className"));
         String TEACHER = convertToString(classDetail.get("TEACHER"));
         String PEOPLE = convertToString(classDetail.get("PEOPLE"));
         String waitNumber = convertToString(classDetail.get("waitNumber"));
         String LOCATION = convertToString(classDetail.get("LOCATION"));
         String MAXPEOPLE = convertToString(classDetail.get("MAXPEOPLE"));
	     
         classDetail.put("className", className);
         classDetail.put("TEACHER", TEACHER);
         classDetail.put("PEOPLE", PEOPLE);
         classDetail.put("waitNumber", waitNumber);
         classDetail.put("LOCATION", LOCATION);
         classDetail.put("MAXPEOPLE", MAXPEOPLE);
         
         for (Map<String, Object> schedule : classMembers) {
         	String USER_NAME = convertToString(schedule.get("USER_NAME"));
         	int id = (int) schedule.get("USER_ID");
         	Map<String, String> memberDetail = service.memberDetail(id);
         	String USER_PHONE = convertToString(memberDetail.get("USER_PHONE"));
         	String USER_MAIL = convertToString(memberDetail.get("USER_MAIL"));
         	         	 
             schedule.put("USER_NAME", USER_NAME);
             schedule.put("USER_PHONE", USER_PHONE);
             schedule.put("USER_MAIL", USER_MAIL);
         }
         
	     model.addAttribute("classDetail", classDetail);
	     model.addAttribute("classMembers", classMembers);
	     
	     return "admin_class_detail"; // JSP 파일 이름
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

	    @PostMapping("/admin_add_class.do")
	    public String addClass(
	            @RequestParam("location") String location,
	            @RequestParam("teacher") String teacher,
	            @RequestParam("className") String className,
	            @RequestParam("people") int people,
	            @RequestParam("startDate") String startDate,
	            @RequestParam("endDate") String endDate,
	            @RequestParam("time") String time,
	            @RequestParam("selectedDays") String selectedDays,
	            RedirectAttributes redirectAttributes) throws Exception {

	    	List<String> dates = new ArrayList<>();
	        List<String> daysOfWeek = Arrays.asList(selectedDays.split(",")); // 요일 리스트

	        // 날짜 범위 내에서 요일이 일치하는 날짜 찾기
	        LocalDate start = LocalDate.parse(startDate);
	        LocalDate end = LocalDate.parse(endDate);
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	        for (LocalDate date = start; !date.isAfter(end); date = date.plusDays(1)) {
	            String dayOfWeek = date.getDayOfWeek().getDisplayName(TextStyle.SHORT, Locale.KOREAN); // "월", "화", "수" 형태 반환
	            if (daysOfWeek.contains(dayOfWeek)) {
	                dates.add(date.format(formatter));
	            }
	        }

	        // MyBatis에 전달할 데이터 구성
	        Map<String, Object> params = new HashMap<>();
	        params.put("location", location);
	        params.put("teacher", teacher);
	        params.put("className", className);
	        params.put("people", people);
	        params.put("time", time);
	        params.put("dates", dates); 

	        service.addClasses(params);
	        
	        // 이전 입력값을 그대로 유지하면서 다시 수업 추가 페이지로 이동
	        redirectAttributes.addAttribute("location", location);
	        redirectAttributes.addAttribute("teacher", teacher);
	        redirectAttributes.addAttribute("className", className);
	        redirectAttributes.addAttribute("people", people);
	        redirectAttributes.addAttribute("startDate", startDate);
	        redirectAttributes.addAttribute("endDate", endDate);
	        redirectAttributes.addAttribute("selectedDays", selectedDays);
	        
	        // 수업 추가 완료 메시지 전달
	        redirectAttributes.addAttribute("message", "수업이 정상적으로 추가되었습니다.");

	        return "redirect:/admin_create_class.do";
	    }
	  
	  @RequestMapping(value="/mypage.do")
	  public String mypage(HttpSession session, Model model) throws Exception {
		    // 세션에서 userID 가져오기
	        String userName = (String) session.getAttribute("userName");
	        
	        if (userName == null) {
	            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
	            return "redirect:/barelogin.do";
	        }
	        int userID = (int) session.getAttribute("userID");
	        Map<String, Object> rtnMap = new HashMap<String, Object>();
	        // DB에서 사용자 정보 조회
	        rtnMap = service.getUser(userID);
	        List<Map<String, String>> ticketList = service.getticketList();
	        List<Map<String, String>> userticketList = service.getuserticketList(userID);
	        List<Map<String, String>> userBookList = service.getuserBookList(userID);
	        List<Map<String, String>> userWaitList = service.getuserWaitList(userID);
	        
	        
	                
	        // 세션에서 사용자 정보 가져오기
	        String userEmail = (String) session.getAttribute("userMail");
	        String userPhone = rtnMap.get("USER_PHONE").toString();
	        String userCash = rtnMap.get("USER_CASH").toString();
	        String userBirth = rtnMap.get("USER_BIRTH").toString();
	        String userOneday = rtnMap.get("ONEDAY_CHECK").toString();
	        
	        session.setAttribute("userEmail", userEmail);
	        session.setAttribute("userPhone", userPhone);
	        session.setAttribute("ticketList", ticketList);
	        session.setAttribute("userticketList", userticketList);
	        session.setAttribute("userBirth", userBirth);
	        session.setAttribute("userOneday", userOneday);
	        session.setAttribute("userBookList", userBookList);
	        session.setAttribute("userWaitList", userWaitList);
	        

	        // Model에 개별 변수로 추가
	        model.addAttribute("userName", userName);
	        model.addAttribute("userEmail", userEmail);
	        model.addAttribute("userPhone", userPhone);
	        model.addAttribute("userCash", userCash);
	        model.addAttribute("userOneday", userOneday);
	        model.addAttribute("userBookList", userBookList);
	        model.addAttribute("userWaitList", userWaitList);

		  return "baremypage"; 
		  }
	  
	  @GetMapping("/checkout.do")
	    public String checkoutPage(
	        @RequestParam("orderName") String orderName,
	        @RequestParam("value") String value,
	        @RequestParam("customerEmail") String customerEmail,
	        @RequestParam("customerName") String customerName,
	        @RequestParam("customerMobilePhone") String customerMobilePhone,
	        @RequestParam("Place") String Place,
	        HttpSession session,
	        Model model) throws Exception {
		  
		  	Map<String, Object> PaymentKey = service.getPaymentKey(Place);
		  	
		  	
		  	String client_key = convertToString(PaymentKey.get("CLIENT_KEY"));
	        // JSP로 데이터 전달
	        model.addAttribute("orderName", orderName);
	        model.addAttribute("value", value);
	        model.addAttribute("customerEmail", customerEmail);
	        model.addAttribute("customerName", customerName);
	        model.addAttribute("customerMobilePhone", customerMobilePhone);
	        model.addAttribute("Place", Place);
	        model.addAttribute("client_key", client_key);
	        
	        
	        session.setAttribute("uuId", UUID.randomUUID().toString());
	        session.setAttribute("orderName", orderName);
	        session.setAttribute("value", value);
	        session.setAttribute("customerEmail", customerEmail);
	        session.setAttribute("customerName", customerName);
	        session.setAttribute("customerMobilePhone", customerMobilePhone);
	        session.setAttribute("Place", Place);
	        session.setAttribute("client_key", client_key);
	        
	       	       
	        System.out.println(UUID.randomUUID().toString());

	        return "checkout"; // checkout.jsp로 포워딩
	    }
	  
	  @GetMapping("/admin_member_detail.do")
	    public String memberDetail(@RequestParam("userId") int userId, Model model, HttpServletRequest request) {
		  
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 0) {
	    	  Map<String, Object> member = service.getMemberDetail(userId);
		        model.addAttribute("member", member);

		        // 사용 중인 수강권 목록 가져오기
		        List<Map<String, Object>> tickets = service.getMemberTickets(userId);
		        model.addAttribute("tickets", tickets);

		        return "admin_member_detail";  // admin_member_detail.jsp로 이동 // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      }
	        // 회원 정보 가져오기
	        
	    }
	  
	  @GetMapping("/admin_edit_class.do")
	    public String editClass(@RequestParam("bookId") int bookId, Model model, HttpServletRequest request) throws Exception {
	        // bookId에 해당하는 수업 정보만 가져옴 (지점/강사 목록은 JSP에서 가져옴)
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 0) {
	    	  Map<String, Object> classDetail = service.getClassDetail(bookId);
		        
		        String className = convertToString(classDetail.get("className"));
		         String TEACHER = convertToString(classDetail.get("TEACHER"));
		         String PEOPLE = convertToString(classDetail.get("PEOPLE"));
		         String waitNumber = convertToString(classDetail.get("waitNumber"));
		         String LOCATION = convertToString(classDetail.get("LOCATION"));
		         String MAXPEOPLE = convertToString(classDetail.get("MAXPEOPLE"));
			     
		         classDetail.put("className", className);
		         classDetail.put("TEACHER", TEACHER);
		         classDetail.put("PEOPLE", PEOPLE);
		         classDetail.put("waitNumber", waitNumber);
		         classDetail.put("LOCATION", LOCATION);
		         classDetail.put("MAXPEOPLE", MAXPEOPLE);

		        model.addAttribute("classInfo", classDetail); // JSP에서 사용
		        return "admin_edit_class"; // JSP 파일명 (admin_edit_class.jsp) 
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      }
	        
	    }
	  
	  @RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	  public String logout(HttpServletRequest request) {
	      request.getSession().invalidate();  
	      return "redirect:/everybare.do";    
	  }
	  
	  @RequestMapping(value = "/admin.do", method = RequestMethod.GET)
	  public String admin(HttpServletRequest request) {
	      // 세션에서 admin_cd 가져오기
		  int admin_cd;
	      Integer value = (Integer) request.getSession().getAttribute("ADMIN_CD");
	      admin_cd = (value != null) ? value : 0;

	      if (admin_cd > 0 ) {
	          return "admin_schedule"; // 관리자 페이지로 이동
	      } else {
	          return "redirect:/everybare.do"; // 일반 사용자 페이지로 리다이렉트
	      }
	  }
  
	  @GetMapping("/success")
	  public String successPage(@RequestParam Map<String, String> params, Model model) {
	        model.addAttribute("orderId", params.get("orderId"));
	        model.addAttribute("amount", params.get("amount"));
	        return "success";
	  }

	  @GetMapping("/fail")
	  public String failPage(@RequestParam Map<String, String> params, Model model) {
	        model.addAttribute("message", params.get("message"));
	        return "fail";
	  }
	  private final Logger logger = LoggerFactory.getLogger(this.getClass());

	  @RequestMapping(value = "/confirm")
	  public ResponseEntity<JSONObject> confirmPayment(@RequestBody String jsonBody,HttpServletRequest request) throws Exception {

	        JSONParser parser = new JSONParser();
	        String orderId;
	        String amount;
	        String paymentKey;
	        String Place;
	        
	        try {
	            // 클라이언트에서 받은 JSON 요청 바디입니다.
	            JSONObject requestData = (JSONObject) parser.parse(jsonBody);
	            paymentKey = (String) requestData.get("paymentKey");
	            orderId = (String) requestData.get("orderId");
	            amount = (String) requestData.get("amount");
		        Place = convertToString(request.getSession().getAttribute("Place"));
	        } catch (ParseException e) {
	            throw new RuntimeException(e);
	        };
	        Map<String, Object> PaymentKey = service.getPaymentKey(Place);
	        
	        String SECRET_key = convertToString(PaymentKey.get("SECRET_KEY"));
	        
	        JSONObject obj = new JSONObject();
	        obj.put("orderId", orderId);
	        obj.put("amount", amount);
	        obj.put("paymentKey", paymentKey);

	        // TODO: 개발자센터에 로그인해서 내 결제위젯 연동 키 > 시크릿 키를 입력하세요. 시크릿 키는 외부에 공개되면 안돼요.
	        // @docs https://docs.tosspayments.com/reference/using-api/api-keys
	        //String widgetSecretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";
	        String widgetSecretKey = SECRET_key;

	        // 토스페이먼츠 API는 시크릿 키를 사용자 ID로 사용하고, 비밀번호는 사용하지 않습니다.
	        // 비밀번호가 없다는 것을 알리기 위해 시크릿 키 뒤에 콜론을 추가합니다.
	        // @docs https://docs.tosspayments.com/reference/using-api/authorization#%EC%9D%B8%EC%A6%9D
	        Base64.Encoder encoder = Base64.getEncoder();
	        byte[] encodedBytes = encoder.encode((widgetSecretKey + ":").getBytes(StandardCharsets.UTF_8));
	        String authorizations = "Basic " + new String(encodedBytes);

	        // 결제 승인 API를 호출하세요.
	        // 결제를 승인하면 결제수단에서 금액이 차감돼요.
	        // @docs https://docs.tosspayments.com/guides/v2/payment-widget/integration#3-결제-승인하기
	        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
	        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
	        connection.setRequestProperty("Authorization", authorizations);
	        connection.setRequestProperty("Content-Type", "application/json");
	        connection.setRequestMethod("POST");
	        connection.setDoOutput(true);


	        OutputStream outputStream = connection.getOutputStream();
	        outputStream.write(obj.toString().getBytes("UTF-8"));

	        int code = connection.getResponseCode();
	        boolean isSuccess = code == 200;

	        InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

	        // TODO: 결제 성공 및 실패 비즈니스 로직을 구현하세요.
	        Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
	        JSONObject jsonObject = (JSONObject) parser.parse(reader);
	        
	        responseStream.close();

	        return ResponseEntity.status(code).body(jsonObject);
	    }
	  
	  @RequestMapping(value = "/downloadSalesExcel.do", method = RequestMethod.GET)
	  public void downloadSalesExcel(@RequestParam Map<String, String> params, HttpServletResponse response) {
	      try {
	          Map<String, Object> queryParams = new HashMap<>();
	          for (Map.Entry<String, String> entry : params.entrySet()) {
	              if (entry.getValue() != null && !entry.getValue().isEmpty()) {
	                  queryParams.put(entry.getKey(), entry.getValue());
	              }
	          }
	          
				/*
				 * // ✅ limit과 start의 기본값 설정 (NULL 방지) int limit = params.containsKey("limit")
				 * && !params.get("limit").isEmpty() ? Integer.parseInt(params.get("limit")) :
				 * 10; int start = params.containsKey("start") && !params.get("start").isEmpty()
				 * ? Integer.parseInt(params.get("start")) : 0;
				 * 
				 * queryParams.put("limit", limit); queryParams.put("start", start)
				 */;

	          
	          // 엑셀 파일 생성
	          Workbook workbook = new XSSFWorkbook();
	          Sheet sheet = workbook.createSheet("매출 데이터");

	          // 헤더 생성
	          Row headerRow = sheet.createRow(0);
	          String[] headers = {"번호", "결제정보", "회원명", "수강권명", "결제일", "지점", "카드 결제", "현금 결제", "총 결제금액", "미수금", "취소 여부", "취소일"};
	          for (int i = 0; i < headers.length; i++) {
	              headerRow.createCell(i).setCellValue(headers[i]);
	          }

	          // 매출 데이터 가져오기
	          List<Map<String, Object>> salesList = service.getSalesList(queryParams);
        	  CellStyle numberStyle = workbook.createCellStyle();
        	  DataFormat format = workbook.createDataFormat();
        	  numberStyle.setDataFormat(format.getFormat("#,##0")); 
	          // 데이터 행 추가
	          int rowNum = 1;
	          for (Map<String, Object> sale : salesList) {
	        	  
	              Row row = sheet.createRow(rowNum++);
	              String user = "-";
	              if((convertToString(sale.get("TICKET_NAME")) == "1회체험권 (계정당한번만 가능)") || (convertToString(sale.get("TICKET_NAME")).equals("1회체험권 (계정당한번만 가능)"))){
	            	  user = "체험";
	              }else if(convertToString(sale.get("USER_CASH")) == "1" || convertToString(sale.get("USER_CASH")).equals("1")){
	            	  user = "신규";
	              }else if(convertToString(sale.get("USER_CASH")) != "1" || !convertToString(sale.get("USER_CASH")).equals("1") || convertToString(sale.get("USER_CASH")) != "0" || !convertToString(sale.get("USER_CASH")).equals("0")){
	            	  user = "재등록";
	              }
	              row.createCell(0).setCellValue(rowNum - 1);
	              row.createCell(1).setCellValue(user);
	              row.createCell(2).setCellValue(convertToString(sale.get("USER_NAME"))); 
	              row.createCell(3).setCellValue(convertToString(sale.get("TICKET_NAME")));
	              row.createCell(4).setCellValue(convertToString(sale.get("PAYMENT_DATE_KST"))); 
	              row.createCell(5).setCellValue(convertToString(sale.get("LOCATION"))); 
	              row.createCell(6).setCellStyle(numberStyle);
	              row.createCell(7).setCellStyle(numberStyle);
	              row.createCell(8).setCellStyle(numberStyle);
	              row.createCell(9).setCellStyle(numberStyle);
	              row.createCell(6).setCellValue(Integer.parseInt(sale.get("CARD_AMOUNT").toString())); 
	              row.createCell(7).setCellValue(Integer.parseInt(sale.get("CASH_AMOUNT").toString())); 
	              row.createCell(8).setCellValue(Integer.parseInt(sale.get("TOTAL_AMOUNT").toString()));
	              row.createCell(9).setCellValue(Integer.parseInt(sale.get("DUE_AMOUNT").toString())); 
	              row.createCell(10).setCellValue(convertToString(sale.get("CANCEL_YN")).equals("Y") ? "✅ 취소됨" : "-"); 
	              row.createCell(11).setCellValue(convertToString(sale.get("CANCEL_DATE_KST") != null ? sale.get("CANCEL_DATE_KST") : "-"));
	            
	          }
	          // 🔹 필터 값 가져오기 (빈 값일 경우 ""로 처리)
	          String startDate = params.getOrDefault("startDate", "").trim();
	          String endDate = params.getOrDefault("endDate", "").trim();
	          String filterTicket = params.getOrDefault("filterTicket", "").trim();
	          String filterLocation = params.getOrDefault("filterLocation", "").trim();
	          
	       // 🔹 filterLocation이 비어 있으면 "전체지점"으로 설정
	          filterLocation = filterLocation.isEmpty() ? "전체지점" : filterLocation + "";

	          // 🔹 엑셀 파일명 동적 생성
	          String name = filterLocation + " " +
	                        (filterTicket.isEmpty() ? "" : filterTicket + " ") +
	                        (startDate.isEmpty() ? "" : startDate + "부터 ") +
	                        (endDate.isEmpty() ? "" : endDate + "까지 ") +
	                        "매출";

	          // 🔹 디버깅: 생성된 파일명 출력
	          System.out.println("📌 생성된 엑셀 파일명: " + name);
	          
	          // 🔹 파일명 UTF-8 URL 인코딩 적용 (브라우저에서 한글 깨짐 방지)
	          String encodedFileName = URLEncoder.encode(name, StandardCharsets.UTF_8.toString()).replaceAll("\\+", "%20");


	          // 응답 헤더 설정
	          response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	          response.setHeader("Content-Disposition", "attachment; filename="+encodedFileName+".xlsx");

	          // 엑셀 파일 출력
	          OutputStream outputStream = response.getOutputStream();
	          workbook.write(outputStream);
	          workbook.close();
	          outputStream.close();
	      } catch (Exception e) {
	          e.printStackTrace();
	      }
	  }
	  
	// 실제 이미지가 저장될 서버 경로
	    private static final String IMAGE_DIR = "/jo7220/tomcat/webapps/static_uploads/img/"; // 예: /usr/local/project/img

	    @PostMapping("/uploadSlideImage.do")
	    public String uploadSlideImages(@RequestParam("slide1") MultipartFile slide1,
	                                    @RequestParam("slide2") MultipartFile slide2,
	                                    @RequestParam("slide3") MultipartFile slide3,
	                                    HttpServletRequest request,
	                                    Model model) {
	    	String realPath = new File(".").getAbsolutePath();
	    	System.out.println("현재 절대 경로: " + realPath);
	        try {
	            saveFile(slide1, "에사회1.jpg");
	            saveFile(slide2, "에사회2.jpg");
	            saveFile(slide3, "에사회3.jpg");

	            model.addAttribute("message", "업로드가 완료되었습니다!");
	        } catch (Exception e) {
	            e.printStackTrace();
	            model.addAttribute("message", "업로드 실패: " + e.getMessage());
	        }

	        return "redirect:/admin_slide_upload.do"; // JSP 페이지로 리다이렉트
	    }

	    private void saveFile(MultipartFile file, String targetName) throws IOException {
	        if (file != null && !file.isEmpty()) {
	            File dir = new File(IMAGE_DIR);
	            if (!dir.exists()) {
	                dir.mkdirs();  // ✅ 폴더 없으면 생성
	            }

	            File target = new File(dir, targetName);
	            file.transferTo(target);
	        }
	    }
	    
	    @GetMapping("/downloadMemberExcel.do")
	    public void downloadMemberExcel(@RequestParam(required = false) String name,
	                                    @RequestParam(required = false) String phone,
	                                    HttpServletResponse response) throws IOException {

	        Map<String, Object> filter = new HashMap<>();
	        if (name != null && !name.trim().isEmpty()) {
	            filter.put("name", name.trim());
	        }
	        if (phone != null && !phone.trim().isEmpty()) {
	            filter.put("phone", phone.trim());
	        }

	        List<Map<String, Object>> members = service.getFilteredMemberList(filter);  // 👈 이름과 전화번호 조건 적용

	        // 엑셀 생성 및 다운로드
	        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	        response.setHeader("Content-Disposition", "attachment; filename=\"member_list.xlsx\"");

	        XSSFWorkbook workbook = new XSSFWorkbook();
	        XSSFSheet sheet = workbook.createSheet("회원목록");

	        Row header = sheet.createRow(0);
	        header.createCell(0).setCellValue("번호");
	        header.createCell(1).setCellValue("이름");
	        header.createCell(2).setCellValue("전화번호");
	        header.createCell(3).setCellValue("이메일");
	        header.createCell(4).setCellValue("생년월일");
	        header.createCell(5).setCellValue("가입일자");
	        header.createCell(6).setCellValue("수강권명");
	        header.createCell(7).setCellValue("수강권남은횟수");
	        header.createCell(8).setCellValue("수강권시작일자");
	        header.createCell(9).setCellValue("수강권종료일자");
	        header.createCell(10).setCellValue("지불금액");
	        header.createCell(11).setCellValue("미수금");
	        header.createCell(12).setCellValue("결제지점");
	        header.createCell(13).setCellValue("결제일");
	        header.createCell(14).setCellValue("결제구분");
	        header.createCell(15).setCellValue("취소여부");
	        header.createCell(16).setCellValue("취소일");

	        int rowNum = 1;
	        for (Map<String, Object> member : members) {
	            Row row = sheet.createRow(rowNum++);

	            row.createCell(0).setCellValue(rowNum - 1);
	            row.createCell(1).setCellValue(convertToString(member.get("USER_NAME")) != null ? convertToString(member.get("USER_NAME")) : "");
	            row.createCell(2).setCellValue(convertToString(member.get("USER_PHONE")) != null ? convertToString(member.get("USER_PHONE")) : "");
	            row.createCell(3).setCellValue(convertToString(member.get("USER_MAIL")) != null ? convertToString(member.get("USER_MAIL")) : "");
	            row.createCell(4).setCellValue(convertToString(member.get("USER_BIRTH")) != null ? convertToString(member.get("USER_BIRTH")) : "");
	            row.createCell(5).setCellValue(convertToString(member.get("USER_JOIN")) != null ? convertToString(member.get("USER_JOIN")) : "");
	            row.createCell(6).setCellValue(convertToString(member.get("TICKET_NAME")) != null ? convertToString(member.get("TICKET_NAME")) : "");
	            row.createCell(7).setCellValue(parseIntSafe(member.get("TICKET_COUNT")));
	            row.createCell(8).setCellValue(convertToString(member.get("START_DATE")) != null ? convertToString(member.get("START_DATE")) : "");
	            row.createCell(9).setCellValue(convertToString(member.get("EMD_DATE")) != null ? convertToString(member.get("EMD_DATE")) : "");
	            row.createCell(10).setCellValue(parseIntSafe(member.get("TOTAL_AMOUNT")));
	            row.createCell(11).setCellValue(parseIntSafe(member.get("DUE_AMOUNT")));
	            row.createCell(12).setCellValue(convertToString(member.get("LOCATION")) != null ? convertToString(member.get("LOCATION")) : "");
	            row.createCell(13).setCellValue(convertToString(member.get("PAYMENT_DATE")) != null ? convertToString(member.get("PAYMENT_DATE")) : "");
	              String user = "-";
	              if(member.get("TICKET_NAME") != null) {
	              if((convertToString(member.get("TICKET_NAME")) == "1회체험권 (계정당한번만 가능)") || (convertToString(member.get("TICKET_NAME")).equals("1회체험권 (계정당한번만 가능)"))){
	            	  user = "체험";
	              }else if(convertToString(member.get("USER_CASH")) == "1" || convertToString(member.get("USER_CASH")).equals("1")){
	            	  user = "신규";
	              }else if(convertToString(member.get("USER_CASH")) != "1" || !convertToString(member.get("USER_CASH")).equals("1") || convertToString(member.get("USER_CASH")) != "0" || !convertToString(member.get("USER_CASH")).equals("0")){
	            	  user = "재등록";
	              }
	              }
	             row.createCell(14).setCellValue(user);
	            row.createCell(15).setCellValue(convertToString(member.get("CANCEL_YN")).equals("Y") ? "✅ 취소됨" : "-");
	            row.createCell(16).setCellValue(convertToString(member.get("CANCEL_DATE") != null ? member.get("CANCEL_DATE_KST") : "-"));
	        }


	        workbook.write(response.getOutputStream());
	        workbook.close();
	    }
	    private int parseIntSafe(Object obj) {
	        if (obj == null) return 0;
	        try {
	            return Integer.parseInt(obj.toString());
	        } catch (NumberFormatException e) {
	            return 0;
	        }
	    }
	    @GetMapping("/downloadClassExcel.do")
	    public void downloadClassExcel(@RequestParam(required = false) String startDate,
	                                   @RequestParam(required = false) String endDate,
	                                   @RequestParam(required = false) String location,
	                                   @RequestParam(required = false) String teacher,
	                                   HttpServletResponse response) throws IOException {

	        Map<String, Object> filter = new HashMap<>();
	        filter.put("startDate", startDate);
	        filter.put("endDate", endDate);
	        if(location == "all" || location.equals("all")) {
	        	location = "";
	        }
	        if(teacher == "all" || teacher.equals("all")) {
	        	teacher = "";
	        }
	        filter.put("location", location);
	        filter.put("teacher", teacher);

	        List<Map<String, Object>> classList = service.getFilteredClassList(filter);
	        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	        response.setHeader("Content-Disposition", "attachment; filename=\"class_list.xlsx\"");

	        XSSFWorkbook workbook = new XSSFWorkbook();
	        XSSFSheet sheet = workbook.createSheet("강의목록");

	        Row header = sheet.createRow(0);
	        header.createCell(0).setCellValue("번호");
	        header.createCell(1).setCellValue("지점");
	        header.createCell(2).setCellValue("수업명");
	        header.createCell(3).setCellValue("강사");
	        header.createCell(4).setCellValue("날짜");
	        header.createCell(5).setCellValue("시간");
	        header.createCell(6).setCellValue("수강인원");
	        header.createCell(7).setCellValue("대기인원");
	        header.createCell(8).setCellValue("최대인원");

	        int rowNum = 1;
	        for (Map<String, Object> cls : classList) {

	            Row row = sheet.createRow(rowNum++);
	            
	            row.createCell(0).setCellValue(rowNum - 1);
	            row.createCell(1).setCellValue(convertToString(cls.get("LOCATION")));
	            row.createCell(2).setCellValue(convertToString(cls.get("CLASS")));
	            row.createCell(3).setCellValue(convertToString(cls.get("TEACHER")));
	            row.createCell(4).setCellValue(convertToString(cls.get("DATE")));
	            row.createCell(5).setCellValue(convertToString(cls.get("TIME")));
	            row.createCell(6).setCellValue(Integer.parseInt(convertToString(cls.get("PEOPLE"))));
	            row.createCell(7).setCellValue(Integer.parseInt(convertToString(cls.get("WAITNUMBER"))));
	            row.createCell(8).setCellValue(Integer.parseInt(convertToString(cls.get("MAXPEOPLE"))));
	        }

	        workbook.write(response.getOutputStream());
	        workbook.close();
	    }
	    @GetMapping("/getSiteContent.do")
	    @ResponseBody
	    public String getSiteContent(@RequestParam("id") String id) {
	        return service.getContent(id);
	    }

	    @PostMapping("/updateSiteContent.do")
	    @ResponseBody
	    public String updateSiteContent(@RequestParam("id") String id,
	                                    @RequestParam("content") String content) {
	    	service.updateContent(id, content);
	        return "success";
	    }



	
	
}


