
const room_click = document.querySelector('#room_click');   	// 객실관리 클릭
const res_click = document.querySelector('#res_click');			// 예약관리 클릭
const member_click = document.querySelector('#member_click');	// 회원관리 클릭
const hotel = document.querySelector('#hotel');					// 객실관리 검색 table
const user = document.querySelector('#user');					// 예약관리 검색 table
const member = document.querySelector('#member');				// 회원관리 검색 table
const standard = document.querySelector('#standard');			// 스탠다드 table
const deluxe = document.querySelector('#deluxe');				// 디럭스 table
const suite = document.querySelector('#suite');					// 스위트 table
const prestige = document.querySelector('#prestige');			// 프레스티지 table
const res_none = document.querySelector('#res_none');			// 예약관리  table
const res_cont = document.querySelector('#res_cont');			// 예약관리  table
const res_cont1 = document.querySelector('#res_cont1');			// 예약관리  table
const member_cont = document.querySelector('#member_cont');		// 회원관리  table
const member_cont1 = document.querySelector('#member_cont1');	// 회원관리  table
const member_cont2 = document.querySelector('#member_cont2');	// 회원관리  table
const use = document.querySelector('.use');						
const search = document.querySelector('#search');				// 객실버튼 

const search_mem = document.querySelector('#member_search');	// 회원 검색 
const search_mem1 = document.querySelector('#member_search1');	// 회원 검색 
const search_none = document.querySelector('#search_none');		// none 검색 
const search_st = document.querySelector('#search_standard');	// standard 검색 
const search_d = document.querySelector('#search_deluxe');		// deluxe 검색 
const search_su = document.querySelector('#search_suite');		// suite 검색 
const search_p = document.querySelector('#search_prestige');	// prestige 검색 

const list_st = document.querySelector('.content_info_st');			// standard 검색 상세보기
const list_d = document.querySelector('.content_info_d');			// deluxe 검색 상세보기
const list_su = document.querySelector('.content_info_su');			// suite 검색 상세보기
const list_p = document.querySelector('.content_info_p');			//  prestige 검색 상세보기

let room = "";
let checkIn = "";
let checkOut = "";

let memberID = "";
let memberPhone = "";

function getContextPath() {

    return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));

}
/* 현재 날짜를 불러오는 함수 */
function getToday() {
	let date = new Date();
	return date.getFullYear() + "-" + ("0"+(date.getMonth()+1)).slice(-2) + "-" + ("0"+date.getDate()).slice(-2);
}

function standard_get() {
	let today = getToday();  // 오늘 날짜를 YYYY-MM-DD로 저장
	console.log("today" + today);
	let standard = $("#standard_name").text();
	let first = $("#101").text();
	let second = $("#102").text();
	let third = $("#103").text();
	// standard ajax
	$.ajax({
		type : "post",
		url : "./view/admin/standard_main.jsp",
		async: false,
		data : {
			"today" : today,
			"room_name" : standard
		},
		success : function(data) {
			let table1 = "";
			let table2 = "";
			let table3 = "";
			$(data).find("roomnum").each(function(){
				let number = $(this).find("number").text();
				if(first == number){
					table1 += "<i class='fas fa-check'><br></i><br>";
				}else if(second == number){
					table2 += "<i class='fas fa-check'><br></i><br>";
				}else if(third == number) {
					table3 += "<i class='fas fa-check'><br></i><br>";
				}
			});
			$("#101_check").empty();
			$("#102_check").empty();
			$("#103_check").empty();
			$("#101_check").append(table1);
			$("#102_check").append(table2);
			$("#103_check").append(table3);
			

		},
		error : function() {
			alert('오류');
		}
	});
};
standard_get();
function deluxe_get() {
	let today = getToday(); 
	let deluxe = $("#deluxe_name").text();
	let first = $("#201").text();
	let second = $("#202").text();
	let third = $("#203").text();
	
	// deluxe ajax
	$.ajax({
		type : "post",
		url : "./view/admin/deluxe_main.jsp",
		async: false,
		data : {
			"today" : today,
			"room_name" : deluxe
		},
		success : function(data) {
			let table1 = "";
			let table2 = "";
			let table3 = "";
			$(data).find("roomnum").each(function(){
				let number = $(this).find("number").text();
				if(first == number){
					table1 += "<i class='fas fa-check'><br></i><br>";
				}else if(second == number){
					table2 += "<i class='fas fa-check'><br></i><br>";
				}else if(third == number) {
					table3 += "<i class='fas fa-check'><br></i><br>";
				}
			});
			$("#201_check").empty();
			$("#202_check").empty();
			$("#203_check").empty();
			$("#201_check").append(table1);
			$("#202_check").append(table2);
			$("#203_check").append(table3);

		},
		error : function() {
			alert('오류');
		}
	});
};
deluxe_get();
function suite_get() {
	let today = getToday(); 
	let suite = $("#suite_name").text();
	let first = $("#301").text();
	let second = $("#302").text();
	let third = $("#303").text();
	// suite ajax
	$.ajax({
		type : "post",
		url : "./view/admin/suite_main.jsp",
		async: false,
		data : {
			"today" : today,
			"room_name" : suite
		},
		success : function(data) {
			let table1 = "";
			let table2 = "";
			let table3 = "";
			$(data).find("roomnum").each(function(){
				let number = $(this).find("number").text();
				if(first == number){
					table1 += "<i class='fas fa-check'><br></i><br>";
				}else if(second == number){
					table2 += "<i class='fas fa-check'><br></i><br>";
				}else if(third == number) {
					table3 += "<i class='fas fa-check'><br></i><br>";
				}
			});
			$("#301_check").empty();
			$("#302_check").empty();
			$("#303_check").empty();
			$("#301_check").append(table1);
			$("#302_check").append(table2);
			$("#303_check").append(table3);

		},
		error : function() {
			alert('오류');
		}
	});
};
suite_get();
function prestige_get() {
	let today = getToday(); 
	let prestige = $("#prestige_name").text();
	let first = $("#401").text();
	let second = $("#402").text();
	let third = $("#403").text();
	// prestige ajax
	$.ajax({
		type : "post",
		url : "./view/admin/prestige_main.jsp",
		async: false,
		data : {
			"today" : today,
			"room_name" : prestige
		},
		success : function(data) {
			let table1 = "";
			let table2 = "";
			let table3 = "";
			$(data).find("roomnum").each(function(){
				let number = $(this).find("number").text();
				if(first == number){
					table1 += "<i class='fas fa-check'><br></i><br>";
				}else if(second == number){
					table2 += "<i class='fas fa-check'><br></i><br>";
				}else if(third == number) {
					table3 += "<i class='fas fa-check'><br></i><br>";
				}
			});
			$("#401_check").empty();
			$("#402_check").empty();
			$("#403_check").empty();
			$("#401_check").append(table1);
			$("#402_check").append(table2);
			$("#403_check").append(table3);

		},
		error : function() {
			alert('오류');
		}
	});
};
prestige_get();

/* 객실검색 버튼 눌렀을 때*/

$(function() {
	$("#search_btn").click(function() {
		if (list_st.style.display === 'block') {
			list_st.style.display = 'none';
		}else if (list_d.style.display === 'block') {
			list_d.style.display = 'none';
		}else if (list_su.style.display === 'block') {
			list_su.style.display = 'none';
		}else if (list_p.style.display === 'block') {
			list_p.style.display = 'none';
		}
		room = $("#roomName").val();
		checkIn = $("#checkIn").val();
		checkOut = $("#checkOut").val();
		
		standard.classList.replace('use', 'off');
		deluxe.classList.replace('use', 'off');
		suite.classList.replace('use', 'off');
		prestige.classList.replace('use', 'off');
		standard.classList.replace('on', 'off');
		deluxe.classList.replace('on', 'off');
		suite.classList.replace('on', 'off');
		prestige.classList.replace('on', 'off');
		
		// 예약관리 테이블 숨김
		if (res_cont.classList == 'on') {
			res_cont.classList.replace('on', 'off');
		}
		
		if (room == 'none') {
			search_none.classList.replace('off','on');
			search_st.classList.replace('on','off');
			search_d.classList.replace('on','off');
			search_su.classList.replace('on','off');
			search_p.classList.replace('on','off');
		}
		
		// 각각 room 이름에 해당하는 ajax 실행
		if (room == 'STANDARD') {
			$("#content_standard").empty();
			search_none.classList.replace('on','off');
			search_st.classList.replace('off','on');
			search_d.classList.replace('on','off');
			search_su.classList.replace('on','off');
			search_p.classList.replace('on','off');

			// standard
			$.ajax({
				type : "post",
				url : "./view/admin/search_room.jsp",
				data : {
					"roomName" : room,
					"checkIn" : checkIn,
					"checkOut" : checkOut
				},
				async: false,
				datatype : "xml",
				success : function(data) {
					let table = "";
					$(data).find("reserve").each(function(){
						
						table += "<tr><td width='15%' align='center'>" + $(this).find("num").text()+"</td>"
						+"<td width='35%' align='center'>" + $(this).find("resin").text() +"&nbsp;~&nbsp;"+ $(this).find("resout").text() + "</td></tr>";
					});
					$("#content_standard").append(table);
					

				},
				error : function() {
					alert("오류");
				}

			});
		}
		// deluxe
		else if(room == "DELUXE") {
			$("#content_deluxe").empty();
			search_d.classList.replace('off','on');
			search_st.classList.replace('on','off');
			search_su.classList.replace('on','off');
			search_p.classList.replace('on','off');
			search_none.classList.replace('on','off');
			$.ajax({
				type : "post",
				url : "./view/admin/search_room.jsp",
				data : {
					"roomName" : room,
					"checkIn" : checkIn,
					"checkOut" : checkOut
				},
				async: false,
				datatype : "xml",
				success : function(data) {
					let table = "";
					$(data).find("reserve").each(function(){
						
						table += "<tr><td width='15%' align='center'>" + $(this).find("num").text()+"</td>"
						+"<td width='35%' align='center'>" + $(this).find("resin").text() +"&nbsp;~&nbsp;"+ $(this).find("resout").text() + "</td></tr>";
					});
					$("#content_deluxe").append(table);
					
					
				},
				error : function() {
					alert("오류");
				}

			});
		// suite
		}else if(room == "SUITE") {
			$("#content_suite").empty();
			search_su.classList.replace('off','on');
			search_st.classList.replace('on','off');
			search_d.classList.replace('on','off');
			search_p.classList.replace('on','off');
			search_none.classList.replace('on','off');
			$.ajax({
				type : "post",
				url : "./view/admin/search_room.jsp",
				data : {
					"roomName" : room,
					"checkIn" : checkIn,
					"checkOut" : checkOut
				},
				async: false,
				datatype : "xml",
				success : function(data) {
					let table = "";
					$(data).find("reserve").each(function(){
						table += "<tr><td width='15%' align='center'>" + $(this).find("num").text()+"</td>"
						+"<td width='35%' align='center'>" + $(this).find("resin").text() +"&nbsp;~&nbsp;"+ $(this).find("resout").text() + "</td></tr>";
					});
					$("#content_suite").append(table);
					

				},
				error : function() {
					alert("오류");
				}

			});
		// prestige
		}else if(room == "PRESTIGE") {
			$("#content_prestige").empty();
			search_p.classList.replace('off','on');
			search_st.classList.replace('on','off');
			search_d.classList.replace('on','off');
			search_su.classList.replace('on','off');
			search_none.classList.replace('on','off');
			$.ajax({
				type : "post",
				url : "./view/admin/search_room.jsp",
				data : {
					"roomName" : room,
					"checkIn" : checkIn,
					"checkOut" : checkOut
				},
				async: false,
				datatype : "xml",
				success : function(data) {
					let table = "";
					$(data).find("reserve").each(function(){
						table += "<tr><td width='15%' align='center'>" + $(this).find("num").text()+"</td>"
						+"<td width='35%' align='center'>" + $(this).find("resin").text() +"&nbsp;~&nbsp;"+ $(this).find("resout").text() + "</td></tr>";
					});
					$("#content_prestige").append(table);

				},
				error : function() {
					alert("오류");
				}

			});
		} // if문 끝

		
	});
	
	

});


// standard 객실 검색 상세내역 오픈
$("#check_st").click(function() {
	
	if (list_d.style.display != 'none') {
		list_d.style.display = 'none';
	}else if (list_su.style.display === 'block') {
		list_su.style.display = 'none';
	}else if (list_p.style.display === 'block') {
		list_p.style.display = 'none';
	}
	
	if (list_st.style.display != 'block') {
		list_st.style.display = 'block';

		$.ajax({
			type : "post",
			url : "./view/admin/search_room.jsp",
			async: false,
			data : {
				"roomName" : room,
				"checkIn" : checkIn,
				"checkOut" : checkOut
			},
			success : function(data) {
				let table1 = "";
				let table2 = "";
				let table3 = "";
				$(data).find("reserve").each(function(){
					
					if($(this).find("num").text() == '101') {
						table1 += "<tr><td id='st_id'>" + $(this).find("id").text() +"</td>";
						table1 += "<td id='st_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table1 += "<td id='st_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table1 += "<td id='st_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table1 += "<td id='st_req'>"+ $(this).find("request").text() + "</td>"
						table1 += "<td id='st_money'>" + $(this).find("total").text() + "원</td></tr>"
					}else if($(this).find("num").text() == '102') {
						table2 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table2 += "<td id='st_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table2 += "<td id='st_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table2 += "<td id='st_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table2 += "<td id='st_req'>"+ $(this).find("request").text() + "</td>"
						table2 += "<td id='st_money'>" + $(this).find("total").text() + "원</td></tr>"
					}else if($(this).find("num").text() == '103') {
						table3 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table3 += "<td id='st_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table3 += "<td id='st_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table3 += "<td id='st_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table3 += "<td id='st_req'>"+ $(this).find("request").text() + "</td>"
						table3 += "<td id='st_money'>" + $(this).find("total").text() + "원</td></tr>"
					}
					
					
				});
				$("#cont_101").empty();
				$("#cont_102").empty();
				$("#cont_103").empty();
				$("#cont_101").append(table1);
				$("#cont_102").append(table2);
				$("#cont_103").append(table3);
				room = $("#roomName").val("none");
				
				
			},
			error : function() {
				alert('오류');
			}
		});
	}else {
		list_st.style.display = 'none';
	}
	
});

// deluxe 객실 검색 상세내역 오픈
$("#check_d").click(function() {

	if (list_st.style.display != 'none') {
		list_st.style.display = 'none';
	}else if (list_su.style.display != 'none') {
		list_su.style.display = 'none';
	}else if (list_p.style.display != 'none') {
		list_p.style.display = 'none';
	}

	// 상세내역 오픈될 때만 룸번호 보여주는 ajax 실행
	if (list_d.style.display != 'block') {
		list_d.style.display = 'block';
		
		$.ajax({
			type : "post",
			url : "./view/admin/search_room.jsp",
			async: false,
			data : {
				"roomName" : room,
				"checkIn" : checkIn,
				"checkOut" : checkOut
			},
			success : function(data) {
				let table1 = "";
				let table2 = "";
				let table3 = "";
				console.log($(data).find("reserve"));
				$(data).find("reserve").each(function(){
					if($(this).find("num").text() == '201') {
						table1 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table1 += "<td id='d_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table1 += "<td id='d_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table1 += "<td id='d_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table1 += "<td id='d_req'>"+ $(this).find("request").text() + "</td>"
						table1 += "<td id='d_money'>" + $(this).find("total").text() + "원</td></tr>"
					}else if($(this).find("num").text() == '202') {
						table2 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table2 += "<td id='d_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table2 += "<td id='d_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table2 += "<td id='d_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table2 += "<td id='d_req'>"+ $(this).find("request").text() + "</td>"
						table2 += "<td id='d_money'>" + $(this).find("total").text() + "원</td></tr>"
					}else if($(this).find("num").text() == '203') {
						table3 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table3 += "<td id='d_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table3 += "<td id='d_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table3 += "<td id='d_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table3 += "<td id='d_req'>"+ $(this).find("request").text() + "</td>"
						table3 += "<td id='d_money'>" + $(this).find("total").text() + "원</td></tr>"
					}
				});
				$("#cont_201").empty();
				$("#cont_202").empty();
				$("#cont_203").empty();
				$("#cont_201").append(table1);
				$("#cont_202").append(table2);
				$("#cont_203").append(table3);
				room = $("#roomName").val("none");
				
				
			},
			error : function() {
				alert('오류');
			}
		});
	} else {
		list_d.style.display = 'none';
	}
});

//suite 객실 검색 상세내역 오픈
$("#check_su").click(function() {

	if (list_st.style.display === 'block') {
		list_st.style.display = 'none';
	}else if (list_d.style.display === 'block') {
		list_d.style.display = 'none';
	}else if (list_p.style.display === 'block') {
		list_p.style.display = 'none';
	}

	// 상세내역 오픈될 때만 룸번호 보여주는 ajax 실행
	if (list_su.style.display === 'none') {
		list_su.style.display = 'block';
		
		$.ajax({
			type : "post",
			url : "./view/admin/search_room.jsp",
			async: false,
			data : {
				"roomName" : room,
				"checkIn" : checkIn,
				"checkOut" : checkOut
			},
			success : function(data) {
				let table1 = "";
				let table2 = "";
				let table3 = "";
				$(data).find("reserve").each(function(){
					if($(this).find("num").text() == '301') {
						table1 += "<tr><td id='su_id'>" + $(this).find("id").text() +"</td>";
						table1 += "<td id='su_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table1 += "<td id='su_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table1 += "<td id='su_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table1 += "<td id='su_req'>"+ $(this).find("request").text() + "</td>"
						table1 += "<td id='su_money'>" + $(this).find("total").text() + "원</td></tr>"
					}else if($(this).find("num").text() == '302') {
						table2 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table2 += "<td id='su_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table2 += "<td id='su_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table2 += "<td id='su_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table2 += "<td id='su_req'>"+ $(this).find("request").text() + "</td>"
						table2 += "<td id='su_money'>" + $(this).find("total").text() + "원</td></tr>"
					}else if($(this).find("num").text() == '303') {
						table3 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table3 += "<td id='su_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table3 += "<td id='su_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table3 += "<td id='su_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table3 += "<td id='su_req'>"+ $(this).find("request").text() + "</td>"
						table3 += "<td id='su_money'>" + $(this).find("total").text() + "원</td></tr>"
					}
				});
				
				$("#cont_301").empty();
				$("#cont_302").empty();
				$("#cont_303").empty();
				$("#cont_301").append(table1);
				$("#cont_302").append(table2);
				$("#cont_303").append(table3);
				room = $("#roomName").val("none");
				
				
			},
			error : function() {
				alert('오류');
			}
		});
	} else {
		list_su.style.display = 'none';
	}
	
});

// prestige 객실 검색 상세내역 오픈
$("#check_p").click(function() {
	
	if (list_st.style.display === 'block') {
		list_st.style.display = 'none';
	}else if (list_d.style.display === 'block') {
		list_d.style.display = 'none';
	}else if (list_su.style.display === 'block') {
		list_su.style.display = 'none';
	}

	// 상세내역 오픈될 때만 룸번호 보여주는 ajax 실행
	if (list_p.style.display === 'none') {
		list_p.style.display = 'block';
		
		$.ajax({
			type : "post",
			url : "./view/admin/search_room.jsp",
			async: false,
			data : {
				"roomName" : room,
				"checkIn" : checkIn,
				"checkOut" : checkOut
			},
			success : function(data) {
				let table1 = "";
				let table2 = "";
				let table3 = "";
				$(data).find("reserve").each(function(){
					if($(this).find("num").text() == '401') {
						table1 += "<tr><td id='p_id'>" + $(this).find("id").text() +"</td>";
						table1 += "<td id='p_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table1 += "<td id='p_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table1 += "<td id='p_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table1 += "<td id='p_req'>"+ $(this).find("request").text() + "</td>"
						table1 += "<td id='p_money'>" + $(this).find("total").text() + "원</td></tr>"
					}else if($(this).find("num").text() == '402') {
						table2 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table2 += "<td id='p_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table2 += "<td id='p_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table2 += "<td id='p_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table2 += "<td id='p_req'>"+ $(this).find("request").text() + "</td>"
						table2 += "<td id='p_money'>" + $(this).find("total").text() + "원</td></tr>"
					}else if($(this).find("num").text() == '403') {
						table3 += "<tr><td id='d_id'>" + $(this).find("id").text() +"</td>";
						table3 += "<td id='p_in'>" + $(this).find("resin").text() + "(" + $(this).find("nod").text() +"박)</td>";
						table3 += "<td id='p_person'>어른 " + $(this).find("adultbr").text() + "명 아이 " +$(this).find("childbr").text()+ "명</td>";
						table3 += "<td id='p_add'>Extra Bed  "+ $(this).find("bed").text() + "개</td>"
						table3 += "<td id='p_req'>"+ $(this).find("request").text() + "</td>"
						table3 += "<td id='p_money'>" + $(this).find("total").text() + "원</td></tr>"
					}
				});
				
				$("#cont_401").empty();
				$("#cont_402").empty();
				$("#cont_403").empty();
				$("#cont_401").append(table1);
				$("#cont_402").append(table2);
				$("#cont_403").append(table3);
				room = $("#roomName").val("none");
				
				
			},
			error : function() {
				alert('오류');
			}
		});
	} else {
		list_p.style.display = 'none';
	}
	
}); 

//예약 검색 버튼 클릭 함수
$(function() {
	$("#user_btn").click(function() {
		
		res_none.classList.replace('on','off');
		res_cont1.classList.replace('off','on');
		res_cont.classList.replace('off','on');
		
		if (list_st.style.display === 'block') {
			list_st.style.display = 'none';
		}else if (list_d.style.display === 'block') {
			list_d.style.display = 'none';
		}else if (list_su.style.display === 'block') {
			list_su.style.display = 'none';
		}else if (list_p.style.display === 'block') {
			list_p.style.display = 'none';
		}
		let userName = $("#userName").val();
		let userPhone = $("#userPhone").val();
		
		standard.classList.replace('use', 'off');
		deluxe.classList.replace('use', 'off');
		suite.classList.replace('use', 'off');
		prestige.classList.replace('use', 'off');
		standard.classList.replace('on', 'off');
		deluxe.classList.replace('on', 'off');
		suite.classList.replace('on', 'off');
		prestige.classList.replace('on', 'off');
		
		$.ajax({
			type : "post",
			url : "./view/admin/hotel_user.jsp",
			async: false,
			data : {
				"userName" : userName,
				"userPhone" : userPhone
			},
			success : function(data) {
				let table1 = "";
				let resno = "";
				let reserve_x = $(data).find("reserve");
				if(reserve_x.length==0){
					table1 += "<tr><td id='user_none' colspan='6'><br><br>찾는 정보가 없습니다.<br><br></td></tr>"
				}else{
				$(data).find("reserve").each(function(){
					table1 += "<tr id='"+$(this).find("resno").text()+"'><td id='res_room'>" + $(this).find("name").text() +" (" + $(this).find("num").text() + "호)</td>"
					table1 += "<td id='res_period'>" + $(this).find("resin").text() + " ~ " + $(this).find("resout").text() + " ("+ $(this).find("nod").text() +"박)" +"</td>"
					table1 += "<td id='res_person'>성인 " + $(this).find("adult").text() +"명  아이" + $(this).find("child").text() + "명</td>"
					table1 += "<td id='res_add'>Extra Bed  " + $(this).find("bed").text() +"개</td>"
					table1 += "<td id='res_req'>" + $(this).find("request").text() + "</td>"
					table1 += "<td id='res_money'>" + $(this).find("total").text() +"KRW</td>"
					table1 += "<td><input type='button' id='res_del' value='삭제' onclick=\"delete_no(\'"+$(this).find("resno").text()+"')\">"+ "</td></tr>"
					
				});}
				$("#res_cont1").empty();
				$("#res_cont1").append(table1);
				
			},
			error : function() {
				alert('오류');
			}
		});
		
	});
});

/* 회원 전체 리스트 */
function getMember() {
	
	$.ajax({
		type : "post",
		url : "./view/admin/member_main.jsp",
		async: false,
		success : function(data) {
			let table = "";
			$(data).find("user").each(function(){
				
				table += "<tr><td id='mem_id'>" + $(this).find("id").text() + "</td>" +
						"<td id='mem_name'>" + $(this).find("name").text() + "</td>" +
						"<td id='mem_phone'>" + $(this).find("phone").text() + "</td>" +
						"<td id='mem_addr'>" + $(this).find("addr").text() + "</td>" +
						"<td id='mem_email'>" + $(this).find("email").text() + "</td>" +
						"<td id='mem_point'>" + $(this).find("point").text() + "</td>" +
						"</tr>";
				
			});
			$("#member_cont1").empty();
			$("#member_cont1").append(table);
			

		},
		error : function() {
			alert('오류');
		}
	});
};


// 회원 검색 버튼 클릭 함수
$(function() {
	$("#member_btn").click(function() {
		search_mem.classList.replace('off','on');
		search_mem1.classList.replace('off','on');
		member_cont.classList.replace('on','off');
		member_cont1.classList.replace('on','off');
		if (list_st.style.display === 'block') {
			list_st.style.display = 'none';
		}else if (list_d.style.display === 'block') {
			list_d.style.display = 'none';
		}else if (list_su.style.display === 'block') {
			list_su.style.display = 'none';
		}else if (list_p.style.display === 'block') {
			list_p.style.display = 'none';
		}
		memberID = $("#memberID").val();
		memberPhone = $("#memberPhone").val();
		
		standard.classList.replace('use', 'off');
		deluxe.classList.replace('use', 'off');
		suite.classList.replace('use', 'off');
		prestige.classList.replace('use', 'off');
		standard.classList.replace('on', 'off');
		deluxe.classList.replace('on', 'off');
		suite.classList.replace('on', 'off');
		prestige.classList.replace('on', 'off');
		
		$.ajax({
			type : "post",
			url : "./view/admin/search_mem.jsp",
			async: false,
			data: {
				"memid" : memberID,
				"memphone" : memberPhone
			},
			success : function(data) {
	
				let table = "";
				let user_x = $(data).find("user");
				if(user_x.length==0){
					table += "<tr><td id='user_none' colspan='6'><br><br>찾는 정보가 없습니다.<br><br></td></tr>"
					memberID = $("#memberID").val("");
					memberPhone = $("#memberPhone").val("");
				}else{
				$(data).find("user").each(function(){
					
					table += "<tr><td id='mem_id1'>" + $(this).find("id").text() + "</td>" +
							"<td id='mem_name1'>" + $(this).find("name").text() + "</td>" +
							"<td id='mem_phone1'>" + $(this).find("phone").text() + "</td>" +
							"<td id='mem_addr1'>" + $(this).find("addr").text() + "</td>" +
							"<td id='mem_email1'>" + $(this).find("email").text() + "</td>" +
							"<td id='mem_point1'>" + $(this).find("point").text() + "</td>" +
							"<td><input type='button' id='mem_del' value='삭제'>"+ "</td>" +
							"</tr>";
					
				})};
				$("#member_search1").empty();
				$("#member_search1").append(table);
				
				$("html").on('click', '#mem_del', function() { 
					
					$.ajax({
						type : "post",
						url : "./view/admin/member_delete.jsp",
						async: false,
						data: {
							"memid" : memberID,
							"memphone" : memberPhone
						},
						success : function(data) {
							$("#member_search").empty();
							$("#member_search1").empty();
						},
						error : function() {
							alert('오류');
						}
						
						
					}); // #mem_del ajax
					
					memberID = $("#memberID").val("");
					memberPhone = $("#memberPhone").val("");
					mem_click();
					
				}); // #mem_del click 함수 end

			},
			error : function() {
				alert('오류');
			}
			
		});
		
		
	});
});


/* 객실관리, 예약관리, 회원관리 클릭시 페이시 숨김 or 보임*/

/* 객실관리 클릭 */
room_click.addEventListener('click', function() {
	standard_get();
	deluxe_get();
	suite_get();
	prestige_get();
	
	// bottom border on, 나머지 off
	room_click.classList.replace('off','on');
	res_click.classList.replace('on','off');
	member_click.classList.replace('on','off');
	
	// 검색table, 내용 on
	hotel.classList.replace('off', 'on');
	standard.classList.replace('off', 'on');		
	deluxe.classList.replace('off', 'on');			
	suite.classList.replace('off', 'on');			
	prestige.classList.replace('off', 'on');
	
	// 나머지 검색table, 내용 off
	user.classList.replace('on','off');
	member.classList.replace('on','off');
	res_none.classList.replace('on','off');
	if (list_st.style.display === 'block') {
		list_st.style.display = 'none';
	}else if (list_d.style.display === 'block') {
		list_d.style.display = 'none';
	}else if (list_su.style.display === 'block') {
		list_su.style.display = 'none';
	}else if (list_p.style.display === 'block') {
		list_p.style.display = 'none';
	}
	search_mem.classList.replace('on','off');
	search_mem1.classList.replace('on','off');
	res_cont.classList.replace('on','off');
	res_cont1.classList.replace('on', 'off');
	member_cont.classList.replace('on', 'off');
	member_cont1.classList.replace('on', 'off');
	member_cont2.classList.replace('on', 'off');
	
	search_none.classList.replace('on','off');
	search_st.classList.replace('on','off');
	search_d.classList.replace('on','off');
	search_su.classList.replace('on','off');
	search_p.classList.replace('on','off');
	
});

/* 예약관리 클릭 */
res_click.addEventListener('click', reserve_click);

function reserve_click() {
	
	userName = $("#userName").val("");
	userPhone = $("#userPhone").val("");
	
	// bottom border on, 나머지 off
	res_click.classList.replace('off','on');
	room_click.classList.replace('on','off');
	member_click.classList.replace('on','off');
	
	// 검색table, 내용 on
	user.classList.replace('off','on');
	res_none.classList.replace('off','on');
	
	// 나머지 검색 table, 내용 off
	member.classList.replace('on','off');
	if (hotel.classList != 'off') {
		hotel.classList.replace('on', 'off');
		hotel.classList.replace('use', 'off');
	}
	search_mem.classList.replace('on','off');
	search_mem1.classList.replace('on','off');
	if (list_st.style.display === 'block') {
		list_st.style.display = 'none';
	}else if (list_d.style.display === 'block') {
		list_d.style.display = 'none';
	}else if (list_su.style.display === 'block') {
		list_su.style.display = 'none';
	}else if (list_p.style.display === 'block') {
		list_p.style.display = 'none';
	}
	
	search_st.classList.replace('on','off');
	search_d.classList.replace('on','off');
	search_su.classList.replace('on','off');
	search_p.classList.replace('on','off');
	search_none.classList.replace('on','off');
	
	member_cont.classList.replace('on', 'off');
	member_cont1.classList.replace('on','off');
	member_cont2.classList.replace('on','off');
	res_cont.classList.replace('on', 'off');
	res_cont1.classList.replace('on', 'off');
	
	
	if (standard.classList != 'off') {
		standard.classList.replace('on', 'off');
		standard.classList.replace('use', 'off');
	}
	if (deluxe.classList != 'off') {
		deluxe.classList.replace('on', 'off');
		deluxe.classList.replace('use','off');
	}
	if (suite.classList != 'off') {
		suite.classList.replace('on', 'off');
		suite.classList.replace('use', 'off');
	}
	if (prestige.classList != 'off') {
		prestige.classList.replace('on', 'off');
		prestige.classList.replace('use', 'off');
	}

};

/* 회원관리 클릭 */
member_click.addEventListener('click', mem_click);
function mem_click() {
	memberID = $("#memberID").val("");
	memberPhone = $("#memberPhone").val("");
	getMember();
	// bottom border on, 나머지 off
	member_click.classList.replace('off','on');
	room_click.classList.replace('on','off');
	res_click.classList.replace('on','off');
	
	// 검색table, 내용 on
	member.classList.replace('off','on');
	member_cont.classList.replace('off','on');
	member_cont1.classList.replace('off','on');
	
	// 나머지 검색 table, 내용 off
	user.classList.replace('on','off');
	res_none.classList.replace('on','off');
	if (hotel.classList != 'off') {
		hotel.classList.replace('on', 'off');
		hotel.classList.replace('use', 'off');
	}
	
	res_cont.classList.replace('on', 'off');
	res_cont1.classList.replace('on', 'off');
	search_mem.classList.replace('on','off');
	search_mem1.classList.replace('on','off');

	if (list_st.style.display === 'block') {
		list_st.style.display = 'none';
	}else if (list_d.style.display === 'block') {
		list_d.style.display = 'none';
	}else if (list_su.style.display === 'block') {
		list_su.style.display = 'none';
	}else if (list_p.style.display === 'block') {
		list_p.style.display = 'none';
	}
	
	if (standard.classList != 'off') {
		standard.classList.replace('on', 'off');
		standard.classList.replace('use', 'off');
	}
	
	if (deluxe.classList != 'off') {
		deluxe.classList.replace('on', 'off');
		deluxe.classList.replace('use','off');
	}
	
	if (suite.classList != 'off') {
		suite.classList.replace('on', 'off');
		suite.classList.replace('use', 'off');
	}
	
	if (prestige.classList != 'off') {
		prestige.classList.replace('on', 'off');
		prestige.classList.replace('use', 'off');
	}

	
	if (hotel.classList != 'off') {
		hotel.classList.replace('on', 'off');
		hotel.classList.replace('use','off');
	}

	
	search_st.classList.replace('on','off');
	search_d.classList.replace('on','off');
	search_su.classList.replace('on','off');
	search_p.classList.replace('on','off');
	search_none.classList.replace('on','off');

	
};


function delete_no(resno) { 
	let num = resno;
	
	console.log(resno)
	
	$.ajax({
		type : "post",
		url : "./view/admin/reserve_delete.jsp",
		async: false,
		data: {
			"num" : num,
		},
		success : function(data) {
			
			$("#"+num).empty();
			userName = $("#userName").val("");
			userPhone = $("#userPhone").val("");
		},
		error : function() {
			alert('오류');
		}
		
		
	}); // #res_del ajax
	
}; // #res_del click 함수 end