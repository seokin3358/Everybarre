// 회원 정보 수정 - 디비 이메일 불러오기 (즉시 실행 함수)
(function() {
	console.log("즉시실행함수");
	
	var fullEmail = document.getElementById('userEmail_1').value;
	
	var email = fullEmail.split('@');
	
	document.getElementById('userEmail_1').value = email[0];
	document.getElementById('userEmail_2').value = email[1];
	
})();

// 회원 정보 수정 - 디비 이메일 불러오기2 (즉시 실행 함수)
/*window.onload = function(){

console.log("온로드 함수입니다")

var fullEmail = document.getElementById('userEmail_1').value;

var email = fullEmail.split('@');

 console.log(email[0])
 console.log(email[1])

document.getElementById('userEmail_1').value = email[0];
document.getElementById('userEmail_2').value = email[1];
}*/



// 예약변경 - 옵션 변경 시 옵션 금액 / 총 예약 금액 계산하기
function calTotal() {
	
	// 1. 계산에 필요한 변수
	// 옵션 금액
	let adult_num = Number($('#adult_num').val()) * 22000;						// 성인 수 * 22000
	let child_num = Number($('#child_num').val()) * 22000;						// 어린이 수 * 22000
	let adultBr = Number($('#adultBr').val()) * 45000;							// 성인 조식 수 * 45000
	let childBr = Number($('#childBr').val()) * 27000;							// 어린이 조식 수 * 27000
	let extraBed = Number($('#extraBed').val()) * 44000;						// 엑스트라 베드 * 44000
	
	// 룸 가격 / 세금
	let roomPrice = parseInt(document.getElementById('room_price').innerHTML);	// 룸 가격
	let tax = parseInt(document.getElementById('tax').innerHTML);				// 세금
	
	
	// 2. 계산하는 변수
	let calOption = adult_num + child_num + adultBr + childBr + extraBed;		// 옵션 금액
	let calTotal = calOption + roomPrice + tax;									// 총 예약 금액
	
	// 3. 출력할 변수
	// 화면에 보여지는 금액
	let optionPrice = document.getElementById('option_price');					// 옵션 금액
	let totalPrice = document.getElementById('total_price');					// 총 예약금액
	
	// 히든으로 보낼 금액(계산된 총 예약 금액)
	let updateTotal = document.getElementById('updateTotal');
	
	console.log(roomPrice);
	console.log(tax);
	
	// 4. 값 넘기기
	option_price.innerText = calOption;
	total_price.innerText = calTotal;
	updateTotal.value = calTotal;

}

