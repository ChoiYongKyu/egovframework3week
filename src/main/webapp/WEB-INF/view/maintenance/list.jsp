<!--                         <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">유지보수 리스트</h1>
<div class="card card-plain" style="padding-left: 20px; padding-right: 20px;">
	<div class="header">
	<input type="hidden" name="paramNo" id="paramNo" value="${param.no }">
		<div class="row">
			<div class="col-lg-5">
				<div class="hidden-xs">
					<button type="button" class="btn btn-xs btn-sucess"
						onclick="location.href='${ctx }/maintenance/excel/download'">엑셀
						양식 다운로드</button>
					<button id="uploadBtn" class="btn btn-xs btn-default" type="button">엑셀
						양식 업로드</button>
					<button type="submit" class="btn btn-xs btn-default"
						onclick="location.href='${ctx }/maintenance/register'">유지보수
						예정/등록</button>
					<form id="upload" enctype="multipart/form-data" method="post"
						action="${ctx }/maintenance/excel/upload" hidden="">
						<input type="file" id="excelFile" name="excelFile"
							accept=".xls, .xlsx">
					</form>
					<script>
                	$('#uploadBtn').on('click', function() {
                		$('#excelFile').click();
                	});
                	$('#excelFile').on('change', function() {
                		$('#upload').submit();

// 						var formData = new FormData();
// 						formData.append('excelFile', $('#excelFile')[0].files[0]);
// 						console.log(formData);
// 						$.ajax({
// 							url : ctx + '/maintenance/excel/upload',
// 							type : 'post',
// 							data : formData,
// 							processData : false,
// 							contentType : false,
// 							success : function() {
// 								alert('!!');
// 							},
// 							error : function() {
// 								alert('??');
// 							}
// 						});
                	});
                </script>

				</div>
			</div>

			<div class="row col-lg-5 col-xs-12 hidden-xs pull-right">
				<form method="get" action="list" id="form">
					<div class="row">
						<div class="form-group-sm col-lg-4" style="min-width: 110px;">
							<select class="form-control border-input" name="searchCategory"
								style="border: none;">
								<option value="1">고객사</option>
								<option value="2">업무구분</option>
								<option value="3">담당자 / 그룹</option>
							</select>
						</div>

						<div class="form-group-sm col-lg-4" style="min-width: 150px;">
							<input type="text" class="form-control border-input"
								name="searchText" style="border: none;">
						</div>
						<div class="col-lg-1 col-xs-1">
							<button type="submit" class="commonBtn">검색</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<div class="content table-resposive table-full-width">

			<table class="table table-hover hidden-xs">
				<colgroup>
					<col width="7%">
					<col width="12%">
					<col width="9%">
					<col width="12%">
					<col width="17%">
					<col width="17%">
					<col width="12%">
					<col width="*">
				</colgroup>
				<thead>
					<tr class="header">
						<th>번호</th>
						<th>고객사</th>
						<th>업무구분</th>
						<th>담당자 / 담당그룹</th>
						<!-- 					<td>지원 시작일 <br />~ 지원 종료일</td> -->
						<th>지원 시작일</th>
						<th>지원 종료일</th>
						<th>작업 상태   <img src="../img/up.png" style="width:13px;" onclick="ascSort()">    
										<img src="../img/down.png" style="width:13px;" onclick="descSort()"></th>
						<th>작성 날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${list.list }">
						<tr onclick="goDetail(${list.MN_NO});">
							<td>${list.MN_NO }</td>
							<td>${list.CLIENT_NAME}<c:if
									test="${list.MN_REPLY_COUNT2 ne 0}">
									<span style="color: red;">[${list.MN_REPLY_COUNT2 }]</span>
								</c:if>
							</td>
							<td>${list.WORK_SCOPE_NAME }</td>
							<td>${list.MEM_NAME }${list.MN_GROUP_NAME }</td>
							<%-- 						<td>${list.MN_START_DATE }<br />~ ${list.MN_END_DATE } --%>
							<c:if
								test="${list.MN_START_DATE == NULL || list.MN_END_DATE == NULL }">
								<td>-</td>
								<td>-</td>
							</c:if>
							<c:if
								test="${list.MN_START_DATE != NULL || list.MN_END_DATE != NULL }">
								<td>${list.MN_START_DATE }</td>
								<td>${list.MN_END_DATE }</td>
							</c:if>
							<c:choose>
								<c:when test="${list.MN_DONE_NO eq 1 }">
									<td style="color: #ff3333; font-weight: bold;">${list.MN_DONE_NAME }</td>
								</c:when>
								<c:when test="${list.MN_DONE_NO eq 2 }">
									<td style="color: #cc00cc; font-weight: bold;">${list.MN_DONE_NAME }</td>
								</c:when>
								<c:when test="${list.MN_DONE_NO eq 3 }">
									<td style="color: #3385ff; font-weight: bold;">${list.MN_DONE_NAME }</td>
								</c:when>
							</c:choose>
								<td>${list.WRITE_DATE }</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
			<!-- 모바일 -->
			<div class="row visible-xs">
				<form method="get" action="list" id="form">
					<div class="row" style="margin-bottom:10px;">
						<span class="form-group-sm col-xs-12" style="min-width: 110px;">
							<select class="form-control border-input" name="searchCategory"
								style="border: none;">
								<option value="1">고객사</option>
								<option value="2">업무구분</option>
								<option value="3">담당자 / 그룹</option>
							</select>
						</span>
					</div>
					<div class="row" style="margin-bottom:10px;">
						<span class="form-group-sm col-xs-12" style="min-width: 150px;">
							<input type="text" class="form-control border-input"
								name="searchText" style="border: none;">
						</span>
					</div>
					<div class="row form-group-sm col-xs-12" style="margin-bottom:10px;">
						<button type="submit" class="commonBtn">검색</button>
					</div>
				</form>
			</div>
			<div class="row visible-xs">
				<button type="submit" class="btn btn-xs btn-default" onclick="location.href='${ctx }/maintenance/register'">유지보수 예정/등록</button>
			</div>	
			<div class="row">
				<table class="table table-hover visible-xs">
					<c:forEach var="list" items="${list.list }">
						<tr onclick="goDetail(${list.MN_NO});">
							<td>
								<div style="font-size: 17px;">
									<span style="font-weight: bold; font-size: 14px;">[${list.WORK_SCOPE_NAME }]</span>
									${list.CLIENT_NAME}
								</div> <span style="font-size: 12px; font-weight: bold; color: #aaa;">${list.MEM_NAME }${list.MN_GROUP_NAME }
									${list.MN_START_DATE } ~ ${list.MN_END_DATE }</span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>	

		</div>
	</div>
	<div class="text-center">
		<ul class="pagination pagination-sm">
			<c:if test="${list.prevPaging ne -1 }">
				<li>
				<a href="?no=${list.prevPaging }&searchCategory=${list.searchCategory }&searchText=${list.searchText }&sortName=${list.sortName }&doneSort=${list.doneSort }"
				aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
				
			</c:if>
			<c:forEach begin="${list.page - 2 <= 0 ? 1 : list.page - 2 }"
				end="${list.page + 2 > list.lastPage ? list.lastPage : list.page + 2 }"
				var="index">
				<li id="list_${index }" class="listBtn"><a
					href="?no=${index }&searchCategory=${list.searchCategory }&searchText=${list.searchText }&sortName=${list.sortName }&doneSort=${list.doneSort }">${index }</a></li>
			</c:forEach>
			<c:if test="${list.nextPaging ne -1 }">
				<li>
					<a href="?no=${list.nextPaging }&searchCategory=${list.searchCategory }&searchText=${list.searchText }&sortName=${list.sortName }&doneSort=${list.doneSort }"
					aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
				
			</c:if>
		</ul>
	</div>
</div>
<!--  주 내용 끝  -->
<script>
	function goDetail(key) {
		location.href="detail?no=" + key;
	}
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
	

	function ascSort() {
		location.href = '?no=${list.page}&searchCategory=${list.searcgCategory}&searchText=${list.searchText}&sortName=' + 'mn_done' + '&doneSort=' + 'asc';
	}
	function descSort() {
		location.href = '?no=${list.page}&searchCategory=${list.searcgCategory}&searchText=${list.searchText}&sortName=' + 'mn_done' + '&doneSort=' + 'desc';
	}
</script>