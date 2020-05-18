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
<h1 class="page-header" hidden="true">비용처리 리스트</h1>
<div class="card card-plain" style="padding:0px 20px;">
	<div class="header">
		<div class="row">
			<div class="col-lg-5">
				<div class="hidden-xs">
					<button type="button" class="btnReg btn btn-xs btn-default">비용처리 등록</button>
				</div>
				<div class="visible-xs">
					<button type="button" class="btnReg btn btn-xs btn-default">비용처리 등록</button>
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
						<th>비용처리구분</th>
						<th>결재회차</th>
						<th>결재상태</th>
						<th>등록일시/수정일시</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${expenseMap.list}" varStatus="status">
						<tr data-no="${list.exNo }">
							<td>${(expenseMap.totCnt - ((expenseMap.page - 1) * expenseMap.postPerPage)) - status.index }</td>
							<td>${list.memDeptNm }</td>
							<td>${list.memGradeNm }</td>
							<td>${list.memName }</td>
							<td>${fn:substring(list.month, 0, 4) }년 ${fn:substring(list.month, 4, 6) }월 ${list.exTypeNm }</td>
							<td>${list.aprvTn }</td>
							<td class="${list.aprvStat }">${list.aprvStatNm }</td>
							<td>${list.regDtm }</td>
						</tr>
					</c:forEach>
					<c:if test="${expenseMap.totCnt eq null}">
						<tr><td colspan="9" style="padding:100px 0; text-align:center;">등록된 비용처리가 없습니다.</td></tr>
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
						<th style="text-align: left;">비용처리구분</th>
						<th>결재상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="list" items="${expenseMap.list}" varStatus="status">
						<tr data-no="${list.exNo }">
							<td style="text-align: left;">
								<div style="font-size: 14px; ">
									${fn:substring(list.month, 0, 4) }년 ${fn:substring(list.month, 4, 6) }월 ${list.exTypeNm }
								</div> 
								<div>
									<span style="font-size: 12px; font-weight: bold; color: #aaa;">
									${list.memGradeNm } / ${list.memName }</span>
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
								<span class="${list.aprvStat }" style="font-weight: bold; font-size: 16px; white-space: nowrap;">[${list.aprvStatNm }]</span>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${expenseMap.totCnt eq null}">
						<tr><td colspan="9" style="padding:100px 0; text-align:center;">등록된 비용처리가 없습니다.</td></tr>
					</c:if>
				</tbody>
				</table> 
				</div>
		</div>
	</div>
	
	<c:if test="${expenseMap.totCnt ne null}">
		<div class="text-center">
			<ul class="pagination pagination-sm">
				<c:if test="${expenseMap.prevPage ne 0 }">
					<li>
						<a href="?page=${expenseMap.prevPage }" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
					</li>
				</c:if>
				<c:forEach begin="${expenseMap.blockFirst }" end="${expenseMap.blockLast }" varStatus="idx">
					<li id="list_${idx.count }" class="listBtn">
						<a href="?page=${idx.count }">${idx.count }</a>
					</li>
				</c:forEach>
				<c:if test="${expenseMap.nextPage ne 0 }">
					<li>
						<a href="?page=${expenseMap.nextPage }" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
					</li>
				</c:if>
			</ul>
		</div>
	</c:if>
</div>
<script>
$(document).on("click", ".btnReg", function() {
	location.href = "./register";
});
$(document).on("click", ".listTable tbody tr", function() {
	location.href = "./view?exNo=" + $(this).data("no");
});
</script>