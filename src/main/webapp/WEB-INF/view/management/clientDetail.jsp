
<!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">고객사 보기</h1>
<div class="card card-plain">
	<div class="row">
		<div class="col-xs-11">
		<sec:authorize access="hasRole('ADMIN')">
			<button type="button" class="btn btn-sm btn-default"
				onclick="goProductRegister('${detail.CLIENT_NO}','${detail.CLIENT_NAME }');"
				style="float: right;">제품 버전 관리하기</button>
			<button type="button" class="btn btn-sm btn-default hidden-xs"
				onclick="goRequestorRegister('${detail.CLIENT_NO}','${detail.CLIENT_NAME }');"
				style="float: right;">지원요청자 관리</button>
		</sec:authorize>
		</div>
	</div>
<div class="content">
	<form action="" method="post" encType="multiplart/form-data" id="form">
	<!-- 앱에서 보기 -->
	<div class="col-xs-12 visible-xs-block" >
		<div class="row">
			<div class="form-group col-xs-6">
				<span>고객사</span>
				<input class="form-control" type="text" value="${detail.CLIENT_NAME }" readonly="readonly">
			</div>
			<div class="form-group col-xs-6">
				<span>지원 요청자</span>
				<input class="form-control" type="text" value="${detail.REQ_NAME }" readonly="readonly">
			</div>
		</div>
		<div class="form-group">
			<span>주소</span>
			<input class="form-control" type="text" value="${detail.CLIENT_ADDR }" readonly="readonly">
		</div>
		<div class="row">
			<div class="form-group col-xs-6">
				<span>연락처</span>
				<div style="clear:both:"></div>
				<div style="width: 85%;float: left;">
					<a href="tel:${detail.REQ_PHONE }" style="cursor: pointer;">
					<input class="form-control" type="text" value="${detail.REQ_PHONE }" readonly="readonly" style="color: #68B3C8;">
					</a>
				</div>
				<div style="float: right;">
					<a href="tel:${detail.REQ_PHONE }" ><img src="${ctx}/img/Phone-icon_32.png" alt="" style="margin-top: 3px;"></a>
				</div>
			</div>
			<div class="form-group col-xs-6">
				<span>이메일</span>
				<input class="form-control" type="text" value="${detail.REQ_EMAIL }" readonly="readonly">
			</div>
		</div>
		<div class="row">
			<div class="form-group col-xs-6">
				<span>계약 시작일</span>
				<input class="form-control" type="text" value="${detail.CLIENT_START_DATE }" readonly="readonly">
			</div>
			<div class="form-group col-xs-6">
				<span>계약 종료일</span>
				<input class="form-control" type="text" value="${detail.CLIENT_END_DATE }" readonly="readonly">
			</div>
		</div>
		<div class="form-group">
			<span>연간 지원일 수</span>
			<input class="form-control" type="text" value="${detail.CLIENT_SUP_TIMES }" readonly="readonly">
		</div>
		<div class="form-group">
			<span>업무 구분</span>
			<div class="form-control" readonly="readonly">
				<label class="checkbox-inline"> <input type="checkbox" name="work_scope_no" value="1">정기점검</label> 
				<label class="checkbox-inline"> <input type="checkbox" name="work_scope_no" value="2">기술지원</label>
				<label class="checkbox-inline"> <input type="checkbox" name="work_scope_no" value="3">프로젝트</label> 
				<label class="checkbox-inline"> <input type="checkbox" name="work_scope_no" value="4">오류해결</label>
			</div> 
			<div class="form-control"  readonly="readonly">
				<label class="checkbox-inline"> <input type="checkbox" name="work_scope_no" value="5">인력추가</label> 
				<label class="checkbox-inline"> <input type="checkbox" name="work_scope_no" value="6">유지보수</label> 
				<label class="checkbox-inline"> <input type="checkbox" name="work_scope_no" value="7">회의</label>
				<label class="checkbox-inline"> <input type="checkbox" name="work_scope_no" value="8">설치작업</label>
			</div>
		</div>
		<div class="form-group">
			<span>비고</span>
			<textarea class="form-control" cols="10" rows="5" style="resize: vertical;"  readonly="readonly">${detail.CLIENT_NOTE }</textarea>
		</div>
	</div>
	<!-- 앱에서 보기 끝 -->
	<div class="row">
		<input type="text" hidden="" value="${detail.REQ_NO }" />
		<input type="hidden" name="no" value="${detail.CLIENT_NO }" />
		<input type="hidden" name="table" value="CLIENT" />
		<table class="table table-bordered hidden-xs">
			<tbody>
				<tr>
					<th>고객사</th>
					<td><pre>${detail.CLIENT_NAME }</pre></td>
					<th>주소</th>
					<td colspan="3"><pre>${detail.CLIENT_ADDR }</pre></td>
				</tr>

				<tr>
					<th>지원 요청자</th>
					<td><pre>${detail.REQ_NAME }</pre></td>
					<th>연락처</th>
					<td><pre>${detail.REQ_PHONE }</pre></td>
					<th>이메일</th>
					<td><pre>${detail.REQ_EMAIL }</pre></td>
				</tr>

				<tr>
					<th>계약 시작일</th>
					<td><pre>${detail.CLIENT_START_DATE }</pre></td>
					<th>계약 종료일</th>
					<td><pre>${detail.CLIENT_END_DATE }</pre></td>
					<th>연간 지원일 수</th>
					<td><pre>${detail.CLIENT_SUP_TIMES }</pre></td>
				</tr>

				<tr>
					<th>업무구분</th>
					<td colspan="5">
					<c:forEach items="${workScopeList }" var="workScope">
						<label class="checkbox-inline"> 
							<input type="checkbox" name="work_scope_no" value="${workScope.COMMON_CODE_KEY }">${workScope.COMMON_CODE_VALUE }
						</label>
					</c:forEach>
<!-- 					<label class="checkbox-inline">  -->
<!-- 						<input type="checkbox" name="work_scope_no" value="1">정기점검 -->
<!-- 					</label>  -->
					
<!-- 					<label class="checkbox-inline"> <input type="checkbox" -->
<!-- 							name="work_scope_no" value="2">기술지원 -->
<!-- 					</label> <label class="checkbox-inline"> <input type="checkbox" -->
<!-- 							name="work_scope_no" value="3">프로젝트 -->
<!-- 					</label> <label class="checkbox-inline"> <input type="checkbox" -->
<!-- 							name="work_scope_no" value="4">오류해결 -->
<!-- 					</label> <label class="checkbox-inline"> <input type="checkbox" -->
<!-- 							name="work_scope_no" value="5">인력추가 -->
<!-- 					</label> <label class="checkbox-inline"> <input type="checkbox" -->
<!-- 							name="work_scope_no" value="6">유지보수 -->
<!-- 					</label> <label class="checkbox-inline"> <input type="checkbox" -->
<!-- 							name="work_scope_no" value="7">회의 -->
<!-- 					</label> <label class="checkbox-inline"> <input type="checkbox" -->
<!-- 							name="work_scope_no" value="8">설치작업 -->
<!-- 					</label> -->
					<!-- 						<button type="button" class="btn btn-xs btn-success" -->
						<!-- 							data-toggle="modal" data-target="#myModal" onclick="modal();">+ -->
						<!-- 							관리</button> --></td>
				</tr>
				<tr>
					<th>비고</th>
					<td colspan="5">
					<%-- 			<textarea class="form-control" cols="10" rows="5" style="resize: vertical;"  readonly="readonly">${detail.CLIENT_NOTE }</textarea> --%>
						<pre style="min-height: 15rem;">${detail.CLIENT_NOTE }</pre>
					</td>
				</tr>
				<!-- 				<tr> -->
				<!-- 					<th>제품명</th> -->
				<%-- 					<td><span>${detail.PRODUCT_NAME }</span></td> --%>
				<!-- 					<th>제품 버전</th> -->
				<%-- 					<td><span>${detail.VERSION }</span></td> --%>
				<!-- 					<th>라이센스 등록일</th> -->
				<%-- 					<td><span>${detail.LICENSE_REG_DATE }</span></td> --%>
				<!-- 				</tr> -->
				<!-- 				<tr> -->
				<!-- 					<th>라이센스 키</th> -->
				<%-- 					<td colspan="5"><span>${detail.LICENSE_KEY }</span></td> --%>
				<!-- 				</tr> -->
				<tr>
					<td colspan="6"><sec:authorize access="hasRole('ADMIN')">
							<button type="button" class="btn btn-xs btn-default"
								onclick="goClientModify(${detail.CLIENT_NO});">수정하기</button>
							<button type="button" class="btn btn-xs btn-default btn-danger"
								onclick="doDelete(${detail.CLIENT_NO});">삭제하기</button>
						</sec:authorize>
						<button type="button" class="btn btn-xs btn-default"
							onclick="location.href='clientList';">목록으로</button></td>
				</tr>

			</tbody>
		</table>
		
		
		</div>
		<div class="row">
			<div class="col-lg-6">
<!-- 			지도 표시부분 -->
				<div  id="map" style="width: 500px; max-width: 93vw; height: 400px;"></div>
			</div>
			<div class="col-lg-6 ">
<!-- 			첨부파일 표시 -->
				<div class="card">
					<div class="alert">
					
						<ul class="pagination">
							<li><label>첨부파일</label></li>
						</ul>
						
						<table class="table table-hover">
							<c:forEach items="${fileList }" var="fileList">
								<tr>
									<td><a href="#this" name="file" id="${fileList.UPLOAD_NO }">${fileList.UPLOAD_BEFORE }</a></td>
									<td style="color: black;">${fileList.UPLOAD_TIME }</td> 
									<sec:authorize access="hasRole('ADMIN')">
										<td><a href="#" name="delete" id="${fileList.UPLOAD_NO }" class="hidden-xs">삭제</a></td>
									</sec:authorize>
								</tr>
							</c:forEach>
						</table>
						
					</div>
				</div>
			</div>
			<sec:authorize access="hasRole('ADMIN')">
				<div class="col-lg-6 ">
					<div class="card">
						<div class="header">
							<div class="col-lg-6"><label>파일 첨부하기</label></div>
							<div class="col-lg-6 text-right"><label class="btn btn-xs btn-default" style="margin: 3px 0 15px 0;">
								<input type="file" id="Files" name="Files" class="hidden"  multiple hidden="true">
								파일 선택
								</label>
								<a href="#" id="fileUpload">파일추가</a>
							</div>
						</div>
						<div>
							<table class="table table-hover" id="fileList">
								<tr>
									
								</tr>
							</table>
						</div>
					</div>
				</div>
			</sec:authorize>
		</div>
	</form>
</div>
</div>
<!--  주 내용 끝  -->

<script>
$(document).ready(function() { 
	
	var result = new Array();
	<c:forEach items="${workScope}" var="info">
		result.push(${info.WORK_SCOPE_NO });	 
	</c:forEach>
	
	var chkbox = document.getElementsByName("work_scope_no");
	var chkboxLen = chkbox.length;
	
	if (chkboxLen == null || isNaN(chkboxLen)) {
		return;
	}
	for(var i=0;i < chkboxLen ; i++){ 
		for(var j = 0; j < result.length; j++){
			if(chkbox[i].value == result[j]){
				chkbox[i].checked = true;	
			}	
		}
	}
		
});

function doDelete(key) {
	if(confirm("정말 삭제하시겠습니까?")) {
		$.ajax ({
			type : 'get',
			url : 'deleteDetail',
			data : 
				{ no : key },
			dataType : "json",
			success : function(data) {
				console.log(data);
				console.log(data.success);
				
			}, error : function(req) {
				console.log('안되');
			}
		});
		location.href="clientList";
	} else {
		return false;
	}
	console.log(key);

}
	



	function goClientModify(key) {
		location.href="clientModify?no=" + key;
	}
	function goRequestorRegister(no, name) {
		console.log(no, name);
		location.href="requestorRegister?no=" + no + "&name=" + name;
	}
	function goProductRegister(no, name) {
		console.log(no, name);
		location.href="../product/requireProduct?no=" + no + "&name=" + name;
	}
	
	/////다음지도 api


$(document).ready(function(){
	if(!geocodeSeach()){
		keywordSeach();
	}
	
});
function geocodeSeach(){
	var x, y;
	var geocoder = new daum.maps.services.Geocoder();
	var address = '${detail.CLIENT_ADDR }';
	console.log(address);
	geocoder.addressSearch(address, function(result, status) {
		 console.log(daum.maps.services.Status.OK);
		 console.log(status);
		 console.log(result);
	    if (status === daum.maps.services.Status.OK) {
	         x = result[0].x;
	       	 y = result[0].y;
	        console.log(x+"//"+y);
	        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
					center: new daum.maps.LatLng(y, x), //지도의 중심좌표.
					level: 5 //지도의 레벨(확대, 축소 정도)
				};
			console.log(options.center);
			var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
			var marker = new daum.maps.Marker({
				    map: map,
				    position: new daum.maps.LatLng(y, x)
				});
			return true;
		    }else {return false;}
		});
}
function keywordSeach(){
	var x, y;
	var places = new daum.maps.services.Places();
	var address = '${detail.CLIENT_ADDR }';
	console.log(address);
	places.keywordSearch(address, function(result, status) {
		 console.log(daum.maps.services.Status.OK);
		 console.log(status);
		 console.log(result);
	    if (status === daum.maps.services.Status.OK) {
	         x = result[0].x;
	       	 y = result[0].y;
	        console.log(x+"//"+y);
	        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
			var options = { //지도를 생성할 때 필요한 기본 옵션
					center: new daum.maps.LatLng(y, x), //지도의 중심좌표.
					level: 5 //지도의 레벨(확대, 축소 정도)
				};
			console.log(options.center);
			var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
			var marker = new daum.maps.Marker({
				    map: map,
				    position: new daum.maps.LatLng(y, x)
				});
			return true;
	    }else {return false;}
		});
}
$('a[name=file]').on('click', function(e){
	e.preventDefault();
 	window.open("${ctx }/file/download?no=" + $(this).attr('id'),"_black");
});

$('a[name=delete]').on('click', function(e){
	e.preventDefault();
	if(confirm("파일을 삭제하시겠습니까?")) {
		var url = '${ctx }/file/delete?no=' + $(this).attr('id');
		$.ajax({
			type : 'get',
			url : url,
			dataType : 'json',
			success : function(data) {
				window.location.reload();
			},
			error : function(req) {
				console.log(req);
				console.log('실패');
			}
		});
	}else {
		return;
	}
});

$('#Files').on('change', function(e) {
	handleImgFileSelect(e)
});

function handleImgFileSelect(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	$('#fileList').empty();
	filesArr.forEach(function(f) {
		var sel_file = [];
		sel_file.push(f);
		var reader = new FileReader();
		reader.onload = function(e) {
			var filelist = '<tr><td>' + f.name + '</td><tr>';
			$('#fileList').append(filelist);
		}
		reader.readAsDataURL(f);
	});
}

$('#fileUpload').on('click',function(){
	var form = $('#form')[0];
	var formData = new FormData(form);
	
	console.log(formData);
	$.ajax({
		type : 'post',
		url : '${ctx}/file/upload',
		processData : false,
		contentType : false,
		data : formData,
		dataType : 'json',
		success : function(data) {
			window.location.reload();
		},
		error : function(req) {
			console.log(req);
			console.log('실패');
		}
	});
});
</script>