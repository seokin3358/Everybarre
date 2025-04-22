<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>객실 예약 - 투숙기간, 객실 선택 | 조선호텔앤리조트</title>
<link rel="stylesheet" href="css/ResStyle.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<jsp:include page="include/header.jsp" />
<div style="margin:0 5%; ">
	<div class="topArea"  style="width:100%;">
		<div class="topInner">
			<h2 class="titDep1">예약하기</h2>
		</div>
	</div>

	<%-- <form class="res_cont" id="step0Form" name="step0Form" method="post" 
			action="<%=request.getContextPath()%>/step1.do">
		<input type="hidden" name="resIn" id="resIn" value="0">				
		<input type="hidden" name="resOut" id="resOut" value="0">
		<input type="hidden" name="resNight" id="resNight" value="0">				
		<input type="hidden" name="resAdult" id="resAdult" value="1">								
		<input type="hidden" name="resChild" id="resChild" value="0">
		<input type="hidden" name="resInYoil" id="resInYoil" value="">
		<input type="hidden" name="resOutYoil" id="resOutYoil" value=""> --%>

			<div class="inner" style="width:100%;">
				<ul class="dateSelect">		
					<li>
						<strong class="listTit">객실정보 및 요금</strong>	
						<div style="display: flex;" >
							<img style="margin: 0 auto; max-width:100%" src="images/Time.jpg">
						</div>
					</li>			
					<li>
						<strong class="listTit">이용 시 확인사항</strong>	
						<p class="resGuide">
							* 기준인원 6인 / 최대 10인
							<br/><br/>
							* 이용시간
							<br/>
							 - 오전 9시 ~ 오후2시
							<br/>
							 - 오후 4시 ~ 오후9시
							<br/>
							 - 종일권은 문의해주세요 
							<br />
							  010-2733-4797
							<br/><br/>
							* 안내사항
							<br/>
							 이용전 모든 내용을 확인 및 동의하신것으로 간주합니다.
							<br/>
							 - 입장시 신발은 벗고 들어가주세요. 슬리퍼가 준비되어 있습니다.				
							<br/>
							 - 배달음식,외부음식 모두 취식 가능합니다.
							<br/>
							 - 무인 공간대여시설로 모든 안전사고에 대한 책임은 보호자에게 있으니 꼭 아이들이 다치지않게 주의와 관심어린 지도 부탁드립니다!
							<br/>
							 - 이용시 분실 또는 파손시 변상비가 청구될 수 있습니다.
							<br/>
							 - 주차는 1팀당 3대까지 무료주차 가능합니다.
							<br/>
							 - 매장 내 흡연 및 취사를 금합니다.
							<br/>
							 - 예약인원을 제외한 외부인원 및 애완견 출입을 금합니다.
							<br/>
							 - 수영장 내부 음식물 반입을 금합니다.
							<br/>
							 - 안전과 인원체크를 위해 샤워실과 파우더룸을 제외한 나머지 공간모두 CCTV설치 운영중이니 참고 부탁드립니다.
							<br/><br/>
							* 입금 계좌번호 안내 *
							<br/>
							- 하나은행 27991075962207 조임경
							<br/><br/>
							* 취소 / 환불규정 안내
							<br/>
							- 예약일 3일전 ~ 이용당일 : 취소불가
							<br/>
							- 예약일 4일전 : 결제금액의 60%차감
							<br/>
							- 예약일 5일전 : 결제금액의 50%차감
							<br/>
							- 예약일 6일전 : 결제금액의 40%차감
							<br/>
							- 예약일 7일전 : 결제금액의 30%차감
							<br/>
							- 예약일 8일전 : 전액환불
													
						</p>
					</li>			
			
				</ul>
				<div class="res_submit_area" style="margin:0 20%; ">
					<a href="https://map.naver.com/v5/search/%ED%92%80%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EB%B3%84%EB%82%B4/place/1544365898?c=15,0,0,0,dh&isCorrectAnswer=true">
					<input type="submit" class="res_submit" value="예약 하기">
					</a>
				</div>
				
			</div>
		
	</div>
	
	<script type="text/javascript" src="js/cal.js"></script>
	<script type="text/javascript" src="js/res_step0.js"></script>

	<jsp:include page="include/footer.jsp" />

</body>
</html>