<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 모바일에서 화면배율을 디바이스 크기 기준으로 설정 -->
<!-- 이게 안되면 pc에서의 100px과 모바일에서의 100px이 디바이스 성능에 따라 달라집니다. -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" href="images/logo.jpg">
<link rel="stylesheet" href="css/CommonStyle.css">
<link rel="stylesheet" href="css/HeaderStyle.css">
<link rel="stylesheet" href="css/FooterStyle.css">
<link rel="stylesheet" href="css/madal_pop.css" />
<style>
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display+SC&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');
</style>
<link rel="stylesheet" href="css/cal.css">
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
    />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jqery.bpopup-0.1.1.min.js"></script>
<script>

function Mobile() {return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);}

</script>
</head>
<body>
    <header class="headerBox">
        <div id="web_logo" class="hotel_logo">
            <a href="<%=request.getContextPath() %>/index.do" class="sitename" style="font-size: 29px;">풀스테이 별내점</a>
        </div>
        <div id="mobile_logo" class="hotel_logo" style="line-height:normal; left:44%; margin-top:7%;">
            <a href="<%=request.getContextPath() %>/index.do" class="sitename">풀스테이 별내점</a>
        </div>

        <div id="mobile" class="top-bar text-align-center line-height-0-ch-only">
		                <i class="fas fa-stream" id="menu_box_img"></i>
	        	<nav class="menu-box inline-block">
						<ul class="row">
							<li class="name">Menu
								<ul class="innerMenu">
								<li><a href="<%=request.getContextPath() %>/information.do">풀스테이 소개</a></li>
	                			<li><a href="<%=request.getContextPath() %>/Map.do">오시는길</a></li>
	                			<!-- <li><a href="https://map.naver.com/v5/entry/place/1369943741?lng=126.6225143&lat=37.6445103&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh">예약하기</a></li> -->
								<li><a href="<%=request.getContextPath() %>/booking.do">예약하기</a></li>
								</ul>
							</li>
							
						</ul>
						</nav>
		            	<div class="menu-box-bg"></div>
	  					<div class="sub-menu-bar-bg"></div>
		</div>

	    <div id="web" class="menu">
	            <ul>
	            				<li><a href="<%=request.getContextPath() %>/information.do">풀파티룸 소개</a></li>
	                			<li><a href="<%=request.getContextPath() %>/Map.do">오시는길</a></li>
	                			<!-- <li><a href="https://map.naver.com/v5/entry/place/1369943741?lng=126.6225143&lat=37.6445103&placePath=%2Fhome%3Fentry=plt&c=15,0,0,0,dh">예약하기</a></li> -->
	                			<li><a href="<%=request.getContextPath() %>/booking.do">예약하기</a></li>
	
	                 
	            </ul>                 
	
	     </div>


    </header>
<script>
if(Mobile()){
	$("#web_logo").hide();
	$("#web").hide();
}else{
	$("#mobile_logo").hide();
	$("#mobile").hide();
}
</script>
