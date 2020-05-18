<!-- 주 내용 시작 -->
<h1 class="page-header" hidden="true">문제 / 해결 게시판</h1>
<div class="card card-plain">
	<form action="insertModify" method="post" name="fm">
		<input type="hidden" value="${modify.TROUBLE_NO }" name="trouble_no"/>
		<div class="content">
			<div class="row">
				<div class="col-lg-10 card">
					<div class="header">
						<h4>참고정보</h4>
					</div>
					<div class="content">
						<div class="col-lg-3">
							<div class="form-group">
								<label>고객사</label>
								<select class="form-control border-input" name="cList" id="cList">
									<option value="0">- 선택 -</option>
									<c:forEach var="clientList" items="${clientList }">
										<option value="${clientList.CLIENT_NO }">${clientList.CLIENT_NAME }</option>
									</c:forEach>
								</select>
							</div>

						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label>제품</label>
								<select class="form-control border-input" name="pList" id="pList">
									<option value="0">- 선택 -</option>
								</select>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label>버전 종류</label>
								<select class="form-control border-input" name="vkList" id="vkList">
									<option value="0">- 선택 -</option>
									<option value="1">운영</option>
									<option value="2">개발</option>
								</select>
							</div>
						</div>
						<div class="col-lg-3">
							<div class="form-group">
								<label>버전</label>
								<select class="form-control border-input" name="vList" id="vList">
									<option value="0">- 선택 -</option>

								</select>
							</div>
						</div>
					</div>
					<div class="header">
						<h4>이슈</h4>
					</div>
					<div class="content">
						<div class="col-lg-12"></div>
						<div class="col-lg-12">
							<div class="form-group">
								<label>문제 내역<span style="color:red;">*</span>
								</label>
								<textarea cols="10" name="trouble_problem" class="form-control border-input">${modify.TROUBLE_PROBLEM }</textarea>
							</div>
						</div>

						<div class="col-lg-12">
							<div class="form-group">
								<label>내용<span style="color:red;">*</span>
								</label>
								<textarea cols="10" rows="17" name="trouble_answer" class="form-control border-input">${modify.TROUBLE_ANSWER }</textarea>
							</div>
						</div>
						<div class="col-lg-12">

							<button type="button" class="btn btn-xs btn-default" onclick="history.back();">취소</button>
							<button type="button" class="btn btn-xs btn-default btn-success" onclick="checkVali();">확인</button>

						</div>

					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<script>
	function checkVali() {
		theForm = document.fm;

		if (theForm.trouble_problem.value == "") {
			alert("문제를 입력해주세요.");
			theForm.trouble_problem.focus();
			return false;
		} else if (theForm.trouble_answer.value == "") {
			alert("해결을 입력해주세요.");
			theForm.trouble_answer.focus();
			return false;
		} else {
			alert("글 수정이 완료되었습니다.");
			theForm.submit();
		}
	}

	$('select[name=cList]').on('change', function () {
		var cList = $('#cList').val();
		$('#pList').html('<option>- 선택 -</option>');
		if (cList != 0) {
			$.ajax({
				type: 'post',
				url: 'selectClient',
				data: {
					cList: cList
				},
				dataType: "json",
				success: function (data) {
					getProduct(data);
				},
				error: function (req) {
					alert('실패');
				}
			});
		}
	});

	/* 제품 셀렉트 */
	function getProduct(data) {
		var dVal = data;
		console.log(dVal);
		var html = '<option value="0">- 선택 -</option>';
		for (var i = 0; i < dVal.length; i++) {
			html += '<option value="' + dVal[i].PRODUCT_NO + '">' + dVal[i].PRODUCT_NAME + '</option>';
		}
		$('#pList').html(html);
	}

	$('select[name=vkList]').on('change', function () {
		var cList = $('#cList').val();
		var pList = $('#pList').val();
		var vkList = $('#vkList').val();
		if (pList != 0) {
			$.ajax({
				type: 'post',
				url: 'selectProduct',
				data: {
					cList: cList,
					pList: pList,
					vkList: vkList
				},
				dataType: "json",
				success: function (data) {
					getVersion(data);
				},
				error: function (req) {
					alert('실패');
				}
			});
		} else {
			alert('제품을 선택해주세요.')
		}
	});

	//	/* 버전 가져오기 */
	function getVersion(data) {
		var dVal = data;
		var html = '<option value="0">- 선택 -</option>';
		for (var i = 0; i < dVal.length; i++) {
			html += '<option value="' + dVal[i].VERSION_NO + '">' + dVal[i].VERSION + '</option>';
		}
		$('#vList').html(html);
	}

	$(function () {
		$('#cList').val(${modify.CLIENT_NO}); // 고객사 세팅하기
		var cList = ${modify.CLIENT_NO};
		if (cList != 0) {
			$.ajax({
				type: 'post',
				url: 'selectClient',
				data: {
					cList: cList
				},
				dataType: "json",
				success: function (data) {
					getProduct(data);
					$('#pList').val(${modify.PRODUCT_NO}); // 제품 세팅하기
				},
				error: function (req) {
					alert('실패');
				}
			});
		}
		var pList = 0;
		var vkList = 0;
		if ('${modify.PRODUCT_NO}' != null || '${modify.PRODUCT_NO}' != '') {
			pList = '${modify.PRODUCT_NO}';
		}
		if ('${modify.VERSION_KIND}' != null || '${modify.VERSION_KIND}' != '') {
			vkList = '${modify.VERSION_KIND}';
		}
		if (pList != 0) {
			$.ajax({
				type: 'post',
				url: 'selectProduct',
				data: {
					cList: cList,
					pList: pList,
					vkList: vkList
				},
				dataType: "json",
				success: function (data) {
					getVersion(data);
					$('#vList').val(${modify.VERSION_NO}); // 버전 세팅하기
				},
				error: function (req) {
					alert('실패');
				}
			});
		}
		$('#vkList').val(${modify.VERSION_KIND}); // 버전 종류 세팅하기
	});
</script>

<%--
<table class="table table-bordered hidden-xs">
		<colgroup>
		<col width="10%">
		<col width="*">
		<col width="10%">
		<col width="*">
		</colgroup>
			<tbody>
				<tr>
					<th>고객사</th>
					<td>
						<select class="form-control" name="cList" id="cList">
							<option value="0">- 선택 -</option>
							<c:forEach var = "clientList" items="${clientList }">
								<option value="${clientList.CLIENT_NO }">${clientList.CLIENT_NAME }</option>
							</c:forEach>
						</select>
					</td>
					<th>제품 명</th>
					<td colspan="3">
						<select class="form-control" name="pList" id="pList">
							<option value="0">- 선택 -</option>
						</select>
					</td>
				</tr>

				<tr>
					<th>버전 종류</th>
					<td>
						<select class="form-control" name="vkList" id="vkList">
							<option value="0">- 선택 -</option>
							<option value="1">운영</option>
							<option value="2">개발</option>
						</select>
					</td>
					<th>버전</th>
					<td>
						<select class="form-control" name="vList" id="vList">
							<option value="0">- 선택 -</option>

						</select>
					</td>
				</tr>

				<tr>
					<th>문제 내역 <span style="color:red;">*</span></th>
					<td colspan="5">
						<textarea class="form-control" cols="150" rows="7" style="resize: vertical; overflow: auto;" wrap="soft" name="trouble_problem">${modify.TROUBLE_PROBLEM }</textarea>
						<pre>${modify.TROUBLE_PROBLEM }</pre>
					</td>
				</tr>
				<tr>
					<th>내용 <span style="color:red;">*</span></th>
					<td colspan="5">
						<textarea class="form-control" cols="150" rows="7" style="resize: vertical; overflow: auto;" wrap="soft" name="trouble_answer">${modify.TROUBLE_ANSWER }</textarea>
						<pre>${modify.TROUBLE_ANSWER }</pre>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<button type="button" class="btn btn-xs btn-default" onclick="history.back();">취소</button>
						<button type="button" class="btn btn-xs btn-default btn-success" onclick="checkVali();">확인</button>
					</td>
				</tr>
			</tbody>
		</table> --%>
