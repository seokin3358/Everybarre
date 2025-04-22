// 예약 변경 페이지

// 기존 예약 옵션으로 옵션 금액 계산하여 페이지 로딩시 바로 보여주는 함수
(function() {
	
	let adult = Number($('#adult_num').val());									// 성인 수
	let adult_num;
	
	// 성인 2명 초과 될 시에만 추가요금 부과
	if(adult > 2 ) {
		adult_num = 22000;	
	} else {
		adult_num = 0;
	}
	
	let child_num = Number($('#child_num').val()) * 22000;						// 어린이 수 * 22000
	let adultBr = Number($('#adultBr').val()) * 45000;							// 성인 조식 수 * 45000
	let childBr = Number($('#childBr').val()) * 27000;							// 어린이 조식 수 * 27000
	let extraBed = Number($('#extraBed').val()) * 44000;						// 엑스트라 베드 * 44000
	
	let input_room = Number($('#input_room').val());							// 룸 금액
	
	let calOption = adult_num + child_num + adultBr + childBr + extraBed;		// 옵션 금액
	let calTax = (calOption + input_room) * 0.1;								// 세금 (룸 금액 + 옵션 금액) * 0.1
	
	document.getElementById('option_price').innerHTML = calOption.toLocaleString('ko-KR') + " (원)" ;
	document.getElementById('tax').innerHTML = calTax.toLocaleString('ko-KR') + " (원)" ;

})();


// 옵션 변경 시 옵션 금액 / 총 예약 금액 계산하기
function calTotal() {
	
	// 1. 계산에 필요한 변수
	
	// 옵션 금액
	let child_num = Number($('#child_num').val()) * 22000;						// 어린이 수 * 22000
	let adultBr = Number($('#adultBr').val()) * 45000;							// 성인 조식 수 * 45000
	let childBr = Number($('#childBr').val()) * 27000;							// 어린이 조식 수 * 27000
	let extraBed = Number($('#extraBed').val()) * 44000;						// 엑스트라 베드 * 44000
	
	// 성인 '2명 초과' 될 시에만 추가요금 부과(2명 이하는 가격 변동 X)
	let adult = Number($('#adult_num').val());									// 성인 수
	let adult_num;

	if(adult > 2 ) {
		adult_num = 22000;	
	} else {
		adult_num = 0;
	}
	
	// 룸 가격
	let input_room = Number($('#input_room').val());
	
	// 2. 계산하는 변수
	let calOption = adult_num + child_num + adultBr + childBr + extraBed;		// 옵션 금액
	let calTax = (calOption + input_room) * 0.1;								// 세금 (룸 금액 + 옵션 금액) * 0.1
	let calTotal = calOption + input_room + calTax;								// 총 예약 금액
	
	// 3. 출력할 변수
	// 화면에 보여지는 금액
	let optionPrice = document.getElementById('option_price');					// 옵션 금액
	let totalPrice = document.getElementById('total_price');					// 총 예약금액
	
	// 히든으로 보낼 금액(계산된 총 예약 금액)
	let updateTotal = document.getElementById('updateTotal');
	
	console.log(input_tax);
	console.log(input_room);
	
	// 4. 값 넘기기
	option_price.innerText = calOption.toLocaleString('ko-KR') + " (원)";		// 옵션 금액에 저장
	tax.innerText = calTax.toLocaleString('ko-KR') + " (원)";					// 세금에 저장
	total_price.innerText = calTotal.toLocaleString('ko-KR') + " KRW";			// 총 예약 금액에 저장
	updateTotal.value = calTotal;												// 총 예약 금액 히든 값에 저장

}