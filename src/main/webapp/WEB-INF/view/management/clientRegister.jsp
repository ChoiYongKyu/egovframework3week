<!--             <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">고객사 등록</h1>
<div class="card card-plain">
	<form action="clientRegister" method="post" name="fm" > 
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th>고객사 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="고객사를 입력하세요." name="client_name" class="form-control" maxlength="15" />
					</td>
					
					<th>주소 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="주소를 입력하세요." onClick="goPopup();" id="roadFullAddr" name="client_addr" class="form-control" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th>지원 요청자 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="지원 요청자를 입력하세요. " name="req_name" class="form-control" maxlength="10" />
					</td>
					
					<th>연락처 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="연락처를 입력하세요.(지원 요청자 전화번호) " name="req_phone" id="req_phone" 
								class="form-control" onkeyup="autoHypen()" maxlength="13" />
					</td>
				</tr>
				<tr>
					<th>이메일 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="이메일을 선택하세요. " name="req_email" class="form-control" maxlength="30" />
					</td>
				</tr>
				<tr>
					<th>계약 시작일 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="계약 시작일을 입력하세요." 
							class="form-control" name="client_start_date" id="client_start_date" />
					</td>
					<th>계약 종료일 <span style="color: red;">*</span></th>
					<td>
						<input type="text" placeholder="계약 종료일을 입력하세요. "
							class="form-control" name="client_end_date" id="client_end_date" />
					</td>
				</tr>
				<tr>
					<th>연간 지원일 수 <span style="color: red;">*</span></th>
					<td><input type="text" placeholder="연간 지원일 수 입력하세요"
						class="form-control" name="client_sup_times" id="client_sup_times"
						maxlength="5" onkeyup="numberCheck();" /></td>
				</tr>
				<tr>
					<th>업무 구분 <span style="color: red;">*</span></th>
					<td colspan="4">
					<c:forEach items="${workScope }" var="workScope">
						<label class="checkbox-inline"> 
							<input type="checkbox" name="work_scope_no" value="${workScope.COMMON_CODE_KEY }">${workScope.COMMON_CODE_VALUE }
						</label>
					</c:forEach>
<!-- 						<label class="checkbox-inline">  -->
<!-- 							<input type="checkbox" name="work_scope_no" value="1">정기점검 -->
<!-- 						</label>  -->
<!-- 						<label class="checkbox-inline">  -->
<!-- 							<input type="checkbox" name="work_scope_no" value="2">기술지원 -->
<!-- 						</label>  -->
<!-- 						<label class="checkbox-inline">  -->
<!-- 							<input type="checkbox" name="work_scope_no" value="3">프로젝트 -->
<!-- 						</label>  -->
<!-- 						<label class="checkbox-inline">  -->
<!-- 							<input type="checkbox" 	name="work_scope_no" value="4">오류해결 -->
<!-- 						</label>  -->
<!-- 						<label class="checkbox-inline">  -->
<!-- 							<input type="checkbox" name="work_scope_no" value="5">인력추가 -->
<!-- 						</label>  -->
<!-- 						<label class="checkbox-inline">  -->
<!-- 							<input type="checkbox" name="work_scope_no" value="6">유지보수 -->
<!-- 						</label>  -->
<!-- 						<label class="checkbox-inline">  -->
<!-- 							<input type="checkbox" name="work_scope_no" value="7">회의 -->
<!-- 						</label> -->
<!-- 						<label class="checkbox-inline">  -->
<!-- 							<input type="checkbox" name="work_scope_no" value="8">설치작업 -->
<!-- 						</label> -->
					</td>
				</tr>
				<tr>
					<th>비고</th>
					<td colspan="4">
						<textarea cols="10" placeholder="내용을 입력하세요. " name="client_note" class="form-control" style="min-height:130px; resize: vertical;"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<button type="button" class="btn btn-xs btn-default" onclick="location.href='${ctx }/management/clientList'">취소</button>
						<button type="button" class="btn btn-xs btn-default btn-success" onclick="checkVali();">등록</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<!--  주 내용 끝  -->

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
		$("#client_start_date, #client_end_date").datepicker();
		//         productList = ${productlist};
	});

	function checkVali() {
		theForm = document.fm;

		if (theForm.client_name.value == "" 
				|| theForm.client_addr.value == ""
				|| theForm.req_name.value == ""
				|| theForm.req_phone.value == ""
				|| theForm.req_email.value == ""
				|| theForm.req_email.value == ""
				|| theForm.client_start_date.value == ""
				|| theForm.client_end_date.value == ""
				|| theForm.client_sup_times.value == "") {
			if (theForm.client_name.value == "") {
				alert("고객사를 선택해주세요.");
				theForm.client_name.focus();
				return false;
			} else if (theForm.client_addr.value == "") {
				alert("주소를 입력해주세요.");
				theForm.client_addr.focus();
				return false;
			} else if (theForm.req_name.value == "") {
				alert("지원 요청자를 선택해주세요");
				theForm.req_name.focus();
				return false;
			} else if (theForm.req_phone.value == "") {
				alert("지원 요청자의 전화번호를 입력해주세요");
				theForm.req_phone.focus();
				return false;
			} else if (theForm.req_email.value == "") {
				alert("메일 주소를 입력해주세요");
				theForm.req_email.focus();
				return false;
			} else if (theForm.client_start_date.value == "") {
				alert("계약 시작을 입력해주세요");
				theForm.client_start_date.focus();
				return false;
			} else if (theForm.client_end_date.value == "") {
				alert("계약 종료일을 입력해주세요");
				theForm.client_end_date.focus();
				return false;
			} else if (theForm.client_sup_times.value == "") {
				alert("연간 지원일 수를 입력해주세요");
				theForm.client_sup_times.focus();
				return false;
			}
		} else {
			theForm.submit();
			alret("고객사 등록이 완료되었습니다.");
		}
	}

	// 전화번호 입력시 하이픈(-) 자동 입력
	function autoHypen() {
		var x = document.getElementById("req_phone");
		x.value = x.value.replace(/[^0-9]/g, '');
		var tmp = "";

		if (x.value.length > 3 && x.value.length <= 7) {
			tmp += x.value.substr(0, 3);
			tmp += '-';
			tmp += x.value.substr(3);
			x.value = tmp;
		} else if (x.value.length > 7) {
			tmp += x.value.substr(0, 3);
			tmp += '-';
			tmp += x.value.substr(3, 4);
			tmp += '-';
			tmp += x.value.substr(7);
			x.value = tmp;
		}
	}

	// 숫자만인지 체크하는 정규식
	function numberCheck() {
		var regNumber = /^[0-9]*$/;
		var supTimes = $('#client_sup_times').val();

		if (!regNumber.test(supTimes)) {
			alert('숫자만 입력해주세요.');
			return false;
		} else {
			return true;
		}
	}

	/* var list = [];
	var i = 0;
	function menuCheck(val) {
		if(val.checked) {
			list[i] = val.value;
			i++;
		} else {
			for(var j = 0; j < list.length; j++) {
				if(list[j] == val.value) {
					list.splice(j, 1);
				}
			}
		}
	   	console.log(list);
	   	console.log(list.length);
	}; */
	/* $("input[name=work_scope_no]:checked").each(function() {
			var listVal = $(this).val();
			if(val.checked) {
				list.push(listVal)
				console.log(list);
			} else {
				list.shift();
				console.log(list);
			}
	}); */
	/* var no = val.value;
	if(val.checked) {
		checked[no] = val.value;
	} else {
		checked[no] = null;
	}
	console.log(checked[no]); */

	/* --- 주소 팝업 창 띄우기 --- */
	function goPopup() {
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("jusoPopup", "pop", "width=600,height=450, scrollbars=yes, resizable=yes");
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	
	function jusoCallBack(roadFullAddr) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.fm.client_addr.value = roadFullAddr;
	}
	
</script>