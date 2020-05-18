<%pageContext.setAttribute("newLine", "\n");%>
<style type="text/css">
.listTable tr th,
.listTable tr td { text-align:center; }
.AS01 { color:orange; font-weight:bold; }
.AS02, .DS01{ color:blue; font-weight:bold; }
.AS03, .AS04, .DS03 { color:red; font-weight:bold; }
.AS05, .DS02{ color:green; font-weight:bold; }
</style>
<h1 class="page-header" hidden="true">품의 상세보기</h1>
<div class="header">
	<div class="card card-plain">
		<input type="hidden" id="cstnNo" value="${consultationInfo.cstnNo}">
		<table class="table table-bordered">
			<colgroup>
				<col class="col-lg-1"/><col class="col-lg-4"/>
				<col class="col-lg-1"/><col class="col-lg-4"/>
			</colgroup>
			<tr>
				<th>작성일자</th><td>${consultationInfo.wrotDt}</td>
				<th>시행일자</th><td>${consultationInfo.enfcDt}</td>
			</tr>
			<tr>
				<th>기안부서</th><td>${consultationInfo.memDeptNm}</td>
				<th>기안자</th><td>${consultationInfo.memName}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">${consultationInfo.cstnTitle}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">${fn:replace(consultationInfo.cstnCn, newLine, "<br/>")}</td>
			</tr>
			<tr>
				<th>첨부</th>
				<td colspan="3"><a href="${ctx}/file/download?no=${consultationInfo.uploadNo}" target="_blank">${consultationInfo.uploadBefore}</a></td>
			</tr>
			<tr>
				<th>등록일시</th><td>${consultationInfo.regDtm}</td>
				<th>등록회원</th><td>${consultationInfo.regNm}</td>
			</tr>
			<tr>
				<th>수정일시</th><td>${consultationInfo.modDtm}</td>
				<th>수정회원</th><td>${consultationInfo.modNm}</td>
			</tr>
			<tr>
				<th>결재회차</th><td>${consultationInfo.aprvTn}</td>
				<th>결재상태</th><td class="${consultationInfo.aprvStat}">${consultationInfo.aprvStatNm}</td>
			</tr>
			<tr>
				<th>결재자</th>
				<td colspan="4">
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
			<c:if test="${consultationInfo.memNo eq sesMemNo}">
				<c:if test="${consultationInfo.aprvStat eq 'AS01'}">
					<button type="button" id="btnReport" class="btn btn-ms btn-success">상신</button>
				</c:if>
				<c:if test="${consultationInfo.aprvStat eq 'AS02' || consultationInfo.aprvStat eq 'AS05'}">
					<button type="button" id="btnReportCancel" class="btn btn-danger">상신취소</button>
				</c:if>
				<c:if test="${consultationInfo.aprvStat eq 'AS04'}">
					<button type="button" id="btnRetryReport" class="btn btn-ms btn-success">재상신</button>
				</c:if>
				<c:if test="${consultationInfo.aprvStat eq 'AS01' || consultationInfo.aprvStat eq 'AS04'}">
					<button type="button" id="btnModify" class="btn btn-ms btn-warning">수정</button>
				</c:if>
				<c:if test="${consultationInfo.aprvStat eq 'AS01'}">
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
		location.href = ctx + "/approval/updateReportOfficial?cstnNo=" + $("#cstnNo").val() + "&aprvStat=AS02&aprvLnkgClsf=CONSULTATION";
	}
});

$(document).on("click", "#btnReportCancel", function() {
	if(confirm("상신취소 하시겠습니까?")) {
		location.href = ctx + "/approval/updateReportOfficial?cstnNo=" + $("#cstnNo").val() + "&aprvStat=AS03&aprvLnkgClsf=CONSULTATION";
	}
});

$(document).on("click", "#btnRetryReport", function() {
	if(confirm("재상신 하시겠습니까?")) {
		location.href = ctx + "/approval/updateReportOfficial?cstnNo=" + $("#cstnNo").val() + "&aprvStat=AS02&aprvLnkgClsf=CONSULTATION";
	}
});

$(document).on("click", "#btnModify", function() {
	location.href = "./register?cstnNo=" + $("#cstnNo").val();
});

$(document).on("click", "#btnDelete", function() {
	if(confirm("삭제 하시겠습니까?")) {
		location.href = "./deleteConsultation?cstnNo=" + $("#cstnNo").val() + "&uploadNo=${consultationInfo.uploadNo}";
	}
});
</script>