// 로그인 페이지

// 로그인시 아이디 저장(체크박스) 기능 스크립트
$(document).ready(function() {
	
	$("#idSaveCheck").change(function(){ 
		let id_save_bol = ($("#idSaveCheck").is(":checked"))
           
		if(id_save_bol === true){ 
        	  $("#id_save_int").val(1);
        }else{
        	 $("#id_save_int").val(0);
        }
	});  
	
});