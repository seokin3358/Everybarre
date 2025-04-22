// 페이지 로딩하면 작동
const className = document.querySelector('.toggleOn');
$(document).ready( function(){
	
	// 토글 -------------------------------------------------
	$( '.total_toggle' ).click( function() {
    	$( '.toggleCont' ).toggle( 'slow' );
    	className.classList.toggle('toggleOn');
    });

	
	// resDate (예약일-오늘) 구하기 -----------------------------
	let now = new Date(); // 현재 날짜 // resDate hidden 값
	let year = now.getFullYear();
	let month = now.getMonth() +1;
	let date = now.getDate();
	
	if(month < 10){
		month = '0' +month;
		if(date < 10){
			date = '0' +date;
		}
	}
	
	$("#resDate").val(now); // hidden 값
	
	let rDateResult = document.getElementById('rDateResult'); // 총액 부분 표시값
	rDateResult.innerText = year+ '.' +month+ '.' +date;
	
	getTotal();
	
});


//어른 조식 증감
function count(type)  {
  // 결과를 표시할 element
  let resultElement = document.getElementById('result'); // +- 버튼 안쪽 숫자
  let aBrResult =  document.getElementById('aBrResult'); // total 영역 표시부분 
  let resAdultBr =  document.getElementById('resAdultBr'); // hidden 값
  
  // 현재 화면에 표시된 값
  let number = resultElement.innerText;
  
  // 더하기/빼기
  if(type === 'plus') {
	  if(number <= 3){
		   number = parseInt(number) +1;
		   resAdultBr.value = number;
	  }	 
  }else if(type === 'minus')  {
	  if(number >= 1) {
		  number = parseInt(number) - 1;
		  resAdultBr.value = number;
	  }		    
  }
  
  // 계산
  let aBr = number *45000;
   
  // 결과 출력	  
  resultElement.innerText = number.toLocaleString('ko-KR');
  aBrResult.innerText = aBr.toLocaleString('ko-KR');
  
  getTotal();
  
} // count() end 

// 어린이 조식 증감
function count2(type)  {
  // 결과를 표시할 element
  let resultElement = document.getElementById('result2'); // +- 버튼 안쪽 숫자
  let cBrResult =  document.getElementById('cBrResult'); // total 영역 표시부분 
  let resChildBr =  document.getElementById('resChildBr'); // hidden 값

  
  // 현재 화면에 표시된 값
  let number = resultElement.innerText;
  
  // 더하기/빼기
  if(type === 'plus') {
	  if(number <= 3){
		   number = parseInt(number) +1;
		   resChildBr.value = number;
	  }	 
  }else if(type === 'minus')  {
	  if(number >= 1) {
		  number = parseInt(number) - 1;
		  resChildBr.value = number;
	  }		    
  }
  
  // 계산
  let cBr = number*27000;
  
  // 결과 출력	  
  resultElement.innerText = number.toLocaleString('ko-KR');	
  cBrResult.innerText =cBr.toLocaleString('ko-KR');
  
  getTotal();
} // count2() end

// 엑스트라베드 증감
function count3(type)  {
  // 결과를 표시할 element
  let resultElement = document.getElementById('result3'); // +- 버튼 안쪽 숫자
  let bedResult =  document.getElementById('bedResult'); // total 영역 표시부분 
  let resBed =  document.getElementById('resBed'); // hidden 값

  
  // 현재 화면에 표시된 값
  let number = resultElement.innerText;
  
  // 더하기/빼기
  if(type === 'plus') {
	  if(number == 0){
		   number = parseInt(number) +1;
		   resBed.value = number;
	  }	 
  }else if(type === 'minus')  {
	  if(number >= 1) {
		  number = parseInt(number) - 1;
		  resBed.value = number;
	  }		    
  }
  
  // 계산
  let bed = number*44000;
  
  // 결과 출력	  
  resultElement.innerText = number.toLocaleString('ko-KR');	
  bedResult.innerText = bed.toLocaleString('ko-KR');
  
  getTotal();
} // count2() end


// 총금액 구하기
function getTotal(){
	
	// 필요한 값 받아오기
	let roomPrice = Number($('#roomPrice').val()); 
	let resNight = Number($('#resNight').val()); 
	let resAdult = Number($('#resAdult').val()); 
	let resChild = Number($('#resChild').val()); 
	let resAdultBr = Number($('#resAdultBr').val()); 
	let resChildBr = Number($('#resChildBr').val()); 
	let resBed = Number($('#resBed').val()); 
	
	// 값 저장용 변수
	let roomTotal = document.getElementById('roomTotal'); 
	let resTax = document.getElementById('resTax'); 
	let resTotal = document.getElementById('resTotal'); 
	let resPretax = document.getElementById('resPretax'); 
	
	// 어른 인원 계산
	let adult_num = 1;
	
	if(resAdult > 2){
		adult_num = resAdult - 2
	}else{
		adult_num = 0;
	}
	
	let aBrPrice = document.getElementById('aBrPrice'); //어른조식*45000
	let cBrPrice = document.getElementById('cBrPrice'); //어린이조식*27000 
	let bedPrice = document.getElementById('bedPrice'); //엑스트라베드*44000
	
	// 화면 출력용 변수
	let roomPriceResult = document.getElementById('roomPriceResult'); 
	let taxResult = document.getElementById('taxResult'); 
	let totalResult = document.getElementById('totalResult'); 
	let realTotal = document.getElementById('realTotal'); 
	
	
	
	// 계산
	let rmTotal = roomPrice * resNight + (adult_num * 22000 + resChild * 22000);
	let pretax = rmTotal+ (resAdultBr*45000)+(resChildBr*27000)+(resBed*44000); // 세금미포함
	let tax = pretax /10;
	let total = pretax + tax;
	
	
	
	
	// 값 저장
	roomTotal.value = rmTotal;
	resPretax.value = pretax; // 세금미포함
	resTotal.value = total; // 세금포함
	resTax.value = tax;
	
	aBrPrice.value = resAdultBr*45000;
	cBrPrice.value = resChildBr*27000;
	bedPrice.value = resBed*44000;
	
	// 화면 출력
	roomPriceResult.innerText = rmTotal.toLocaleString('ko-KR');
	totalResult.innerText = total.toLocaleString('ko-KR');
	realTotal.innerText = total.toLocaleString('ko-KR');
	taxResult.innerText = tax.toLocaleString('ko-KR');
	// resPretax는 step3에서만 쓰이므로 step2에서는 출력하지 않음
	
	
} // getTotal() end

