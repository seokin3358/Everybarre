<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String referer = request.getHeader("Referer");
    if (referer != null && !referer.contains("barelogin.do")) {
        session.setAttribute("prevPage", referer);
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
<script type="text/javascript" src="js/isotope/isotope.pkgd.min.js"></script>
        <!--    Google Fonts-->
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!--Fontawesom-->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!--Animated CSS-->
        <link rel="stylesheet" type="text/css" href="css/animate.min.css">

        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!--Bootstrap Carousel-->
        <link type="text/css" rel="stylesheet" href="css/carousel.css" />
        <!-- ✅ jQuery (이미 있는 경우 생략 가능) -->
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
		<!-- ✅ Bootstrap JS 추가 (맨 아래에 추가!) -->
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        

        <link rel="stylesheet" href="css/isotope/style.css">

        <!--Main Stylesheet-->
        <link href="css/style.css" rel="stylesheet">
        <!--Responsive Framework-->
        <link href="css/responsive.css" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap');
*, ::before, ::after {
  box-sizing: border-box;
}
@font-face {
    font-family: 'Cafe24OhsquareAir-v2.0';
    src: url('/fonts/Cafe24OhsquareAir-v2.0.otf') format('opentype');
}
        
        body, html {
        font-family: "Cafe24OhsquareAir-v2.0", sans-serif;
		  font-style: normal;
        }
body {
  margin: 0;
  padding: 0;
  font-size: 3rem;
  color: #23004d;
}
h1 {
  margin: 0;
}
a {
  text-decoration: none;
}
img {
  max-width: 100%;
  height: auto;
  display: block;
}
.login {
  display: grid;
  grid-template-columns: 100%;
  min-height: 100vh;
  margin-left: 1.5rem;
  margin-right: 1.5rem;
  padding-top: 120px; /* ✅ 추가 */
}
.login__content {
  display: grid;
}
.login__img {
  justify-self: center;
}
.login__img img {
  width: 310px;
  margin-top: 1.5rem;
    max-width: 80vw;
  margin-bottom: 2rem;
}
.login__forms {
  position: relative;
  height: 368px;
}
.login__register, .login__create {
  position: absolute;
  bottom: 1rem;
  width: 150%;
  background-color: #f2f2f2;
  padding: 2rem 1rem;
  border-radius: 1rem;
  text-align: center;
  box-shadow: 0 8px 20px rgba(35, 0, 77, 0.2);
  animation-duration: 0.4s;
  animation-name: animateLogin;
}
.login__title {
  font-size: 3.5rem;
  margin-bottom: 2rem;
}
.login__box {
  display: grid;
  grid-template-columns: max-content 1fr;
  column-gap: 0.5rem;
  padding: 1.125rem 1rem;
  background-color: #fff;
  margin-top: 1rem;
  border-radius: 0.5rem;
}
.login__icon {
  font-size: 3.5rem;
  color: #4AD395;
}
.login__input {
  border: none;
  outline: none;
  font-size: 2.5rem;
  font-weight: 700;
  color: #23004d;
  width: 100%;
}
.login__input::placeholder {
  font-size: 3rem;
  color: #a49eac;
}
.login__forgot {
  display: block;
  width: max-content;
  margin-left: auto;
  margin-top: 0.5rem;
  font-size: 2rem;
  font-weight: 600;
  color: #a49eac;
}
.login__button {
  display: block;
  padding: 1rem;
  margin: 2rem 0;
  background-color: #4AD395;
  color: #fff;
  font-weight: 600;
  text-align: center;
  border-radius: 0.5rem;
  transition: 0.3s;
}
.login__button:hover {
  background-color: #65bf97;
}
.login__account, .login__signin, .login__signup {
  font-weight: 600;
  font-size: 2rem;
}
.login__account--account, .login__signin--account, .login__signup--account {
  color: #23004d;
}
.login__account--signin, .login__signin--signin, .login__signup--signin, .login__account--signup, .login__signin--signup, .login__signup--signup {
  color: #4AD395;
  cursor: pointer;
}
.login__social {
  margin-top: 2rem;
}
.login__social--icon {
  font-size: 3.5rem;
  color: #23004d;
  margin: 0 1rem;
}
.block {
  display: block;
}
.none {
  display: none;
}
.navbar-header {
  position: relative;
  left:35%; /* 네모칸과 화살표 방향으로 로고 이동 */
}
.navbar-right {
  margin-right: -15%; 
}
.custom_navbar-brand {
  margin-left: 0; /* 필요하면 이 값을 조정 */
  text-align: left; /* 정렬 */
}
@keyframes animateLogin {
  0% {
    transform: scale(1, 1);
  }
  50% {
    transform: scale(1.1, 1.1);
  }
  100% {
    transform: scale(1, 1);
  }
}
@media screen and (min-width: 576px) {
  .login__forms {
    width: 348px;
    justify-self: center;
  }
}
@media screen and (min-width: 1024px) {
  .login {
    min-height: 100vh;
    overflow: visible;
  }
  .login__content {
    grid-template-columns: repeat(2, max-content);
    justify-content: center;
    align-items: center;
  }
  .login__img {
    display: flex;
    width: 600px;
    height: 588px;
    background-color: #fff;
    border-radius: 1rem;
    padding-left: 1rem;
  }
  .login__img img {
    width: 80%;
    margin-top: 0;
  }
  .login__register, .login__create {
    left: -11rem;
  }
  .login__register {
    bottom: -2rem;
  }
  .login__create {
    bottom: -5.5rem;
  }
}
@media screen and (max-width: 768px) {
  .login__img {
    display: none !important;
  }
.navbar-toggle .icon-bar {
  background-color: white;
  display: block;
  width: 22px;
  height: 2px;
  margin: 4px auto;
}
  .navbar-header {
    left: 0 !important; /* ✅ 모바일에선 왼쪽으로 초기화 */
    flex-direction: row-reverse;
    position: relative;
    width: 100%;
    display: flex;
    justify-content: space-between; /* 로고 왼쪽, 토글 오른쪽 */
    margin-left: 13%;
  }

  .navbar-toggle {
    margin-right: 10px; /* 오른쪽 여백 */
  }

  .custom_navbar-brand {
    margin-left: 10px; /* 로고 좌측 정렬 */
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

    .navbar-collapse {
        position: absolute;
        top: 60px;
        left: 0;
        width: 100%;
        background-color: #e94560;
        padding: 10px;
        display: none; /* 기본적으로 숨김 */
    }

    .navbar-collapse.show {
        display: block !important; /* 토글 시 보이도록 설정 */
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
.login__register, .login__create {
  position: static;
  bottom: 1rem;
  width: 100%;
  background-color: #f2f2f2;
  padding: 2rem 1rem;
  border-radius: 1rem;
  text-align: center;
  box-shadow: 0 8px 20px rgba(35, 0, 77, 0.2);
  animation-duration: 0.4s;
  animation-name: animateLogin;
}
  /* 1. 로그인 전체 화면 가운데 정렬 */
  .login {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center; /* 세로 가운데 정렬 */
    height: 100vh; /* 전체 화면 높이 */
    padding: 1rem;
  }

  /* 2. 컨텐츠도 세로 정렬 유지 */
  .login__content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    height: 100%;
  }

  /* 3. 로그인 폼은 비율 맞추기 */
  .login__forms {
    width: 100%;
    max-width: 360px;
    margin-top: 1rem;
    position: static; /* ✅ absolute 제거 효과 */
  }

  /* 4. 로그인 이미지 크게 표시 */
  .login__img img {
    width: 70%;
    max-width: 240px;
    margin-bottom: 2rem;
  }

  /* 5. 로그인 박스 내 글자 크기 키우기 */
  .login__box input,
  .login__input::placeholder {
    font-size: 1.6rem;
  }

section#slider {
    width: 100%;
    box-sizing: border-box;
  }

 .login__img {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
    margin-bottom: 20px;
  }

  .login__img img {
    width: 70%;
    max-width: 300px;
  }

  .login__title {
    font-size: 2.6rem; /* 📌 제목 크게 */
  }

  .login__input {
    font-size: 2rem;  /* 📌 입력창 글씨 크게 */
    padding: 1rem;
  }

  .login__button {
    font-size: 2rem;
    padding: 1rem;
  }

  .login__account,
  .login__signin,
  .login__signup,
  .login__forgot {
    font-size: 1.6rem;  /* 📌 부가 텍스트 크게 */
  }
  .login__register, .login__create {
    padding: 2rem 1.5rem;
    font-size: 1.6rem;
  }

  .login__box {
    grid-template-columns: 1fr;
    row-gap: 0.5rem;
  }

  .login__icon {
    display: none; /* ✅ 모바일에선 아이콘 숨김 */
  }

  .email-box {
    flex-direction: column; /* ✅ 입력창 + 버튼 세로 배치 */
    align-items: stretch;
  }

  .email-check-button {
    width: 100%;
    margin-left: 0;
    margin-top: 0.5rem;
  }

  .login__input {
    font-size: 1.6rem;
    padding: 0.8rem;
  }

  .login__title {
    font-size: 2.4rem;
  }

  .login__button {
    font-size: 1.6rem;
    padding: 1rem;
  }

  .login__account, .login__signin, .login__signup {
    font-size: 1.5rem;
  }
}
/* The Modal (background) */
.modal {
  display: none;
  position: fixed;
  z-index: 1;
  padding-top: 100px;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
  font-size: 1.5rem;
  line-height: 1.6;
  max-width: 50%;
}

/* Close Button */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

/* Adjusting checkbox size and removing extra space */
.login__checkbox {
  width: 20px;
  height: 20px;
  vertical-align: middle;
  margin-right: 3px; /* Reduced margin to bring label closer */
}

/* Adjusting font size and alignment for the label and link */
.login__box label {
  font-size: 1.5rem; /* Adjust the font size */
  vertical-align: middle;
  margin-right: 10px;
  color: #23004d; /* Font color */
}

#privacy-link {
  font-size: 1.5rem; /* Adjust the font size for the privacy link */
  vertical-align: middle;
  color: #4AD395;
  margin-left: 10px;
}

/* 이메일 입력 필드와 중복 확인 버튼을 감싸는 박스 */
.email-box {
    display: flex;
    align-items: center;
}

/* 중복 확인 버튼 스타일 */
.email-check-button {
    margin-left: 0.5rem;
    padding: 1rem;
    background-color: #4CAF50;
    color: #fff;
    font-size: 1.5rem;
    font-weight: bold;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    height: 100%;
}

/* 버튼 호버 및 클릭 효과 */
.email-check-button:hover {
    background-color: #45a049;
    transform: scale(1.05);
}
.email-check-button:active {
    transform: scale(0.95);
}

/* 이메일 중복 확인 메시지 스타일 */
.email-check-message {
    color: #fff;
    font-size: 1.3rem;
    margin-top: 0.5rem;
    text-align: left;
}

/* 비밀번호 찾기 전용 모달 스타일 */
#forgotPasswordModal .modal-content {
  background-color: #fff;
  margin: 10% auto;
  padding: 30px; 
  border: 1px solid #888;
  width: 90%; 
  max-width: 500px;
  font-size: 1.8rem;
  border-radius: 10px; 
}

#forgotPasswordModal .login__box {
  display: flex;
  align-items: center; 
  justify-content: space-between;
  width: 100%;
  margin-bottom: 15px; 
}

#forgotPasswordModal .login__box label {
  font-size: 1.8rem;
  font-weight: bold;
  margin-right: 10px;
  width: 25%;
  text-align: right;
}

#forgotPasswordModal .login__box input {
  font-size: 1.8rem;
  padding: 10px;
  width: 70%; 
  border: 1px solid #ccc;
  border-radius: 5px;
}

#forgotPasswordModal .login__input {
  font-size: 1.8rem;
  padding: 10px; 
  width: 100%;
  border: 1px solid #ccc;
  border-radius: 5px; 
}

#forgotPasswordModal button.login__button {
  display: block; 
  margin: 20px auto;
  font-size: 1.8rem; 
  padding: 10px 20px; 
  background-color: #4AD395;
  color: #fff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

#forgotPasswordModal button.login__button:hover {
  background-color: #45a049;
}
</style>
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
                                    <li><a href="/everybare.do#volunteer">book</a></li>
                                    <li class="active"><a href="/barelogin.do">login <span class="sr-only">(current)</span></a></li>
                                    <li><a href="/everybare.do#contact_us" >contact us</a></li>
                                </ul>
                            </div>
                            <!-- /.navbar-collapse -->
                        </nav>
                        <!--End of nav-->
                    </div>
                    <!--End of container-->
                </div></div></section>
                <section id="slider">
  <div class="login">
    <div class="login__content">
      <div class="login__img">
        <img src="/static_uploads/img/everybarre_login.jpg" alt="user login">
      </div>
      <div class="login__forms">
<!--         login form -->
        <form action="" class="login__register" id="login-in">
          <h1 class="login__title">Sign In</h1>
          <div class="login__box">
            <i class='bx bx-at login__icon'></i>
            <input type="text" placeholder="Email" class="login__input">
          </div>
          <div class="login__box">
            <i class='bx bx-lock login__icon'></i>
            <input type="Password" placeholder="Password" class="login__input">
          </div>
          <a href="#" id="forgotPasswordLink" class="login__forgot">비밀번호를 잊어버리셨나요?</a>
          
          <a href="#" class="login__button">Sign In</a>
          
          <div>
            <span class="login__account login__account--account">계정이 없으신가요?</span>
            <span class="login__signin login__signin--signup" id="sign-up">Sign Up</span>
          </div>
          <!-- 비밀번호 찾기 모달 -->
			<div id="forgotPasswordModal" class="modal">

        </form>
        	<div class="modal-content">
			    <span class="close">&times;</span>
			    <h2>비밀번호 찾기</h2>
			    <form id="forgotPasswordForm">
			      <div class="login__box">
			        <label for="resetName">이메일</label>
			        <input type="text" id="resetName" class="login__input" required>
			      </div>
			      <div class="login__box">
			        <label for="resetPhone">휴대폰 번호</label>
			        <input type="text" id="resetPhone" class="login__input" required>
			      </div>
			      <button type="submit" class="login__button">임시 비밀번호 발급</button>
			    </form>
			    <p id="resetMessage"></p>
			  </div>
			</div>
        
<!--         create account form -->
        <form action="" class="login__create none" id="login-up">
          <h1 class="login__title">계정 생성</h1>
          <div class="login__box">
            <i class='bx bx-user login__icon'></i>
            <input type="text" placeholder="Username" class="login__input">
          </div>
          
          <div class="login__box email-box">
			    <i class='bx bx-at login__icon'></i>
			    <input type="text" id="signupEmail" placeholder="Email" class="login__input">
			    <button id="checkEmailButton" type="button" class="email-check-button">중복확인</button>
			</div>
			<div id="emailCheckMessage" class="email-check-message"></div>

          
          <div class="login__box">
            <i class='bx bx-lock login__icon'></i>
            <input type="Password" placeholder="Password (8자리이상)" class="login__input">
          </div>
          <div class="login__box">
            <i class='bx bx-lock login__icon'></i>
            <input type="Password" placeholder="Password_Check" class="login__input">
          </div>
          
          <div class="login__box">
            <i class='bx bxs-cake login__icon'></i>
            <input type="text" placeholder="Brith (예시 - 901125)" class="login__input">
          </div>

          <div class="login__box">
            <i class='bx bxs-phone login__icon'></i>
            <input type="text" placeholder="Phone (예시 - 01012341234)" class="login__input">
          </div>
          <div class="login__box">
          	<div>
			  <input type="checkbox" id="agree" class="login__checkbox" style="margin:0;">
			  <label for="agree" style="margin:0;">약관에 동의합니다</label>
			  <a href="#" id="privacy-link">개인정보보호약관 보기</a></div>
			</div>


          <!-- https://ddorang-d.tistory.com/97 모달창 개인정보약관 -->
          <a href="#" class="login__button">Sign Up</a>
          			<!-- Modal Structure -->
			<div id="privacyModal" class="modal">
			  <div class="modal-content">
			    <span class="close">&times;</span>
			    <h2>개인정보보호약관</h2>
			    <h3>에블바레(EVERY BARRE) 개인정보 처리방침</h3>
			    <p>에블바레(이하 "회사"라 한다)는 회원님의 개인정보를 소중히 다루며, 「개인정보 보호법」 및 관련 법령을 준수하여 개인정보 보호에 만전을 기하고 있습니다. 회사는 개인정보 보호법 제30조에 따라 회원님의 개인정보를 안전하게 처리하고, 이와 관련된 고충을 신속하고 원활하게 처리할 수 있도록 다음과 같은 개인정보 처리방침을 수립합니다.</p>
			
			    <h3>1. 개인정보 수집 항목</h3>
			    <p>회사는 회원가입, 서비스 이용, 고객상담 등을 위해 다음의 개인정보를 수집할 수 있습니다.</p>
			    <ul>
			        <li>필수 항목: 이름, 이메일 주소, 비밀번호, 휴대전화 번호, 생년월일</li>
			        <li>서비스 이용 과정에서 자동으로 수집되는 정보: IP 주소, 쿠키, 서비스 이용 기록, 접속 로그</li>
			    </ul>
			
			    <h3>2. 개인정보 수집 및 이용 목적</h3>
			    <p>회사는 다음의 목적을 위해 개인정보를 수집 및 이용합니다.</p>
			    <ul>
			        <li>회원 관리: 회원제 서비스 제공, 본인 확인, 가입 의사 확인</li>
			        <li>서비스 제공: 콘텐츠 제공, 맞춤형 서비스 제공</li>
			        <li>마케팅 및 광고: 신규 서비스 안내, 이벤트 정보 제공</li>
			        <li>고객 지원: 문의 사항 및 불만 처리</li>
			    </ul>
			
			    <h3>3. 개인정보의 보유 및 이용 기간</h3>
			    <p>회사는 법령에 따른 개인정보 보유 및 이용 기간 또는 정보주체로부터 개인정보를 수집 시 동의받은 개인정보 보유 및 이용 기간 내에서 개인정보를 처리 및 보유합니다.</p>
			    <ul>
			        <li>회원가입 및 관리: 회원 탈퇴 시까지</li>
			        <li>계약 또는 청약철회 등에 관한 기록: 5년 (전자상거래 등에서의 소비자 보호에 관한 법률)</li>
			        <li>대금 결제 및 재화 등의 공급에 관한 기록: 5년 (전자상거래 등에서의 소비자 보호에 관한 법률)</li>
			        <li>소비자의 불만 또는 분쟁 처리에 관한 기록: 3년 (전자상거래 등에서의 소비자 보호에 관한 법률)</li>
			    </ul>
			
			    <h3>4. 개인정보의 제3자 제공</h3>
			    <p>회사는 원칙적으로 회원님의 개인정보를 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.</p>
			    <ul>
			        <li>회원님이 사전에 동의한 경우</li>
			        <li>법령의 규정에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</li>
			    </ul>
			
			    <h3>5. 개인정보의 처리 위탁</h3>
			    <p>회사는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.</p>
			    <ul>
			        <li>[위탁 대상자]: [위탁하는 업무의 내용]</li>
			        <li>[위탁 대상자]: [위탁하는 업무의 내용]</li>
			    </ul>
			    <p>회사는 위탁계약 체결 시 「개인정보 보호법」에 따라 위탁업무 수행 목적 외 개인정보 처리 금지, 기술적·관리적 보호조치, 재위탁 제한 등을 명확히 규정하고 이를 준수하도록 관리하고 있습니다.</p>
			
			    <h3>6. 개인정보의 파기 절차 및 방법</h3>
			    <p>회사는 개인정보 보유 기간이 경과하거나 처리 목적이 달성된 경우에는 지체 없이 해당 개인정보를 파기합니다.</p>
			    <ul>
			        <li>전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제</li>
			        <li>종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각</li>
			    </ul>
			
			    <h3>7. 정보주체와 법정대리인의 권리·의무 및 그 행사방법</h3>
			    <p>회원님은 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.</p>
			    <ul>
			        <li>개인정보 열람 요청</li>
			        <li>오류 등이 있을 경우 정정 요청</li>
			        <li>삭제 요청</li>
			        <li>처리 정지 요청</li>
			    </ul>
			    <p>권리 행사는 회사에 대해 서면, 전자우편 등을 통하여 하실 수 있으며, 회사는 이에 대해 지체 없이 조치하겠습니다.</p>
			
			    <h3>8. 개인정보 보호책임자 및 문의</h3>
			    <p>회사는 회원님의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.</p>
			    <ul>
			        <li>개인정보 보호책임자: [성명]</li>
			        <li>연락처: [전화번호]</li>
			        <li>이메일: [이메일 주소]</li>
			    </ul>
			    <p>회원님은 회사의 서비스를 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만 처리, 피해 구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다.</p>

			  </div>
			</div>
          <div>
            <span class="login__account login__account--account">이미 계정이 있으신가요?</span>
            <span class="login__signup login__signup--signup" id="sign-in">Sign In</span>
          </div>          
        </form>
      </div>
    </div>
   </div></section>


   <script type="text/javascript">
    const signup = document.getElementById("sign-up");
    const signin = document.getElementById("sign-in");
    const loginin = document.getElementById("login-in");
    const loginup = document.getElementById("login-up");

	signup.addEventListener("click", () => {
	    loginin.classList.remove("block");
	    loginup.classList.remove("none");
	
	    loginin.classList.add("none");
	    loginup.classList.add("block");
	})
	
	signin.addEventListener("click", () => {
	    loginin.classList.remove("none");
	    loginup.classList.remove("block");
	
	    loginin.classList.add("block");
	    loginup.classList.add("none");
	})
	// Get modal element
	var modal = document.getElementById("privacyModal");
	// Get the link that opens the modal
	var privacyLink = document.getElementById("privacy-link");
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	
	// When the user clicks on the link, open the modal
	privacyLink.onclick = function(event) {
	  event.preventDefault(); // Prevent default link behavior
	  modal.style.display = "block";
	}
	
	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
	  modal.style.display = "none";
	}
	
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == modal) {
	    modal.style.display = "none";
	  }
	}
</script>

<script type="text/javascript">
//비밀번호 찾기 모달 관련 요소
const forgotPasswordLink = document.getElementById("forgotPasswordLink");
const forgotPasswordModal = document.getElementById("forgotPasswordModal");
const closeForgotPasswordModal = document.querySelector("#forgotPasswordModal .close");
const forgotPasswordForm = document.getElementById("forgotPasswordForm");
const resetMessage = document.getElementById("resetMessage");

// "비밀번호를 잊어버리셨나요?" 클릭 시 모달 열기
forgotPasswordLink.addEventListener("click", (event) => {
  event.preventDefault();
  forgotPasswordModal.style.display = "block";
});

// 모달 닫기
closeForgotPasswordModal.addEventListener("click", () => {
  forgotPasswordModal.style.display = "none";
});

// 모달 외부 클릭 시 닫기
window.addEventListener("click", (event) => {
  if (event.target === forgotPasswordModal) {
    forgotPasswordModal.style.display = "none";
  }
});

// 임시 비밀번호 발급 요청
forgotPasswordForm.addEventListener("submit", (event) => {
  event.preventDefault();

  const name = document.getElementById("resetName").value.trim();
  const phone = document.getElementById("resetPhone").value.trim();

  if (!name || !phone) {
    resetMessage.textContent = "이메일과 휴대폰 번호를 모두 입력하세요.";
    resetMessage.style.color = "red";
    return;
  }

  // AJAX 요청
  $.ajax({
    type: "post",
    url: "/requestTemporaryPassword", // API 엔드포인트
    data: { NAME:name, PHONE:phone },
    dataType: "json",
    success: function (response) {
    	
        if (response.success) {
        	sendSms(response.PASSWORD,phone);
        } else {
            // 로그인 실패 시 메시지 출력
            alert(response.message);
        }
    },
    error: function () {
      resetMessage.textContent = "서버 오류가 발생했습니다. 다시 시도해 주세요.";
      resetMessage.style.color = "red";
    },
  });
});

function sendSms(message,phone) {

    $.ajax({
        type: "POST",
        url: "/sendSms",
        data: {
            RECEIVER: phone,
            SENDER: phone,
            MESSAGE: message
        },
        dataType: "json",
        success: function(response) {
            if (response.success) {
            	alert(response.message || "휴대폰 번호로 임시비밀번호가 발급되었습니다. 로그인 후 반드시 비밀번호를 변경하세요.");
                window.location.href = '/barelogin.do';  // 로그인 성공 후 이동
            } else {
                alert("문자 전송 실패: " + response.message);
            }
        },
        error: function(xhr, status, error) {
            alert("문자 전송 중 오류 발생: " + error);
        }
    });
}

// 로그인 버튼 클릭 시 이벤트 핸들러
const signinButton = document.querySelector("#login-in .login__button");
const emailInput = document.querySelector("#login-in input[placeholder='Email']");
const passwordInput = document.querySelector("#login-in input[placeholder='Password']");

function handleLogin(event) {
    event.preventDefault(); // 기본 동작 방지

    // 유효성 검사
    if (!emailInput.value) {
        alert("Email을 입력하세요.");
        return;
    }

    if (!passwordInput.value) {
        alert("Password를 입력하세요.");
        return;
    }

    // AJAX로 로그인 요청 보내기
    const loginData = {
        USER_MAIL: emailInput.value,
        USER_PASSWORD: passwordInput.value
    };

    $.ajax({
        type: "post",
        url: "/login",  // 로그인 처리 엔드포인트
        data: loginData,
        dataType: "json",
        success: function(response) {
            // 로그인 성공 시 처리
            if (response.success) {
                alert("로그인에 성공했습니다.");
                window.location.href = response.redirectUrl || '/everybare.do'; // 로그인 성공 후 이동
            } else {
                // 로그인 실패 시 메시지 출력
                alert(response.message || "로그인에 실패했습니다. 다시 시도하세요.");
            }
        },
        error: function() {
            // 서버 오류 또는 네트워크 오류 시 처리
            alert("서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
        }
    });
}

// 로그인 버튼 클릭 시 로그인 처리
signinButton.addEventListener("click", handleLogin);

// 비밀번호 입력 필드에서 Enter 키를 누르면 로그인 처리
passwordInput.addEventListener("keydown", (event) => {
    if (event.key === "Enter") {
        handleLogin(event); // 로그인 처리 함수 호출
    }
});

  // Sign Up form validation
  const signupButton = document.querySelector("#login-up .login__button");

  signupButton.addEventListener("click", (event) => {
    const usernameInput = document.querySelector("#login-up input[placeholder='Username']");
    const emailInput = document.querySelector("#login-up input[placeholder='Email']");
    const passwordInput = document.querySelector("#login-up input[placeholder='Password (8자리이상)']");
    const passwordCheckInput = document.querySelector("#login-up input[placeholder='Password_Check']");
    const birthInput = document.querySelector("#login-up input[placeholder^='Brith']");
    const phoneInput = document.querySelector("#login-up input[placeholder^='Phone']");
    const agreeCheckbox = document.querySelector("#agree");

    // Username validation
    if (!usernameInput.value) {
      alert("Username을 입력하세요.");
      event.preventDefault();
      return;
    }

    // Email validation
    if (!emailInput.value) {
      alert("Email을 입력하세요.");
      event.preventDefault();
      return;
    }

    // Password validation
    if (!passwordInput.value) {
      alert("Password를 입력하세요.");
      event.preventDefault();
      return;
    }
    if (!passwordCheckInput.value) {
      alert("Password_Check를 입력하세요.");
      event.preventDefault();
      return;
    }

    // Check if Password and Password_Check are the same
    if (passwordInput.value !== passwordCheckInput.value) {
      alert("Password가 일치하지 않습니다.");
      event.preventDefault();
      return;
    }
    
    if (passwordInput.value && passwordInput.value.length < 8) {
    	alert("비밀번호는 8자리 이상이어야 합니다.");
    	event.preventDefault();
	      return;
	  }

    // Birth validation (6 digits, no hyphen)
    const birthRegex = /^\d{6}$/;
    if (!birthRegex.test(birthInput.value)) {
      alert("Brith는 6자리 숫자여야 하며 하이픈(-)을 포함하지 않아야 합니다.");
      event.preventDefault();
      return;
    }

    // Phone validation (11 digits, no hyphen)
    const phoneRegex = /^\d{11}$/;
    if (!phoneRegex.test(phoneInput.value)) {
      alert("Phone는 11자리 숫자여야 하며 하이픈(-)을 포함하지 않아야 합니다.");
      event.preventDefault();
      return;
    }

    // Checkbox validation
    if (!agreeCheckbox.checked) {
      alert("약관에 동의하셔야 합니다.");
      event.preventDefault();
      return;
    }
    
    var name = usernameInput.value;
    var email = emailInput.value;
    var birth = birthInput.value;
    var phone = phoneInput.value;
    var password = passwordInput.value;
    
    // Confirmation alert after all validations pass
    const confirmationMessage = '다음 정보가 맞는지 확인해 주세요:\n\n' +
                                '이름: '+name+'\n' +
                                '이메일: '+email+'\n' +
                                '생년월일: '+birth+'\n' +
                                '휴대폰번호: '+phone;

    if (!confirm(confirmationMessage)) {
      event.preventDefault(); // If the user clicks "Cancel", prevent form submission
    }else{
		var sendData = {USER_NAME:name,USER_MAIL:email,USER_BIRTH:birth,USER_PHONE:phone,USER_PASSWORD:password};
		
		 $.ajax({
			type:"post",
			url:"/usersave",
			data:sendData,
			dataType:"",
			success: function(data){
				console.log("완료");
				if(data.result != null){
					confirm(data.result);
				}
				window.location.href = '/barelogin.do';
			}
		}); 
    }
  });
  
  document.getElementById("checkEmailButton").addEventListener("click", function () {
	    const emailInput = document.getElementById("signupEmail").value.trim();
	    const emailCheckMessage = document.getElementById("emailCheckMessage");

	    // 유효성 검사: 이메일 입력 확인
	    if (!emailInput) {
	        emailCheckMessage.textContent = "이메일을 입력하세요.";
	        return;
	    }

	    // 유효성 검사: 이메일 형식 확인
	    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    if (!emailRegex.test(emailInput)) {
	        emailCheckMessage.textContent = "올바른 이메일 형식을 입력하세요.";
	        return;
	    }

	    // AJAX 요청으로 이메일 중복 확인
	    $.ajax({
	        type: "post",
	        url: "/checkEmail", // 이메일 중복 확인 엔드포인트
	        data: { USER_MAIL: emailInput },
	        dataType: "json",
	        success: function (response) {
	            if (response.success) {
	                if (response.isAvailable) {
	                    emailCheckMessage.style.color = "green";
	                    emailCheckMessage.textContent = "사용 가능한 이메일입니다.";
	                } else {
	                    emailCheckMessage.style.color = "red";
	                    emailCheckMessage.textContent = "이미 사용 중인 이메일입니다.";
	                }
	            } else {
	                emailCheckMessage.style.color = "red";
	                emailCheckMessage.textContent = "중복 확인 중 오류가 발생했습니다.";
	            }
	        },
	        error: function () {
	            emailCheckMessage.style.color = "red";
	            emailCheckMessage.textContent = "서버 오류가 발생했습니다. 다시 시도해 주세요.";
	        }
	    });
	});
  

</script>
</body>
</html>