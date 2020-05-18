<style>
.listTable thead tr th,
.listTable tbody tr td { text-align:center; }
.listTable tbody tr { cursor:pointer; }
.AS01 { color:orange; font-weight:bold; }
.AS02 { color:blue; font-weight:bold; }
.AS03, .AS04 { color:red; font-weight:bold; }
.AS05 { color:green; font-weight:bold; }
</style>
<h1 class="page-header" hidden="true">품의 리스트</h1>
<div class="card card-plain" style="padding:0px 20px;">
	<div class="header">
		<div class="row">
			<div class="col-lg-5">
				<div class="hidden-xs">
					<button type="button" class="btnReg btn btn-xs btn-default">품의 등록</button>
				</div>
			</div>
			<div class="row col-lg-5 col-xs-12 hidden-xs pull-right">
				<!-- <form method="get" action="list" id="form">
					<div class="row">
						<div class="form-group-sm col-lg-4" style="min-width: 110px;">
							<select class="form-control border-input" name="searchCategory" style="border: none;">
								<option value="">전체</option>
							</select>
						</div>
						<div class="form-group-sm col-lg-4" style="min-width: 150px;">
							<input type="text" class="form-control border-input" name="searchText" style="border: none;">
						</div>
						<div class="col-lg-1 col-xs-1">
							<button type="submit" class="commonBtn">검색</button>
						</div>
					</div>
				</form> -->
			</div>
		</div>
		<div class="content table-resposive table-full-width">
			<table class="listTable table table-hover hidden-xs">
				<thead>
					<tr class="header">
						<th>번호</th>
						<th>제목</th>
						<th>기안부서</th>
						<th>기안자</th>
						<th>시행일자</th>
						<th>결재회차</th>
						<th>결재상태</th>
						<th>등록일시</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="consultationInfo" items="${consultationList}" varStatus="status">
						<tr data-no="${consultationInfo.cstnNo}">
							<td>${fn:length(consultationList) - status.index}</td>
							<td>${consultationInfo.cstnTitle}</td>
							<td>${consultationInfo.memDeptNm}</td>
							<td>${consultationInfo.memName}</td>
							<td>${consultationInfo.enfcDt}</td>
							<td>${consultationInfo.aprvTn}</td>
							<td class="${consultationInfo.aprvStat}">${consultationInfo.aprvStatNm}</td>
							<td>${consultationInfo.regDtm}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(consultationList) eq 0}">
						<tr><td colspan="7" style="padding:100px 0; text-align:center;">등록된 품의가 없습니다.</td></tr>
					</c:if>
				</tbody>
			</table>
			<!-- 모바일 -->
			<!-- <div class="row visible-xs">
				<form method="get" action="list" id="form">
					<div class="row" style="margin-bottom:10px;">
						<span class="form-group-sm col-xs-12" style="min-width: 110px;">
							<select class="form-control border-input" name="searchCategory"
								style="border: none;">
								<option value="1">담당자</option>
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
			</div> -->
			<%-- <div class="row visible-xs">
				<button type="submit" class="btn btn-xs btn-default" onclick="location.href='${ctx }/vacation/vac_register'">휴가신청 등록</button>
			</div>	
			<div class="row">
				<table class="table table-hover visible-xs">
					<c:forEach var="list" items="${list.list }">
						<tr onclick="goDetail(${list.VAC_NO});">
							<td>
								<div style="font-size: 17px;">
									<span style="font-weight: bold; font-size: 16px;">[${list.MEN_DEPT }]</span>
									${list.MEN_NAME} / ${list.VAC_TYPE}
								</div> <span style="font-size: 14px; font-weight: bold; color: #aaa;">${list.VAC_DAYS }&nbsp;일&nbsp;/
									${list.VAC_START_DATE } ~ ${list.VAC_END_DATE }</span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div> --%>
		</div>
	</div>
	<%-- <div class="text-center">
		<ul class="pagination pagination-sm">
			<c:if test="${list.prevPaging ne -1 }">
				<li>
				<a href="?no=${list.prevPaging }"
				aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
				
			</c:if>
			<c:forEach begin="${list.page - 2 <= 0 ? 1 : list.page - 2 }"
				end="${list.page + 2 > list.lastPage ? list.lastPage : list.page + 2 }"
				var="index">
				<li id="list_${index }" class="listBtn"><a
					href="?no=${index }">${index }</a></li>
			</c:forEach>
			<c:if test="${list.nextPaging ne -1 }">
				<li>
					<a href="?no=${list.nextPaging }"
					aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
				
			</c:if>
		</ul>
	</div> --%>
</div>
<script>
$(document).on("click", ".btnReg", function() {
	location.href = "./register";
});
$(document).on("click", ".listTable tbody tr", function() {
	location.href = "./view?cstnNo=" + $(this).data("no");
});
</script>