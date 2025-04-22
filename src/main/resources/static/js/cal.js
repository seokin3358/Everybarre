$(function () {
  var startDate, endDate;

  var datepicker = {
    container: $("#datepicker"),
    dateFormat: "yy-mm-dd",
    dates: [null, null],
    status: null,
    inputs: {
      checkin: $("#resIn"),
      checkout: $("#resOut"),
      dates: $("#dates"),
      datetext: $("#dateText"),
    },
  };

  console.log(datepicker.container.datepicker);

  datepicker.container.datepicker({
    numberOfMonths: 2,
    dateFormat: datepicker.dateFormat,
    minDate: 0,
    maxDate: null,
    monthNames: [
      "01월",
      "02월",
      "03월",
      "04월",
      "05월",
      "06월",
      "07월",
      "08월",
      "09월",
      "10월",
      "11월",
      "12월",
    ],
    dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
    showMonthAfterYear: true,
    yearSuffix: "년",

    beforeShowDay: function (date) {
      var highlight = false,
        currentTime = date.getTime(),
        selectedTime = datepicker.dates,
        checkin_date = selectedTime[0] ? new Date(selectedTime[0]) : null,
        checkout_date = selectedTime[1] ? new Date(selectedTime[1]) : null,
        checkin_timestamp,
        checkout_timestamp,
        classes = "ui-datepicker-highlight";

      date.setHours(0);
      date.setMinutes(0);
      date.setSeconds(0);
      date.setMilliseconds(0);

      currentTime = date.getTime();

      // CHECKIN/CHECKOUT CLASSES
      if (checkin_date) {
        checkin_date.setHours(0);
        checkin_date.setMinutes(0);
        checkin_date.setSeconds(0);
        checkin_date.setMilliseconds(0);
        checkin_timestamp = checkin_date.getTime();

        startDate = checkin_timestamp;
      }

      if (checkout_date) {
        checkout_date.setHours(0);
        checkout_date.setMinutes(0);
        checkout_date.setSeconds(0);
        checkout_date.setMilliseconds(0);
        checkout_timestamp = checkout_date.getTime();

        endDate = checkout_timestamp;
      }

      if (checkin_timestamp && currentTime == checkin_timestamp) {
        classes = "ui-datepicker-highlight ui-checkin";
      } else if (checkout_timestamp && currentTime == checkout_timestamp) {
        classes = "ui-datepicker-highlight ui-checkout";
      }

      // Highlight date range
      if (
        (selectedTime[0] && selectedTime[0] == currentTime) ||
        (selectedTime[1] &&
          currentTime >= selectedTime[0] &&
          currentTime <= selectedTime[1])
      )
        highlight = true;

      return [true, highlight ? classes : ""];
    },
    onSelect: function (dateText) {
      if (!datepicker.dates[0] || datepicker.dates[1] !== null) {
        // CHOOSE FIRST DATE

        // fill dates array with first chosen date
        datepicker.dates[0] = $.datepicker
          .parseDate(datepicker.dateFormat, dateText)
          .getTime();
        datepicker.dates[1] = null;

        // clear all inputs
        datepicker.inputs.checkin.val("");
        datepicker.inputs.checkout.val("");
        datepicker.inputs.dates.val("");
        
        //dateText id 값 초기화
        datepicker.inputs.datetext.val("");

        // set current datepicker state
        datepicker.status = "checkin-selected";

        // create mouseover for table cell
        $("#datepicker").delegate(
          ".ui-datepicker td",
          "mouseover",
          function () {
            // if it doesn't have year data (old month or unselectable date)
            if ($(this).data("year") == undefined) return;

            // datepicker state is not in date range select, depart date wasn't chosen, or return date already chosen then exit
            if (datepicker.status != "checkin-selected") return;

            // get date from hovered cell
            var hoverDate =
              $(this).data("year") +
              "-" +
              ($(this).data("month") + 1) +
              "-" +
              $("a", this).html();

            // parse hovered date into milliseconds
            hoverDate = $.datepicker.parseDate("yy-mm-dd", hoverDate).getTime();

            $("#datepicker td").each(function () {
              // compare each table cell if it's date is in date range between selected date and hovered
              if ($(this).data("year") == undefined) return;

              var year = $(this).data("year"),
                month = $(this).data("month"),
                day = $("a", this).html();

              var cellDate =
                $(this).data("year") +
                "-" +
                ($(this).data("month") + 1) +
                "-" +
                $("a", this).html();

              // convert cell date into milliseconds for further comparison
              cellDate = $.datepicker.parseDate("yy-mm-dd", cellDate).getTime();

              if (
                (cellDate >= datepicker.dates[0] && cellDate <= hoverDate) ||
                (cellDate <= datepicker.dates[0] && cellDate >= hoverDate)
              ) {
                $(this).addClass("ui-datepicker-hover");
              } else {
                $(this).removeClass("ui-datepicker-hover");
              }
            });
          }
        );
      } else {
        // CHOOSE SECOND DATE

        // push second date into dates array
        datepicker.dates[1] = $.datepicker
          .parseDate(datepicker.dateFormat, dateText)
          .getTime();

        // sort array dates
        datepicker.dates.sort();

        var checkInDate = $.datepicker.parseDate("@", datepicker.dates[0]);
        var checkOutDate = $.datepicker.parseDate("@", datepicker.dates[1]);

        datepicker.status = "checkout-selected";

        //fill input fields
        datepicker.inputs.checkin.val(
          $.datepicker.formatDate(datepicker.dateFormat, checkInDate)
        );
        datepicker.inputs.checkout
          .val($.datepicker.formatDate(datepicker.dateFormat, checkOutDate))
          .change();
        datepicker.inputs.dates.val(
          datepicker.inputs.checkin.val() +
            " / " +
            datepicker.inputs.checkout.val()
        );
        
        datepicker.inputs.datetext.text($.datepicker.formatDate(datepicker.dateFormat, checkInDate)+ 
        		" / " + $.datepicker.formatDate(datepicker.dateFormat, checkOutDate));
        console.log("datapicker 실행확인")
        
        countNight();
        
        $('#resInYoil').val(getYoil(resIn.value));
		$('#resOutYoil').val(getYoil(resOut.value));
      }
    },
  });
});

$(document).ready(function () {
  $(".a.ui-datepicker-prev .ui-icon").empty();

  $(".a.ui-datepicker-prev .ui-icon").append("append success!");
});


//숙박 일수 계산
function countNight(){		
	console.log("countNight 실행확인")
	let nightResult = document.getElementById('nightResult'); 
	
	// 직접 input date 에서 받은 값 받기 (yyyy-mm-dd 형식)
	let start_string = $('#resIn').val(); 
	let end_string = $('#resOut').val();

	// split 으로 - 분해 (배열로 저장됨)
	let start_res = start_string.split("-");
	let end_res = end_string.split("-");
	
	// 분해된 데이터를 DATE 형식으로 계산하기 위해 재정렬
    let start_date = new Date(start_res[0],Number(start_res[1]),start_res[2]);
    let end_date = new Date(end_res[0],Number(end_res[1]),end_res[2]);
    
    // /1000:초, /60:분, /60:시간, /24:일 단위
    let night_date = (end_date.getTime() - start_date.getTime())/1000/60/60/24;
    
    resNight.value = Number(night_date);
    nightResult.innerText = Number(night_date) + "박";
    
    console.log("cal.js : " + night_date);
    
  
} // countNight() end

//요일 구하기
function getYoil(date){
	
	let week = new Array('일', '월', '화', '수', '목', '금', '토');
 	let yoil = week[new Date(date).getDay()];
 	return yoil;
}