<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Full Stay | 별내</title>
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
</head>
<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false'>
	<jsp:include page="include/header.jsp" />
    	
    <div id="fullpage">
    	<!-- <div class="section" style="-webkit-background-size: cover; -moz-background-size: cover; -o-background-size: cover; background-size: cover;">
 		<video id=“vid” muted autoplay playsinline loop data-keepplaying style="position: fixed; right: 0; bottom: 0; min-width: 100%; min-height: 100%; width: auto; height: auto;">
        <source src="file/network.mp4" type="video/mp4">        
      </video>  
      </div> -->
      <div class="section">
      
		<div id="index_web" class="section_menu">
			<div class="slide" style="background-image: url(images/main_1_blur.jpg); background-size: cover;">
				<div class="fp_bg_1" ></div>
						  	<img class="slide_box" src="images/main_1.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_2_blur.jpg); background-size: cover;">
				<div class="fp_bg_2"></div>
						  	<img class="slide_box" src="images/main_2.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_3_blur.jpg); background-size: cover;">
				<div class="fp_bg_3"></div>
						  	<img class="slide_box" src="images/main_3.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_4_blur.jpg); background-size: cover;">
				<div class="fp_bg_4"></div>
						  	<img class="slide_box" src="images/main_4.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_5_blur.jpg); background-size: cover;">
				<div class="fp_bg_5"></div>
						  	<img class="slide_box" src="images/main_5.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_6_blur.jpg); background-size: cover;">
				<div class="fp_bg_6"></div>
						  	<img class="slide_box" src="images/main_6.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_7_blur.jpg); background-size: cover;">
				<div class="fp_bg_7"></div>
						  	<img class="slide_box" src="images/main_7.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_8_blur.jpg); background-size: cover;">
				<div class="fp_bg_8"></div>
						  	<img class="slide_box" src="images/main_8.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_9_blur.jpg); background-size: cover;">
				<div class="fp_bg_9"></div>
						  	<img class="slide_box" src="images/main_9.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_10_blur.jpg); background-size: cover;">
				<div class="fp_bg_10"></div>
						  	<img class="slide_box" src="images/main_10.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_11_blur.jpg); background-size: cover;">
				<div class="fp_bg_11"></div>
						  	<img class="slide_box" src="images/main_11.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_12_blur.jpg); background-size: cover;">
				<div class="fp_bg_12"></div>
						  	<img class="slide_box" src="images/main_12.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_13_blur.jpg); background-size: cover;">
				<div class="fp_bg_13"></div>
						  	<img class="slide_box" src="images/main_13.jpg">
			</div>
			</div>
			<!-- 모바일부분 추가 -->
		
		<div id="mobile_web" class="section_menu_mobile">
			<div class="slide" style="background-image: url(images/main_1_blur.jpg); background-size: cover;">
				<div class="fp_bg_1" ></div>
						  	<img class="slide_box_mobile" src="images/main_1.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_2_blur.jpg); background-size: cover;">
				<div class="fp_bg_2"></div>
						  	<img class="slide_box_mobile" src="images/main_2.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_3_blur.jpg); background-size: cover;">
				<div class="fp_bg_3"></div>
						  	<img class="slide_box_mobile" src="images/main_3.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_4_blur.jpg); background-size: cover;">
				<div class="fp_bg_4"></div>
						  	<img class="slide_box_mobile" src="images/main_4.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_5_blur.jpg); background-size: cover;">
				<div class="fp_bg_5"></div>
						  	<img class="slide_box_mobile" src="images/main_5.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_6_blur.jpg); background-size: cover;">
				<div class="fp_bg_6"></div>
						  	<img class="slide_box_mobile" src="images/main_6.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_7_blur.jpg); background-size: cover;">
				<div class="fp_bg_7"></div>
						  	<img class="slide_box_mobile" src="images/main_7.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_8_blur.jpg); background-size: cover;">
				<div class="fp_bg_8"></div>
						  	<img class="slide_box_mobile" src="images/main_8.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_9_blur.jpg); background-size: cover;">
				<div class="fp_bg_9"></div>
						  	<img class="slide_box_mobile" src="images/main_9.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_10_blur.jpg); background-size: cover;">
				<div class="fp_bg_10"></div>
						  	<img class="slide_box_mobile" src="images/main_10.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_11_blur.jpg); background-size: cover;">
				<div class="fp_bg_11"></div>
						  	<img class="slide_box_mobile" src="images/main_11.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_12_blur.jpg); background-size: cover;">
				<div class="fp_bg_12"></div>
						  	<img class="slide_box_mobile" src="images/main_12.jpg">
			</div>
			<div class="slide" style="background-image: url(images/main_13_blur.jpg); background-size: cover;">
				<div class="fp_bg_13"></div>
						  	<img class="slide_box_mobile" src="images/main_13.jpg">
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
		setInterval(function(){
			$("#next_button").trigger("click");
			},6000)
	</script>
</html>