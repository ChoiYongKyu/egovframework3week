<%pageContext.setAttribute("newLine", "\n");%>

<style type="text/css">
.listTable tr th,
.listTable tr td { text-align:center; }
.AS01 { color:orange; font-weight:bold; }
.AS02, .DS01{ color:blue; font-weight:bold; }
.AS03, .AS04, .DS03 { color:red; font-weight:bold; }
.AS05, .DS02{ color:green; font-weight:bold; }

@media( max-width: 768px ) {
	.ctable {
		width: calc(100% - 30%);
	}
	
	.xstable {
		display: block;
	}
</style>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<link rel="stylesheet" href="${ctx}/css/responsive-tables.css">
<script src="${ctx}/js/responsive-tables.js"></script>
<script src="${ctx}/js/approver.js"></script>
<script src="${ctx}/js/expense.js"></script>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://rawgit.com/zorab47/jquery.ui.monthpicker/master/jquery.ui.monthpicker.js"></script>
<script>
$(document).ready(function() {
	var currentYear = (new Date()).getFullYear();
	$("#month").monthpicker({changeYear:true, minDate: "-2 Y", maxDate: "+2 Y", dateFormat: "yy년 mm월", monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"]});
	
	$("#memNo").change(function() {
		var $memNo = $("#memNo option:selected");
		var tel = $memNo.data("tel");
		
		$("#memTel").val(tel != "google user"?tel:"");
		$("#memDept").val($memNo.data("dept"));
		$("#memGrade").val($memNo.data("grade"));
	});
	
	$("#memNo").val("${sesMemNo}").trigger("change");//세션값 셋팅
	
	if($('#mode').val() == 'insert') {
		var date = new Date();
		var month = String(date.getMonth());
		
		if(month.length == 1) {
			month = '0'.concat(month);
		}
		$('#month').val(date.getFullYear() + '년 ' + month + '월');
	};
});

var ctx = "${ctx}";
$(document).on("click", "#btnList", function() {
	location.href = "./list";
});

$(document).on('keyup', 'input[name=person]', function() {
	$(this).val($(this).val().replace(/[^0-9]/g,""));
});

$(document).on("click", "#btnInsert, #btnUpdate", function() {
	if($("#mode").val() == "insert") {
		if($("#memNo").val() == "") {
			alert("성명을 선택해주세요.");
			$("#memNo").focus();
			return;
		}
		if($("#memDept").val() == "") {
			alert("소속을 선택해주세요.");
			$("#memDept").focus();
			return;
		}
		if($("#memGrade").val() == "") {
			alert("직위*직급을 선택해주세요.");
			$("#memGrade").focus();
			return;
		}
	}
	
	if($("#month").val() === "") {
		alert("연월을 입력해주세요.");
		return;
	}
	if($("#category").val() === "") {
		alert("구분을 입력해주세요.");
		return;
	}
	if(!isSelectedApprover()) {
		alert("결재자를 선택해주세요.");
		return;
	}

	var type = $("#category").val();
	// 공통
	if(!isDtm()) {
		alert("일자를 선택해주세요.");
		return;
	}
	if(!isMoney()) {
		alert("금액을 입력해주세요.");
		return;
	}
	
	// 복리후생비(EX01) / 교통비 및 기타비용(EX02)
	if(type == 'EX01' || type == 'EX02') {
		if(!isUsage()) {
			alert("용도를 입력해주세요.");
			return;
		}
		if(!isContent()) {
			alert("내역을 입력해주세요.");
			return;
		}
		if(!isPerson()) {
			alert("인원을 입력해주세요.");
			return;
		}
		if(!isEtc()) {
			alert("비고를 입력해주세요.");
			return;
		}
		
	// 대중교통비(EX03)
	} else if(type == 'EX03') {
		if(!isUsage()) {
			alert("교통수단을 입력해주세요.");
			return;
		}
		if(!isContent()) {
			alert("방문장소를 입력해주세요.");
			return;
		}
		if(!isPurpose()) {
			alert("방문회사/목적을 입력해주세요.");
			return;
		}
		if(!isEtc()) {
			alert("구분을 입력해주세요.");
			return;
		}
	}
	
	$("#month").val($("#month").val().replace(/(\d{4})년 (\d{1,2})월/g, '$1$2'));
	$("#frm").submit();
});

$(document).on("click", "#btnReport", function() {
	if(confirm("상신 하시겠습니까?")) {
		location.href = ctx + "/approval/updateReportOfficial?exNo=" + $("#exNo").val() + "&aprvStat=AS02&aprvLnkgClsf=EXPENSE";
	}
});

$(document).on("click", "#btnReportCancel", function() {
	if(confirm("상신취소 하시겠습니까?")) {
		location.href = ctx + "/approval/updateReportOfficial?exNo=" + $("#exNo").val() + "&aprvStat=AS03&aprvLnkgClsf=EXPENSE";
	}
});

$(document).on("click", "#btnRetryReport", function() {
	if(confirm("재상신 하시겠습니까?")) {
		alert($("#exNo").val());
		location.href = ctx + "/approval/updateReportOfficial?exNo=" + $("#exNo").val() + "&aprvStat=AS02&aprvLnkgClsf=EXPENSE";
	}
});

$(document).on("click", "#btnModify", function() {
	location.href = "./register?exNo=" + $("#exNo").val();
});

$(document).on("click", "#btnDelete", function() {
	if(confirm("삭제 하시겠습니까?")) {
		location.href = "./delete?delYn=Y&exNo=" + $("#exNo").val();
	}
});
</script>

<c:set value="${info.exDtl }" var="detail" />
<c:set value="${info.exDtlList }" var="list" />

<%-- 상세보기 --%>
<c:if test="${mode == 'view' }">
<h1 class="page-header" hidden="true">비용처리 상세보기</h1>
<div class="header">
	<div class="card card-plain">
		<input type="hidden" id="exNo" value="${detail.exNo}">
		<table class="table table-bordered">
			<colgroup>
				<col class="col-lg-1"/><col class="col-lg-4"/>
				<col class="col-lg-1"/><col class="col-lg-4"/>
			</colgroup>
			<tr class="xstable">
				<th class="xstable">소속</th><td class="xstable">${detail.memDeptNm}</td>
				<th class="xstable">직위*직급</th><td class="xstable">${detail.memGradeNm}</td>
			</tr>
			<tr class="xstable">
				<th class="xstable">성명</th><td  class="xstable" colspan="4">${detail.memName}</td>
			</tr>
			<tr>
				<th class="xstable">구분</th>
				<td  class="xstable" colspan="4">${fn:substring(detail.month, 0, 4) }년 ${fn:substring(detail.month, 4, 6) }월 ${detail.exTypeNm }</td>
			</tr>
			<tr class="xstable">
				<th class="xstable">등록일시</th><td class="xstable">${detail.regDtm}</td>
				<th class="xstable">수정일시</th><td class="xstable">${detail.modDtm}</td>
			</tr>
			<tr class="xstable">
				<th class="xstable">결재회차</th><td class="xstable">${detail.aprvTn}</td>
				<th class="xstable">결재상태</th><td class="xstable ${detail.aprvStat}">${detail.aprvStatNm}</td>
			</tr>
			<tr class="xstable">
				<th class="xstable">내역</th>
				<td  class="xstable" colspan="4">
					<c:if test="${detail.category eq 'EX01' or detail.category eq 'EX02'}">
						<table class="listTable table table-bordered responsive">
							<colgroup>
								<col width="5%" />
								<col width="10%" />
								<col width="10%" />
								<col width="*%" />
								<col width="10%" />
								<col width="10%" />
								<col width="10%" />
							</colgroup>
							<tr>
								<th>번호</th>
								<th>일자</th>
								<th>용도</th>
								<th>내역</th>
								<th>인원</th>
								<th>금액</th>
								<th>비고</th>
							</tr>
							<c:forEach var="listInfo" items="${list}" varStatus="idx">
								<tr>
									<td>${idx.count}</td>
									<td>${listInfo.dtm}</td>
									<td>${listInfo.usage}</td>
									<td style="text-align:left;">${listInfo.content}</td>
									<td>${listInfo.person}</td>
									<td style="text-align:right;"><fmt:formatNumber value="${listInfo.money}" pattern="#,###" /></td>
									<td>${listInfo.etc}</td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
					<c:if test="${detail.category eq 'EX03'}">
						<table class="listTable table table-bordered responsive">
							<colgroup>
								<col width="5%" />
								<col width="10%" />
								<col width="20%" />
								<col width="20%" />
								<col width="20%" />
								<col width="10%" />
								<col width="15%" />
							</colgroup>
							<tr>
								<th>번호</th>
								<th>일자</th>
								<th>방문회사/목적</th>
								<th>교통수단</th>
								<th>방문장소</th>
								<th>구분</th>
								<th>금액</th>
							</tr>
							<c:forEach var="listInfo" items="${list}" varStatus="idx">
								<tr>
									<td>${idx.count}</td>
									<td>${listInfo.dtm}</td>
									<td>${listInfo.purpose}</td>
									<td>${listInfo.usage}</td>
									<td>${listInfo.content}</td>
									<td>${listInfo.etc}</td>
									<td><fmt:formatNumber value="${listInfo.money}" pattern="#,###" /></td>
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</td>
			</tr>
			<tr class="xstable">
				<th class="xstable">결재자</th>
				<td  class="xstable" colspan="4">
					<table class="listTable table table-bordered ctable">
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
			<c:if test="${detail.memNo eq sesMemNo}">
				<c:if test="${detail.aprvStat eq 'AS01'}">
					<button type="button" id="btnReport" class="btn btn-ms btn-success">상신</button>
				</c:if>
				<c:if test="${detail.aprvStat eq 'AS02' || detail.aprvStat eq 'AS05'}">
					<button type="button" id="btnReportCancel" class="btn btn-danger">상신취소</button>
				</c:if>
				<c:if test="${detail.aprvStat eq 'AS04'}">
					<button type="button" id="btnRetryReport" class="btn btn-ms btn-success">재상신</button>
				</c:if>
				<c:if test="${detail.aprvStat eq 'AS01' || detail.aprvStat eq 'AS04'}">
					<button type="button" id="btnModify" class="btn btn-ms btn-warning">수정</button>
				</c:if>
				<c:if test="${detail.aprvStat eq 'AS01'}">
					<button type="button" id="btnDelete" class="btn btn-ms btn-danger">삭제</button>
				</c:if>
			</c:if>
		</div>
	</div>
</div>
</c:if>

<%-- 등록 및 수정 --%>
<c:if test="${mode != 'view' }">
<c:forEach items="${list }" var="list">
	<dt class="dtlData" data-dtm="${list.dtm }" data-money="${list.money }" data-purpose="${list.purpose }" data-usage="${list.usage }" data-content="${list.content }" data-etc="${list.etc }" data-person="${list.person }" />
</c:forEach>

<c:forEach items="${useExtList1 }" var="use">
	<dt class="useEx01" data-key="${use.COMMON_CODE_KEY }" data-value="${use.COMMON_CODE_VALUE }">
</c:forEach>

<c:forEach items="${useExtList2 }" var="use">
	<dt class="useEx02" data-key="${use.COMMON_CODE_KEY }" data-value="${use.COMMON_CODE_VALUE }">
</c:forEach>

<h1 class="page-header" hidden="true">비용처리 ${mode == 'update' ? '수정' : '등록' }</h1>
<div class="header">
	<div class="card">
		<ul>
			<li><span style="color:#ff4d4d; font-weight:bold; font-size:15px;">* </span>으로 표시된 항목은 필수 입력 사항입니다.</li>
			<li style="color:#ff4d4d; font-weight:bold;">사용금액 30만 초과시 사장님 결재가 필요합니다.</li>
		</ul>
		<ul id="notice_EX01" class="hidden">
			<li>용  도 : 식대비, 회의비, 회식비, 복리후생비, 도서구입비, 소모품비, 교통비, 숙박비, 통신비 등</li>			
			<li>인  원 : 사용 총 인원</li>				
			<li>비  고 : 카드사용시 개인카드, 법인카드 명기</li>
			<li style="color:#ff4d4d; font-weight:bold;">소모품비 결재시 구매한 소모품 내역이 영수증에 반드시 나와야 합니다.</li>
		</ul>
		<ul id="notice_EX02" class="hidden">
			<li>용  도 : 교통비, 유류대, 주차비, 접대비</li>			
			<li>인  원 : 사용 총 인원</li>				
			<li>비  고 : 카드사용시 개인카드, 법인카드 명기</li>
		</ul>
		<ul id="notice_EX03" class="hidden">
			<li>영수증이 없는 버스,전철이용시 대중교통비 양식을 첨부해서 경비청구시 제출하면됩니다.</li>
		</ul>
	</div>
	<div class="card card-plain">
		<form name="frm" id="frm" method="post" action="registerExpense" autocomplete="off">
			<input type="hidden" name="mode" id="mode" value="${mode}"/>
			<input type="hidden" name="exNo" value="${detail.exNo}"/>
			
			<c:if test="${mode eq 'update'}">
				<input type="hidden" name="memDept" value="${detail.memDept}"/>
				<input type="hidden" name="memGrade" value="${detail.memGrade}"/>
			</c:if>
			
			<table class="table table-bordered custom-table" style="border-width: 0px;">
				<colgroup>
					<col class="col-lg-1"/><col class="col-lg-4"/>
					<col class="col-lg-1"/><col class="col-lg-4"/>
				</colgroup>
				<tr>
					<th>소속<c:if test="${mode eq 'insert'}"><span style="color:red;">*</span></c:if></th>
					<td>${detail.memDeptNm}
						<c:if test="${mode eq 'insert'}">
							<select name="memDept" id="memDept" class="form-control" required>
								<option value="">- 선택 -</option>
								<c:forEach var="info" items="${memDeptList}">
									<option value="${info.COMMON_CODE_KEY}">${info.COMMON_CODE_VALUE}</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
					<th>직위*직급<c:if test="${mode eq 'insert'}"><span style="color:red;">*</span></c:if></th>
					<td>${detail.memGradeNm}
						<c:if test="${mode eq 'insert'}">
							<select name="memGrade" id="memGrade" class="form-control">
								<option value="">- 선택 -</option>
								<c:forEach var="info" items="${memGradeList}">
									<option value="${info.COMMON_CODE_KEY}">${info.COMMON_CODE_VALUE}</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>성명<c:if test="${mode eq 'insert'}"><span style="color:red;">*</span></c:if></th>
					<td colspan="4">${detail.memName}
						<c:if test="${mode eq 'insert'}">
							<select name="memNo" id="memNo" class="form-control">
								<option value="">- 선택 -</option>
								<c:forEach var="info" items="${memberList}">
									<option value="${info.memNo}" data-tel="${info.memTel}" data-dept="${info.memDept}" data-grade="${info.memGrade}">${info.memName}</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
				</tr>
				<tr>
					<th>연월<span style="color:red;">*</span></th>
					<td><input id="month" name="month" type="text" class="form-control" value="${fn:substring(detail.month, 0, 4) }년 ${fn:substring(detail.month, 4, 6) }월" readonly /></td>
					<th>구분<span style="color:red;">*</span></th>
					<td>${detail.exType }
						<select name="category" id="category" class="form-control">
							<option value="">- 선택 -</option>
							<c:forEach var="info" items="${exTypeList}">
								<option value="${info.COMMON_CODE_KEY}" ${info.COMMON_CODE_KEY == detail.category ? 'selected' : '' }>${info.COMMON_CODE_VALUE}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>내역<span style="color:red;">*</span></th>
					<td colspan="4" id="content">
						구분을 선택해주세요.
					</td>
				</tr>
				<tr>
					<th>결재자<span style="color:red;">*</span></th>
					<td colspan="4" id="approverArea"></td>
				</tr>
			</table>
			<div class="text-right">
				<button type="button" id="btnList" class="btn btn-ms btn-default">목록으로</button>
				<c:if test="${mode eq 'insert'}">
					<button type="button" id="btnInsert" class="btn btn-ms btn-success">임시저장</button>
				</c:if>
				<c:if test="${info.exDtl.memNo eq sesMemNo}">
					<c:if test="${mode eq 'update'}">
						<button type="button" id="btnUpdate" class="btn btn-ms btn-success">수정</button>
					</c:if>
				</c:if>
			</div>
		</form>
	</div>
</div>
</c:if>

<c:forEach var="memberInfo" items="${memberList}">
	<c:if test="${memberInfo.memNo ne sesMemNo}">
		<input type="hidden" class="approversData" value="${memberInfo.memNo}|${memberInfo.memName}"/>
	</c:if>
</c:forEach>
<c:forEach var="decidingOfficerInfo" items="${decidingOfficerList}">
	<input type="hidden" class="decidingOfficerData" value="${decidingOfficerInfo.memNo}"/>
</c:forEach>