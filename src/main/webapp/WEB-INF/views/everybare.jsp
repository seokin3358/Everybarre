<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
String userName = (String) session.getAttribute("userName"); 
List<Map<String, String>> storeList = (List<Map<String, String>>) session.getAttribute("storeList");
int storeCount = (storeList != null) ? storeList.size() : 0;
%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ include file="dbConnection.jsp" %>

<%
    // 1. 영상 주소들 전부 조회
    List<String> videoList = new ArrayList<>();
    String videoID = "Y_wjzyHcR2g"; // 기본값 (혹시 비어있을 경우 대비)

    try {
        PreparedStatement pstmt = conn.prepareStatement("SELECT ADDRESS FROM VIDEO_LIST");
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            videoList.add(rs.getString("ADDRESS"));
        }

        rs.close();
        pstmt.close();

        // 2. 랜덤으로 하나 선택
        if (!videoList.isEmpty()) {
            Random rand = new Random();
            videoID = videoList.get(rand.nextInt(videoList.size()));
        }
    } catch (Exception e) {
        e.printStackTrace(); // 디버깅용
    }
%>


<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">

        
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
        <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=no">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Every Barre</title>
		<script type="text/javascript" src="js/isotope/isotope.pkgd.min.js"></script>
        <!--    Google Fonts-->
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
		

        <!--Fontawesom-->
        <link rel="stylesheet" href="css/font-awesome.min.css">

        <!--Animated CSS-->
        <link rel="stylesheet" type="text/css" href="css/animate.min.css">

        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!--Bootstrap Carousel-->
        <link type="text/css" rel="stylesheet" href="css/carousel.css" />

        <link rel="stylesheet" href="css/isotope/style.css">

        <!--Main Stylesheet-->
        <link href="css/style2.css" rel="stylesheet" media="screen and (min-width: 769px)">
        <link href="css/font.css" rel="stylesheet">
        <link rel="stylesheet" href="css/mobile.css" media="screen and (max-width: 768px)"/>
        
        <!--Responsive Framework-->
        <!-- <link href="css/responsive.css" rel="stylesheet"> -->
        
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <!-- 토스 결제 sdk -->
        <script src="https://js.tosspayments.com/v2/standard"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>
        <style>   
         .video-container {
    position: relative;
    width: 100%;
    height: auto;
    aspect-ratio: 9 / 16; /* 세로형 영상 기준 */
    overflow: hidden;
  }

  .video-container iframe {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border: 0;
  }
/* @font-face {
    font-family: 'Cafe24OhsquareAir-v2.0';
    src: url('/fonts/Cafe24OhsquareAir-v2.0.otf') format('opentype');
}
        
        body, html {
        font-family: "Cafe24OhsquareAir-v2.0", sans-serif;
		  font-style: normal;
        } */
       /* 📌 헤더 스타일 */
.header_menu {
    position: flex;
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
        
/* 모달 스타일 */
/* 📌 모달 스타일 개선 */
.modal {

  display: none;
  
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
}

/* 📌 모달 콘텐츠 스타일 */
.modal-content {
  background-color: #fff;
  padding: 30px;
  border-radius: 12px;
  width: 90%;
  max-width: 500px;
  box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
  text-align: center;
  animation: fadeIn 0.3s ease-in-out;
}

/* 📌 닫기 버튼 */
.close {
  position: absolute;
  top: 15px;
  right: 20px;
  font-size: 28px;
  font-weight: bold;
  color: #333;
  cursor: pointer;
}

.close:hover {
  color: #e94560;
}
h2 {
  margin-top: 0;
  font-size: 1.5em;
}

/* 📌 점포 선택 카드 스타일 */
.store-options {
  display: flex;
  flex-direction: column;
  gap: 15px;
  margin-top: 20px;
}

/* 📌 점포 카드 */
.store-card {
  background-color: #f8f9fa;
  padding: 15px;
  border-radius: 10px;
  text-align: center;
  cursor: pointer;
  border: 1px solid #ddd;
  transition: all 0.3s ease-in-out;
  box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
}

.store-card h3 {
  font-size: 1.2em;
  color: #e94560;
  font-weight: bold;
}

.store-card p {
  font-size: 0.9em;
  color: #666;
}

/* 📌 마우스 호버 효과 */
.store-card:hover {
  transform: scale(1.05);
  background-color: #e94560;
  color: white;
  box-shadow: 0px 8px 12px rgba(0, 0, 0, 0.2);
}

.store-card:hover h3 {
  color: white;
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
video {
    position: absolute;
    top: 50%;
    left: 50%;
    width: auto;
    height: auto;
    min-width: 100%;
    min-height: 100%;
    transform: translate(-50%, -50%);
    object-fit: cover;
}

.slider_overlay {
    position: relative;
    width: 100%;
    height: 100vh; /* 💡 화면 전체 높이 */
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
}

.carousel-caption {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    color: white;
    width: 90%;
    max-width: 600px;
}

/* 📌 BOOK 버튼 */
#slider .bookButton {
    display: inline-block;
    padding: 14px 28px;
    font-size: 18px;
    font-weight: bold;
    color: white;
    background-color: #e94560;
    border: none;
    border-radius: 30px;
    transition: all 0.3s ease-in-out;
    text-decoration: none;
    width: auto;
    max-width: 200px;
    text-align: center;
    margin-top: 20px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
}

#slider .bookButton:hover {
    background-color: #ff5a75;
    transform: scale(1.1);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

/* 📌 반응형: 모바일 최적화 */
@media screen and (max-width: 768px) {
    #slider .slider_text {
        padding-top: 45%;
    }
	  video {
	    width: 100%;
	    height: auto;
	    min-width: unset;
	    min-height: unset;
	    object-fit: contain; /* 💡 잘리지 않도록 변경 */
	    position: relative;
	    top: 0;
	    left: 0;
	    transform: none;
	  }
	
	  .slider_overlay {
	    height: auto;
	    position: relative;
	  }
	
	  .carousel-caption {
	    top: 30%;
	    transform: translate(-50%, -30%);
	  }
	.navbar-header {
	  position: relative;
	  left: 17%; /* 네모칸과 화살표 방향으로 로고 이동 */
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
}

/* 📌 애니메이션 효과 */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
        <style>
  /* 기본값: 데스크탑은 보이고 슬라이드는 숨김 */
  .desktop-view { display: flex; }
  .mobile-view { display: none; }

  @media screen and (max-width: 768px) {
    .desktop-view { display: none !important; }
    .swiper-pagination-horizontal { display: none !important; }
    .mobile-view { display: block !important; }
  }
  /* 리디자인된 CTA 영역 */
#volunteer.highlight-cta {
  background: linear-gradient(to right, #fff1f1, #ffecec);
  text-align: center;
  padding: 80px 20px;
  border-radius: 16px;
  margin-top: 40px;
}

.volunteer-inner h2 {
  font-size: 2.8rem;
  color: #e94560;
  margin-bottom: 10px;
}

.volunteer-inner p {
  font-size: 1.8rem;
  color: #333;
  margin-bottom: 25px;
}

.cta-btn {
  display: inline-block;
  padding: 12px 32px;
  background-color: #e94560;
  color: #fff;
  font-size: 1.6rem;
  border-radius: 8px;
  transition: all 0.3s ease;
  font-weight: bold;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.cta-btn:hover {
  background-color: #d03e56;
  transform: translateY(-2px);
}

/* 모바일 대응 */
@media screen and (max-width: 768px) {
  .volunteer-inner h2 {
    font-size: 2rem;
  }
  .volunteer-inner p {
    font-size: 1.5rem;
  }
  .cta-btn {
    font-size: 1.4rem;
    padding: 10px 24px;
  }
}
  
</style>
    </head>

    <body data-spy="scroll" data-target="#header">

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
          <li>
            <% if (userName != null) { %>
              <a href="/logout.do">LOGOUT</a>
            <% } else { %>
              <a href="/barelogin.do">LOGIN</a>
            <% } %>
          </li>
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
        <% if (userName != null) { %>
              <a href="/logout.do">LOGOUT<span class="dot"></span></a>
            <% } else { %>
              <a href="/barelogin.do">LOGIN<span class="dot"></span></a>
            <% } %>
        <a href="#contact">CONTACT US<span class="dot"></span></a>
      </nav>
  </div>
</header>



    <main>
  <section id="slider">
            <div id="carousel-example-generic" class="carousel slide carousel-fade" data-ride="carousel" data-interval="3000">
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <div class="slider_overlay">                           
                             <!-- <video id="vid" muted autoplay playsinline loop data-keepplaying>
                                <source id="videoSource" src="" type="video/mp4">  
                                   
                              </video> -->
                              <div class="video-container">
								  <iframe 
								    src="https://www.youtube.com/embed/<%= videoID %>?autoplay=1&mute=1&controls=0&loop=1&playlist=<%= videoID %>"
								    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
								    referrerpolicy="strict-origin-when-cross-origin"
								    allowfullscreen>
								  </iframe>
								</div>
                              
                            <div class="carousel-caption">
                                <div class="slider_text">
								        <h2 class="intro-title" id="mainTitle">로딩중...</h2>
   										 <p class="intro-description" id="mainDesc">불러오는 중입니다</p>
								    <!-- <a href="#" class="bookButton">BOOK</a> -->
								</div>
                            </div>
                        </div>
                    </div>                    
                </div>
                <!--End of Carousel Inner-->
            </div>
        </section>

  <% if (userName == null) { %>
  <section class="cta-section">
    <div class="main-inner">
      <h3 class="cta-title">지금 에블바레와 함께하세요!</h3>
      <p class="cta-description">지금 회원가입하고 수업 예약부터 시작해보세요!</p>
      <a href="/barelogin.do" class="join-btn">JOIN US</a>
    </div>
  </section>
  <% } %>

  <section class="magazine-section">
    <div class="main-inner">
      <h2 class="magazine-title" id="blogTitle">로딩중...</h2>
      <p class="magazine-description" id="blogDesc">불러오는 중입니다</p>
    </div>
    <div class="img-wrap desktop-view">
      <div class="image-placeholder"><img src="/static_uploads/img/에사회1.jpg" alt="" style="width:100%;"></div>
      <div class="image-placeholder"><img src="/static_uploads/img/에사회2.jpg" alt="" style="width:100%;"></div>
      <div class="image-placeholder"><img src="/static_uploads/img/에사회3.jpg" alt="" style="width:100%;"></div>
    </div>
    <div class="swiper-container mobile-view" style="margin-top:30px;">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <img src="/static_uploads/img/에사회1.jpg" alt="" style="width:95%;">
        </div>
        <div class="swiper-slide">
          <img src="/static_uploads/img/에사회2.jpg" alt="" style="width:95%;">
        </div>
        <div class="swiper-slide">
          <img src="/static_uploads/img/에사회3.jpg" alt="" style="width:95%;">
        </div>
      </div>
      <div class="swiper-pagination"></div>
    </div>
  </section>
</main>

        <!--Start of contact-->
        <section id="contact" style="background-color: #eeeeee;">
            <div id="contact_us" class="container">
                <div class="row">
                    <div class="colmd-12">
                        <div class="contact_area text-center" >
                            <h3>에블바레 오시는길</h3>
                            <div class="desktop-view"><p>저희 에블바레는 총 <%= storeCount %> 개의 지점으로 이루어져 있고, 아래는 각 센터별 정보입니다.</p></div>
                            <div class="mobile-view"><p>저희 에블바레는 총 <%= storeCount %> 개의 지점으로 이루어져 있고,<br />아래는 각 센터별 정보입니다.</p></div>                            
                        </div>
                    </div>
                </div>
                <!--End of row-->
                <div class="row" style="padding-bottom:40px;">
                <% for (Map<String, String> store : storeList) {
                	String name = store.get("LOCATION");
                	String address = store.get("ADDRESS");
                	String instagram = store.get("INSTAGRAM");
                	String place = store.get("PLACE");
                	String instagram_link = store.get("INSTA_LINK");
                	String place_link = store.get("NAVER_LINK");
                %>
                    <div class="col-md-6" >
                        <div class="office">
                            <div class="title">
                                <h3><%= name %></h3>
                            </div>
                            <div class="office_location">
                                <div class="address">
                                    <p><%= address %></p>
                                </div>
                                <div class="phone">
                                    <p><%= instagram %></p>
                                </div>
                                <div class="email" >
                                    <p><%= place %></p>
                                </div>
                                <div class="icon-wrap">
					            <a href="<%= store.get("NAVER_LINK") %>" target="_blank"><img class="location-icon" src="/img/map.svg" alt="지도"></a>
					            <a href="<%= store.get("INSTA_LINK") %>" target="_blank"><img class="location-icon" src="/img/instargram.svg" alt="인스타그램"></a>
					          </div>
                            </div>
                        </div>
                    </div>
                    <%} %>                             
                    <!--End of col-md-6-->
                </div>
                <!--End of row-->
            </div>
            <!--End of container-->
        <button class="scroll-to-top" onclick="window.scrollTo({ top: 0, behavior: 'smooth' });">
		  <img src="/img/top-arrow.svg" alt="맨 위로">
		</button>
        </section>
        
        <!--Scroll to top-->

        <!--End of Scroll to top-->
		<!-- 점포 선택 모달 -->
		<div id="storeModal" class="modal">
		  <div class="modal-content" >
		    <span class="close">&times;</span>
		    <h2>📍 지점 선택</h2>
		    <p>예약할 지점을 선택하세요.</p>
		    <div class="store-options">
		      <% for (Map<String, String> store : storeList) {
		          String name = store.get("LOCATION");
		          String address = store.get("ADDRESS");
		      %>
		      <div class="store-card" data-store="<%= name %>">
		        <h3>🏠 <%= name %></h3>
		        <p>📍 <%= address %></p>
		      </div>
		      <% } %>
		    </div>
		  </div>
		</div>


        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <!-- <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.2/jquery.min.js'></script>-->
        <script src="js/jquery-1.12.3.min.js"></script>

        <!--Counter UP Waypoint-->
        <script src="js/waypoints.min.js"></script>
        <!--Counter UP-->
        <script src="js/jquery.counterup.min.js"></script>

        <script>
            //for counter up
            $('.counter').counterUp({
                delay: 10,
                time: 1000
            });
        </script>
                


        <!--Isotope-->
        <script src="js/isotope/min/scripts-min.js"></script>
        <script src="js/isotope/cells-by-row.js"></script>
        <script src="js/isotope/isotope.pkgd.min.js"></script>
        <script src="js/isotope/packery-mode.pkgd.min.js"></script>
        <script src="js/isotope/scripts.js"></script>

        <!--JQuery Click to Scroll down with Menu-->
        <script src="js/jquery.localScroll.min.js"></script>
        <script src="js/jquery.scrollTo.min.js"></script>
        <!--WOW With Animation-->
        <script src="js/wow.min.js"></script>
        <!--WOW Activated-->
        <script>
            new WOW().init();
        </script>


        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="js/bootstrap.min.js"></script>
        <!-- Custom JavaScript-->
        <!-- <script src="js/main.js"></script> -->
         <script type="text/javascript">
    	 $(document).ready(function($) {
            $(".scroll_move").click(function(event){
     
                event.preventDefault();
                $('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
            });
            // 메인 타이틀 로드
            $.get("/getSiteContent.do", { id: "main_title" }, function(data){
                $("#mainTitle").html(data);
            });

            $.get("/getSiteContent.do", { id: "main_description" }, function(data){
                $("#mainDesc").html(data);
            });

            $.get("/getSiteContent.do", { id: "blog_title" }, function(data){
                $("#blogTitle").html(data);
            });

            $.get("/getSiteContent.do", { id: "blog_description" }, function(data){
                $("#blogDesc").html(data);
            });
            $(window).on('scroll', function () {
                if ($(window).scrollTop() > 300) {
                  $('.scroll-to-top').addClass('show');
                } else {
                  $('.scroll-to-top').removeClass('show');
                }
              });
        });
        </script>
        
        <script>
     // 모달 요소 가져오기
			document.addEventListener("DOMContentLoaded", function () {
			  var modal = document.getElementById("storeModal");
			  var bookButtons = document.getElementsByClassName("bookButton");
			  var closeBtn = document.getElementsByClassName("close")[0];
			  var storeCards = document.getElementsByClassName("store-card");
			  
			   modal.style.display = "none";
			
			  // 📌 "BOOK" 버튼 클릭 시 모달 열기
			  for (var i = 0; i < bookButtons.length; i++) {
			    bookButtons[i].addEventListener("click", function (e) {
			      e.preventDefault();
			      modal.style.display = "flex"; // 모달 표시
			      $(".navbar-collapse").collapse("hide");
			    });
			  }
			
			  // 📌 닫기 버튼 클릭 시 모달 닫기
			  closeBtn.addEventListener("click", function () {
			    modal.style.display = "none"; // 모달 숨김
			  });
			
			  // 📌 모달 외부 클릭 시 닫기
			  window.addEventListener("click", function (e) {
			    if (e.target == modal) {
			      modal.style.display = "none";
			    }
			  });
			
			  // 📌 점포 선택 시 동작
			  for (var i = 0; i < storeCards.length; i++) {
			    storeCards[i].addEventListener("click", function () {
			      var selectedStore = this.dataset.store;
			      window.location.href = "/barebook.do?store=" + encodeURIComponent(selectedStore);
			    });
			  }
			});			

		</script>
		<script>
		document.addEventListener("DOMContentLoaded", function () {
			  new Swiper(".swiper-container", {
			    loop: true,
			    pagination: {
			      el: ".swiper-pagination",
			      clickable: true,
			    },
			    autoplay: {
			      delay: 5000, // 5초
			      disableOnInteraction: false, // 사용자 터치 후에도 자동 슬라이드 유지
			    },
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