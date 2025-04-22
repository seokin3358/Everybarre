<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% String userName = (String) session.getAttribute("userName"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOK</title>
<%
    String store = request.getParameter("store");

if (store == null || store.trim().isEmpty()) {
%>
<script type="text/javascript">
    alert("점포를 선택하지 않았습니다.");
    window.location.href = "/everybare.do";
</script>
<%
    return; // 아래 코드가 실행되지 않도록 리턴
}
%>
 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">

<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

        <!--    Google Fonts-->
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/GmarketSans/GmarketSans.css" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fonts-archive/Aggro/Aggro.css" type="text/css"/>

        <!--Fontawesom-->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!--Animated CSS-->
        <link rel="stylesheet" type="text/css" href="css/animate.min.css">

        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!--Bootstrap Carousel-->
        <link type="text/css" rel="stylesheet" href="css/carousel.css" />
        <script type="text/javascript" src="js/isotope/isotope.pkgd.min.js"></script>

        <link rel="stylesheet" href="css/isotope/style.css">

        <!--Main Stylesheet-->
        <link href="css/style.css" rel="stylesheet">
        <!--Responsive Framework-->
        <link href="css/responsive.css" rel="stylesheet">
        <script src="js/jquery-1.12.3.min.js"></script>
<style>
@font-face {
    font-family: 'Cafe24OhsquareAir-v2.0';
    src: url('/fonts/Cafe24OhsquareAir-v2.0.otf') format('opentype');
}
        
        body, html {
        font-family: "Cafe24OhsquareAir-v2.0", sans-serif;
		  font-style: normal;
        }
.week-day {
  background-color: #333;
  color: white;
  border-radius: 6px;
  padding: 12px 8px;
  font-size: 13px;
  transition: 0.2s ease-in-out;
}

.week-day.selected {
  background-color: #e94560;
  color: white;
  font-weight: bold;
}
.header_menu {
    position: fixed;
    width: 100%;
    height: 60px; /* 고정 높이 */
    background-color: #e94560;
    display: flex;
    align-items: center; /* 로고와 메뉴를 한 줄로 정렬 */
    justify-content: space-between;
    padding: 10px 20px;
    z-index: 1000;
}

/* 📌 로고 스타일 */
.navbar-brand {
    display: flex;
    align-items: center; /* 로고 중앙 정렬 */
}

/* 📌 네비게이션 메뉴 */
.navbar-nav {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
}

.navbar-nav li a {
    font-size: 14px;
    color: white;
    padding: 8px 12px;
}

.navbar-header {
  position: relative;
  left: 35%; /* 네모칸과 화살표 방향으로 로고 이동 */
}

.custom_navbar-brand {
  margin-left: 0; /* 필요하면 이 값을 조정 */
  text-align: left; /* 정렬 */
}
.navbar-right {
  margin-right: -15%; 
}
body {
			font-size: 25px;
            background-color: #1f1f1f;
            color: #ffffff;
            text-align: center;
        }

        .calendar {
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 5%;
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            width: 60%;
            margin-bottom: 20px;
            align-items: center;
        }

        .week-range-container {
            flex-grow: 1; /* 중앙에 오도록 공간 차지 */
            text-align: center; /* 중앙 정렬 */
        }

        .calendar-header button {
            background-color: #333;
            border: none;
            color: #fff;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .calendar-header button:hover {
            background-color: #555;
        }

        .week-days {
            display: flex;
            justify-content: space-around;
            width: 60%;
            margin: 0 auto;
        }

        .week-day {
            width: 100px;
            padding: 20px;
            background-color: #333;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .week-day:hover {
            background-color: #555;
        }

        .week-day.selected {
            background-color: #e94560;
        }

        .no-classes {
            margin-top: 20px;
            font-size: 18px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            color: white;
            background-color: #2c2c2c;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #444;
        }
        th {
            background-color: #333;
        }
        td img {
            border-radius: 50%;
            width: 50px;
            height: 50px;
        }
        .time, .location, .duration {
            width: 10%;
        }
        .class, .instructor {
            width: 25%;
        }
        .notes {
            width: 20%;
            text-align: right;
        }
         /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.7);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #333;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            color: white;
            border-radius: 10px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: #fff;
            text-decoration: none;
            cursor: pointer;
        }

        .modal h2 {
            margin-top: 0;
        }

        .modal p {
            margin: 15px 0;
        }
        .navbar-right {
		  margin-right: -15%; 
		}
        /* ✅ 모바일 최적화 */
@media screen and (max-width: 768px) {
.h3, h3 {
    font-size: 21px;
}
	body {
    font-size: 14px;
    
  }
  .calendar {
    margin-top: 10px; /* 선택 영역 내려줌 */
  }

  .calendar-header {
    flex-direction: column;
    width: 100% !important;
    padding: 0 10px;
  }

  .week-days {
    grid-template-columns: repeat(2, 1fr);
    gap: 5px;
    padding: 0 10px;
  }

  .week-day {
    font-size: 10px;
    padding: 10px 5px;
  }
  .table-wrapper {
  width: 60%;
  margin: auto;
  height: auto;
}
	.slider{
	 padding-top: 70px;
	}
  .table-wrapper {
    width: 100% !important;
    padding: 0 10px;
  }


  .calendar,
  .week-range-container {
    width: 100% !important;
    padding: 0 10px;
  }

  table {
    font-size: 12px;
    width: 100% !important;
    overflow-x: auto;
    display: block;
     min-width: 600px;
  }

  th, td {
    padding: 6px;
  }

 
	.calendar-header,
	  #classList,
	  #dayset,
	  #dayclassList,
	  table {
	    width: 100% !important;
	  }
	    .navbar-collapse {
        display: none; /* 기본적으로 숨김 */
        position: absolute;
        top: 60px;
        left: 0;
        width: 100%;
        background-color: #e94560;
        padding: 10px;
    }

    /* 📌 토글 버튼 클릭 시 메뉴 표시 */
    .navbar-collapse.show {
        display: block !important;
    }
    .calendar {
        flex-direction: column;
    }

    .calendar-header {
        flex-direction: column;
        align-items: center;
    }

    .week-days {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 10px;
        margin-top: 10px;
    }

    .week-day {
        font-size: 10px;
        padding: 8px;
    }

    table {
        font-size: 12px;
    }

    th, td {
        padding: 8px;
    }
	 .modal-content {
    padding: 20px;
    font-size: 14px;
    text-align: left;
  }
    .modal-content .close {
    top: 10px;
    right: 15px;
    font-size: 24px;
  }

  .modal-content h2 {
    font-size: 18px;
    margin-bottom: 15px;
  }
  .modal-flex-wrapper {
    flex-direction: column !important; /* ✅ 모바일에서는 세로 정렬 */
    gap: 10px;
  }

  .modal-left,
  .modal-right {
    width: 100% !important;  /* ✅ 양쪽 모두 꽉 차게 */
  }

  .modal-left p {
    margin-bottom: 8px;
    line-height: 1.4;
  }

  .modal-right p {
    margin-bottom: 6px;
  }

  .modal-buttons {
    display: flex;
    justify-content: center;
    margin-top: 20px;
  }

  .modal-buttons button {
    padding: 12px 24px;
    font-size: 16px;
    border-radius: 6px;
  }

    .calendar-header button {
        width: 100%;
        margin: 5px 0;
    }

    .today-button {
        width: 100%;
        margin-top: 5px;
    }
    .modal-container {
        flex-direction: column;
        gap: 15px;
    }    

    .modal-buttons .btn-experience,
    .modal-buttons .btn-enroll {
        width: 100%;
    }
    .navbar-header {
	  position: relative;
	  left:17%;
	}
	.navbar-right {
	  margin-right: 0%; 
	}

    .header_menu {
        height: 60px; /* 모바일에서 헤더 높이 줄이기 */
        padding: 5px 15px;
    }

    .navbar-brand img {
        max-width: 200px; /* 모바일에서 로고 크기 증가 */
        height: auto;
    }
     .navbar-toggler {
        position: absolute;
        left: 10px; /* 왼쪽 정렬 */
        top: 15px;
        z-index: 1050;
        background-color: transparent;
        border: none;
        font-size: 24px;
        color: white;
    }
    .navbar-nav {
        flex-direction: column; /* 세로 정렬 */
        align-items: flex-start;
    }

    .navbar-nav li {
        width: 100%;
    }

    .navbar-nav li a {
        font-size: 14px;
        padding: 10px;
        display: block;
    }
}
</style>
</head>
<body>

<section id="header">
            <div class="header-area">
			<div class="header_menu text-center" data-spy="affix" data-offset-top="50" id="nav">
                    <div class="container">
                        <nav class="navbar navbar-default zero_mp ">
                            <!-- Brand and toggle get grouped for better mobile display -->
                            <div class="navbar-header">                            
                                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand custom_navbar-brand" href="/everybare.do"><img src="/static_uploads/img/logo.png" alt=""></a>
                            </div>
                            <!--End of navbar-header-->

                            <!-- Collect the nav links, forms, and other content for toggling -->
                            <div class="collapse navbar-collapse zero_mp" id="bs-example-navbar-collapse-1">
                                <ul class="nav navbar-nav navbar-right main_menu">
                                    <li><a href="/everybare.do#header">Home </a></li>
                                    <li class="active"><a href="/barebook.do">book<span class="sr-only">(current)</span></a></li>
                                    <% if (userName != null) { %>
						                <!-- 로그인 상태일 때 -->
						                <li><a href="/mypage.do">My Page</a></li> <!-- 마이페이지 버튼 -->
						                <li><a href="/logout.do">Logout</a></li> <!-- 로그아웃 버튼 -->
						            <% } else { %>
						                <!-- 로그인되지 않았을 때 -->
						                <li><a href="/barelogin.do">Login</a></li> <!-- 로그인 버튼 -->
						            <% } %>
                                    <li><a href="/everybare.do#contact_us" >contact us</a></li>
                                </ul>
                            </div>
                            <!-- /.navbar-collapse -->
                        </nav>
                        <!--End of nav-->
                    </div>
                    <!--End of container-->
                </div></div></section>
                <section id="slider" class="slider">
  <div class="calendar">
        <div class="calendar-header">
            
            <div class="week-range-container" id="weekRange">
                <h2 id="weekRange"></h2>
            </div>
            <div style="display: flex; gap: 10px;">
            	<button onclick="prevWeek()">←</button>
                <button class="today-button" onclick="goToToday()">Today</button>
                <button onclick="nextWeek()">→</button>
            </div>
        </div>
    </div>

    <div class="week-days" id="weekDays">
        <!-- 각 요일이 여기에 동적으로 생성됩니다. -->
    </div>
    
    <div class="table-wrapper">
    	<table id="tableList" style="width:100%">
    		<thead></thead>
    		<tbody id="classList">
    		</tbody>
    	</table> 
    </div>
    
    <div style="margin-top:2%; padding-bottom: 10%;">
    <header id="dayset"></header>
    <div style="overflow-x: auto;">
    <table style="width:60%; margin:auto; height:50%;">
        <thead>        	
            <tr>
                <th class="time" style="width:20%;">Time</th>
                <th class="Teacher" style="width:20%;">Teacher</th>
                <th class="class" style="width:20%;">Class</th>
                <td class="people" style="width:20%;">People</td>
                <td class="people" style="width:20%;">Wait People</td>
            </tr>
        </thead>
        <tbody id="dayclassList">
            
        </tbody>
    </table>
	</div>
	</div>
    </section>
<!-- 모달 구조 -->
<div id="myModal" class="modal">
  <div class="modal-content">
    
  </div>
</div>
<script>	
	// 모달 열기 및 닫기 기능
    var modal = document.getElementById("myModal");
    var span = document.getElementsByClassName("close")[0];
    var modalContent = modal.querySelector('.modal-content');
	var store = "<%= store %>";

    // modalclick 함수 수정
    function modalclick(event) {
        // 클릭한 tr 요소 가져오기
        var clickedRow = event.target.closest('tr'); // 클릭한 tr 상위 행
        if (!clickedRow) return;

        // tr 안의 데이터를 가져오기
        var time = clickedRow.querySelector('.time p')?.textContent || "시간 없음";
        var teacher = clickedRow.querySelector('.Teacher')?.textContent || "강사 정보 없음";
        var className = clickedRow.querySelector('.class p')?.textContent || "클래스 정보 없음";
        var people = clickedRow.querySelector('.people')?.textContent || "인원 정보 없음";
        var wait = clickedRow.querySelector('.wait')?.textContent || "대기 정보 없음";
        var bookId = clickedRow.getAttribute("data-bookid"); 

     // 모달 내용을 동적으로 설정
        var modalHTML = '<span class="close">&times;</span>';

        // ✅ 공통: 좌우 정렬 (PC), 모바일은 CSS media query로 세로로 바뀜
        modalHTML += '<div class="modal-flex-wrapper" style="display: flex; justify-content: center; align-items: flex-start; gap: 20px; text-align: left; margin: 20px 0;">';

        // 왼쪽 영역 (설명)
        modalHTML += '<div class="modal-left" style="width: 35%; text-align: left;">';
        modalHTML += '<p>📌수업 예약 시 참고하여 주시고, 모두가 즐거운 에블바레가 될 수 있도록 예약 에티켓을 지켜주세요!🔥</p>';
        modalHTML += '<p>*에블바레의 수업은 정원제로 운영됩니다. 어떤 경우에도 당일 취소 및 변경, 환불이 불가합니다.</p>';
        modalHTML += '<p>*수업 시간 5분 지각시 입장이 제한됩니다.</p>';
        modalHTML += '<p>*언리미티드 회원님의 경우 노쇼 2회시 5일간 예약 불가합니다.</p>';
        modalHTML += '<p>*수강권 가격 안내 및 문의사항은 DM 주시면 순차적으로 답변 드립니다.</p>';
        modalHTML += '</div>';

        // 오른쪽 영역 (클래스 정보)
        modalHTML += '<div id="BookClass" class="modal-right" style="width: 30%; text-align: left; font-size: 14px; line-height: 1.5;">';
        modalHTML += '<h2>' + className + ' 클래스 정보</h2>';
        modalHTML += '<p class="Time" value="'+ time +'">시간: ' + time + '</p>';
        modalHTML += '<p class="Teacher" value="'+ teacher +'">강사: ' + teacher + '</p>';
        modalHTML += '<p class="Class" value="'+ className +'">클래스명: ' + className + '</p>';
        modalHTML += '<p class="People" value="'+ people +'">인원: ' + people + '</p>';
        modalHTML += '<p class="Wait" value="'+ wait +'">대기인원: ' + wait + '</p>';
        modalHTML += '</div>';

        modalHTML += '</div>'; // flexbox 종료

        // 버튼 영역
        modalHTML += '<div class="modal-buttons" style="margin-top: 20px; display: flex; justify-content: center; gap: 10px;">';
        modalHTML += '<button onclick="checkLoginAndProceed(\'enroll\', \'' + bookId + '\')" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;">수강하기</button>';
        modalHTML += '</div>';

        modalContent.innerHTML = modalHTML;

        // 모달 열기
        modal.style.display = "block";

        // 닫기 버튼 다시 연결
        modalContent.querySelector('.close').onclick = function () {
            modal.style.display = "none";
        };
    }
 	// 유저 로그인 여부 확인
    const userName = "<%= userName != null ? userName : "" %>";

    function checkLoginAndProceed(action, bookId) {
        if (!userName) {
            alert("로그인이 필요합니다!");
            window.location.href = "/barelogin.do"; // 로그인 페이지로 이동
            return;
        }
        
        // 선택된 날짜 및 시간 유효성 검사
        if (!validateClassDateTime()) {
            return;
        }
        
        if (action === "enroll") {
        	usercheck(bookId);
            
        }
    }
    
    function usercheck(bookId){
    	const selectedDateElement = document.querySelector('.week-day.selected');
        if (!selectedDateElement) {
            alert("날짜를 선택해주세요!");
            return;
        }
        const selectedDate = selectedDateElement.dataset.date; // YYYY-MM-DD

        // 수업 정보 가져오기
        const bookClassElement = document.getElementById("BookClass");
        const classTime = bookClassElement.querySelector(".Time")?.getAttribute("value") || "00:00";
        const teacher = bookClassElement.querySelector(".Teacher")?.getAttribute("value") || "미정";
        const className = bookClassElement.querySelector(".Class")?.getAttribute("value") || "미정";
        const people = bookClassElement.querySelector(".People")?.getAttribute("value") || "0/10";

        // 수강 정보 객체 생성
        var sendData = {
            USER_NAME: "<%= userName %>",  // JSP에서 가져온 세션 유저 이름
            CLASS_NAME: className,
            CLASS_DATE: selectedDate,
            CLASS_TIME: classTime,
            TEACHER: teacher,
            CURRENT_PEOPLE: people.split("/")[0], // 현재 수강 인원
            MAX_PEOPLE: people.split("/")[1], // 최대 수강 인원
            STORE: "<%= store %>" // 현재 선택된 점포
        };
    	
    	 $.ajax({
             type: "POST",
             url: "/userTicketCheck",  // 서버 예약 엔드포인트
             data: sendData,
             dataType: "json",
             success: function (response) {
                 if (response.success) {
                	 enroll(bookId); // 수강하기 로직 실행
                 } else {
                     alert(response.message || "수강권이 존재하지 않습니다.");
                 }
             },
             error: function () {
                 alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
             }
         });
    }


    // 수강하기 버튼 클릭 로직
    function enroll(bookId) {
     // 선택된 날짜
        const selectedDateElement = document.querySelector('.week-day.selected');
        if (!selectedDateElement) {
            alert("날짜를 선택해주세요!");
            return;
        }
        const selectedDate = selectedDateElement.dataset.date; // YYYY-MM-DD

        // 수업 정보 가져오기
        const bookClassElement = document.getElementById("BookClass");
        const classTime = bookClassElement.querySelector(".Time")?.getAttribute("value") || "00:00";
        const teacher = bookClassElement.querySelector(".Teacher")?.getAttribute("value") || "미정";
        const className = bookClassElement.querySelector(".Class")?.getAttribute("value") || "미정";
        const people = bookClassElement.querySelector(".People")?.getAttribute("value") || "0/10";
        const wait = bookClassElement.querySelector(".Wait")?.getAttribute("value") || "0/10";        

        // 수강 정보 객체 생성
        var sendData = {
            USER_NAME: "<%= userName %>",  // JSP에서 가져온 세션 유저 이름
            CLASS_NAME: className,
            CLASS_DATE: selectedDate,
            CLASS_TIME: classTime,
            TEACHER: teacher,
            CURRENT_PEOPLE: people.split("/")[0], // 현재 수강 인원
            MAX_PEOPLE: people.split("/")[1], // 최대 수강 인원
            STORE: "<%= store %>", // 현재 선택된 점포
            WAIT: wait,
            BOOK_ID: bookId 
        };

        // 수강 인원이 다 찼을 경우 대기 여부 확인
        if (people.split("/")[0] >= 10) {

            if (confirm("수강 인원이 다 찼습니다. 대기인원 : "+wait+"명 대기하시겠습니까?")) {
                waitClass(sendData); // wait() 함수 실행
                return;
            } else {
                alert("수강 신청이 취소되었습니다.");
                return; // AJAX 요청 실행 안함
            }
        }
        
        // AJAX 요청
         $.ajax({
            type: "POST",
            url: "/reserveClass",  // 서버 예약 엔드포인트
            data: sendData,
            dataType: "json",
            success: function (response) {
                if (response.success) {
                    alert("수강 신청이 완료되었습니다.");
                    window.location.reload(); // 페이지 새로고침
                } else {
                    alert(response.message || "수강 신청에 실패했습니다.");
                }
            },
            error: function () {
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
         
    }
    
	 // 대기 등록 함수
    function waitClass(sendData) {
        $.ajax({
            type: "POST",
            url: "/waitClass",  // 서버 대기 등록 엔드포인트
            data: sendData,
            dataType: "json",
            success: function (response) {
                if (response.success) {
                    alert("대기 등록이 완료되었습니다.");
                    window.location.reload(); // 페이지 새로고침
                } else {
                    alert(response.message || "대기 등록에 실패했습니다.");
                }
            },
            error: function () {
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    }
    
    /**
     * 날짜 및 시간 검증 함수
     */
    function validateClassDateTime() {
    	 // 선택된 날짜 가져오기
        const selectedDateElement = document.querySelector('.week-day.selected');
        if (!selectedDateElement) {
            alert("날짜를 선택해주세요!");
            return false;
        }

        const selectedDate = selectedDateElement.dataset.date;

        // 현재 날짜와 시간
        const currentDate = new Date();

        // 선택된 시간 가져오기
        const timeText = document.getElementById("BookClass").querySelector(".Time").getAttribute("value") || "00:00"; // 시간 문자열 가져오기
        const [hours, minutes] = timeText.split(':').map(Number); // 시와 분 분리
        const selectedDateTime = new Date(selectedDate); // 선택된 날짜 객체 생성
        selectedDateTime.setHours(hours); // 시간 설정
        selectedDateTime.setMinutes(minutes); // 분 설정

        // 오늘 날짜 이전인지 확인
        if (selectedDateTime <= currentDate) {
            alert("지난 날짜나 시간의 강의는 예약할 수 없습니다!");
            return false;
        }

        // 2주 이후 날짜 확인
        const twoWeeksLater = new Date();
        twoWeeksLater.setDate(currentDate.getDate() + 14);
        if (selectedDateTime > twoWeeksLater) {
            alert("2주 이후의 날짜는 예약할 수 없습니다!");
            return false;
        }

        return true;
    }

    // 클릭 이벤트 연결
    document.querySelectorAll("tr[onclick='modalclick();']").forEach(function (row) {
        row.addEventListener("click", modalclick);
    });
	  window.onclick = function(event) {
	    if (event.target == modal) {
	      modal.style.display = "none";
	    }
	  }

        const weekDaysElement = document.getElementById('weekDays');
        const weekRangeElement = document.getElementById('weekRange');
        const noClassesMessage = document.getElementById('noClassesMessage');

        var currentDate = new Date();
        var selectedDate = null;

        function startOfWeek(date) {
            const day = date.getDay();
            const diff = date.getDate() - day + (day === 0 ? -6 : 1); // Adjust when day is Sunday
            return new Date(date.setDate(diff));
        }

        function getWeekDates(date) {
            const start = startOfWeek(new Date(date));
            const weekDates = [];
            for (let i = 0; i < 7; i++) {
                const day = new Date(start);
                day.setDate(start.getDate() + i);
                weekDates.push(day);
            }
            return weekDates;
        }

        function updateWeek() {
        	const store = "<%= store%>";
        	
            const weekDates = getWeekDates(currentDate);
            weekDaysElement.innerHTML = '';
            weekDates.forEach((date) => {
                const weekDayElement = document.createElement('div');
                weekDayElement.className = 'week-day';
                
                weekDayElement.textContent = date.getMonth() + 1+"월"+ date.getDate()+"일   "+ ['일', '월', '화', '수', '목', '금', '토'][date.getDay()]+"요일";                               

                weekDayElement.dataset.date = date.toISOString().slice(0, 10); // 날짜 데이터를 저장

                // 날짜 클릭 이벤트 추가
                weekDayElement.onclick = () => selectDate(weekDayElement);

                // 선택된 날짜를 유지
                if (selectedDate && weekDayElement.dataset.date === selectedDate) {
                    weekDayElement.classList.add('selected');
                }

                weekDaysElement.appendChild(weekDayElement);
            });

            const firstDay = weekDates[0];
            const lastDay = weekDates[6];
            var firstmonth = firstDay.getMonth()+1;
            var lastmonth = lastDay.getMonth()+1;
            weekRangeElement.textContent = firstDay.getFullYear()+"년 "+ firstmonth+"월 "+ firstDay.getDate()+"일 - "+lastmonth+"월 "+ lastDay.getDate()+"일";

            const hasClasses = false; // 수업 데이터에 따라 이 값을 변경하세요
            /* noClassesMessage.style.display = hasClasses ? 'none' : 'block'; */
        }

        function selectDate(element) {
            const previouslySelected = document.querySelector('.week-day.selected');
            if (previouslySelected) {
                previouslySelected.classList.remove('selected');
            }

            element.classList.add('selected');
            selectedDate = element.dataset.date;

            var tb = $("#dayset");
            var inHtml = "<h3>" + selectedDate + " " + store + " 강의 리스트 입니다.</h3>";

            var sendData = { DATE: selectedDate, STORE: store };

            $.ajax({
                type: "post",
                url: "/getschedule",
                data: sendData,
                dataType: "json",
                success: function (data) {
                    console.log(data.result);
                    const tableBody = document.querySelector("#dayclassList");
                    tableBody.innerHTML = "";
                    if (data.result.length == 0) {
                        tb.html('<div class="no-classes" id="noClassesMessage">이날엔 강의가 없습니다, 다른날을 선택해주세요!</div>');
                        return;
                    }
                    data.result.forEach((classItem) => {
                        const row = document.createElement("tr");
                        row.setAttribute("onclick", "modalclick(event);");
                        row.setAttribute("data-bookid", classItem.BOOK_ID); 

                        row.innerHTML = '<td class="time"><p>' + classItem.TIME + '</p></td>';
                        row.innerHTML += '<td class="Teacher">' + classItem.TEACHER + '</td>';
                        row.innerHTML += '<td class="class"><p>' + classItem.CLASS + '</p></td>';
                        row.innerHTML += '<td class="people">' + classItem.PEOPLE + '/10</td>';
                        row.innerHTML += '<td class="wait">' + classItem.WAITNUMBER + '</td>';

                        tableBody.appendChild(row);
                    });
                }
            });

            tb.html(inHtml);
            
        }

        function prevWeek() {
            currentDate.setDate(currentDate.getDate() - 7);
            updateWeek();
        }

        function nextWeek() {
            currentDate.setDate(currentDate.getDate() + 7);
            updateWeek();
        }

        function goToToday() {
            currentDate = new Date();  // 현재 날짜로 이동
            selectedDate = currentDate.toISOString().slice(0, 10);  // 오늘 날짜 선택
            
            updateWeek();  // 주 갱신
            var tb = $("#dayset");
            var inHtml = "";
            inHtml += "<h3>"+selectedDate+" "+store+" 강의 리스트 입니다.</h3>";
            tb.html(inHtml);
            var sendData = {DATE:selectedDate,STORE:store}

        	$.ajax({
        	type:"post",
        	url:"/getschedule",
        	data:sendData,
        	dataType:"json",
        	success: function(data){
        		if(data.result.length==0){
        			var tb = $("#dayset");
                    var inHtml = "";
                    inHtml+= '<div class="no-classes" id="noClassesMessage">이날엔 강의가 없습니다, 다른날을 선택해주세요!</div>';
                    tb.html(inHtml);
        		}
        		 const tableBody = document.querySelector("#dayclassList"); // tbody의 ID가 classList인 부분에 데이터 삽입
        		    tableBody.innerHTML = ""; // 기존 데이터를 초기화

        		    // 반복문으로 각 항목을 테이블에 추가
        		    data.result.forEach((classItem) => {

        		         const row = document.createElement("tr");
        		        row.setAttribute("onclick", "modalclick(event);"); // 클릭 이벤트 연결

        		        row.innerHTML = '<td class="time"><p>'+classItem.TIME+'</p></td>';
        		        row.innerHTML +=    '<td class="Teacher">'+classItem.TEACHER+'</td>';
        		        row.innerHTML +=    '<td class="class"><p>'+classItem.CLASS+'</p></td>';
        		        row.innerHTML +=    '<td class="people">'+classItem.PEOPLE+'/10</td>';
        		        row.innerHTML +=    '<td class="wait">'+classItem.WAITNUMBER+'</td>';

        		        // 생성된 <tr>을 테이블에 추가
        		        tableBody.appendChild(row);
        		    });
        	}
        	});

        }

        updateWeek();
        goToToday();
        
        document.addEventListener("DOMContentLoaded", function () {
            console.log("✅ Navbar script loaded in barebook.jsp");

            const toggler = document.querySelector(".navbar-toggle");
            const menu = document.querySelector("#bs-example-navbar-collapse-1");

            if (!toggler || !menu) {
                console.error("❌ Navbar elements not found in barebook.jsp");
                return;
            }

            toggler.addEventListener("click", function () {
                console.log("🔄 Toggle button clicked in barebook.jsp");
                menu.classList.toggle("show");
            });
        });
    </script>
</body>
</html>