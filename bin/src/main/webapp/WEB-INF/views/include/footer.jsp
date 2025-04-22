<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/FooterStyle.css">
<script src="https://kit.fontawesome.com/57a8fee989.js" crossorigin="anonymous"></script>
<script>

function Mobile() {return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);}

</script>

</head>
    <footer>
        <div id="web_footer" class="site_logo">
            <a href="<%=request.getContextPath() %>/index.do" class="sitename">풀스테이 별내점</a>            
        </div>
        <div id="mobile_footer" class="site_logo" style="margin-top:5%; align-items:flex-start;" >
            <a style="padding:10px;" href="<%=request.getContextPath() %>/index.do" class="sitename" >
            <img style="width:100%;"  src="images/logo.jpg">
            </a>            
        </div>
        
        <div class="footer">          
            <div class="info">
                <address>주소 : 경기도 남양주시 별내중앙로 34, 602-1호</address>
                <p class="ceo">대표 : 조임경</p>
                <p class="tel">대표번호 : 010-2733-4797</p>
                <p class="tel">사업자등록번호 : 596-36-01232</p>
                <p class="copyright">©2023 Fullstay Co. All rights</p>
            </div>
            <ul class="policy">
                <a href="<%=request.getContextPath() %>/provision.do"><li>이용약관</li></a>
                <a href="<%=request.getContextPath() %>/privacy.do"><li>개인정보처리방침</li></a>
            </ul>
        </div>
        <div class="icon">
            <a href="https://www.instagram.com/fullstay2023/"><i class="fab fa-instagram"></i></a>
            <!-- <a href=""><i class="far fa-comments"></i></a>
            <a href=""><i class="fab fa-youtube"></i></a>     -->     
        </div>
    </footer>
<script>
if(Mobile()){
	$("#web_footer").hide();
}else{
	$("#mobile_footer").hide();
}
</script>