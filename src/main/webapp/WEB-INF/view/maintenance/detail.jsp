
<!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<style type="text/css">
img {
	max-height: 100vh;
	max-width: 100vx;
	width: inherit;
}

img.mini {
	width: 100px;
	padding: 3px;
}

</style>
<h1 class="page-header" hidden="true">유지보수 상세보기</h1>
<div class="header">
	<div class="card card-plain">
	<button class="commonBtn" style="width:75px;" onclick='allOpen();'>모두 열기</button>
	<button class="commonBtn" style="width:75px;" onclick='allClose();'>모두 닫기</button>
		<c:forEach var="detail" items="${detail }" varStatus="index">
			<div class="panel-group" id="accordion">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">
							<a data-toggle="collapse" data-parent="#accordion"
								href="#collapse${index.index }">${detail.CLIENT_NAME }
								${index.count }</a>
						</h4>
					</div>
					<div id="collapse${index.index }" class="panel-collapse collapse">
						<input type="text" hidden="true" value="${detail.MN_NO }">
						<h1 hidden="true">${detail.WRITE_DATE }</h1>

						<!-- 					<table class="table table-bordered"> -->
						<!-- 						<colgroup> -->
						<!-- 							<col class="col-lg-1" /> -->
						<!-- 							<col class="col-lg-4" /> -->
						<!-- 							<col class="col-lg-1" /> -->
						<!-- 							<col class="col-lg-4" /> -->
						<!-- 						</colgroup> -->

						<!-- 						<tbody> -->
						<!-- 							<tr> -->
						<%-- 								<th>고객사${mygroup }</th> --%>
						<%-- 								<td><span>${detail.CLIENT_NAME }</span></td> --%>
						<!-- 								<th>지원 형태</th> -->
						<%-- 								<td><span>${detail.SUPPORT_NAME }</span></td> --%>
						<!-- 							</tr> -->
						<!-- 							<tr> -->
						<!-- 								<th>업무구분</th> -->
						<%-- 								<td><span>${detail.WORK_SCOPE_NAME }</span></td> --%>
						<!-- 								<th>작업 담당자</th> -->
						<%-- 								<td><span>${detail.MEM_NAME }${detail.MN_GROUP_NAME }</span></td> --%>
						<!-- 							</tr> -->
						<!-- 							<tr> -->
						<!-- 								<th>지원 요청자</th> -->
						<%-- 								<td><span>${detail.REQ_NAME }</span></td> --%>
						<!-- 								<th>지원 요청일</th> -->
						<%-- 								<td><span>${detail.MN_REQ_DATE }</span></td> --%>
						<!-- 							</tr> -->
						<!-- 							<tr> -->
						<!-- 								<th>지원 시작일</th> -->
						<%-- 								<td><span>${detail.MN_START_DATE }</span></td> --%>
						<!-- 								<th>지원 종료일</th> -->
						<%-- 								<td><span>${detail.MN_END_DATE }</span></td> --%>
						<!-- 							</tr> -->
						<!-- 							<tr> -->
						<!-- 								<th>지원일 수</th> -->
						<%-- 								<td><span>${detail.MN_SUP_DAYS }</span></td> --%>
						<!-- 							</tr> -->
						<!-- 												<div class="form-group"> -->
						<%-- 													<label>고객사${mygroup }</label> <input type="text" --%>
						<!-- 														class="form-control border-input" -->
						<%-- 														value="${detail.CLIENT_NAME }"> --%>
						<!-- 												</div> -->
						<div class="">
							<div class="header">
								<%-- 								<h6>${detail.CLIENT_NAME }</h6> --%>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="col-lg-10">
										<div class="row">
											<div class="col-lg-6 col-xs-6">
												<div class="form-group">
													<label>지원 요청자 </label> 
<!-- 													<input type="text" -->
<!-- 														class="form-control border-input" -->
<%-- 														value="${detail.REQ_NAME }"> --%>
														<div id="goReqDetail" value="${detail.CLIENT_NO }">
															<pre><a style="cursor: pointer;">${detail.REQ_NAME }</a></pre>
														</div>
												</div>
											</div>
											<div class="col-lg-3 col-xs-6">
												<div class="form-group">
													<label>지원 형태</label> 
<!-- 													<input type="text" -->
<!-- 														class="form-control border-input" -->
<%-- 														value="${detail.SUPPORT_NAME }"> --%>
														<pre>${detail.SUPPORT_NAME }</pre>
												</div>
											</div>
											<div class="col-lg-3 col-xs-6">
												<div class="form-group">
													<label>작업상태</label> 
<!-- 													<input type="text" -->
<!-- 														class="form-control border-input" -->
<%-- 														value="${detail.SUPPORT_NAME }"> --%>
														<c:if test="${detail.MN_DONE_NO == 1 }">
															<pre>${detail.MN_DONE_NAME }</pre>
														</c:if>
														<c:if test="${detail.MN_DONE_NO == 2 }">
															<pre>${detail.MN_DONE_NAME }</pre>
														</c:if>
														<c:if test="${detail.MN_DONE_NO == 3 }">
															<pre>${detail.MN_DONE_NAME }</pre>
														</c:if>
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-10 hidden-xs">
										<div class="form-group ">
											<label>지원 요청일</label> 
<!-- 											<input type="text" -->
<!-- 												class="form-control border-input " -->
<%-- 												value="${detail.MN_REQ_DATE }"> --%>
												<pre>${detail.MN_REQ_DATE }</pre>
										</div>
									</div>
									<div class="col-lg-10 ">
										<div class="row">
											<div class="col-lg-6 col-xs-6">
												<div class="form-group">
													<label>작업 담당자</label> 
<!-- 													<input type="text" -->
<!-- 														class="form-control border-input" -->
<%-- 														value="${detail.MEM_NAME }${detail.MN_GROUP_NAME }"> --%>
														<pre>${detail.MEM_NAME }${detail.MN_GROUP_NAME }</pre>
												</div>
											</div>
											<div class="col-lg-6 col-xs-6">
												<div class="form-group">
													<label>업무구분</label> 
<!-- 													<input type="text" -->
<!-- 														class="form-control border-input" -->
<%-- 														value="${detail.WORK_SCOPE_NAME }"> --%>
														<pre>${detail.WORK_SCOPE_NAME }</pre>
												</div>
											</div>
										</div>
									</div>
									<div class="col-lg-7 col-xs-8">

										<div class="form-group">
											<label>지원일</label> 
<!-- 											<input type="text" -->
<!-- 												class="form-control border-input" -->
<%-- 												value="${detail.MN_START_DATE } ~ ${detail.MN_END_DATE }"> --%>
												<pre>${detail.MN_START_DATE } ~ ${detail.MN_END_DATE }</pre>
										</div>
									</div>
									<div class="col-lg-3 col-xs-4">

										<div class="form-group">
											<label>지원일 수</label> 
<!-- 											<input type="text" -->
<!-- 												class="form-control border-input" -->
<%-- 												value="${detail.MN_SUP_DAYS }"> --%>
												<pre>${detail.MN_SUP_DAYS }</pre>
										</div>
									</div>



								</div>
								<div class="col-lg-6">
										<div class="col-lg-10">
											<label>지원항목</label>
<!-- 											<textarea cols="10" class="form-control" rows="5" -->
<%-- 												style="resize: vertical;" readonly="readonly">${detail.MN_SUP_ITEM }</textarea> --%>
												<pre style="min-height: 11.5rem;"><c:out value="${detail.MN_SUP_ITEM }" escapeXml="true" /></pre>
										</div>
										<div class="col-lg-10">
											<br> <label>참조사항</label>
<!-- 											<textarea cols="10" class="form-control" rows="5" -->
<%-- 												style="resize: vertical;" readonly="readonly">${detail.MN_REFERENCE }</textarea> --%>
												<pre style="min-height: 11.5rem;"><c:out value="${detail.MN_REFERENCE }" escapeXml="true" /></pre>
									</div>
								</div>
							</div>
							<hr>
<!-- //////////////////// -->
<!-- 이미지 첨부  -->
<!-- 							<div class="row  hidden-xs"> -->
<!-- 								<div class="col-lg-10" style="overflow: auto; height: 120px;"> -->
<!-- 									<div class=" col-lg-10 form-gruop border-input"> -->
<%-- 										<c:forEach var="img" items="${detail.imgAttach }"> --%>
<!-- 											<img data-target="#layerpop" data-toggle="modal" -->
<%-- 												title="${img.UPLOAD_BEFORE }" id="imgClick" --%>
<%-- 												src="..\download\ ${img.UPLOAD_AFTER}" --%>
<!-- 												class="card card-user mini" -->
<%-- 												onclick="javascript: onClickImg( '${img.UPLOAD_AFTER}');"> --%>
<%-- 										</c:forEach> --%>
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
							
<!-- 							///////////////////////// -->

<!-- 파일첨부 -->
							<c:if test="${detail.PARENT_NO == 0}">

								<form action="" method="post" encType="multiplart/form-data" id="form">
									<input type="hidden" name="no" value="${detail.MN_NO }" />
									<input type="hidden" name="table" value="MAINTENANCE" />
								
									<div class="row">
										<div class="col-lg-6 ">
											<div class="card">
												<div class="alert">
												
													<ul class="pagination">
														<li><label>첨부파일</label></li>
													</ul>
													
													<table class="table table-hover">
														<c:forEach items="${fileList }" var="fileList">
															<tr>
																<td><a href="#this" name="file" id="${fileList.UPLOAD_NO }">${fileList.UPLOAD_BEFORE }</a></td>
																<td style="color: black;">${fileList.UPLOAD_TIME}</td> 
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
							</c:if>
						</div>
						
						<hr>
						<!-- 							<td colspan="4"> -->
						<div class="row">
							<div class="col-lg-11">
								<div class="col-lg-5 col-xs-7">
									<sec:authentication property="principal.mem_no" var="my_no" />
									<sec:authentication property="principal.auth_no" var="auth_no" />
									<c:choose>
										<c:when test="${detail.MEM_NO == my_no }">
											<button type="button" class="btn btn-xs btn-default"
												onclick="goModify(${detail.MN_NO})">수정하기</button>
											<button type="button"
												class="btn btn-xs btn-default btn-danger"
												onclick="doDelete(${detail.MN_NO})">삭제하기</button>
										</c:when>
										<c:when test="${auth_no == 1}">
											<button type="button" class="btn btn-xs btn-default"
												onclick="goModify(${detail.MN_NO})">수정하기</button>
											<button type="button"
												class="btn btn-xs btn-default btn-danger"
												onclick="doDelete(${detail.MN_NO})">삭제하기</button>
										</c:when>
										<c:otherwise>
											<c:forEach items="${myGroup }" var="my_group">
												<c:if test="${my_group.MN_GROUP_NO == detail.MN_GROUP_NO}">
													<button type="button" class="btn btn-xs btn-default"
														onclick="goModify(${detail.MN_NO})">수정하기</button>
													<button type="button"
														class="btn btn-xs btn-default btn-danger"
														onclick="doDelete(${detail.MN_NO})">삭제하기</button>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>

									<button type="button" class="btn btn-xs btn-default"
										onclick="history.back();">목록으로</button>
								</div>
								<div class="pull-right">
									<c:if test="${detail.PARENT_NO eq 0}">
										<button type="button" class="btn btn-xs btn-default"
											onclick="goReply(${detail.MN_NO});">이어쓰기</button>
									</c:if>
								</div>

							</div>
						</div>
						<hr>
						<!-- 								</td> -->
						<!-- 							</tr> -->
						<!-- 						</tbody> -->
						<!-- 					</table> -->
					</div>
				</div>
			</div>
		</c:forEach>

		<br> <br>


	</div>
</div>
<div class="modal fade" id="layerpop">
	<div id="modal-dialog" class="modal-dialog" style="width: max-content;">
		<div class="modal-content"
			style="width: max-content; overflow: hidden; width: auto; background-color: transparent; box-shadow: unset; border: none;">
			<!-- header -->

			<!-- body -->
			<div class="modal-body">
				<img class="card card-plain" src="" id="modal-img">
			</div>
			<!-- Footer -->

		</div>
	</div>
</div>





<!--  주 내용 끝  -->
<script>
	function goModify(key) {
		location.href="modify?no=" + key;
	}
	function goReply(key) {
		location.href="reply?no=" + key;
	}

	$('#goReqDetail').click(function() {
			var n = $(this).attr('value');
			
			location.href="${ctx}/management/clientDetail?no=" + n;
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
					
				}, errer : function(req) {
					alert('안되');
				}
			});
			location.href="list";
		} else {
			return false;
		}
		console.log(key);
	}
	
	$(function () {
//  		$('#collapse0').removeClass('panel-collapse collapse'); // 클래스가 panel-collapse collapse in 이면 열려있는상태 / 클래스가 없거나, in이 없으면 닫혀있는 상태
																// 부모 유지보수 글 정렬 후 0번째만 열리게함
 		$('#collapse0').addClass('in');
 		
 		
	});
	// 	function viewTd() { // 작업 담당자에 담당자명, 그룹명 히든처리 ... 일단 필요없어서 주석
// 		var solo = $('#solo').text();
// 		var group = $('#group').text();
// 		console.log(solo);
// 		console.log(group);
// 		if(solo == "") {
// 			$('#solo').css('display', 'none');
// 			$('#group').css('display', 'block');
// 		} else {
// 			$('#solo').css('display', 'block');
// 			$('#group').css('display', 'none');
// 		}
// 	}
// 	viewTd();

// $('#imgClick').on('click',function(){
//  alert("asldkfjasldkfj")
// 	console.log(this.getAttribute('src'));
// 	$('#modal-img').attr('src',this.getAttribute('src'));
// });

// $('#imgClick').click(function(){
// 	 alert("555")
// 		console.log(this.getAttribute('src'));
// 		$('#modal-img').attr('src',this.getAttribute('src'));
// 	});

function onClickImg(imgName){
// 	alert(imgName);
	console.log(this);
	var path = '..\\download\\' + imgName; 
	
	$('#modal-img').attr('src',path);
// 	modal-dialog
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
	
	function allOpen() {
		$('.collapse').addClass('in').css('height','');
	}
	function allClose() {
		$('.collapse').removeClass('in');
	}
	
	
	
	
	
	
	/* function modal() {
		$('#myModal').modal("hide");
	}
	// Get the modal
	var modal = document.getElementById('myModal');

	// Get the button that opens the modal
	var btn = document.getElementById("goReqDetail");

	// var submitBtn = document.getElementById("submitBtn"); Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	var exitSpan = document.getElementById('closeId');
	// When the user clicks the button, open the modal
	btn.onclick = function () {
		modal.style.display = "block";
	}

	// When the user clicks on <span> (x), close the modal
	span.onclick = function () {
		modal.style.display = "none";
	}
	exitSpan.onclick = function () {
		modal.style.display = "none";
	}

	// submitBtn.onclick = function() {  modal.style.display = "none";  var req = "";  var reqno = [];  for (var i = 0; i < checked.length; i++) {  if (checked[i] != null) {   var ss = checked[i].split('=');   reqno[i] = ss[0];   req += ss[1];  }  }
	// btn.value = req;  btn.placeholder = reqno;  $('[name=req_no2]').val(reqno); } When the user clicks anywhere outside of the modal, close it
	window.onclick = function (event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}

		$('#goReqDetail').on('click', function () {
			var client = $(this).val();

			if (client != 0) {
				$.ajax({
					type: 'post',
					url: 'selectClientReq',
					data: 'client=' + client,
					dataType: "json",
					success: function (data) {
						getReqData(data);
					},
					error: function (req) {
						alert('실패');
					}
				});
				$.ajax({
					type: 'post',
					url: 'selectClientWorkScope',
					data: 'client=' + client,
					dataType: "json",
					success: function (data) {
						getWSData(data);
					},
					error: function (req) {
						alert('실패');
					}
				});
			} else {
				alert('고객사를 선택해주세요.');
			}
		});
		function getReqData(data) {
			var dVal = data;
			var html;
			for (var i = 0; i < dVal.length; i++) {
				html += '<tr class="trclick" id="req-' + i + '"><td>' + (
					i + 1
				) + '</td><td>' + dVal[i].REQ_NAME + '</td><td>' + dVal[i].REQ_PHONE + '</td><td>' + dVal[i].REQ_EMAIL + '</td><td><input type="hidden" name="' + dVal[i].REQ_NO + '" value="' + dVal[i].REQ_NAME + '"></td></tr>';
			}
			$('#req').html(html);
		}

		$(function () {
			$(document).on('click', '.trclick', function () {
				//  alert('asdfasdfas');
				//$('#req_no').val(this.children[1].textContent);
				//$('#req_no2').val(this.children[4].children[0].name);
				modal.style.display = "none";
			});
		});
		// $('.trclick').click(function(){  alert(this.children().children().prop('value'));  $('#req_no').val(this.children().children().prop('value'));  $('#req_no2').val(this.children().children().prop('name')); });

		function getWSData(data) {
			var dVal = data;
			var html;
			html += '<option value="-1">- 선택 -</option>';
			for (var i = 0; i < dVal.length; i++) {
				html += '<option value="' + dVal[i].WORK_SCOPE_NO + '">' + dVal[i].WORK_SCOPE_NAME + '</option>';
			}
			$('#work_scope_no').html(html);
		}
		function getGroupData(data) {
			var dVal = data;
			var html;
			html += '<option value="-1">- 선택 -</option>';
			console.log(dVal.length);
			for (var i = 0; i < dVal.length; i++) {
				html += '<option value="' + dVal[i].MN_GROUP_NO + '">' + dVal[i].MN_GROUP_NAME + '</option>';
			}
			$('#mn_group_no').html(html);
		}
	 */
</script>