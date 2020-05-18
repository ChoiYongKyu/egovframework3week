<!-- <script	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script> -->

<!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->

<h1 class="page-header" hidden="true">유지보수 관리</h1>
<div>
	<div class="col-lg-3 col-sm-6">
		<div class="card" onclick="location.href='/nos.mm/approval/list?type=received'">
			<div class="content" style="padding-top: 10px;">
				<div class="row">
					<div class="col-xs-5">
						<div class="icon-big icon-success text-center">
							<i class="ti-pencil"></i>
						</div>
					</div>
					<div class="col-xs-7">
						<div class="numbers">
							<p>수신 함</p>
							${receiveCount } 개
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-3 col-sm-6">
		<div class="card" onclick="location.href='/nos.mm/member_manage/member'">
			<div class="content" style="padding-top: 10px;">
				<div class="row">
					<div class="col-xs-5">
						<div class="icon-big icon-warning text-center">
							<i class="ti-user"></i>
						</div>
					</div>
					<div class="col-xs-7">
						<div class="numbers">
							<p>회원 수</p>
							${memCount } 명
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-3 col-sm-6">
		<div class="card" onclick="location.href='/nos.mm/management/clientList'">
			<div class="content" style="padding-top: 10px;">
				<div class="row">
					<div class="col-xs-5">
						<div class="icon-big icon-success text-center">
							<i class="ti-comments"></i>
						</div>
					</div>
					<div class="col-xs-7">
						<div class="numbers">
							<p>고객사 수</p>
							${clientCount } 개
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-3 col-sm-6">
		<div class="card" onclick="location.href='/nos.mm/maintenance/list'">
			<div class="content" style="padding-top: 10px;">
				<div class="row">
					<div class="col-xs-5">
						<div class="icon-big icon-danger text-center">
							<i class="ti-pencil"></i>
						</div>
					</div>
					<div class="col-xs-7">
						<div class="numbers">
							<p>유지보수 글 수</p>
							${maintenanceCount } 개
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-3 col-sm-6">
		<div class="card">
			<div class="content" style="padding-top: 10px;">
				<div class="row">
					<div class="col-xs-5">
						<div class="icon-big icon-info text-center">
							<img id="weathericon" src="">
						</div>
					</div>
					<div class="col-xs-7">
						<div class="numbers">
							<p id="weatherstatus">현재 날씨</p>
							<contentsw id="weatherdetail">지금 날씨</contentsw>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!--차트 그려지는 부분-->
<div>
<input id="mem_no" type="text" hidden=""
	value="<sec:authentication property="principal.mem_no"/>">
	<sec:authentication property="principal.auth_no" var="auth_no" />
<div class="col-md-6">
	<div class="card grpChart">
		<div style="padding-left: 5px; padding-top: 5px; ">
			<div class="btn-group" style="z-index: 1">
				<button type="button" class="btn btn-primary dropdown-toggle"
					data-toggle="dropdown" aria-expanded="false" value="0">개인별</button>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#" class="period" title="0">월별</a></li>
					<li><a href="#" class="period" title="1">분기별</a></li>
					<li><a href="#" class="period" title="2">연도별</a></li>
				</ul>
			</div>
			<div class="btn-group" style="z-index: 1">
				<button type="button" class="btn btn-primary dropdown-toggle"
					data-toggle="dropdown" aria-expanded="false" value="1">그룹별</button>
				<ul class="dropdown-menu" role="menu">
					<li><a href="#" class="period" title="0">월별</a></li>
					<li><a href="#" class="period" title="1">분기별</a></li>
					<li><a href="#" class="period" title="2">연도별</a></li>
				</ul>
			</div>
		</div>
<!-- 		<div id="chartContainer" -->
<!-- 			style="height: 334px; width: 99%; display: inline-block;"></div> -->
	</div>
	<!-- 라이센스 가리기용 -->
</div>
<div class="col-md-6">
	<div class="content">
		<div class="card" style="padding: 20px;">
			<div class="header">
				<h4 class="title">최신글 </h4>
				<p class="category">유지보수 리스트</p>
			</div>
			<div class="content" style="padding: 5px;">
				<div class="content table-responsive table-full-width" style="padding: 5px;">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>고객사</th>
								<th>업무구분</th>
								<th>담당자</th>
<!-- 								<th>작성날짜</th> -->
							</tr>
						</thead>
						<c:forEach var="chartList" items="${chartList }">
							<tbody>
							
								<tr onclick="location.href='${ctx }/maintenance/detail?no=${chartList.MN_NO }'">
									<td>${chartList.CLIENT_NAME }</td>
									<td>${chartList.WORK_SCOPE_NAME }</td>
									<td>${chartList.MEM_NAME}${chartList.MN_GROUP_NAME}</td>
<%-- 									<td>${chartList.WRITE_DATE }</td> --%>
								</tr>
								
							</tbody>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<script>
	$(function() {

		// 그룹체크 (0이면 개인, 1이면 그룹)
		var grpchk = 0;

		// 기간체크 (0이면 월별, 1은 분기별, 2는 연별)
		var period = 0;

		// 아이디체크
		var mem_no = $('#mem_no').val();

		// 운영자일경우
		if(${auth_no == 1}) {
			mem_no = 0;
		}
		
		// 차트 불러오기
		$.getChart(mem_no, grpchk, period);

		// 그룹체크 (0이면 개인, 1이면 그룹)
		$('button').on('click', function() {
			grpchk = $(this).val();
		});

		// 기간체크 (0이면 월별, 1은 분기별, 2는 연별)
		$('.period').on('click', function(e) {
			e.preventDefault();
			period = $(this).prop('title');

			// 차트 불러오기
			$.getChart(mem_no, grpchk, period);
		});

// 		$.ajax({
// 			url:"https://apis.sktelecom.com/v1/weather/status?latitude=37.546256&longitude=127.048655",
// 			type:"GET",
// 			beforeSend: function(xhr){xhr.setRequestHeader('TDCProjectKey', 'b13c548b-9d8a-4b28-a54c-668b96c678c2')},
// 			success: function(data){
// 				console.log("api로그!!");
// 				console.log(data);
// 				weatherView(data);
// 			}
// 		});
var weatherStatus;
		$.ajax({
			url : '${ctx }/home/weather',
			type : 'post',
			data : {no : 'no'},
			dataType : 'json',
			success : function(data){
				console.log('웨더로그');
				console.log(data);
				weatherStatus = data;
				console.log((data.timestamp + 600000) - Date.now());
				if((data.timestamp + 600000) < Date.now()){
					/* $.ajax({
						url:"https://apis.sktelecom.com/v1/weather/status?latitude=37.546256&longitude=127.048655",
						type:"GET",
						beforeSend: function(xhr){xhr.setRequestHeader('TDCProjectKey', '9fa2128b-e075-44a0-ada1-c69b06505d1d')},
						success: function(data){
							console.log("api로그!!");
							console.log(data);
							if(data.weatherModifyCode != 0){
								$.ajax({
									url : '${ctx }/home/weatherUp',
									type : 'post',
									data : {weatherModifyCode : data.weatherModifyCode
							 			  , weatherModifyDescription : data.weatherModifyDescription
									  	  , weatherStatusCode : data.weatherStatusCode
									  	  , weatherStatusDescription : data.weatherStatusDescription
									  	  , timestamp : Date.now()
									  		},
									dataType : 'json',
									success : function(data){
									},
									error : function(data){
										alert('실패!!');
									}
								});
								weatherStatus = data;
								
							}
						}
					}); */
					// 사용하던 api 서비스 종료로 임시 api 사용중
					$.ajax({
						url : "http://api.openweathermap.org/data/2.5/weather?q=seoul&appid=796f399c049c2a4d99cb84916cc1b586",
						type : "GET",
						success : function(data) {
							var temp = (data.main.temp - 273.15).toFixed(1);
							$('#weatherdetail').html(temp + "°C");
							$('#weathericon').prop('src', "http://openweathermap.org/img/w/" + data.weather[0].icon + ".png");
						}
					});
				}
				//weatherView(weatherStatus);
			},
			error : function(data){
				alert('실패');
			}
			
		});
	});
	function weatherView(data){
		$('#weatherstatus').html(data.weatherStatusDescription);
		$('#weatherdetail').html(data.weatherModifyDescription);
		var status = '${ctx }/img/weather/' + data.weatherStatusCode + '.png';
		$('#weathericon').prop('src', status);

		switch(data.weatherModifyCode){
			case 1 : //강추위	
			case 2 : //춥다
				$('#weatherdetail').css('color', 'skyblue');
				break;
			case 3 ://쌀쌀하다
				$('#weatherdetail').css('color', 'blue');
				break;
			case 4 ://포근
				$('#weatherdetail').css('color', 'yellow');
				break;
			case 5 ://따뜻
			case 6 ://선선
				$('#weatherdetail').css('color', 'orange');
				break;
			case 7 ://덥다
			case 8 ://무더위
				$('#weatherdetail').css('color', 'red');
				break;
			default:
				$('#weatherdetail').css('color', 'black');
				break;
		}
	}
	
	// 차트 불러오기
	$.getChart = function(no, grpchk, period) {
		$.ajax({
			url : ctx + '/home/chart',
			type : 'post',
			data : 'mem_no=' + no + '&grpchk=' + grpchk + '&period=' + period,
			dataType : 'json',
			success : function(chartData) {
				if(chartData.length == 0) {
					console.log("empty");		
					$('.chartContainers').remove();
				} else {
					if(chartData[0].hasOwnProperty('CLIENT_NO')) {
						$.createPersonChart(chartData);
					} else {
						$.createGroupChart(chartData);
					}
// 					$('.canvasjs-chart-credit').remove();
				}
			}
		});
	};
	
	
	// 차트에 필요한 메서드
	function explodePie(e) {
		for (var i = 0; i < e.dataSeries.dataPoints.length; i++) {
			if (i != e.dataPointIndex)
				e.dataSeries.dataPoints[i].exploded = false;
		}
	}

	// 개인 차트 그리기
	$.createPersonChart = function(chartData) {
		$('.chartContainers').remove(); // 동적으로 생성된 차트 지우기

		// 유지보수 개수
		var total = 0;
		$.each(chartData, function(key, value) {
			total += value.COUNT;
		});

		// 차트용 데이터로 전환
		var chartArray = [];
		$.each(chartData, function(key, value) {
			chartArray[key] = {
				'y' : (value.COUNT / total) * 100,
				'label' : value.CLIENT_NAME
			};
		});
		$('.grpChart').append('<div class="chartContainers" id="chartContainer" style="height: 334px; width: 99%; display: inline-block;"></div>'); // 동적 차트 생성
		$('.grpChart').append('<div class="chartContainers" style="position: relative; top: -30px; background-color: #fff; width:max-width; height:50px"></div>');
		
		
// 		var chart = // 바로 render해서 변수가 필요없음
		// 차트 그리기
// 		chart.render();
		var d = new Date();
		var year = d.getFullYear() + "년";


		new CanvasJS.Chart("chartContainer", { // 첫번째 차트
			theme : "light2",
			animationEnabled : true,
			title : {
				text : "유지보수 현황",
				fontSize : 25
			},
			subtitles : [ {
				text : year,
				fontSize : 14
			} ],
			data : [ {
				type : "pie",
				indexLabelFontSize : 14,
				radius : 80,
				indexLabel : "{label} - {y}",
				yValueFormatString : "###0.0\"%\"",
				click : explodePie,
				dataPoints : chartArray
			} ]
		}).render();
	};
	
	// 그룹 차트 그리기
	$.createGroupChart = function(chartData) {
		$('.chartContainers').remove(); // 동적으로 생성된 차트 지우기
		$.each(chartData, function(key, value) {
			if(value.length > 0) {
				
				// 유지보수 개수
				var total = 0;
				$.each(value, function(k, v) {
					total += v.COUNT;
				});

				var chartTitle;
				// 차트용 데이터로 전환
				var chartArray = [];
				$.each(value, function(k, v) {
					chartTitle = v.MN_GROUP_NAME;
					chartArray[k] = {
						'y' : (v.COUNT / total) * 100,
						'label' : v.CLIENT_NAME
					};
				});
				
				var chartContainerName = "chartContainer-" + key;
				var d = new Date();
				var year = d.getFullYear() + "년";
				
				$('.grpChart').append('<div class="chartContainers" id="' + chartContainerName + '" style="height: 334px; width: 99%; display: inline-block;"></div>'); // 동적 차트 생성
				$('.grpChart').append('<div class="chartContainers" style="position: relative; top: -30px; background-color: #fff; width:max-width; height:50px"></div>');
				
				new CanvasJS.Chart(chartContainerName, { // 첫번째 차트
					theme : "light2",
					animationEnabled : true,
					title : {
						text : chartTitle + "의 유지보수 현황",
						fontSize : 25
					},
					subtitles : [ {
						text : year,
						fontSize : 14
					} ],
					data : [ {
						type : "pie",
						indexLabelFontSize : 14,
						radius : 80,
						indexLabel : "{label} - {y}",
						yValueFormatString : "###0.0\"%\"",
						click : explodePie,
						dataPoints : chartArray
					} ]
				}).render();
			} else {
				console.log('empty list');
			}
		});
	};
</script>