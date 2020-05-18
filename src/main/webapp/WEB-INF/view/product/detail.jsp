<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">제품 관리</h1>
<div class="container-fluid" style="padding-right:0px; padding-left:0px;">
<button type="button" class="btn btn-xs btn-default" onclick="history.back();" style="float:right;">뒤로가기</button>
	<div class="col-lg-9" style="margin-top: 40px;">
		<div class="card" style="padding:10px;">
			<div class="header">
				<p>${detail.PRODUCT_NAME }</p>
			</div>
			<div class="content">
				<span>${detail.PRODUCT_NOTE }</span>
			</div>
		</div>
	</div>
	<div class="col-lg-9">
		<div class="card" style="padding:10px;">
			<div class="header">
				<p>Version Management</p>
			</div>
			<div class="content">
				<form method="post" id="fm">
					<input type="hidden" name="product_no" id="product_no"
						value="${detail.PRODUCT_NO }">
					<table class="table">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="*">
							<col width="*">
							<col width="0%">
						</colgroup>
						<tr>
							<th>Kind</th>
							<th>Version</th>
							<th>Expire_Date</th>
							<th colspan="2">Note</th>

						</tr>
						<c:forEach items="${version }" var="version">
							<tr class="items" id="${version.VERSION_NO}">
								<td>
									<c:choose>
										<c:when test="${version.VERSION_KIND eq 1}">운영<input type="hidden" id="kind${version.VERSION_NO }" value="운영"></c:when>
										<c:when test="${version.VERSION_KIND eq 2}">개발<input type="hidden" id="kind${version.VERSION_NO }" value="개발"></c:when>
									</c:choose>
								</td>
								<td>${version.VERSION }
								</td>
								<td>${version.EXPIRE_DATE }
								</td>
								<td>${version.VERSION_NOTE }
								</td>
								<sec:authorize access="hasRole('ADMIN')">
									<td style="margin: 0px; padding: 0px" class="text-right hidden-xs">
										<div>
											<input type="hidden" class="form-control border-input" id="this_version${version.VERSION_NO }" readonly="readonly" value="${version.VERSION }">
											<input type="hidden" class="form-control border-input" id="this_expire_date${version.VERSION_NO }" readonly="readonly" value="${version.EXPIRE_DATE }">
											<input type="hidden" class="form-control border-input" id="this_version_note${version.VERSION_NO }" readonly="readonly" value="${version.VERSION_NOTE }">
											<a href="#" onclick="modifyConfirm(${version.VERSION_NO})" id="a${version.VERSION_NO }" class=" a${version.VERSION_NO }">
												수정
											</a>
											/
											<a href="#" onclick="deleteConfirm(${version.VERSION_NO})" id="a${version.VERSION_NO }" class=" a${version.VERSION_NO }">
												삭제　
											</a>
										</div>
									</td>
								</sec:authorize>
							</tr>
								
						</c:forEach>
						<sec:authorize access="hasRole('ADMIN')">
							<tr class="hidden-xs">
								<td>
									<select name="version_kind" id="version_kind" class="form-control border-input">
										<option value="1">운영</option>
										<option value="2">개발</option>
									</select>
								</td><td>
									<input type="text" name="version" id="version" class="form-control border-input" placeholder="Input Version">
								</td><td>
									<input type="text" name="expire_date" id="expire_date" class="form-control border-input timePick" placeholder="Input Expire Date(생략가능)">
								</td><td colspan="2">
									<input type="text" name="version_note" 	id="version_note" class="form-control border-input" placeholder="Input Note(생략가능)">
								</td>
							</tr>
							<tr class="text-right hidden-xs">
								<td colspan="6" style="border-top: none">
									<input type="hidden" value="0" name="add" id="add">
									<button type="button" class="btn btn-primary" onclick="addButton()">추가하기</button>
								</td>
								
							</tr>
						</sec:authorize>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
function addButton() {
	if (fm.version.value == "") {
		alert('버전을 입력하세요.');
		fm.version.focus();
		return false;
	}  else {
		fm.submit();
	}
}


$(".timePick").datetimepicker({
			dateFormat : 'yy-mm-dd',
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
					'8월', '9월', '10월', '11월', '12월' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true, // timepicker 설정
			timeFormat : 'HH:mm:ss',
			controlType : 'select',
			oneLine : true,
});
	
$('.items').hover(function() {
	$(this).css('box-shadow', '0 1px 2px #eb5e28');
	// 		alert($(this).attr('id'));
	var temp = '.a' + $(this).attr('id');
	// 		$(temp).removeClass('hidden');

}, function() {
	$(this).css('box-shadow', 'unset');
	var temp = '.a' + $(this).attr('id');
// 		$(temp).addClass('hidden');
});

function deleteConfirm(version_no){
	if(confirm('정말 삭제하시겠습니까?') == true){
		location.href="${ctx }/product/versionDelete?no="+version_no+"&pro=${detail.PRODUCT_NO }";
	}else{
		return;
	}
};

function modifyConfirm(version_no){
	var check = 'input[id=kind' + version_no + ']';
	if ($(check).val() == '개발'){
		$('#version_kind')[0].value = 2;
	} else {
		$('#version_kind')[0].value = 1;
	}
	var this_version = '#this_version'+version_no;
	var this_expire_date =  '#this_expire_date'+version_no;
	var this_version_note =  '#this_version_note'+version_no;
	$('#version').val($(this_version).val()).attr('readonly','readonly');
	$('#expire_date').val($(this_expire_date).val());
	$('#version_note').val($(this_version_note).val());
	$('#add').val('1');
	$('button[onclick*=add]').html('수정하기');
}
</script>