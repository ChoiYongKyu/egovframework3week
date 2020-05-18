<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<script src="${ctx}/js/approver.js"></script>
<style>
@media( max-width: 768px ) {
	.custom-table tr,
	.custom-table th,
	.custom-table td {
		display: block;
	}
	
</style>


<h1 class="page-header" hidden="true">휴가신청</h1>
<div class="header">
	<div class="card">
		<ul><li><span style="color:#ff4d4d; font-weight:bold; font-size:15px;">* </span>으로 표시된 항목은 필수 입력 사항입니다.</li></ul>
	</div>
	<div class="card card-plain">
		<form name="frm" id="frm" method="post" action="${mode}Vacation" autocomplete="off">
			<input type="hidden" name="mode" id="mode" value="${mode}"/>
			<input type="hidden" name="vacNo" value="${vacationInfo.vacNo}"/>
			<table class="table table-bordered custom-table" style="border-width: 0px;">
				<colgroup>
					<col class="col-lg-1"/><col class="col-lg-4"/>
					<col class="col-lg-1"/><col class="col-lg-4"/>
				</colgroup>
				<tr>
					<th>소속<c:if test="${mode eq 'insert'}"><span style="color:red;">*</span></c:if></th>
					<td>${vacationInfo.memDeptNm}
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
					<td>${vacationInfo.memGradeNm}
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
					<th>연락처<span style="color:red;">*</span></th>
					<td><input type="tel" name="memTel" id="memTel" class="form-control" maxlength="13" value="${vacationInfo.memTel}"/></td>
					<th>성명<c:if test="${mode eq 'insert'}"><span style="color:red;">*</span></c:if></th>
					<td>${vacationInfo.memName}
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
					<th style="white-space: nowrap;">휴가 시작일<span style="color:red;">*</span></th>
					<td><input type="text" name="vacStartDt" id="vacStartDt" class="form-control" readonly value="${vacationInfo.vacStartDt}"/></td>
					<th style="white-space: nowrap;">휴가 종료일<span style="color:red;">*</span></th>
					<td><input type="text" name="vacEndDt" id="vacEndDt" class="form-control" readonly value="${vacationInfo.vacEndDt}"/></td>
				</tr>
				<tr>
					<th>휴가구분<span style="color:red;">*</span><img src="../img/questionmark.JPG" style="width: 25px;" onclick="javascript:$('#dialogProcessing').dialog('open');"/></th>
					<td>
						<div class="radio-group">
							<c:forEach var="info" items="${vacTypeList}" varStatus="status">
								<label class="radio-inline">
									<c:set var="checked" value=""/>
									<c:if test="${vacationInfo.vacType eq info.COMMON_CODE_KEY}">
										<c:set var="checked" value="checked"/>
									</c:if>
									<input type="radio" name="vacType" id="vacType${status.count}" value="${info.COMMON_CODE_KEY}" style="cursor:pointer;" ${checked}/>
									${info.COMMON_CODE_VALUE}
								</label>
							</c:forEach>
						</div>
					</td>
					<th>휴가일수<span style="color:red;">*</span></th>
					<td><input type="text" name="vacDays" id="vacDays" class="form-control" maxlength="3" value="${vacationInfo.vacDays}"/></td>
				</tr>
				<tr>
					<th>사유</th>
					<td colspan="4">
						<textarea cols="10" name="vacReason" class="form-control" id="vacReason" style="min-height:100px; resize:vertical;">${vacationInfo.vacReason}</textarea>
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
				<c:if test="${vacationInfo.memNo eq sesMemNo}">
					<c:if test="${mode eq 'update'}">
						<button type="button" id="btnUpdate" class="btn btn-ms btn-success">수정</button>
					</c:if>
				</c:if>
			</div>
		</form>
	</div>
</div>

<div id="dialogProcessing" title="경조휴가 &기타휴가" style="display:none;">
**경조휴가**<br/>
휴가일수는 휴일을 제외한 일수를 의미한다.<br/>
본가 및 처가에 한하여 적용하며 외가는 적용하지 아니한다.<br/>
<br/>
1. 본인 결혼 휴가 5일<br/>
2. 자녀 결혼 휴가 2일<br/>
3. 형제자매 결혼 휴가 1일<br/>
4. 본인 부모 회갑 및 칠순 휴가 1일<br/>
5. 장인장모 회갑 및 칠순 휴가 1일<br/>
6. 자녀 출생 휴가 3 ~ 5일<br/>
7. 부모 사망 휴가 5일<br/>
8. 장인장모 사망 휴가 5일<br/>
9. 배우자 사망 휴가 5일<br/>
10. 자녀 사망 휴가 5일<br/>
11. 형제자매 사망 휴가 3일<br/>
12. 본인 조부모 사망 휴가 3일<br/>
<br/>
**기타휴가**<br/>
예비군훈련, 민방위 훈련<br/>
</div>

<c:forEach var="memberInfo" items="${memberList}">
	<c:if test="${memberInfo.memNo ne sesMemNo}">
		<input type="hidden" class="approversData" value="${memberInfo.memNo}|${memberInfo.memName}"/>
	</c:if>
</c:forEach>
<c:forEach var="decidingOfficerInfo" items="${decidingOfficerList}">
	<input type="hidden" class="decidingOfficerData" value="${decidingOfficerInfo.memNo}"/>
</c:forEach>

<script>
$(document).ready(function() {
	$("#vacStartDt, #vacEndDt").datepicker(datePickerOption);

	$("#btnList").click(function() {
		location.href = "./list";
	});

	$("#btnInsert, #btnUpdate").click(function() {
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
		if($("#memTel").val() == "") {
			alert("연락처를 입력해주세요.");
			$("#memTel").focus();
			return;
		}
		if($("#vacStartDt").val() == "") {
			alert("휴가 시작일을 선택해주세요.");
			$("#vacStartDt").focus();
			return;
		}
		if($("#vacEndDt").val() == "") {
			alert("휴가 종료일을 선택해주세요.");
			$("#vacEndDt").focus();
			return;
		}
		if($("#vacStartDt").val() > $("#vacEndDt").val()) {
			alert("휴가 종료일은 시작일보다 빠를 수 없습니다.");
			$("#vacEndDt").focus();
			return;
		}
		if($(":input:radio[name='vacType']:checked").val() === undefined) {
			alert("휴가구분을 선택해주세요.");
			return;
		}
		if($("#vacDays").val() == "") {
			alert("휴가일수를 입력해주세요.");
			$("#vacDays").focus();
			return;
		}
		if(!isSelectedApprover()) {
			alert("결재자를 선택해주세요.");
			return;
		}

		$("#frm").submit();
	});

	$("#memNo").change(function() {
		var $memNo = $("#memNo option:selected");
		var tel = $memNo.data("tel");
		$("#memTel").val(tel != "google user"?tel:"");
		$("#memDept").val($memNo.data("dept"));
		$("#memGrade").val($memNo.data("grade"));
	});
	
	$("#memTel").keyup(function() {
		var memTel = $(this).val().replace(/[^0-9]/g, "");
		var memTelLen = memTel.length;
		if(memTelLen > 3  && memTelLen <= 7) {
 	       memTel = memTel.substr(0, 3) + "-" + memTel.substr(3);
		}
		else if(memTelLen > 7) {
	        memTel = memTel.substr(0, 3) + "-" + memTel.substr(3, 4) + "-" + memTel.substr(7);
	    }
		$(this).val(memTel);
	});
	
	$("#vacStartDt, #vacEndDt").change(function() {
		var vacStartDt = $("#vacStartDt").val();
		var vacEndDt = $("#vacEndDt").val();
		var diffDay = "";
		if(vacStartDt != "" && vacEndDt != "" && vacStartDt <= vacEndDt) {
			diffDay = diffDate(parseDate(vacStartDt), parseDate(vacEndDt));
		}
		$("#vacDays").val(diffDay);
	});
	
	$("#vacDays").keyup(function() {
		var vacDays = $(this).val().replace(/[^0-9]/g, "");
		$(this).val(vacDays);
	});

	$("#memNo").val("${sesMemNo}").trigger("change");//세션값 셋팅
	
	// 휴가 관련 다이얼로그
	$("#dialogProcessing").dialog({
		autoOpen: false,
		width: 'auto',
		height: 'auto',
		modal: true,
		resizable: false,
	});
	$(document).on('click', '.ui-widget-overlay, .ui-dialog', function() {
		$("#dialogProcessing").dialog("close");
	});
});

function parseDate(date) {
    var ymd = date.split("-");
    return new Date(ymd[0], ymd[1], ymd[2]);
}

function diffDate(first, second) {
    return Math.round((second - first) / (1000 * 60 * 60 * 24)) + 1;
}
</script>