<script src="${ctx}/js/calendar/dhtmlxscheduler.js"
	type="text/javascript"></script>
<style>
html, body {
	height: 100%;
}
</style>
<link rel="stylesheet" href="${ctx}/css/calendar/dhtmlxscheduler.css"
	type="text/css">
<div class="card">
	<ul>
		<li><span style="color:#ff4d4d; font-weight:bold; font-size:15px;">붉은색</span>으로 표시된 작업 예정인 스케쥴입니다.</li>
		<li><span style="color:#866aa1; font-weight:bold; font-size:15px;">그 외</span>의 색으로 표시된 작업 완료인 스케쥴입니다.</li>
	</ul>
</div>
<div class="card">
	<div class="container-fluid" style="height: 100%; width: 100%">
		<!--  주 내용 시작  -->
		<h1 class="page-header">달력</h1>
		<div id="scheduler_here" class="dhx_cal_container"
			style='width: 100%; height: 768px;'>
			<div class="dhx_cal_navline">
				<div class="dhx_cal_prev_button">&nbsp;</div>
				<div class="dhx_cal_next_button">&nbsp;</div>
				<div class="dhx_cal_today_button" style="left: 0px;"></div>
				<div class="dhx_cal_date"></div>
				<!-- 			<div class="dhx_cal_tab" name="day_tab" style="right: 204px;"></div> -->
				<!-- 			<div class="dhx_cal_tab" name="week_tab" style="right: 140px;"></div> -->
				<!-- 			<div class="dhx_cal_tab" name="month_tab" style="right: 76px;"></div> -->
			</div>
			<div class="dhx_cal_header"></div>
			<div class="dhx_cal_data"></div>
		</div>
	</div>
	<br>
</div>

<!--  주 내용 끝  -->
<input type="hidden" value="<sec:authentication property='principal.mem_no' />" id="mem_no">
<input type="hidden" value="<sec:authentication property='principal.auth_no' />" id="auth_no">
<script>
$(function(){
	
	scheduler.config.readonly = true;
	scheduler.config.start_on_monday = false;
	scheduler.init('scheduler_here', new Date(), "month");
	
	$.ajax({
		type : 'post',
		url : 'calendarData',
		
		data : {
			mem_no : $("#mem_no").val(),
			auth_no : $('#auth_no').val()
		},
		
		dataType : 'json',
		success : function(data) {
			console.log(data);
			var events = data;
			scheduler.parse(events, "json");//takes the name and format of the data source
			onColorChange(eval(data));
			dataSave(eval(data));
			
		},
		error : function(req) {
			console.log(req);
			console.log('캘린더 정보 받아오기 실패');
		}
	});
		
	$('div[class^=dhx_cal]').on('click', function() {
		onColorChange(ajaxData);
	});
});

function onColorChange(data){
	var color = ['#c6b1d5', '#866aa1', '#97b3c8', '#5f4a8b', '#add8e6'];
	var reservation = '#ff4d4d';
	console.log(data[0].mn_done);
	for(var i = 0; i < data.length; i++) {
		console.log(data[i]);
		var temp = 'div[event_id=' + data[i].id + ']';
		if(data[i].mn_done == 1) {
			$(temp).css('background-color', reservation);
		} else {
			$(temp).css('background-color', color[data[i].id % 5]);
		}
	}
	$('.dhx_cal_event_clear').css('color','white');
	
}
var ajaxData;
function dataSave(data) {
	ajaxData = data;
}

$(document).on('click', 'div[class*=dhx_cal_event_line]', function(d) {
	location.href = "detail?no=" + $(d.target).attr("event_id");
	console.log(event);
});

</script>


