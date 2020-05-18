<!--                         <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">고객사 별 유지보수 내역</h1>
<div class="card card-plain">
	<div class="header">
	<input type="hidden" name="paramNo" id="paramNo" value="${param.no }">
		<div class="content table-resposive table-full-width">
			<form method="get" action="getClientStats" id="form">
				<span class="form-group form-group-sm col-lg-2">
					<select name="cNo" id="cNo" class="form-control">
							<option value="0">- 고객사 선택 -</option>
						<c:forEach var="clientList" items="${clientList }">
							<option value="${clientList.CLIENT_NO }" ${clientList.CLIENT_NO == param.cNo ? 'selected' : '' }>${clientList.CLIENT_NAME }</option>
						</c:forEach>
					</select>
				</span>
				<span class="form-group form-group-sm col-lg-2">
					<select name="workScope" id="workScope" class="form-control">
							<option value="0">- 업무구분 선택 -</option>
					</select>
				</span>
				<span class="form-group form-group-sm col-lg-2">
					<select name="supportName" id="supportName" class="form-control">
							<option value="0">- 지원형태 선택 -</option>
							<c:forEach var="getSupportName" items="${getSupportName }">
								<option value="${getSupportName.SUPPORT_NO }" ${getSupportName.SUPPORT_NO == param.supportName ? 'selected' : '' }>${getSupportName.SUPPORT_NAME }</option>
							</c:forEach>
					</select>
				</span>
				<span class="form-group form-group-sm col-lg-3">
					<button type="submit" class="commonBtn">검색</button>
				</span>
			</form>
			<table class="table table-hover hidden-xs">
				<colgroup>
					<col width="4%">
					<col width="6%">
					<col width="6%">
					<col width="8%">
					<col width="10%">
					<col width="10%">
					<col width="11%">
					<col width="11%">
					<col width="7%">
					<col width="*">
					<col width="*">
				</colgroup>
				<thead>
					<tr class="header">
						<th>번호</th>
						<th>업무구분</th>
						<th>지원형태</th>
						<th>지원 요청일</th>
						<!-- 					<td>지원 시작일 <br />~ 지원 종료일</td> -->
						<th>지원 요청자</th>
						<th>작업 담당자</th>
						<th>지원 시작일</th>
						<th>지원 종료일</th>
						<th>지원일 수</th>
						<th>지원항목</th>
						<th>참조사항</th>
					</tr>
				</thead>
				<tbody id="clientStatsList">
					<c:forEach var="clientStats" items="${clientStats.list }">
						<tr onclick="goDetail(${clientStats.MN_NO})">
							<td>${clientStats.MN_NO} / ${clientStats.CLIENT_NAME}</td>
							<td>${clientStats.WORK_SCOPE_NAME }</td>
							<td>${clientStats.SUPPORT_NAME}</td>
							<td>${clientStats.MN_REQ_DATE }</td>
							<td>${clientStats.REQ_NAME }</td>
							<td>${clientStats.MEM_NAME }${clientStats.MN_GROUP_NAME }</td>
							<td>${clientStats.MN_START_DATE }</td>
							<td>${clientStats.MN_END_DATE }</td>
							<td>${clientStats.MN_SUP_DAYS }</td>
							<td>
								<a href="#" data-toggle="tooltip" title="${clientStats.ORIGINAL_MN_SUP_ITEM }" style="text-decoration:none; color:#000;">${clientStats.MN_SUP_ITEM }</a>
							</td>
							<td>
								<a href="#" data-toggle="tooltip" title="${clientStats.ORIGINAL_MN_REFERENCE }" style="text-decoration:none; color:#000;">${clientStats.MN_REFERENCE }</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			
			
			<!-- 모바일 -->	
			<div class="row" style="margin: 20px 2px 2px 2px;">
				<table class="table table-hover visible-xs">
					<tbody id="clientStatsList">
						<c:forEach var="clientStats" items="${clientStats.list }">
							<tr onclick="goDetail(${clientStats.MN_NO})">
								<td>
									<div style="font-size: 17px;">
										<span style="font-weight: bold; font-size: 14px;">[${clientStats.WORK_SCOPE_NAME } / ${clientStats.SUPPORT_NAME}]</span>
										${clientStats.CLIENT_NAME}
									</div> <span style="font-size: 12px; font-weight: bold; color: #aaa;">${clientStats.MEM_NAME }${clientStats.MN_GROUP_NAME }
										${clientStats.MN_START_DATE } ~ ${clientStats.MN_END_DATE }</span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>	
			
			
			
			
			
			
			
			
			
		</div>
	</div>
	<c:if test="${clientStats.list ne null }">
		<div class="text-center">
			<ul class="pagination pagination-sm">
				<c:if test="${clientStats.prevPaging ne -1 }">
					<li><a href="?cNo=${clientStats.prevPaging }&no=${clientStats.page }&workScope=${clientStats.workScope }&supportName=${clientStats.supportName }"
						aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
				</c:if>
				<c:forEach begin="${clientStats.page - 2 <= 0 ? 1 : clientStats.page - 2 }"
					end="${clientStats.page + 2 > clientStats.lastPage ? clientStats.lastPage : clientStats.page + 2 }"
					var="index">
					<li id="list_${index }" class="listBtn">
					<a href="?cNo=${clientStats.cNo }&no=${index }&workScope=${clientStats.workScope }&supportName=${clientStats.supportName }">${index }</a></li>
				</c:forEach>
				<c:if test="${clientStats.nextPaging ne -1 }">
					<li><a href="?cNo=${clientStats.nextPaging }&no=${clientStats.page }&workScope=${clientStats.workScope }&supportName=${clientStats.supportName }"
						aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
				</c:if>
			</ul>
		</div>
	</c:if>
</div>
<!--  주 내용 끝  -->
<script>
	
	
//	$('tr[class!=header]').on('mouseenter',function(){$(this).css('background-color', 'whitesmoke')});
	$('tr[class!=header]').on('mouseleave',function(){$(this).removeAttr('style')});
	$('tr[class!=header]').on('mousedown',function(){$(this).css('background-color', 'wheat')});
	$('tr[class!=header]').on('mouseup',function(){$(this).removeAttr('style')});
	
	var isMobile;
	$(window).resize(function(){
		var winWidth = $(window).width();
		var winHeight = $(window).height();
		if(winWidth < winHeight){
			$('.pcVer').addClass('hidden');
			$('.moVer').removeClass('hidden');
		}else{
			$('.pcVer').removeClass('hidden');
			$('.moVer').addClass('hidden');
		}
	});
	
	
	
	
	function getWorkScope(data) {
		var dVal = data;
		var html;
		html = '<option value="0">- 업무구분 선택 -</option>';
		for (var i = 0; i < dVal.length; i++) {
			html += '<option value="' + dVal[i].WORK_SCOPE_NO + '">'
					+ dVal[i].WORK_SCOPE_NAME + '</option>';
		}
		$('#workScope').html(html);
		
		var paramWorkScope = '${param.workScope }';
		$('#workScope').val(paramWorkScope);
	}
// 	function getSupportName(data) {
// 		var dVal = data;
// 		var html;
// 		html = '<option value="0">- 지원형태 선택 -</option>';
// 		for (var i = 0; i < dVal.length; i++) {
// 			html += '<option value="' + dVal[i].WORK_SCOPE_NO + '">'
// 					+ dVal[i].WORK_SCOPE_NAME + '</option>';
// 		}
// 		$('#workScope').html(html);
// 	}

	
	function goDetail(key) {
		location.href="../maintenance/detail?no=" + key;
	}
	
	// 툴팁 
	$(document).ready(function(){
		$('select[name=cNo]').on('change', function() {
			var cNo = $('#cNo').val();
			if(cNo != 0) {
				$.ajax({
					type : 'post',
					url : 'getWorkScope',
					data : {
						client : cNo
					},
					dataType : "json",
					success : function(data) {
						getWorkScope(data);
					},
					error : function(req) {
						alert('실패');
					}
				});
			}
		});
		
		var paramCNo = '${param.cNo }';
		if(paramCNo != 0) {
			$.ajax({
				type : 'post',
				url : 'getWorkScope',
				data : {
					client : paramCNo
				},
				dataType : "json",
				success : function(data) {
					getWorkScope(data);
				},
				error : function(req) {
					alert('실패');
				}
			});
		} 
	});
	
	
</script>