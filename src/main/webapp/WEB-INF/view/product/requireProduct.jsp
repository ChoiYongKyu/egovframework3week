
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">제품 등록</h1>
<div class="container-fluid">
<div class="card card-plain">
	<form action="requireProduct" method="post" name="fm">
		<input type="hidden" value="${client_no }" name="client_no" id="client_no"> 
		<input type="hidden" value="${client_name }" name="client_name" id="client_name">
		<input type="hidden" value="" name="license_no" id="license_no">
		<button type="button" class="btn btn-xs btn-default" onclick="location.href='../management/clientList';" style="float:right;">목록</button>
		<button type="button" class="btn btn-xs btn-default" onclick="history.back();" style="float:right;">업체 보기</button>
		<table class="table hidden-xs" id="myTable">
			<thead>
				<tr>
					<td>
						<h5>${client_name } 요구 제품 등록</h5>
					</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>제품명 <span style="color: red;">*</span></th>
					<th>버전 종류 <span style="color: red;">*</span></th>
					<th>제품 버전 <span style="color: red;">*</span></th>
					<th>라이센스 등록일 <span style="color: red;">*</span></th>
					<th>비고</th> <!-- 라이센스 키 >> 비고로 변경  -->
					<th>추가</th>
				</tr>
				<tr>
					<td><select class="form-control" name="product_no"
						id="input_product_no">
							<option value="0">- 선택 -</option>
							<c:forEach var="productList" items="${productList }">
								<option value="${productList.PRODUCT_NO}">${productList.PRODUCT_NAME }</option>
							</c:forEach>
					</select></td>
					<td><select class="form-control" name="version_kind"
						id="input_version_kind">
							<option value="0">- 선택 -</option>
							<option value="1">운영</option>
							<option value="2">개발</option>
					</select></td>
					<td><select class="form-control" name="version_no"
						id="input_version_no">

					</select></td>
					<td><input type="text" class="form-control license_reg_date"
						name="license_reg_date" id="input_license_reg_date" /></td>
					<td><input type="text" class="form-control" name="license_key"
						id="input_license_key"></td>
					<td>
						<input type="hidden" value="0" name="add" id="add">
						<button type="button" class="btn btn-primary" id="btn"
							onclick="addButton()">추가하기</button>
					</td>
				</tr>

			</tbody>
		</table>
	</form>

	<!-- 사용중인 버전 리스트 -->
	<div class="col-lg-10 col-md-10">
		<div class="card">
			<div class="header">
				<div class="row">
					<div class="col-lg-5">
						<p>제품 리스트</p>
					</div>
				</div>
			</div>
			<div class="content">
				<div class=" table-resposive">
					<table class="table table-hover">
						<colgroup>
							<col width="15%">
							<col width="10%">
							<col width="8%">
							<col width="25%" class="hidden-xs">
							<col width="*" class="hidden-xs">
						</colgroup>
						<thead>
							<tr class="header">
								<td>제품명</td>
								<td>버전 종류</td>
								<td>제품 버전</td>
								<td class="hidden-xs">라이센스 등록일</td>
								<td class="hidden-xs">비고</td><!-- 라이센스 키 >> 비고로 변경  -->
								<td class="hidden-xs">수정 / 삭제</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="list" items="${list }">
								<tr>
									<td id="product_no_${list.LICENSE_NO }" name="${list.PRODUCT_NO}">${list.PRODUCT_NAME }</td>
									<td id="version_kind_${list.LICENSE_NO }"><c:choose>
											<c:when test="${list.VERSION_KIND eq 1}">운영</c:when>
											<c:when test="${list.VERSION_KIND eq 2}">개발</c:when>
										</c:choose></td>
									<td id="version_no_${list.LICENSE_NO }">${list.VERSION }</td>
									<td id="license_reg_date_${list.LICENSE_NO }" class="hidden-xs">${list.LICENSE_REG_DATE }</td>
									<td id="license_key_${list.LICENSE_NO }"  class="hidden-xs">${list.LICENSE_KEY }</td>
									<td class="hidden-xs">
										<button style="border: none; background: none;"
											onclick="rowModify(${list.LICENSE_NO },${list.VERSION_NO });">
											<img alt="" src="../img/edit.png">
										</button>
										<button style="border: none; background: none;"
											onclick="rowDelete(${list.PRODUCT_NO },${list.LICENSE_NO });">
											<img alt="" src="../img/trash.png">
										</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
</div>
</div>
<!--  주 내용 끝  -->

<script>
	/*  날짜 선택  */
	$.datepicker.setDefaults({
		dateFormat : 'yy-mm-dd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
				'9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		showMonthAfterYear : true,
		yearSuffix : '년',
		timeFormat : 'HH:mm:ss',
		controlType : 'select',
		oneLine : true
	});
	$(".license_reg_date").datetimepicker({
		dateFormat : 'yy-mm-dd',
		monthNamesShort : [ '1월', '2월', '3월', '4월',
				'5월', '6월', '7월', '8월', '9월',
				'10월', '11월', '12월' ],
		dayNamesMin : [ '일', '월', '화', '수', '목',
				'금', '토' ],
		showMonthAfterYear : true, // timepicker 설정
		timeFormat : 'HH:mm:ss',
		controlType : 'select',
		oneLine : true,
	});

	//	var productList;
	$(function() {
		$("#client_start_date, #client_end_date").datepicker();
		//     productList = ${productlist};
	});

	
	function addButton() {
		if (fm.product_no.value == "") {
			alert('제품을 선택하세요.');
			fm.product_no.focus();
			return false;
		} else if (fm.version_kind.value == "") {
			alert('버전 종류를 선택하세요.');
			fm.version_kind.focus();
			return false;
		} else if (fm.version_no.value == "") {
			alert('제품 버전을 선택하세요.');
			fm.version_no.focus();
			return false;
		} else if (fm.license_reg_date.value == "") {
			alert('등록일을 설정하세요.');
			fm.license_reg_date.focus();
			return false;
		} else {
			fm.submit();
		}
	}
	
	/* 제품명, 버전 종류 선택하기 */
	$('select[name=version_kind]').on('change', function() {
		var productNo = fm.product_no.value;
		var version_kind = fm.version_kind.value;
		if (productNo != 0) {
			$.ajax({
				type : 'post',
				url : 'selectVersion',
				data : {productNo : productNo,
						versionKind : version_kind},
				dataType : "json",
				success : function(data) {
					getVersion(data);
				},
				error : function(req) {
					alert('실패');
				}
			});
		} else {
			alert("제품명을 선택해주세요.");
		}
	});
	
	/* 제품 버전 셀렉트 */
	function getVersion(data) {
		var dVal = data;
		var html;
		for (var i = 0; i < dVal.length; i++) {
			html += '<option value="' + dVal[i].VERSION_NO + '">'
					+ dVal[i].VERSION + '</option>';
		}
		$('#input_version_no').html(html);
	} 
	
	/* 제품 삭제하기 */
	function rowDelete(product_no, license_no) {
		if(confirm('정말 삭제하시겠습니까?') == true){
			location.href="${ctx }/product/requireDelete?pNo=" + product_no + "&lNo=" + license_no + "&cNo=${client_no}&cName=${client_name}";
		}else{
			return;
		}
	}
	
	/* 제이쿼리로 수정할 값 가져오기 */
	function rowModify(license_no, version_no) {
		$('#license_no').val(license_no);
		
		var nameCondition = '#product_no_' + license_no;
		var name = $(nameCondition).text();
		
		var kindCondition = '#version_kind_' + license_no; 
		var kind = $(kindCondition).text();

		var versionCondition = '#version_no_' + license_no;
		var version = $(versionCondition).text();
		
		var dateCondition = '#license_reg_date_' + license_no;
		var date = $(dateCondition).text();
		
		var keyCondition = '#license_key_' + license_no;
		var key = $(keyCondition).text();
		
		
		$('#input_product_no')[0].value=$(nameCondition).attr('name');
		
		
		if(kind.indexOf('운영')!=-1) {
			$('#input_version_kind')[0].value = 1;
		} else {
			$('#input_version_kind')[0].value = 2;
		}
		
		$.ajax({
			type : 'post',
			url : 'selectVersion',
			data : {productNo : $(nameCondition).attr('name'),
					versionKind : $('#input_version_kind')[0].value},
			dataType : "json",
			success : function(data) {
				getVersion(data);
				$('#input_version_no').val(version_no);
			},
			error : function(req) {
				alert('실패');
			}
		});
// 		$('#input_version_no').html('<option value=' + version_no + '>' + version + '</option>');
		$('#input_license_reg_date').val(date);
		$('#input_license_key').val(key);
		$('#add').val('1');
		$('button[onclick*=add]').html('수정하기');
	}
</script>