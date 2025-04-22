//회원가입 페이지

// 이메일 선택 스크립트 (선택한 해당 이메일 값 가져오기 + 직접 입력하기)
function email_change(){
	 
	// ::E-mail 선택:: 옵션 선택했을 시
	if(document.join.userEmail.options[document.join.userEmail.selectedIndex].value == '0'){

			document.join.userEmail_2.readOnly = true;
			document.join.userEmail_2.value = " ";
 
	}
	
	// 직접입력 옵션 선택했을 시
	if(document.join.userEmail.options[document.join.userEmail.selectedIndex].value == '1'){

			document.join.userEmail_2.readOnly = false;
			document.join.userEmail_2.value = "";
			document.join.userEmail_2.focus();

	} else {
		// 그 외에 이메일 형식 옵션 선택했을 시
		document.join.userEmail_2.readOnly = true;
		document.join.userEmail_2.value = document.join.userEmail.options[document.join.userEmail.selectedIndex].value;

	}

}


// 도로명 주소  다음 API 스크립트
//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
function sample4_execDaumPostcode() {
	 new daum.Postcode({
    oncomplete: function(data) {
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var roadAddr = data.roadAddress; // 도로명 주소 변수
        var extraRoadAddr = ''; // 참고 항목 변수

        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraRoadAddr += data.bname;
        }
        // 건물명이 있고, 공동주택일 경우 추가한다.
        if(data.buildingName !== '' && data.apartment === 'Y'){
           extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
        }
        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
        if(extraRoadAddr !== ''){
            extraRoadAddr = ' (' + extraRoadAddr + ')';
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('sample4_postcode').value = data.zonecode;
        document.getElementById("sample4_roadAddress").value = roadAddr;
        document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
        
        // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
        if(roadAddr !== ''){
            document.getElementById("sample4_extraAddress").value = extraRoadAddr;
        } else {
            document.getElementById("sample4_extraAddress").value = '';
        }

        var guideTextBox = document.getElementById("guide");
        // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
        if(data.autoRoadAddress) {
            var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
            guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
            guideTextBox.style.display = 'block';

        } else if(data.autoJibunAddress) {
            var expJibunAddr = data.autoJibunAddress;
            guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
            guideTextBox.style.display = 'block';
        } else {
            guideTextBox.innerHTML = '';
            guideTextBox.style.display = 'none';
        }
    }
	  }).open();
}


// 아이디 중복 체크 스크립트
function idCheck(){
	var userId = document.join.userId.value;
	
	// 중복 체크할 아이디 입력 안 하였을 경우 
	if(userId.length<1 || userId == null) {
		alert("중복체크할 아이디를 입력하세요.");
		document.join.userId.focus();
		return false;
	}
	
	$.ajax({
		type : "post",
		url : "../Hotel_JSP/view/login/idCheck.jsp?userId=" + userId,
		data : {
			"userId" : userId
		},
		success : function(data) {
			data = parseInt(data);
			if(data === 1){
				alert("중복된 아이디입니다.")
				$('#id_txt').val("");
			} else if(data === -1){
				alert("'admin'과 'ADMIN'은 사용 불가한 아이디입니다.")
				$('#id_txt').val("");
			} else {
				alert("사용가능한 아이디입니다.")
			}
		},
		error : function() {
			alert('오류');
		}
	});
}


// 비밀번호 체크 후 확인 메시지 출력하는 스크립트
function pwd_check(){
	
	// 비밀번호 값(pwd)과 비밀번호 확인 값(pwd_check)이 null값이 아닌 경우 
	if(document.getElementById('userPwd').value != '' && document.getElementById('userPwd_check').value != '') {
		if(document.getElementById('userPwd').value == document.getElementById('userPwd_check').value) {
			// 비밀번호 값(pwd)과 비밀번호 확인 값(pwd_check)이 같은 경우 
			document.getElementById('check').innerHTML = '비밀번호가 일치합니다.';
			document.getElementById('check').style.color = 'black';
		} else {
			// 비밀번호 값(pwd)과 비밀번호 확인 값(pwd_check)이 다른 경우 
			document.getElementById('check').innerHTML = '비밀번호가 일치하지 않습니다.';
			document.getElementById('check').style.color = 'red';
		}
	} else if(document.getElementById('userPwd_check').value == '') {
		// 비밀번호 확인(pwd_check)에 값이 없는 경우(다시 체크할 때)
		document.getElementById('check').innerHTML = '비밀번호를 확인해주세요.';
		document.getElementById('check').style.color = 'black';
	}
	
}

