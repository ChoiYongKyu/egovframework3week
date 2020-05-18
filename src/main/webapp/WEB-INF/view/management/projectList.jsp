<h1 class="page-header" hidden="true">프로젝트 리스트</h1>
<div class="card card-plain">
	<div class="header">
		<div class="row">
			<div class="col-lg-8">
				<form method="get" action="" id="form">
					<div class="form-group-sm col-lg-2">
						<select class="form-control border-input" name="searchSort" style="border: none;">
							<option value="1" ${param.searchSort eq 1 ? "selected" : "" }>프로젝트명</option>
							<option value="2" ${param.searchSort eq 2 ? "selected" : "" }>고객사</option>
						</select>
					</div>
					<div class="form-group-sm col-lg-2">
						<input type="text" class="form-control border-input"
							name="keyword" style="border: none;" value="${param.keyword }">
					</div>
					<div class="col-lg-3 col-xs-2">
						<button type="submit" class="commonBtn">검색</button>
					</div>
				</form>
			</div>
			<div class="col-lg-4">
				<sec:authorize access="hasRole('ADMIN')">
					<div>
						<button type="button" class="btn btn-sm btn-default hidden-xs" onclick="location.href='projectList/projectRegister'" style="float: right;">프로젝트 등록</button>
					</div>
				</sec:authorize>
			</div>
		</div>
	</div>
	<table class="table table-hover table-responsive">
		<thead>
			<tr>
				<th style="white-space:nowrap;">번호</th>
				<th>프로젝트명</th>
				<th>고객사</th>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list.pj_list }" var="list">
				<tr>
					<td onclick="goDetail(${list.PJ_NO })">${list.PJ_NO }</td>
					<td onclick="goDetail(${list.PJ_NO })">${list.PJ_NAME }</td>
					<td onclick="goDetail(${list.PJ_NO })">${list.CLIENT_NAME }</td>
					
					
				</tr>
				<%-- <tr>
					<td> </td>
					<td onclick="goDetail(${list.PJ_NO })">
						<input id="start_${list.PJ_NO }" value="${list.PJ_START_DATE }" hidden="">
						<input id="end_${list.PJ_NO }" value="${list.PJ_END_DATE }" hidden="">
						<div id="gantt_${list.PJ_NO }"></div>
					</td>
					<td>
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse_${list.PJ_NO }" onclick="getMembers(${list.PJ_NO }, '${list.PJ_START_DATE }', '${list.PJ_END_DATE }')">▼</a>
					</td>
				</tr> --%>
				
				
				<tr>
					<td onclick="goDetail(${list.PJ_NO })"> </td>
					<td onclick="goDetail(${list.PJ_NO })">
					
						<input id="start_${list.PJ_NO }" value="${list.PJ_START_DATE }" hidden="">
						<input id="end_${list.PJ_NO }" value="${list.PJ_END_DATE }" hidden="">
						
						
						<div class="progress" id="progress_${list.PJ_NO }">
		  					
		  					
		  					
						</div>
						
					</td>
					<td>
						<a data-toggle="collapse" data-parent="#accordion" href="#collapse_${list.PJ_NO }" onclick="getMembers(${list.PJ_NO }, '${list.PJ_START_DATE }', '${list.PJ_END_DATE }')">▼</a>
					</td>
				</tr>
				
				
				
				
				
				
				<tr>
					<td colspan="5">
						<div id="collapse_${list.PJ_NO }" class="panel-collapse collapse"></div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="text-center">
		<ul class="pagination pagination-sm">
			<c:if test="${list.prev_paging != -1 }">
				<li><a href="projectList?page=${list.prev_paging }&searchSort=${list.searchSort }&keyword=${list.keyword }" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
			</c:if>
			<c:forEach begin="${list.page - list.half > 0 ? list.page - list.half : 1 }" end="${list.page + list.half < list.lastPage ? list.page + list.half : list.lastPage }" var="i">
				<li value="${i }" class="${i == list.page ? 'active' : '' }"><a href="projectList?page=${i }&searchSort=${list.searchSort }&keyword=${list.keyword }">${i }</a></li>
			</c:forEach>
			<c:if test="${list.next_paging != -1 }">
				<li><a href="projectList?page=${list.next_paging }&searchSort=${list.searchSort }&keyword=${list.keyword }" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
			</c:if>
		</ul>
	</div>
</div>



<script>
	






	function goDetail(key) {
		location.href = "projectList/" + key;
	};
	
	function getMembers(no, start, end) {
		$.ajax({
			type: 'post',
			url: 'projectList/getMembers',
			data: 'no=' + no,
			dataType: 'json',
			success: function(data) {
				gantt(no, data, start, end);
			},
			error: function(req) {
				console.log(req);
			}
		});
	};
	
	function gantt(no, data, start, end) {
		$('#collapse_' + no).empty();		
		var json = eval(data); // json string to json array
		
		$(json).each(function(i) {
			$('#collapse_' + no).append('<div style="margin:3px; width:10%; float:left; font-size:12px; text-align:right;">' + (i + 1) + '</div><div style="margin:3px; padding-left:15px; width:18%; float:left; font-size:12px; text-align: -webkit-center; ">' + json[i].MEM_NAME + '</div><div style="float:left; margin: 3px; padding-right: 15px; font-size: 11px;">' + json[i].MEM_START_DATE + ' ~ ' + json[i].MEM_END_DATE + '</div>');
			
			var start_m = json[i].MEM_START_DATE.split('-');
			var start_m_date = new Date(start_m[0], start_m[1] - 1, start_m[2]);
			var end_m = json[i].MEM_END_DATE.split('-');
			var end_m_date = new Date(end_m[0], end_m[1] - 1, end_m[2]);
			
			var start_s = start.split('-');
			var start_s_date = new Date(start_s[0], start_s[1] - 1, start_s[2]);
			var end_s = end.split('-');
			var end_s_date = new Date(end_s[0], end_s[1] - 1, end_s[2]);

			var today_date = new Date();
			
			var standard = ((end_s_date.getTime() - start_s_date.getTime()) / (1000 * 60 * 60 * 24)) / 100;
			
			var x = ((start_m_date.getTime() - start_s_date.getTime()) / (1000 * 60 * 60 * 24)) / standard;
			var y = ((end_m_date.getTime() - start_m_date.getTime()) / (1000 * 60 * 60 * 24)) / standard;
			var z = ((end_s_date.getTime() - end_m_date.getTime()) / (1000 * 60 * 60 * 24)) / standard;
			var a = ((end_m_date.getTime() - today_date.getTime()) / (1000 * 60 * 60 * 24)) / standard;
		
		
			
			/*
			
			x는 안한것,.
			(x+y)는 한것
			
			if((x+y)-a)<=100) 이래야 일한것
			
			100-(x+y-a)는 일 안한것?
			
			
			
			*/
			
			var n1 = 0;
			var n2 = 0;
			var n3 = 0;
			var n4 = 0;
			
			
			for(var j = 1 ; j <= 100; j++) {
				if(j < x) {
					//안한것
					//$('#collapse_' + no).append('<div style="height:3px; width:3px; background-color:#f4f3ef; float:left; margin-top:15px;"></div>');
					n1++;
				} else if(j > x && j <= (y + x)) {
					if(j < (x + y - a) && a < x + y) {
						//한것
						//$('#collapse_' + no).append('<div style="height:3px; width:3px; background-color:gray; float:left; margin-top:15px;"></div>');
						n2++;
					} else {
						//이제해야함
						//$('#collapse_' + no).append('<div style="height:3px; width:3px; background-color:red; float:left; margin-top:15px;"></div>');
						n3++;
					}
				} else {
					//$('#collapse_' + no).append('<div style="height:3px; width:3px; background-color:#f4f3ef; float:left; margin-top:15px;"></div>');
					n4++;
				}
			}
			
		
			$('#collapse_' + no).append('<div class="progress" style="width: 30%;"><div class="progress-bar bg-warning" role="progressbar" style="width:' + n1 + '%" aria-valuenow="' + n1 +'" aria-valuemin="0" aria-valuemax="100"></div><div class="progress-bar bg-success" role="progressbar" style="width:' + n2 +'%" aria-valuenow="' + n2 + '" aria-valuemin="0" aria-valuemax="100"></div><div class="progress-bar bg-info" role="progressbar" style="width:' + n3 +'%" aria-valuenow="' + n3 + '" aria-valuemin="0" aria-valuemax="100"></div><div class="progress-bar bg-warning" role="progressbar" style="width:' + n4 + '%" aria-valuenow="' + n4 +'" aria-valuemin="0" aria-valuemax="100"></div></div>');
			
		
			//$('#collapse_' + no).append('<div class="progress" style="width: 30%;"><div class="progress-bar bg-warning" role="progressbar" style="width:' + x + '%" aria-valuenow="' + x +'" aria-valuemin="0" aria-valuemax="100"></div><div class="progress-bar bg-success" role="progressbar" style="width:' + ix +'%" aria-valuenow="' + ix + '" aria-valuemin="0" aria-valuemax="100"></div><div class="progress-bar bg-warning" role="progressbar" style="width:' + ((100-ix)-z) +'%" aria-valuenow="' + ((100-ix)-z) + '" aria-valuemin="0" aria-valuemax="100"></div></div></div>');
				
			
				
				
			
			
			
			
			
			
			
			
			
			
			$('#collapse_' + no).append('<br><br>');
		});
	}
	
	$(function() {
		<c:forEach items="${list.pj_list }" var="list">
			var s = $('#start_' + ${list.PJ_NO }).val();
			var e = $('#end_' + ${list.PJ_NO }).val();
			
			var today_date = new Date(); 
			var start = $('#start_' + ${list.PJ_NO }).val().split('-');
			var start_date = new Date(start[0], start[1] - 1, start[2]);
			var end = $('#end_' + ${list.PJ_NO }).val().split('-');
			var end_date = new Date(end[0], end[1] - 1, end[2]);
			
			var standard = ((end_date.getTime() - start_date.getTime()) / (1000 * 60 * 60 * 24)) / 100;
			var today = Math.floor((end_date.getTime() - today_date.getTime()) / (1000 * 60 * 60 * 24)) / standard;
			
			var temp = parseInt(100 - today);
			if(temp>=100){
				temp = 100;
			}
			
			
			for(var i = 0; i < 100; i++) {
				if(i > 100 - today) {
					$('#gantt_' + ${list.PJ_NO }).append('<div style="height:3px; width:3px; background-color:red; float:left; margin-top:10px;"></div>');
				} else {
					$('#gantt_' + ${list.PJ_NO }).append('<div style="height:3px; width:3px; background-color:gray; float:left; margin-top:10px;"></div>');
				}
			}
			
			$('#gantt_' + ${list.PJ_NO }).prepend('<div style="float:left; margin-right:10px;">' + s + '</div>');
			$('#gantt_' + ${list.PJ_NO }).append('<div style="float:left; margin-left:10px;">' + e + '</div>');
			

			$('#progress_' + ${list.PJ_NO }).prepend('<div class="progress-bar bg-success" role="progressbar" style="width:' + temp +'%" aria-valuenow="' + temp + '" aria-valuemin="0" aria-valuemax="100"><div style="float:left; margin-left:10px; margin-top: 1px; font-size: 11px;">${list.PJ_START_DATE}</div><div style="float:right; margin-right:10px; margin-top: 1px; font-size: 11px;">${list.PJ_END_DATE}</div></div><div class="progress-bar bg-info" role="progressbar" style="width: '+(100-temp)+'%" aria-valuenow="'+temp+'" aria-valuemin="0" aria-valuemax="100"></div>');
			
			
		</c:forEach>
	});
	
</script>