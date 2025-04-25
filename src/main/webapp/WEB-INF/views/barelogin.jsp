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
        <link href="css/style2.css" rel="stylesheet" media="screen and (min-width: 769px)">
        <link href="css/font.css" rel="stylesheet">
        <link rel="stylesheet" href="css/mobile.css" media="screen and (max-width: 768px)"/>
<style>
@import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap');
*, ::before, ::after {
  box-sizing: border-box;
}
  .desktop-view { display: flex; }
  .mobile-view { display: none; }

  @media screen and (max-width: 768px) {
    .desktop-view { display: none !important; }
    .swiper-pagination-horizontal { display: none !important; }
    .mobile-view { display: block !important; }
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
.block {
  display: block;
}
.none {
  display: none;
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

</style>
<header>
  <div class="header desktop-view">
    <div class="header-inner">
      <div class="logo">
        <img src="/img/every-barre-logo.svg" alt="every barre" />
      </div>
      <nav class="nav">
        <ul>
          <li><a href="/everybare.do">HOME</a></li>
          <li><a href="/everybare.do">ABOUT</a></li>
         <!--  <li><a href="#" onclick="document.getElementById('storeModal').style.display='flex'">BOOK</a></li> -->
          <li><a href="/barelogin.do">LOGIN</a></li>
          <li><a href="#contact">CONTACT US</a></li>
        </ul>
      </nav>
    </div>
  </div>
  <div class="mobile-view">
  	  <div class="logo">
        <img src="/img/every-barre-logo.svg" alt="every barre" />
      </div>
      <button class="menu-toggle" onclick="toggleMenu()">
        <img id="menuIcon" src="/img/menu-icon.svg" alt="menu icon" />
      </button>
      <nav class="nav" id="mobileNav">
        <a href="/everybare.do">HOME<span class="dot"></span></a>
        <a href="#">ABOUT<span class="dot"></span></a>
        <a href="/barelogin.do">LOGIN<span class="dot"></span></a>
        <a href="#contact">CONTACT US<span class="dot"></span></a>
      </nav>
  </div>
</header>

                <section id="slider">
  <div>
    <div class="login__content">
        <form action="" id="login-in">
        <section class="login-section">
        <div class="main-inner">
          <div class="login-container">
            <div class="login-slogan desktop-view">
              <img src="/img/login-slogan-image.svg" alt="move burn together" />
            </div>
			
            <div class="login-box">
              <h2>LOG IN</h2>
              
                <input type="text" placeholder="Email" required />
                <input type="password" placeholder="Password" required />
                <div id="forgotPasswordLink"  class="forgot-password">비밀번호를 잊어 버리셨나요?</div>
                <button type="button" class="login__button">LOG IN</button>
              
              <p class="no-account">
                계정이 없으신가요?
                <a href="#" id="sign-up">SIGN IN</a>
              </p>
              <div id="forgotPasswordModal" class="modal">
            </div>
          </div>
          
          </div>
        </div>
      </section>
      </form>
     
	<form action="" id="login-up" class="none">
		<section class="signup-section">
            <div class="signup-box">
              <h2>회원가입</h2>
              
                <input type="text" name="username" placeholder="Username" required />
                <div class="email-wrap">
                  <div class="email-contant">
                    <input type="email" id="signupEmail" name="email" placeholder="Email" required />
                    <button type="button" class="check-btn" id="checkEmailButton">중복확인</button>            
                  </div>
                  <div id="emailCheckMessage" class="email-check-message"></div>   
                </div>
                <input type="password" name="password" placeholder="Password 8자 이상" required />
                <input type="password" name="passwordCheck" placeholder="Password Check" required />
                <input type="text" name="birth" placeholder="Brith ex. 901125" />
                <input type="text" name="phone" placeholder="Phone ex. 01012341234" />
                <div class="terms-row">
                  <label class="checkbox-label">
                    <input type="checkbox" class="custom-checkbox" name="agree" id="agree" required />
                    <span class="checkmark"></span>
                    <span>약관에 동의합니다.</span>
                  </label>
                  <button type="button" class="terms-link" id="privacy-link">개인정보보호약관보기</button>
                </div>
                <button class="signup-btn login__button" type="button">SIGN UP</button>
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
              <p class="signup-footer">
                이미 계정이 있으신가요? <a href="#" id="sign-in">LOG IN</a>
              </p>
        </div>
      </section>
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
//  event.preventDefault();
//  forgotPasswordModal.style.display = "block";
	 alert("관리자에게 문의해주세요.");
});

// 모달 닫기
/* closeForgotPasswordModal.addEventListener("click", () => {
  forgotPasswordModal.style.display = "none";
}); */

// 모달 외부 클릭 시 닫기
window.addEventListener("click", (event) => {
  if (event.target === forgotPasswordModal) {
    forgotPasswordModal.style.display = "none";
  }
});

// 임시 비밀번호 발급 요청
/* forgotPasswordForm.addEventListener("submit", (event) => {
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
}); */

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
	console.log("123");
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
    const passwordInput = document.querySelector("#login-up input[placeholder='Password 8자 이상']");
    const passwordCheckInput = document.querySelector("#login-up input[placeholder='Password Check']");
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
  function toggleMenu() {
      const nav = document.getElementById("mobileNav");
      const icon = document.getElementById("menuIcon");
      nav.classList.toggle("show");
      if (nav.classList.contains("show")) {
        icon.src = "/img/close-icon.svg";
        icon.alt = "close icon";
      } else {
        icon.src = "/img/menu-icon.svg";
        icon.alt = "menu icon";
      }
    }

</script>
</body>
</html>