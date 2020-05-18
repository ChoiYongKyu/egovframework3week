<%pageContext.setAttribute("newLine", "\n");%>
<style type="text/css">
.listTable tr th,
.listTable tr td { text-align:center; }
.AS01 { color:orange; font-weight:bold; }
.AS02, .DS01{ color:blue; font-weight:bold; }
.AS03, .AS04, .DS03 { color:red; font-weight:bold; }
.AS05, .DS02{ color:green; font-weight:bold; }
.custom-table tr th { white-space: nowrap; }
.custom-table tr td { colspan="3" }
</style>
<h1 class="page-header" hidden="true">휴가 상세보기</h1>
<div class="header">
	<div class="card card-plain">
		<input type="hidden" id="vacNo" value="${vacationInfo.vacNo}">
		<table class="table table-bordered custom-table hidden-xs">
			<colgroup>
				<col class="col-lg-1"/><col class="col-lg-4"/>
				<col class="col-lg-1"/><col class="col-lg-4"/>
			</colgroup>
			<tr>
				<th>소속</th><td>${vacationInfo.memDeptNm}</td>
				<th>직위*직급</th><td>${vacationInfo.memGradeNm}</td>
			</tr>
			<tr>
				<th>연락처</th><td>${vacationInfo.memTel}</td>
				<th>성명</th><td>${vacationInfo.memName}</td>
			</tr>
			<tr>
				<th>휴가기간</th>
				<td colspan="3">
					<c:choose>
						<c:when test="${vacationInfo.vacStartDt eq vacationInfo.vacEndDt}">
							${vacationInfo.vacStartDt}
						</c:when>
						<c:otherwise>
							${vacationInfo.vacStartDt} ~ ${vacationInfo.vacEndDt}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>휴가구분</th><td>${vacationInfo.vacTypeNm}</td>
				<th>휴가일 수</th><td>${vacationInfo.vacDays}</td>
			</tr>
			<tr>
				<th>사유</th>
				<td colspan="4">${fn:replace(vacationInfo.vacReason, newLine, "<br/>")}</td>
			</tr>
			<tr>
				<th>등록일시</th><td>${vacationInfo.regDtm}</td>
				<th>등록회원</th><td>${vacationInfo.regNm}</td>
			</tr>
			<tr>
				<th>수정일시</th><td>${vacationInfo.modDtm}</td>
				<th>수정회원</th><td>${vacationInfo.modNm}</td>
			</tr>
			<tr>
				<th>결재회차</th><td>${vacationInfo.aprvTn}</td>
				<th>결재상태</th><td class="${vacationInfo.aprvStat}">${vacationInfo.aprvStatNm}</td>
			</tr>
			<tr>
			<th>결재자</th>
				<td colspan="4" style="padding-left: 1px; padding-right: 1px;">
					<table class="listTable table table-bordered">
						<colgroup><col class="col-lg-2"/><col class="col-lg-2"/><col class="col-lg-2"/><col class="col-lg-4"/></colgroup>
						<tr>
							<th>No</th>
							<th>결재자이름</th>
							<th>결재상태</th>
							<th>비고</th>
						</tr>
						<c:forEach var="decidingOfficerInfo" items="${decidingOfficerList}">
							<tr>
								<td>${decidingOfficerInfo.aprvSort}</td>
								<td>${decidingOfficerInfo.memName}</td>
								<td class="${decidingOfficerInfo.docfStat}">${decidingOfficerInfo.docfStatNm}</td>
								<td style="text-align:left;">${fn:replace(decidingOfficerInfo.aprvRmrk, newLine, "<br/>")}</td>
							</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
		</table>
		
		<table class="table table-bordered custom-table visible-xs">
			<colgroup>
				<col class="col-lg-1"/><col class="col-lg-4"/>
				<!-- <col class="col-lg-1"/><col class="col-lg-4"/> -->
			</colgroup>
			<tr>
				<th>소속</th><td>${vacationInfo.memDeptNm}</td>
			</tr>
			<tr>
				<th>직위*직급</th><td>${vacationInfo.memGradeNm}</td>
			</tr>
			<tr>
				<th>연락처</th><td>${vacationInfo.memTel}</td>
			</tr>
			<tr>
				<th>성명</th><td>${vacationInfo.memName}</td>
			</tr>
			<tr>
				<th>휴가기간</th>
				<td colspan="3">
					<c:choose>
						<c:when test="${vacationInfo.vacStartDt eq vacationInfo.vacEndDt}">
							${vacationInfo.vacStartDt}
						</c:when>
						<c:otherwise>
							${vacationInfo.vacStartDt} ~ ${vacationInfo.vacEndDt}
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>휴가구분</th><td>${vacationInfo.vacTypeNm}</td>
			</tr>
			<tr>
				<th>휴가일 수</th><td>${vacationInfo.vacDays}</td>
			</tr>
			<tr>
				<th>사유</th>
				<td colspan="4">${fn:replace(vacationInfo.vacReason, newLine, "<br/>")}</td>
			</tr>
			<tr>
				<th>등록일시</th><td>${vacationInfo.regDtm}</td>
				
			</tr>
			<tr>
				<th>등록회원</th><td>${vacationInfo.regNm}</td>
			</tr>
			<tr>
				<th>수정일시</th><td>${vacationInfo.modDtm}</td>
				
			</tr>
			<tr>
				<th>수정회원</th><td>${vacationInfo.modNm}</td>
			</tr>
			<tr>
				<th>결재회차</th><td>${vacationInfo.aprvTn}</td>
			</tr>
			<tr>
				<th>결재상태</th><td class="${vacationInfo.aprvStat}">${vacationInfo.aprvStatNm}</td>
			</tr>
			<tr>
			<th>결재자</th>
				<td colspan="4" style="padding-left: 1px; padding-right: 1px;">
					<table class="listTable table table-bordered">
						<colgroup><col class="col-lg-2"/><col class="col-lg-2"/><col class="col-lg-2"/><col class="col-lg-4"/></colgroup>
						<tr>
							<th>No</th>
							<th>결재자이름</th>
							<th>결재상태</th>
							<th>비고</th>
						</tr>
						<c:forEach var="decidingOfficerInfo" items="${decidingOfficerList}">
							<tr>
								<td>${decidingOfficerInfo.aprvSort}</td>
								<td>${decidingOfficerInfo.memName}</td>
								<td class="${decidingOfficerInfo.docfStat}">${decidingOfficerInfo.docfStatNm}</td>
								<td style="text-align:left;">${fn:replace(decidingOfficerInfo.aprvRmrk, newLine, "<br/>")}</td>
							</tr>
						</c:forEach>
					</table>
				</td>
			</tr>
		</table>
		
		
		
		<div class="text-right">
			<button type="button" id="btnList" class="btn btn-ms btn-default">목록으로</button>
			<c:if test="${vacationInfo.memNo eq sesMemNo}">
				<c:if test="${vacationInfo.aprvStat eq 'AS01'}">
					<button type="button" id="btnReport" class="btn btn-ms btn-success">상신</button>
				</c:if>
				<c:if test="${vacationInfo.aprvStat eq 'AS02' || vacationInfo.aprvStat eq 'AS05'}">
					<button type="button" id="btnReportCancel" class="btn btn-danger">상신취소</button>
				</c:if>
				<c:if test="${vacationInfo.aprvStat eq 'AS04'}">
					<button type="button" id="btnRetryReport" class="btn btn-ms btn-success">재상신</button>
				</c:if>
				<c:if test="${vacationInfo.aprvStat eq 'AS01' || vacationInfo.aprvStat eq 'AS04'}">
					<button type="button" id="btnModify" class="btn btn-ms btn-warning">수정</button>
				</c:if>
				<c:if test="${vacationInfo.aprvStat eq 'AS01'}">
					<button type="button" id="btnDelete" class="btn btn-ms btn-danger">삭제</button>
				</c:if>
			</c:if>
		</div>
	</div>
</div>
<script>
var ctx = "${ctx}";
$(document).on("click", "#btnList", function() {
	location.href = "./list";
});

$(document).on("click", "#btnReport", function() {
	if(confirm("상신 하시겠습니까?")) {
		location.href = ctx + "/approval/updateReportOfficial?vacNo=" + $("#vacNo").val() + "&aprvStat=AS02&aprvLnkgClsf=VACATION";
	}
});

$(document).on("click", "#btnReportCancel", function() {
	if(confirm("상신취소 하시겠습니까?")) {
		location.href = ctx + "/approval/updateReportOfficial?vacNo=" + $("#vacNo").val() + "&aprvStat=AS03&aprvLnkgClsf=VACATION";
	}
});

$(document).on("click", "#btnRetryReport", function() {
	if(confirm("재상신 하시겠습니까?")) {
		location.href = ctx + "/approval/updateReportOfficial?vacNo=" + $("#vacNo").val() + "&aprvStat=AS02&aprvLnkgClsf=VACATION";
	}
});

$(document).on("click", "#btnModify", function() {
	location.href = "./register?vacNo=" + $("#vacNo").val();
});

$(document).on("click", "#btnDelete", function() {
	if(confirm("삭제 하시겠습니까?")) {
		location.href = "./deleteVacation?vacNo=" + $("#vacNo").val();
	}
});
</script>