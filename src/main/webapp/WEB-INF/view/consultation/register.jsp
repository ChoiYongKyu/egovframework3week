<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<script type="text/javascript" src="${ctx}/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<style>
input[type='checkbox'] { width:17px; height:17px; cursor:pointer; margin:0 5px 0 0; }
label { cursor:pointer; }
</style>
<script src="${ctx}/js/approver.js"></script>
<script>
var oEditors = [];
$(document).ready(function() {
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "cstnCn",
		sSkinURI: "${ctx}/se2/SmartEditor2Skin.html",
		fCreator: "createSEditor2"
	});
});
</script>
<h1 class="page-header" hidden="true">품의 신청</h1>
<div class="header">
	<div class="card">
		<ul><li><span style="color:#ff4d4d; font-weight:bold; font-size:15px;">* </span>으로 표시된 항목은 필수 입력 사항입니다.</li></ul>
	</div>
	<div class="card card-plain">	
		<form name="frm" id="frm" method="post" action="${mode}Consultation" autocomplete="off" encType="multipart/form-data">
			<input type="hidden" name="mode" id="mode" value="${mode}"/>
			<input type="hidden" name="cstnNo" value="${consultationInfo.cstnNo}"/>

			<table class="table table-bordered">
				<colgroup>
					<col class="col-lg-1"/><col class="col-lg-4"/>
					<col class="col-lg-1"/><col class="col-lg-4"/>
				</colgroup>
				<tr>
					<th style="white-space: nowrap;">작성일자</th>
					<td><input type="text" name="wrotDt" id="wrotDt" class="form-control" readonly value="${consultationInfo.wrotDt}"/></td>
					<th style="white-space: nowrap;">시행일자<span style="color:red;">*</span></th>
					<td><input type="text" name="enfcDt" id="enfcDt" class="form-control" readonly value="${consultationInfo.enfcDt}"/></td>
				</tr>
				<tr>
					<th>기안부서<c:if test="${mode eq 'insert'}"><span style="color:red;">*</span></c:if></th>
					<td>${consultationInfo.memDeptNm}
						<c:if test="${mode eq 'insert'}">
							<select name="memDept" id="memDept" class="form-control" required>
								<option value="">- 선택 -</option>
								<c:forEach var="info" items="${memDeptList}">
									<option value="${info.COMMON_CODE_KEY}" <c:if test="${consultationInfo.memDept eq info.COMMON_CODE_KEY}">selected</c:if>>${info.COMMON_CODE_VALUE}</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
					<th>기안자</th>
					<td>${consultationInfo.memName}</td>
				</tr>
				<tr>
					<th>제목<span style="color:red;">*</span></th>
					<td colspan="3"><input type="text" name="cstnTitle" id="cstnTitle" class="form-control" value="${consultationInfo.cstnTitle}"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<textarea name="cstnCn" id="cstnCn" class="form-control" style="width:100%; height:300px;">${consultationInfo.cstnCn}</textarea>
					</td>
				</tr>
				<tr>
					<th>첨부</th>
					<td colspan="3">
						<c:if test="${!empty consultationInfo.uploadNo}">
							<a href="${ctx}/file/download?no=${consultationInfo.uploadNo}" target="_blank">${consultationInfo.uploadBefore}</a>
							<div class="checkbox-inline">
								<input type="checkbox" name="uploadNo" id="uploadNo" value="${consultationInfo.uploadNo}"/><label for="uploadNo">삭제 시 체크</label>
							</div>
							<script>
							$(document).on("change", "#cstnAttach", function() {
								$("#uploadNo").attr("checked", $(this).val() != "");
							});
							</script>
						</c:if>
						<input type="file" name="cstnAttach" id="cstnAttach" class="form-control"/>
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
				<c:if test="${consultationInfo.memNo eq sesMemNo}">
					<c:if test="${mode eq 'update'}">
						<button type="button" id="btnUpdate" class="btn btn-ms btn-success">수정</button>
					</c:if>
				</c:if>
			</div>
		</form>
	</div>
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
	$("#wrotDt, #enfcDt").datepicker(datePickerOption);

	$("#btnList").click(function() {
		location.href = "./list";
	});

	$("#btnInsert, #btnUpdate").click(function() {
		if($("#enfcDt").val() == "") {
			alert("시행일자를 선택해주세요.");
			$("#enfcDt").focus();
			return;
		}

		if($("#mode").val() == "insert") {
			if($("#memDept").val() == "") {
				alert("기안부서를 선택해주세요.");
				$("#memDept").focus();
				return;
			}
		}

		if($("#cstnTitle").val() == "") {
			alert("제목을 입력해주세요.");
			$("#cstnTitle").focus();
			return;
		}

		if(!isSelectedApprover()) {
			alert("결재자를 선택해주세요.");
			return;
		}

		if($("#wrotDt").val() == "") {
			$("#wrotDt").val($.datepicker.formatDate("yy-mm-dd", new Date()));
		}

		oEditors.getById["cstnCn"].exec("UPDATE_CONTENTS_FIELD", []);

		$("#frm").submit();
	});
});
</script>