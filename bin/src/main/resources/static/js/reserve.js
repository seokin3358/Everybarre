// 페이지가 처음 로드되었을때 실행문
$(document).ready( function(){
	
	// 토글 버튼 ------------------------------------
	$( '.dToggleBtn' ).click( function() {
    	$( '.dToggleInner' ).toggle( 'slow' );
    });
	
	$( '.pToggleBtn' ).click( function() {
    	$( '.pToggleInner' ).toggle( 'slow' );
    });
	
	// 달력 날짜 표시 ------------------------------------
	let resIn_val = document.getElementById('resIn_val'); 		// input type=date 안에 표시 날짜
	let resOut_val = document.getElementById('resOut_val'); 		
	
	let resIn = document.getElementById('resIn');				// 결과 값 저장 변수
	let resOut = document.getElementById('resOut');				

	let resInView = document.getElementById('resInView'); 		// 상단 표시 날짜
	let resOutView = document.getElementById('resOutView'); 

	
	let now = new Date(); // 현재
	
	let today = new Date(now); // 오늘 날짜
	let year = now.getFullYear();
	let month = now.getMonth() +1;
	let date = now.getDate();
	
	let tomorrow = new Date(now.setDate(now.getDate() + 1)); // 내일 날짜
	let t_year = tomorrow.getFullYear();
	let t_month = tomorrow.getMonth() +1;
	let t_date = tomorrow.getDate();
	
	
	if(month < 10){
		month = '0' +month;
		
		if(date < 10){
			date = '0' +date;
		}
	}
	
	if(t_month < 10){
		t_month = '0' +t_month;
		
		if(t_date < 10){
			t_date = '0' +t_date;
		}
	}
	

	// 결과 저장
	resIn.value = today;
	resOut.value = tomorrow;
	
	resIn_val.value = year+ '-' +month+ '-' +date;
	resOut_val.value = t_year+ '-' +t_month+ '-' +t_date;
	
	resInView.innerText = resIn_val.value;
	resOutView.innerText = resOut_val.value;

});
	
	
	// 어른 인원 증감 (완료)
	function count(type)  {
		  // 결과를 표시할 element
		  let resultElement = document.getElementById('result'); // +- 버튼 안쪽 명수
		  let resultA =  document.getElementById('resultA'); // 상단 표시 명수
		  let resAdult =  document.getElementById('resAdult');
		  
		  // 현재 화면에 표시된 값
		  let number = resultElement.innerText;
		  
		  // 더하기/빼기
		  if(type === 'plus') {
			  if(number <= 3){
				   number = parseInt(number) +1;
				   resAdult.value = number;
			  }	 
		  }else if(type === 'minus')  {
			  if(number >= 1) {
				  number = parseInt(number) - 1;
				  resAdult.value = number;
			  }		    
		  }
		  
		  // 결과 출력	  
		  resultElement.innerText = number + "명";	
		  resultA.innerText = number;
		  
	} // count() end 
	
	// 어린이 인원 증감 (완료)
	function count2(type)  {
		  // 결과를 표시할 element
		  let resultElement = document.getElementById('result2'); // +- 버튼 안쪽 명수
		  let resultC =  document.getElementById('resultC'); // 상단 표시 명수
		  let resChild =  document.getElementById('resChild');
		
		  
		  // 현재 화면에 표시된 값
		  let number = resultElement.innerText;
		  
		  // 더하기/빼기
		  if(type === 'plus') {
			  if(number <= 3){
				   number = parseInt(number) +1;
				   resChild.value = number;
			  }	 
		  }else if(type === 'minus')  {
			  if(number >= 1) {
				  number = parseInt(number) - 1;
				  resChild.value = number;
			  }		    
		  }
		  
		  // 결과 출력	  
		  resultElement.innerText = number + "명";	
		  resultC.innerText = number;
	} // count2() end 
	
	// 날짜 입력값 받아서 화면에 출력하기 (완료)
	function viewDate(type){
		let resultIn = document.getElementById('resIn_val'); 		// input type=date 안에 표시 날짜
		let resultOut = document.getElementById('resOut_val'); 		
		
		let resIn = document.getElementById('resIn');				// 결과 값 저장 변수
		let resOut = document.getElementById('resOut');				

		let resInView = document.getElementById('resInView'); 		// 상단 표시 날짜
		let resOutView = document.getElementById('resOutView'); 
		
		if(type === 'in'){
			resIn.value = resultIn.value;
			resultIn.innerText = resultIn.value;
			resInView.innerText = resultIn.value;
			countNight();
		}else if(type === 'out'){
			resOut.value = resultOut.value;
			resultOut.innerText = resultOut.value;
			resOutView.innerText = resultOut.value;
			countNight();
		}
		
		//숙박일수 
	} // viewDate() end
	
	
	
	// 숙박 일수 계산 (미완)
	function countNight(){		
		
		let resNight = document.getElementById('resNight'); 		// hidden 값
		let nightResult = document.getElementById('nightResult'); 	// 텍스트 표시 부분
		
		//직접 input date에서 받은 값 받기.
		let start_string = $("#resIn_val").val();
		let end_string = $("#resOut_val").val();
			
		// split으로 - 로 분해
		let start_res = start_string.split("-");
		let end_res = end_string.split("-");
		
		// 분해된 데이터를 DATE형식으로 계산하기위해 다시 재정렬.
		let start_date = new Date(start_res[0], Number(start_res[1]), start_res[2]);
		let end_date = new Date(end_res[0], Number(end_res[1]), end_res[2]);
		
		// 1000을 나누면 초, 60을 나누면 분, 60을 나누면 시간, 24을 나누면 일 단위. 초단위.
		let night_date = (end_date.getTime()- start_date.getTime())/1000/60/60/24; 
		
		nightResult.innerText = Number(night_date);
		resNight.value = Number(night_date);

	} // countNight() end
		