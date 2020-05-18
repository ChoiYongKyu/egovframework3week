
<!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<style type="text/css">
img.mini {
	width: 100px;
	padding: 3px;
}
</style>
<h1 class="page-header" hidden="true">유지보수 수정</h1>
<div class="card card-plain">
	<form action="modify" method="post" encType="multiplart/form-data"
		id="form" name="fm">
		<table class="table table-bordered">
			<colgroup>
				<col class="col-lg-1" />
				<col class="col-lg-4" />
				<col class="col-lg-1" />
				<col class="col-lg-4" />
			</colgroup>

			<c:forEach var="modify" items="${modify }">
				<input type="text" hidden="" id="mn_no" value="${modify.MN_NO }"
					name="mn_no" />
				<input type="text" hidden="" id="mem_no3" value="${modify.MEM_NO }"/>
				<input type="text" hidden="" id="mn_group_no3" value="${modify.MN_GROUP_NO }"/>
				<tr>
					<th>고객사 <span style="color:red;">*</span></th>
					<td><select id="client_no" class="form-control"
						name="client_no">
							<option value="${modify.CLIENT_NO }">${modify.CLIENT_NAME }</option>
					</select></td>
					<th>
						작업상태
						<span style="color:red;">*</span>
					</th>
					<td>
						<div class="radio-group">
						<c:if test="${modify.MN_DONE == '1' }">
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="1" checked="checked"/>작업 예정
							</label>
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="2"/>작업 진행중
							</label>
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="3"/>작업 완료
							</label>
						</c:if>
						<c:if test="${modify.MN_DONE == '2' }">
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="1"/>작업 예정
							</label>
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="2" checked="checked"/>작업 진행중
							</label>
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="3"/>작업 완료
							</label>
						</c:if>
						<c:if test="${modify.MN_DONE == '3' }">
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="1"/>작업 예정
							</label>
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="2"/>작업 진행중
							</label>
							<label class="radio-inline">
								<input type="radio" class="jobStatus" name="jobStatus" value="3" checked="checked"/>작업 완료
							</label>
						</c:if>
						</div>
					</td>
				</tr>
				<tr>
					<th>업무구분 <span style="color:red;">*</span></th>
					<td><input type="hidden"
						value='<sec:authentication property="principal.mem_no" />'
						id='mem_non' /> <select id="work_scope_no" class="form-control"
						name="work_scope_no">

					</select>
						<input type="hidden" value="${modify.WORK_SCOPE_NO }" id="wsn" >
					</td>

					<th>작업 담당자 <span style="color:red;">*</span></th>
					<td>
						<label class="btn btn-sm btn-default"> 
							<input type="radio" class="hidden" name="chkVal" id="solo" value="1" checked> 개인
						</label> 
						<label class="btn btn-sm btn-default"> 
							<input type="radio" class="hidden" name="chkVal" id="group" value="2" /> 그룹
						</label> 
<%-- 						<input type="text" placeholder='<sec:authentication property="principal.mem_no" />' name="mem_no"  --%>
<%-- 								class="form-control" id="mem_no" value='<sec:authentication property="principal.mem_name" />'/>  --%>
						<select class="form-control" name="mem_no" id="mem_no">
							<c:forEach var="memberList" items="${memberList }">
								<option value="${memberList.MEM_NO }">${memberList.MEM_NAME }</option>
							</c:forEach>
						</select>
						<input type="hidden" value='<sec:authentication property="principal.mem_no" />' name="mem_no2" id="mem_no2"> 
						<select class="form-control" name="mn_group_no" id="mn_group_no" style="display: none;">
							
						</select>
					</td>


				</tr>
				<tr>
					<th>지원 요청자 <span style="color:red;">*</span></th>
					<td><input type="text" value="${modify.REQ_NAME }" placeholder="${modify.REQ_NO }" name="req_no"
						class="form-control" data-toggle="modal" data-target="#myModal"
						id="req_no" /> 
						<input type="hidden" value="" id="req_no2" name="req_no2"> <!-- The Modal -->
						<div id="myModal" class="modal">
							<!-- Modal content -->
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
									<h4 class="modal-title">지원요청자</h4>
								</div>
								<div class="modal-body">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>번호</th>
												<th>지원 요청자</th>
												<th>연락처</th>
												<th>이메일</th>
											</tr>
										</thead>
										<tbody id="req">
										</tbody>
									</table>
								</div>
								<div class="modal-footer">
									<button type="button" id="closeId" class="btn btn-default"
										data-dismiss="modal">닫기</button>
<!-- 									<button type="button" id="submitBtn" class="btn btn-primary">확인</button> -->
								</div>
							</div>
						</div> <!-- 모달 끝 --></td>
					<th>지원 형태 <span style="color:red;">*</span></th>
					<td><select id="support_no" class="form-control"
						name="support_no">
							<option value="-1">- 선택 -</option>
							<option value="1"
								<c:if test="${modify.SUPPORT_NO == '1'}">selected</c:if>>유선</option>
							<option value="2"
								<c:if test="${modify.SUPPORT_NO == '2'}">selected</c:if>>방문</option>
							<option value="3"
								<c:if test="${modify.SUPPORT_NO == '3'}">selected</c:if>>이메일</option>
							<option value="4"
								<c:if test="${modify.SUPPORT_NO == '4'}">selected</c:if>>VPN</option>
							<option value="5"
								<c:if test="${modify.SUPPORT_NO == '5'}">selected</c:if>>상주</option>
					</select></td>
				</tr>
				<tr>
					<th>지원 요청일 <span class="disable hidden" style="color:red;">*</span></th>
					<td>
						<input type="text" placeholder="" name="mn_req_date" value="${modify.MN_REQ_DATE }" class="form-control" id="mn_req_date" />
					</td>
					<th>지원 시작일 <span class="" style="color:red;">*</span></th>
					<td>
						<input type="text" name="mn_start_date" placeholder="필수 입력 사항입니다." value="${modify.MN_START_DATE }" class="form-control" id="mn_start_date" />
					</td>
				</tr>
				<tr>
					<th>지원일 수 <span class="disable hidden" style="color:red;">*</span></th>
					<td>
						<input type="text" name="mn_sup_days" value="${modify.MN_SUP_DAYS }" class="form-control" id="mn_sup_days" maxlength="5"/>
					</td>
					<th>지원 종료일 <span class="" style="color:red;">*</span></th>
					<td>
						<input type="text" name="mn_end_date" placeholder="필수 입력 사항입니다." value="${modify.MN_END_DATE }" class="form-control" id="mn_end_date" />
					</td>
				</tr>
				<tr>
					<th>지원항목 <span class="disable hidden" style="color:red;">*</span></th>
					<td colspan="4"><textarea cols="10" name="mn_sup_item" class="form-control" id="mn_sup_item" style="min-height:15rem; resize: vertical;">${modify.MN_SUP_ITEM } </textarea>
					</td>
				</tr>
				<tr>
					<th>참조사항</th>
					<td colspan="4"><textarea cols="10" name="mn_reference" class="form-control" id="mn_reference" style="min-height:15rem; resize: vertical;">${modify.MN_REFERENCE }</textarea>
					</td>
				</tr>

				<!-- 				<tr> -->
				<!-- 					<td colspan="4"> -->
				<!-- 						<button type="button" class="btn btn-xs btn-default" -->
				<!-- 							onclick="history.back()">취소</button> -->
				<!-- 						<button type="submit" id="submitBtn" -->
				<!-- 							class="btn btn-xs btn-success">확인</button> -->
				<!-- 					</td> -->
				<!-- 				</tr> -->

				<!-- 				<tr> -->
				<!-- 					<td colspan="4"> -->
				<!-- 						<button type="button" class="btn btn-xs btn-default" -->
				<!-- 							onclick="history.back()">취소</button> -->
				<!-- 						<button type="submit" id="submitBtn" -->
				<!-- 							class="btn btn-xs btn-default btn-success">확인</button> -->
				<!-- 					</td> -->
				<!-- 				</tr> -->
			</c:forEach>
<!-- 			<tr> -->
<!-- 				<td colspan="4"> -->
<!-- 					<div> -->
<!-- 						<label class="btn btn-xs btn-default " -->
<!-- 							style="margin: 3px 0 15px 0;"><input type="file" -->
<!-- 							id="imgFile" name="imgFile" class="hidden" -->
<!-- 							accept=".png, .jpg, .jpeg, .gif" multiple hidden="true">이미지 -->
<!-- 							추가</label> -->
<!-- 					</div> -->
<!-- 					<div id="imgView" class="col-md-10" -->
<!-- 						style="overflow: auto; height: 200px;"> -->

<%-- 						<c:forEach var="img" items="${imgAttach }"> --%>

<%-- 							<img src="..\download\ ${img.UPLOAD_AFTER}" title="${img.UPLOAD_BEFORE }" --%>
<!-- 								class="card card-user mini"> -->

<%-- 						</c:forEach> --%>
						
<!-- 					</div> -->

<!-- 				</td> -->
<!-- 			</tr> -->

		</table>
		<p class="pull-right">
			<button type="button" class="btn btn-ms btn-default"
				onclick="location.href='${ctx }/maintenance/list'">취소</button>
			<input type="submit" class="btn btn-ms btn-success" value="등록">
		</p>
	</form>
	<script>
	$('#form').submit(
			function(event) {
				event.preventDefault();
				var theForm = document.fm;
				var chkStatus = $('input[name=jobStatus]').val();
				if (theForm.client_no.value == "-1") {
					alert("고객사를 선택해주세요.");
					theForm.client_no.focus();
					return false;
				} else if (theForm.support_no.value == "-1") {
					alert("지원 형태를 선택해주세요.");
					theForm.support_no.focus();
					return false;
				} else if (theForm.work_scope_no.value == "- 선택 -") {
					alert("업무 구분을 선택해주세요.");
					theForm.work_scope_no.focus();
					return false;
				}  else if (theForm.req_no.value == "") {
					alert("지원 요청자를 입력해주세요.");
					theForm.req_no.focus();
					return false;
				} else if(chkStatus == 1){
					if (theForm.mn_start_date.value == "") {
						alert("지원 시작일을 입력해주세요.");
						theForm.mn_start_date.focus();
						return false;
					} else if (theForm.mn_end_date.value == "") {
						alert("지원 종료일을 입력해주세요.");
						theForm.mn_end_date.focus();
						return false;
					} else if (theForm.mn_sup_days.value == "") {
						alert("지원일 수를 입력해주세요.");
						theForm.mn_sup_days.focus();
						return false;
					} else if (theForm.mn_sup_item.value == "") {
						alert("지원 항목를 입력해주세요.");
						theForm.mn_sup_item.focus();
						return false;
					} else if (theForm.mn_req_date.value == "") {
						alert("지원 요청일을 입력해주세요.");
						theForm.mn_req_date.focus();
						return false;
					}
				}
// 					$('#req_no2').val( $('#req_no').prop('placeholder'));
					$('#mem_no2').val($('#mem_no').prop('placeholder'));
					
					var form = $('#form')[0];
					var formData = new FormData(form);

					console.log(formData);
					$.ajax({
						type : 'post',
						url : 'modify',
						processData : false,
						contentType : false,
						data : formData,
						// 							data : {
						// 								chkVal : $(
						// 										"input[type=radio][name=chk]:checked")
						// 										.val(),
						// 								client_no : $('#client_no').val(),
						// 								support_no : $('#support_no').val(),
						// 								work_scope_no : $('#work_scope_no').val(),
						// 								mn_req_date : $('#mn_req_date').val(),
						// 								req_no : $('#req_no').prop('placeholder'),
						// 								mem_no : $('#mem_no').prop('placeholder'),
						// 								mn_group_no : $('#mn_group_no').val(),
						// 								mn_start_date : $('#mn_start_date').val(),
						// 								mn_end_date : $('#mn_end_date').val(),
						// 								mn_sup_days : $('#mn_sup_days').val(),
						// 								mn_sup_item : $('#mn_sup_item').val(),
						// 								mn_reference : $('#mn_reference').val()
						// 							},
						dataType : 'json',
						success : function(data) {

 							console.log(data);
							alert('유지보수 글이 수정되었습니다.');
							history.back();
						},
						error : function(req) {
							console.log(req);
							alert('실패');
						}
					});
				
			});
	</script>
</div>
<!--  주 내용 끝  -->

<script>
	$(document).ready(function() {
		var client = $("#client_no").val();
		$.ajax({
			type : 'post',
			url : 'selectClientReq',
			data : 'client=' + client,
			dataType : "json",
			success : function(data) {
				getReqData(data);
			},
			error : function(req) {
				alert('실패');
			}
		});
		$.ajax({
			type : 'post',
			url : 'selectClientWorkScope',
			data : 'client=' + client,
			dataType : "json",
			success : function(data) {
				getWSData(data);
			},
			error : function(req) {
				alert('실패');
			}
		});
		
	});

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
		yearSuffix : '년', // timepicker 설정
		timeFormat : 'HH:mm:ss',
		controlType : 'select',
		oneLine : true,
	});
	$("#mn_start_date, #mn_end_date").datetimepicker(
			{
				dateFormat : 'yy-mm-dd',
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
						'8월', '9월', '10월', '11월', '12월' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				showMonthAfterYear : true, // timepicker 설정
				timeFormat : 'HH:mm:ss',
				controlType : 'select',
				oneLine : true,
			});
	$(function() {
		$("#mn_req_date").datepicker();
	});
	function modal() {
		$('#myModal').modal("hide");
	}
	// Get the modal
	var modal = document.getElementById('myModal');

	// Get the button that opens the modal
	var btn = document.getElementById("req_no");

// 	var submitBtn = document.getElementById("submitBtn");

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];
	var exitSpan = document.getElementById('closeId');
	// When the user clicks the button, open the modal 
	btn.onclick = function() {
		modal.style.display = "block";
	}

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
		modal.style.display = "none";
	}
	exitSpan.onclick = function() {
		modal.style.display = "none";
	}

// 	submitBtn.onclick = function() {
// 		modal.style.display = "none";
// 		var req = "";
// 		var reqno = [];
// 		for (var i = 0; i < checked.length; i++) {
// 			if (checked[i] != null) {
// 				var ss = checked[i].split('=');
// 				reqno[i] = ss[0];
// 				req += ss[1];
// 			}
// 		}
// 		btn.value = req;
// 		btn.placeholder = reqno;
// 		$('#req_no2').val(reqno);
// 	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}

	function getReqData(data) {
		var dVal = data;
		var html;
		for (var i = 0; i < dVal.length; i++) {
			html += '<tr class="trclick" id="req-' + i + '"><td>' + (i + 1) + '</td><td>'
			+ dVal[i].REQ_NAME + '</td><td>' + dVal[i].REQ_PHONE
			+ '</td><td>' + dVal[i].REQ_EMAIL
			+ '</td><td><input type="hidden" name="'+ dVal[i].REQ_NO + '" value="'
			+ dVal[i].REQ_NAME + '"></td></tr>';
		}
		$('#req').html(html);
	}
	
	$(function() {
		$(document).on('click', '.trclick', function(){
// 			alert('asdfasdfas');
			$('#req_no').val(this.children[1].textContent);
			$('#req_no2').val(this.children[4].children[0].name);
			
			console.log($('#req_no2').val(this.children[4].children[0].name));
			modal.style.display = "none";
		});
	});
	
	function getWSData(data) {
		var dVal = data;
		console.log(dVal);
		var html;
		var wsnVal = $('#wsn').val();
		var temp = "option[value=" + wsnVal + "]";
		html += '<option value="-1">' + "- 선택 -" + '</option>';
		for (var i = 0; i < dVal.length; i++) {
			html += '<option value="' + dVal[i].WORK_SCOPE_NO + '">'
					+ dVal[i].WORK_SCOPE_NAME + '</option>';
		}
		$('#work_scope_no').html(html);
// 		$(temp).attr('selected', 'selected');
		$('#work_scope_no').val(wsnVal);
	}
	function getGroupData(data) {
		var dVal = data;
		var html;
		html += '<option value="-1">' + "- 선택 -" + '</option>';
		console.log(dVal.length);
		for (var i = 0; i < dVal.length; i++) {
			html += '<option value="' + dVal[i].MN_GROUP_NO + '">'
					+ dVal[i].MN_GROUP_NAME + '</option>';
		}
		$('#mn_group_no').html(html);
		
		
		if($('#mem_no3').val() == null || $('#mem_no3').val() == ""){
			$('#mem_no').css('display', 'none');
			$('#mn_group_no').css('display', 'block');
			$('#mn_group_no').val($('#mn_group_no3').val());
			console.log('if'+$('#mn_group_no3').val());
			console.log($('#mn_group_no'));
			$('#group').parents()[0].classList.add('btn-fill');
			$('#solo').parents()[0].classList.remove('btn-fill');
			$('#group').prop('checked', true);
		}else{
			$('#mem_no').val($('#mem_no3').val());
			console.log('else'+$('#mem_no3').val());
		}
	}

	// 지원 요청자 split
// 	var checked = [];
// 	function checkMember(val) {
// 		var no = val.name.split('-')[1];
// 		var req_no = val.name.split('-')[2];
// 		var req_name = val.name.split('-')[3];
// 		if (val.checked) {
// 			checked[no] = req_no + '=' + req_name;
// 		} else {
// 			checked[no] = null;
// 		}
// 	}

	// 숫자만인지 체크하는 정규식
// 	function numberCheck() {
// 		var regNumber = /^[0-9]*$/;
// 		var supTimes = $('#mn_sup_days').val();

// 		if (!regNumber.test(supTimes)) {
// 			alert('숫자만 입력해주세요.');
// 			return false;
// 		} else {
// 			return true;
// 		}
// 	}
		
	$('input[value=2]').click(function() {
		$('#mem_no').css('display', 'none');
		$('#mn_group_no').css('display', 'block');

	});
	$('input[value=1]').click(function() {
		$('#mn_group_no').css('display', 'none');
		$('#mem_no').css('display', 'block');
	});

	$(function() {
		var mem_no = $('#mem_non').val();
		console.log(mem_no);

		$.ajax({
			type : 'post',
			url : 'getGroup',
			data : 'mem_no=' + mem_no,
			dataType : "json",
			success : function(data) {
				getGroupData(data);
			},
			error : function(req) {
				alert('작업 담당자 에러');
			}
		});
	});
	$('.mini').hover(function() {
		$(this).css('box-shadow', '0 5px 15px #eb5e28');

	}, function() {
		$(this).css('box-shadow', 'unset');
	});

	$('.mini').click(function() {
		if (confirm("삭제하시겠습니까?")) {
			var imgFile = $(this).attr('src');
			imgFile = imgFile.split('\ ');
			imgFile = imgFile[imgFile.length - 1];
			var thisis = $(this)
			$.ajax({
				type : 'post',
				url : 'deleteImg',
				data : 'upload_after=' + imgFile,
				dataType : "json",
				success : function(data) {
					thisis.addClass('hidden');
				},
				error : function(req) {
					alert('삭제 에러');
				}
			});
			// 		$(this).attr('hidden','true');
		} else {
			return;
		}
	});
	
	
	$('#imgFile').on('change', function(e) {

		handleImgFileSelect(e)

	});
	var testtes;
	function handleImgFileSelect(e) {
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		$('.newImage').remove();
		filesArr.forEach(function(f) {
					if (!f.type.match("image.*")) {
						alert("이미지 파일만 업로드 할 수 있습니다.");
						return;
					}
					var sel_file = [];
					sel_file.push(f);

					var reader = new FileReader();
					reader.onload = function(e) {
						
						var img_html = '<img class="card card-user mini newImage" title="'+files[0].name+'" src="'+e.target.result +'" />';
						// 				$("#img").attr('src', e.target.result);
						$('#imgView').append(img_html);
					}
					reader.readAsDataURL(f);
				});

	}
	
	$('input[name=jobStatus]').on('click',function () {
		console.log($('.jobStatus').val());
		if(this.value==0){
			$('.disable').addClass('hidden');
		}else{
			$('.disable').removeClass('hidden');
		}
	});
	
	// 시작일 입력하면 종료일 자동 입력..
	$('#mn_start_date').on('change', function() {
		var copyDate = $(this).val();
		$('#mn_end_date').val(copyDate);
	});
</script>