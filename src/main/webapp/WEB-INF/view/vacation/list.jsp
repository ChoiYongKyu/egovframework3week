<style>
.listTable thead tr th,
.listTable tbody tr td { text-align:center; }
.listTable tbody tr { cursor:pointer; }
.AS01 { color:orange; font-weight:bold; }
.AS02 { color:blue; font-weight:bold; }
.AS03, .AS04 { color:red; font-weight:bold; }
.AS05 { color:green; font-weight:bold; }
@media (max-width: 767px) {
	.card .content {
    padding-top: 0px;
    padding-bottom: 10px;
    }
}
</style>
<h1 class="page-header" hidden="true">휴가 리스트</h1>
<div class="card card-plain" style="padding:0px 20px;">
	<div class="header">
		<div class="row">
			<div class="col-lg-5">
				<div class="hidden-xs">
					<button type="button" class="btnReg btn btn-xs btn-default">휴가 등록</button>
				</div>
				<div class="visible-xs">
					<button type="button" class="btnReg btn btn-xs btn-default">휴가 등록</button>
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
						<th>소속</th>
						<th>직급</th>
						<th>이름</th>
						<th>휴가기간</th>
						<th>휴가구분</th>
						<th>결재회차</th>
						<th>결재상태</th>
						<th>등록일시</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vacationInfo" items="${vacationList}" varStatus="status">
						<tr data-no="${vacationInfo.vacNo}">
							<td>${fn:length(vacationList) - status.index}</td>
							<td>${vacationInfo.memDeptNm}</td>
							<td>${vacationInfo.memGradeNm}</td>
							<td>${vacationInfo.memName}</td>
							<td>
								<c:choose>
									<c:when test="${vacationInfo.vacStartDt eq vacationInfo.vacEndDt}">
										${vacationInfo.vacStartDt}
									</c:when>
									<c:otherwise>
										${vacationInfo.vacStartDt} ~ ${vacationInfo.vacEndDt}
									</c:otherwise>
								</c:choose>
							</td>
							<td>${vacationInfo.vacTypeNm}</td>
							<td>${vacationInfo.aprvTn}</td>
							<td class="${vacationInfo.aprvStat}">${vacationInfo.aprvStatNm}</td>
							<td>${vacationInfo.regDtm}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(vacationList) eq 0}">
						<tr><td colspan="9" style="padding:100px 0; text-align:center;">등록된 휴가가 없습니다.</td></tr>
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
			</div>	--%>
			<div class="row">
				<table class="listTable table table-hover visible-xs">
				<thead>
					<tr class="header">
						<th style="text-align: left;">구분 / 이름</th>
						<th>결재상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="vacationInfo" items="${vacationList}" varStatus="status">
						<tr data-no="${vacationInfo.vacNo}">
							<td style="text-align: left;">
								<div style="font-size: 14px; ">
									${vacationInfo.vacTypeNm} / ${vacationInfo.memName}
								</div> 
								<div>
									<span style="font-size: 12px; font-weight: bold; color: #aaa;">
									${vacationInfo.memGradeNm} / ${vacationInfo.memTel}</span>
								</div>
								<div>
									<span style="font-size: 12px; font-weight: bold; color: #aaa;">
										<c:choose>
											<c:when test="${vacationInfo.vacStartDt eq vacationInfo.vacEndDt}">
												${vacationInfo.vacStartDt}
											</c:when>
											<c:otherwise>
												${vacationInfo.vacStartDt} ~ ${vacationInfo.vacEndDt}
											</c:otherwise>
										</c:choose>
									</span>
								</div>
							</td>
							<td>
								<span class="${vacationInfo.aprvStat}" style="font-weight: bold; font-size: 16px; white-space: nowrap;">[${vacationInfo.aprvStatNm}]</span>
							</td>
						</tr>
					</c:forEach>
				
				</tbody>
				</table> 
				</div>
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
	location.href = "./view?vacNo=" + $(this).data("no");
});
</script>