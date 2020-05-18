
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">고객사, 제품 별 통계</h1>

<div class="row">
	<div class="col-lg-6">
		<div class="card" style="padding:30px;">
			<div class="header">
				<div class="row">
					<div class="col-lg-5">
						<h3><b>제품 리스트</b></h3>
					</div>
					<sec:authorize access="hasRole('ADMIN')">
						<div class="pull-right">
							<button type="submit" class="btn btn-sm btn-default"
								onclick="location.href='/nos.mm/product/productRegister'">제품
								등록</button>
						</div>
					</sec:authorize>


				</div>
			</div>
			<div class="content">
				<div class=" table-resposive">
					<table class="table table-hover">
						<colgroup>
							<col class="col-lg-1">
							<col class="col-lg-3">
							<col width="*">
						</colgroup>
						<thead>
							<tr class="header">
								<td>번호</td>
								<td>제품 이름</td>
								<td>제품 정보</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="list" items="${list }">
								<tr
									onclick="location.href='${ctx }/product/productDetail?no=${list.PRODUCT_NO}'">
									<td>${list.RNUM }</td>
									<td>${list.PRODUCT_NAME }</td>
									<td><span>${list.PRODUCT_NOTE }</span></td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
	<div class="col-lg-6">
		<div class="col-lg-12">
			<div class="row" style="padding-left: 15px;">
				<div class="form-group col-lg-7 col-xs-10">
					<label><h4>고객사가 사용중인 제품 검색</h4></label> 
					<select name="client_no" class="form-control" id="client_no">
						<option value="0">- 선택 -</option>
						<c:forEach var="clientList" items="${clientList }">
							<option value="${clientList.CLIENT_NO }">${clientList.CLIENT_NAME }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div id="totalDiv" class="col-lg-12 noneDiv card" hidden="hidden">
				<div class="row">
					<div class=" col-xs-12 col-lg-6">
						<h4>사용중인 제품</h4>
						<ul id="usingProductList">
						</ul>
					</div>
					<div class=" col-xs-12 col-lg-6">
						<h4>제품별 개수</h4>
						<ul id="productCount">
						</ul>
					</div>
					
				</div>
				<div class="row">
					<div class=" col-xs-12 col-lg-12">
						<h4>사용중인 버전</h4>
						<ul id="usingVersionList">
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-lg-12 col-xs-10">
			<div class="row">
				<div class="form-group col-lg-7">
					<label><h4>사용중인 제품으로 고객사 검색</h4></label>
						<select name="product_no" class="form-control" id="product_no">
							<option value="0">- 선택 -</option>
							<c:forEach var="productList" items="${productList }">
								<option value="${productList.PRODUCT_NO }">${productList.PRODUCT_NAME }</option>
							</c:forEach>
						</select>
				</div>
			</div>
			<div id="totalDiv2" class="col-lg-12 noneDiv card" hidden="hidden">
				<h4>사용중인 고객사</h4>
				<ul id="usingClientList">
				</ul>
			</div>
		</div>
	</div>
</div>


<!--  주 내용 끝  -->

<script>
	$('select[name=client_no]').on('change', function() {
		var client_no = $('#client_no').val();
		console.log(client_no);
		if (client_no != 0) {
			$.ajax({
				type : 'post',
				url : 'selectClient',
				data : {
					client_no : client_no
				},
				dataType : "json",
				success : function(data) {
					$('#totalDiv').show();
					getClientList(data);
					getProductCount(data);
				},
				error : function(req) {
					alert('실패');
				}
			});
		} else {
			$('#totalDiv').hide();
		}
	});

	/* 고객사 셀렉트 제품리스트 */
	function getClientList(data) {
		var dVal = data;

		var html = ""; // var html;  --> 로 초기화 하면 첫칸에 undefind가 뜸
		for (var i = 0; i < dVal.product.length; i++) {
			html += '<li value="' + dVal.product[i].PRODUCT_NO.toString()
					+ '">' + dVal.product[i].PRODUCT_NAME.toString() + '</li>';
		}
		$('#usingProductList').html(html);
		html = ""; // var html;  다시 초기화
		/* -------------------------------------------------------------------------------------------------------------- */

		var temp = "";
		
		for (var i = 0; i < dVal.version.length; i++) {

			if (temp != dVal.version[i].PRODUCT_NAME) {
				console.log(dVal.version[i].VERSION_KIND);
				html += '</ol><li style="font-size:18px; font-weight:100;">' + dVal.version[i].PRODUCT_NAME+'</li><ol>';
			}
			if (dVal.version[i].VERSION_KIND == 1) {
				html += '<li>운영 ' + dVal.version[i].VERSION;
				temp = dVal.version[i].PRODUCT_NAME;
			} else {
				html += '<li>개발 ' + dVal.version[i].VERSION;
				temp = dVal.version[i].PRODUCT_NAME;
			}
			if(dVal.version[i].REMAINDAY >= -100 && dVal.version[i].REMAINDAY < 0){
				var color = 'orange';
				if(dVal.version[i].REMAINDAY >= -50){
					color = 'red';
				}
				html += ' - <span style="color:' + color + '">만료일이 ' + (-1 * dVal.version[i].REMAINDAY) + ' 일 남았습니다.</span></li>';
			} else if(dVal.version[i].REMAINDAY == null || dVal.version[i].REMAINDAY == "") {
				
			} else {
				html += ' - <span>만료일이 지났습니다.</span></li>';
			}
			// 		html += '<ol><li>' + dVal.version[i].VERSION + '</li></ol></li>';
			// 		temp = dVal.version[i].PRODUCT_NAME;
		}
		$('#usingVersionList').html(html);
	}

	function getProductCount(data) {
		var dVal = data;
		console.log(dVal);
		var html = ""; // var html;  --> 로 초기화 하면 첫칸에 undefind가 뜸
		for (var i = 0; i < dVal.count.length; i++) {
			html += '<li>' + dVal.count[i].PRODUCT_NAME + ' - '
					+ dVal.count[i].COUNT + '개' + '</li>';
			console.log(html);
		}
		$('#productCount').html(html);
	}

	$('select[name=product_no]').on('change', function() {
		var product_no = $('#product_no').val();
		console.log(product_no);
		if (product_no != 0) {
			$.ajax({
				type : 'post',
				url : 'selectProduct',
				data : {
					product_no : product_no
				},
				dataType : "json",
				success : function(data) {
					$('#totalDiv2').show();
					getProductList(data);
				},
				error : function(req) {
					alert('실패');
				}
			});
		} else {
			$('#totalDiv2').hide();
		}
	});

	/* 제품 셀렉트 */
	function getProductList(data) {
		var dVal = data;
		var html = ""; // var html;  --> 로 초기화 하면 첫칸에 undefind가 뜸
		for (var i = 0; i < dVal.length; i++) {
			html += '<li value="' + dVal[i].CLIENT_NO + '">'
					+ dVal[i].CLIENT_NAME + '</li>';
		}
		$('#usingClientList').html(html);
	}
</script>
<style>
/* li { */
/* 	/* 	list-style: none; */ */
	
/* } */

/* .usingDiv { */
/* 	float: left; */
/* } */

/* .noneDiv { */
/* 	/* 	display: none; */ */
/* 	margin-top: 10px; */
/* } */
</style>