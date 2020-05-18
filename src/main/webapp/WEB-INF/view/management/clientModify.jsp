<!--             <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">고객사 수정</h1>
<div class="card card-plain">
	<form action="clientModify" method="post" name="fm">
		<table class="table table-bordered">
			<tbody>

				<tr>
					<th>고객사</th>
					<td><input type="text" name="client_name"
						value="${modify.CLIENT_NAME}" class="form-control"
						maxlength="15" readonly="readonly" /> <input type="text"
						hidden="" name="client_no" value="${modify.CLIENT_NO}"></td>
					<th>주소 <span style="color: red;">*</span></th>
					<td><input type="text" name="client_addr" onClick="goPopup();"
						id="roadFullAddr" value="${modify.CLIENT_ADDR}"
						class="form-control" maxlength="100" /></td>
				</tr>
<!-- 				<tr> -->
<!-- 					<th>지원 요청자 <span style="color: red;">*</span></th> -->
<!-- 					<td><input type="text" name="req_name" -->
<%-- 						value="${modify.REQ_NAME}" --%>
<!-- 						id="req_name" class="form-control" maxlength="10"/></td> -->
<!-- 					<th>연락처 <span style="color: red;">*</span></th> -->
<!-- 					<td><input type="text" name="req_phone" id="req_phone" maxlength="13" onkeyup="autoHypen()" -->
<%-- 						value="${modify.REQ_PHONE}" class="form-control"/></td> --%>
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>이메일 <span style="color: red;">*</span></th> -->
<!-- 					<td><input type="text" name="req_email" -->
<%-- 						value="${modify.REQ_EMAIL}" class="form-control" --%>
<!-- 						maxlength="30"/></td> -->
<!-- 				</tr> -->
				<tr>
					<th>계약 시작일 <span style="color: red;">*</span></th>
					<td><input type="text" class="form-control"
						name="client_start_date" value="${modify.CLIENT_START_DATE}"
						id="client_start_date" /></td>
					<th>계약 종료일 <span style="color: red;">*</span></th>
					<td><input type="text" class="form-control"
						name="client_end_date" value="${modify.CLIENT_END_DATE}"
						id="client_end_date" /></td>
				</tr>
				<tr>
					<th>연간 지원일 수 <span style="color: red;">*</span></th>
					<td><input type="text" class="form-control"
						name="client_sup_times" value="${modify.CLIENT_SUP_TIMES}"
						id="client_sup_times" maxlength="5" onkeyup="numberCheck();" /></td>
				</tr>
				<tr>
					<th>업무 구분 <span style="color: red;">*</span></th>
					<td colspan="4">
					<c:forEach items="${workScopeList }" var="workScope">
						<label class="checkbox-inline"> 
							<input type="checkbox" name="work_scope_no" value="${workScope.COMMON_CODE_KEY }">${workScope.COMMON_CODE_VALUE }
						</label>
					</c:forEach>
					
					
<!-- 					<label class="checkbox-inline"> <input -->
<!-- 							type="checkbox" name="work_scope_no" value="1">정기점검 -->
<!-- 					</label> <label class="checkbox-inline"> <input type="checkbox" -->
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
						<!-- 							관리</button>  모달 시작  --> <!-- 						<div class="modal fade" tabindex="-1" role="dialog" id="myModal"> -->
						<!-- 							<div class="modal-dialog" role="document"> --> <!-- 								<div class="modal-content"> -->
						<!-- 									<div class="modal-header"> --> <!-- 										<button type="button" class="close" data-dismiss="modal" -->
						<!-- 											aria-label="Close"> --> <!-- 											<span aria-hidden="true">&times;</span> -->
						<!-- 										</button> --> <!-- 										<h4 class="modal-title">업무구분</h4> -->
						<!-- 									</div> --> <!-- 									<div class="modal-body"> -->
						<!-- 										<label class="checkbox-inline"> <input type="checkbox">정기점검 -->
						<!-- 										</label> <label class="checkbox-inline"> <input -->
						<!-- 											type="checkbox">기술지원 --> <!-- 										</label> <label class="checkbox-inline"> <input -->
						<!-- 											type="checkbox">프로젝트 --> <!-- 										</label> <label class="checkbox-inline"> <input -->
						<!-- 											type="checkbox">오류해결 --> <!-- 										</label> <label class="checkbox-inline"> <input -->
						<!-- 											type="checkbox">인력추가 --> <!-- 										</label> <label class="checkbox-inline"> <input -->
						<!-- 											type="checkbox">유지보수 --> <!-- 										</label> <label class="checkbox-inline"> <input -->
						<!-- 											type="checkbox">회의 --> <!-- 										</label> -->
						<!-- 									</div> --> <!-- 									<div class="modal-footer"> -->
						<!-- 										<button type="button" class="btn btn-default" --> <!-- 											data-dismiss="modal">닫기</button> -->
						<!-- 										<button type="button" class="btn btn-primary">+ 항목 추가</button> -->
						<!-- 										<button type="button" class="btn btn-primary">확인</button> -->
						<!-- 									</div> --> <!-- 								</div> --> <!-- 								/.modal-content -->
						<!-- 							</div> --> <!-- 							/.modal-dialog --> <!-- 						</div> /.modal  모달 끝  -->
					</td>
				</tr>
				<tr>
					<th>비고</th>
					<td colspan="4">
						<textarea rows="13" cols="10" name="client_note" class="form-control">${modify.CLIENT_NOTE}</textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<button type="button" class="btn btn-xs btn-default"
							onclick="location.href='${ctx }/management/clientList'">취소</button>
						<button type="submit" class="btn btn-xs btn-default btn-success"
							onclick="">확인</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<!--  주 내용 끝  -->

<script>
    function modal() {
        $('#myModal').modal("hide");
    }
    /*  날짜 선택  */
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd'
        , prevText: '이전 달'
        , nextText: '다음 달'
        , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
        , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
        , dayNames: ['일', '월', '화', '수', '목', '금', '토']
        , dayNamesShort: ['일', '월', '화', '수', '목', '금', '토']
        , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토']
        , showMonthAfterYear: true
        , yearSuffix: '년'
    });
    $(function () {
        $("#client_start_date, #client_end_date").datepicker();
    });
    
    
    $(document).ready(function() { 
    	
    	var result = new Array();
    	<c:forEach items="${work}" var="info">
    		result.push(${info.WORK_SCOPE_NO});	 
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
    function numberCheck () {
        var regNumber = /^[0-9]*$/;
        var supTimes = $('#client_sup_times').val();

        if(!regNumber.test(supTimes)) {
            alert('숫자만 입력해주세요.');
            return false;
        } else {
        	return true;
        }
    }
    
    /* --- 주소 팝업 창 띄우기 --- */
	function goPopup(){
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("jusoPopup","pop","width=600,height=450, scrollbars=yes, resizable=yes"); 
		
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
   	function jusoCallBack(roadFullAddr){
   		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
   		document.fm.client_addr.value = roadFullAddr;
    }
</script>