<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">		
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css">
	<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/fullpage.css" />
	<link rel="stylesheet" href="css/MainStyle.css">
	<!-- <link rel="stylesheet" href="css/services.css"> -->
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
	<script>

function Mobile() {return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);}

</script>
	<jsp:include page="include/header.jsp" />
<title>풀스테이 소개 | Full Stay 별내</title>
</head>
<body>
<div id="fullpage">
	 <div class="section">
		<div id="index_web" class="section_menu">
			<div class="slide">
				<div class="fp_bg_1" ></div>
						  	<img class="slide_box" src="images/playroom.jpg">
						  	<p style="text-align:center; margin-top:2%;">플레이룸</p>
						  	<p style="text-align:center; margin-top:0.5%;">풀스테이만의 색감으로 아이들의 창의력과 즐거운 시간을 보낼수있도록 다양한 장난감이 준비되어있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_2"></div>
						  	<img class="slide_box" src="images/partyroom.jpg">
						  	<p style="text-align:center; margin-top:2%;">파티룸</p>
						  	<p style="text-align:center; margin-top:0.5%;">파티룸이용시 다양한 동영상 및 음악을 즐길수있으며, 각양각색의 컨셉으로 파티룸을 즐길수 있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_3"></div>
						  	<img class="slide_box" src="images/swimmingpool.jpg">
						  	<p style="text-align:center; margin-top:2%;">수영장</p>
						  	<p style="text-align:center; margin-top:0.5%;">사계절 따뜻한 온수풀로 아이들의 귀여운 물놀이공간입니다.</p>
						  	<p style="text-align:center; margin-top:0.5%;">수영장은 통유리로 아이들이 노는모습을 한눈에 볼수있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_4"></div>
						  	<img class="slide_box" src="images/showerroom.jpg">
						  	<p style="text-align:center; margin-top:2%;">샤워실</p>
						  	<p style="text-align:center; margin-top:0.5%;">아이들은 물론 어른들까지 샤워할수있는 샤워공간과 샤워용품 및 탈수기가 구비되어있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_5"></div>
						  	<img class="slide_box" src="images/powerroom.jpg">
						  	<p style="text-align:center; margin-top:2%;">파우더룸</p>
						  	<p style="text-align:center; margin-top:0.5%;">하나만으로도 충분한 큰 수건과 기저귀갈이대, 드라이기등이 구비되어있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_6"></div>
						  	<img class="slide_box" src="images/kitchen.jpg">
						  	<p style="text-align:center; margin-top:2%;">주방</p>
						  	<p style="text-align:center; margin-top:0.5%;">아이와 어른들의 다양한 식기와 캡슐 커피머신, 전자렌지 냉장고등이 구비되어있습니다.</p>
			</div>
			</div>
			<!-- 모바일부분 추가 -->
		
		<div id="mobile_web" class="section_menu_mobile">
			<div class="slide">
				<div class="fp_bg_1" ></div>
						  	<img class="slide_box_mobile" src="images/playroom.jpg">
						  	<p style="text-align:center; margin-top:2%;">플레이룸</p>
						  	<p style="text-align:center; margin-top:0.5%;">풀스테이만의 색감으로 아이들의 창의력과 즐거운 시간을 보낼수있도록 다양한 장난감이 준비되어있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_2"></div>
						  	<img class="slide_box_mobile" src="images/partyroom.jpg">
						  	<p style="text-align:center; margin-top:2%;">파티룸</p>
						  	<p style="text-align:center; margin-top:0.5%;">파티룸이용시 다양한 동영상 및 음악을 즐길수있으며, 각양각색의 컨셉으로 파티룸을 즐길수 있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_3"></div>
						  	<img class="slide_box_mobile" src="images/swimmingpool.jpg">
						  	<p style="text-align:center; margin-top:2%;">수영장</p>
						  	<p style="text-align:center; margin-top:0.5%;">사계절 따뜻한 온수풀로 아이들의 귀여운 물놀이공간입니다.</p>
						  	<p style="text-align:center; margin-top:0.5%;">수영장은 통유리로 아이들이 노는모습을 한눈에 볼수있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_4"></div>
						  	<img class="slide_box_mobile" src="images/showerroom.jpg">
						  	<p style="text-align:center; margin-top:2%;">샤워실</p>
						  	<p style="text-align:center; margin-top:0.5%;">아이들은 물론 어른들까지 샤워할수있는 샤워공간과 샤워용품 및 탈수기가 구비되어있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_5"></div>
						  	<img class="slide_box_mobile" src="images/powerroom.jpg">
						  	<p style="text-align:center; margin-top:2%;">파우더룸</p>
						  	<p style="text-align:center; margin-top:0.5%;">하나만으로도 충분한 큰 수건과 기저귀갈이대, 드라이기등이 구비되어있습니다.</p>
			</div>
			<div class="slide">
				<div class="fp_bg_6"></div>
						  	<img class="slide_box_mobile" src="images/kitchen.jpg">
						  	<p style="text-align:center; margin-top:2%;">주방</p>
						  	<p style="text-align:center; margin-top:0.5%;">아이와 어른들의 다양한 식기와 캡슐 커피머신, 전자렌지 냉장고등이 구비되어있습니다.</p>
			</div>
		</div>	
		</div>	
			
		
	

		<div class="section fp-auto-height">
			<jsp:include page="include/footer.jsp" />
		</div>
		</div>
<!--  Fullpage.js -->
	<script type="text/javascript" src="js/fullpage.js">
	if(Mobile()){
		$("#indexweb").empty();
		$("#index_web").empty();
		$("#fp-nav").hide();
	}else{
		$("#indexmobile").empty();
		$("#index_mobile").empty();
		$("#mobile_web").empty();
		
	}
	</script>
	<script type="text/javascript" src="js/cal.js"></script>
	<script type="text/javascript" src="js/main.js"></script>
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  	<script>
    	AOS.init();
  	</script>
</body>
<script>
		if(Mobile()){
			$("#indexweb").empty();
			$("#index_web").empty();
			$("#fp-nav").hide();
		}else{
			$("#indexmobile").empty();
			$("#index_mobile").empty();
			$("#mobile_web").empty();
		}
/* 		setInterval(function(){
			$("#next_button").trigger("click");
			},6000) */
	</script>
</html>