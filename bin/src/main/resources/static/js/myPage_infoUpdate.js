// 회원 정보 수정 페이지

// 디비 이메일 불러오기 (즉시 실행 함수)
(function() {
	console.log("온로드 함수입니다");
	
	var fullEmail = document.getElementById('userEmail_1').value;
	
	var email = fullEmail.split('@');
	
	document.getElementById('userEmail_1').value = email[0];
	document.getElementById('userEmail_2').value = email[1];
	
	
})();


// 디비 이메일 불러오기2 (즉시 실행 함수)
/*window.onload = function(){

console.log("온로드 함수입니다")

var fullEmail = document.getElementById('userEmail_1').value;

var email = fullEmail.split('@');

 console.log(email[0])
 console.log(email[1])

document.getElementById('userEmail_1').value = email[0];
document.getElementById('userEmail_2').value = email[1];
}*/



