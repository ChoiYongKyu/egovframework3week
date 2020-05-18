<!--             <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">프로젝트 등록</h1>
<div class="card card-plain">
	<form action="projectRegister" method="post" name="fm"> 
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th>프로젝트명 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="프로젝트명을 입력하세요." name="project_name" class="form-control" maxlength="50" />
					</td>
					
					<th>고객사 <span style="color: red;">*</span></th>
					<td>
						<select id="client_no" class="form-control" name="client_no">
							<option value="-1">- 선택 -</option>
							<c:forEach var="clientList" items="${clientList }">
								<option value="${clientList.CLIENT_NO }">${clientList.CLIENT_NAME }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>프로젝트 시작일 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="프로젝트 시작일을 입력하세요." 
							class="form-control" name="project_start_date" id="project_start_date" />
					</td>
					<th>프로젝트 종료일 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="프로젝트 종료일을 입력하세요. "
							class="form-control" name="project_end_date" id="project_end_date" />
					</td>
				</tr>
				<tr>
					<th>구분 <span style="color: red;">*</span></th>
					<td colspan="4">
					<c:forEach items="${projectScope }" var="project_scope">
						<label class="checkbox-inline"> 
							<input type="checkbox" name="project_scope_no" value="${project_scope.COMMON_CODE_KEY }">${project_scope.COMMON_CODE_VALUE }
						</label>
					</c:forEach>
					</td>
				</tr>
				<tr>
					<th>프로젝트 멤버 <span style="color: red;">*</span></th>
					<td colspan="4">
						<div class="form-control" data-toggle="modal" data-target="#myModal" id="" style="color:#e9e9e9">프로젝트 멤버를 선택해주세요.</div>
						<div>
							<table id="pj_table" class="table table-hover hidden">
								<thead>
									<tr>
										<th>번호</th>
										<th>사용자</th>
										<th>시작일</th>
										<th>종료일</th>
									</tr>
								</thead>
								<tbody id="addUser">
								</tbody>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<th>설명</th>
					<td colspan="4">
						<textarea cols="10" placeholder="내용을 입력하세요." name="project_explanation" class="form-control" style="min-height:130px; resize: vertical;"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<button type="button" class="btn btn-xs btn-default" onclick="location.href='${ctx }/management/projectList'">취소</button>
						<button type="button" class="btn btn-xs btn-default btn-success" onclick="checkVali();">등록</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<!--  주 내용 끝  -->

<!-- The Modal -->
<div id="myModal" class="modal">
	<!-- Modal content -->
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<h4 class="modal-title">사용자 리스트</h4>
		</div>
		<div class="modal-body">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>사용자</th>
						<th>이메일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${allList }" var="list">
						<tr class="getUser">
							<td style="display: none;"><input type="checkbox" value="${list.MEM_NO }"></td>
							<td>${list.MEM_NO }</td>
							<td>${list.MEM_NAME }</td>
							<td>${list.MEM_ID }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			<button type="button" id="submitbtn" class="btn btn-primary">확인</button>
		</div>
	</div>
</div>

<template id="test_temp">
	<tr>
		<td><input type="text" class="form-control" name="user_no" readonly></td>
		<td><input type="text" class="form-control" name="user_name" readonly></td>
		<td><input type="text" placeholder="프로젝트 시작일을 입력하세요." class="form-control person_date" name="user_start_date" /></td>
		<td><input type="text" placeholder="프로젝트 종료일을 입력하세요." class="form-control person_date" name="user_end_date"/></td>
	</tr>
</template>

<!-- 모달 끝 -->

<script type="text/javascript">
	/*  날짜 선택  */
	$.datepicker.setDefaults({
		dateFormat : 'yy-mm-dd',
		prevText : '이전 달',
		nextText : '다음 달',
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		showMonthAfterYear : true,
		yearSuffix : '년',
		timeFormat : 'HH:mm:ss',
		controlType : 'select',
		oneLine : true
	});
	
	$(document).on("click", ".license_register_date", function() {
		$(".license_register_date").datetimepicker({
			dateFormat : 'yy-mm-dd',
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			showMonthAfterYear : true, // timepicker 설정
			timeFormat : 'HH:mm:ss',
			controlType : 'select',
			oneLine : true,
		});
	});

	$(function() {
		$("#project_start_date, #project_end_date").datepicker();
		//         productList = ${productlist};
	});

	function checkVali(event) {
		theForm = document.fm;
		
		if (theForm.project_name.value == "") {
			alert("프로젝트명을 입력해주세요.");
			theForm.project_name.focus();
			return false;
		} else if (theForm.client_no.value < 0) {
			alert("고객사를 선택해주세요.");
			theForm.client_no.focus();
			return false;
		} else if (theForm.project_start_date.value == "") {
			alert("프로젝트 시작일을 선택해주세요.");
			theForm.project_start_date.focus();
			return false;
		} else if (theForm.project_end_date.value == "") {
			alert("프로젝트 종료일을 입력해주세요.");
			theForm.project_end_date.focus();
			return false;
		} else if (theForm.querySelectorAll('input[name=project_scope_no]:checked').length == 0) {
			alert("구분을 선택해주세요");
			return false;
		} else if (theForm.querySelector('#addUser').childNodes.length <= 1) {
			alert("프로젝트 멤버를 선택해주세요");
			return false;
		} else if (!validate_member($('.person_date'))) {
			return false;
		} else {
			theForm.submit();
			alert("프로젝트 등록이 완료되었습니다.");
		}
		
	}
	
	function validate_member(data) {
		var returnData = true;
		data.each(function() {
			if($(this).val() == "") {
				alert("멤버별 기간을 선택해주세요");
				returnData = false;
				return false;
			} 
		});
		return returnData;
	}
	
	$('div[data-target="#myModal"]').on('click', function() {
		if(document.fm.project_start_date.value == "" || document.fm.project_end_date.value == "") {
			alert("프로젝트 기간을 먼저 선택해주세요.");
			return false;
		} else {
			var check = $('.modal').find('input');
			check.each(function() {
				$(this).prop('checked', false);
				$('.getUser').css('background-color', 'white');
			});
		}
	});
	
	$('.getUser').on('click', function() {
		var check = $(this).find('input');
		
		if(check.is(':checked')) {
			check.prop('checked', false);			
			$(this).css('background-color', 'white');
		} else {
			check.prop('checked', true);
			$(this).css('background-color', '#c6b1d5');
		}
	});
	
	$('#submitbtn').on('click', function() {
		$('#addUser').empty();
		
		var users = [];
		var checked = $('.modal').find('input:checked');
		if(checked.length != 0) {
			$('#pj_table').removeClass('hidden');
			
			checked.each(function(i, k) {
// 				users[i] = {'no' : $(this).val(), 'name' : $(this).parent().siblings()[1].innerHTML};
				
				var temp = document.querySelector('#test_temp').content;
				temp.querySelectorAll('td')[0].querySelector('input').value = $(this).val();
				temp.querySelectorAll('td')[1].querySelector('input').value = $(this).parent().siblings()[1].textContent;
				temp.querySelectorAll('td')[2].querySelector('input').value = document.fm.project_start_date.value;
				temp.querySelectorAll('td')[3].querySelector('input').value = document.fm.project_end_date.value;
				var clone = document.importNode(temp, true);
				$('#addUser').append(clone);
				
				$("input[name=user_start_date]").datepicker();
				$("input[name=user_end_date]").datepicker();
			});
			
		} else {
			$('#pj_table').addClass('hidden');
		}
		
		$('.modal').hide();
	});
	
</script>