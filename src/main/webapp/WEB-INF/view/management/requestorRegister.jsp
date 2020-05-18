<!--             <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
                <!--  주 내용 시작  -->
                <h1 class="page-header" hidden="true">지원 요청자 추가</h1>
                <div class="card card-plain">
                <form action="requestorRegister" method="post" name="fm">
                <input type="hidden" value="" name="req_no" id="req_no">
                <input type="hidden" value="${param.name }" name="client_name">
                    <table class="table table-bordered">
                        <tbody>
                        	<h3>${param.name }</h3>
                                <tr>
                                    <th>지원 요청자 <span style="color:red;">*</span></th>
                                    <td><input type="text" hidden="" id="client_no" name="client_no" value="${param.no }" />
                                    <input type="text" placeholder="이름을 입력하세요. " id="req_name" name="req_name" class="form-control" maxlength="10" /></td>
                                    <th>직책</th>
                                    <td><input type="text" placeholder="직책을 입력하세요.(생략가능) " id="req_rank" name="req_rank" class="form-control" maxlength="5"/></td>
                                    <th>연락처 <span style="color:red;">*</span></th>
                                    <td colspan="4"><input type="text" placeholder="연락처를 입력하세요. " name="req_phone" id="req_phone" class="form-control" onkeyup="autoHypen();" maxlength="13"/></td>
                                </tr>
                                <tr>
                                    <th>이메일 <span style="color:red;">*</span></th>
                                    <td><input type="text" placeholder="이메일를 입력하세요. " id="req_email" name="req_email" class="form-control" maxlength="30"/></td>
                                    <th>비고</th>
                                    <td colspan="4"><input type="text" placeholder="비고를 입력하세요. " id="req_note" name="req_note" class="form-control" /></td>
                                </tr>
                                <tr>
                                    <td colspan="10">
                                        <button type="button" class="btn btn-xs btn-default" onclick="location.href='clientList';">목록</button>
                                        <button type="button" class="btn btn-xs btn-default" onclick="history.back();">업체 보기</button>
                                        <span>
                                        <input type="hidden" value="0" name="add" id="add">
                                        <button type="button" class="btn btn-xs btn-default" onclick="checkVali();">저장</button>
                                        </span>
                                    </td>
                                </tr>
                        </tbody>
                    </table>
                </form>
                </div>
                <h3>지원 요청자 목록</h3>
                	<div class="col-lg-12 col-md-12">
		<div class="card">
			<div class="header">
				<div class="row">
					<div class="col-lg-5">
						<p>지원 요청자 리스트</p>
					</div>
				</div>
			</div>
			<div class="content">
				<div class=" table-resposive">
					<table class="table table-hover">
						<colgroup>
							<col width="15%">
							<col width="10%">
							<col width="20%">
							<col width="20%" class="hidden-xs">
							<col width="*" class="hidden-xs">
						</colgroup>
						<thead>
							<tr class="header">
								<td>지원 요청자 이름</td>
								<td>직책</td>
								<td>이메일</td>
								<td>전화번호</td>
								<td>비고</td><!-- 라이센스 키 >> 비고로 변경  -->
								<td>수정 / 삭제</td>
								<td>대표 설정</td>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="list" items="${list }">
							<input type="hidden" value="${list.req_no }" id="reqNo_${list.req_no }">
								<tr>
									<td id="reqName_${list.REQ_NO }">${list.REQ_NAME }</td>
									<td id="reqRank_${list.REQ_NO }">${list.REQ_RANK }</td>
									<td id="reqEmail_${list.REQ_NO }">${list.REQ_EMAIL }</td>
									<td id="reqPhone_${list.REQ_NO }">${list.REQ_PHONE }</td>
									<td id="reqNote_${list.REQ_NO }">${list.REQ_NOTE }</td>
									<td>
										<c:choose>
										<c:when test="${list.ROW_COUNT != '1' }">
											<button style="border: none; background: none;" onclick="rowModify(${list.REQ_NO })">
												<img alt="" src="../img/edit.png">
											</button>
											<button style="border: none; background: none;" onclick="rowDelete(${list.REQ_NO })">
												<img alt="" src="../img/trash.png">
											</button>
										</c:when>
										<c:otherwise>
											<button style="border: none; background: none;" onclick="rowModify(${list.REQ_NO })">
												<img alt="" src="../img/edit.png">
											</button>
											<button style="border: none; background: none;" onclick="alert('삭제할 수 없습니다.')">
												<img alt="" src="../img/trash.png">
											</button>
										
										</c:otherwise>
										</c:choose>
									</td>
									<td>
										<button class="btn btn-xs" id="reqRep_${list.REQ_NO }" value="1" onclick="changeRep(${list.REQ_NO })">설정</button>
<!-- 										<input type="radio" class="req_representative" name="req_representative" value="1" onclick="changeRep();"> -->
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
                <!--  주 내용 끝  -->
<script>
	function checkVali() {
	    var theForm = document.fm;
	    
	    if(theForm.req_name.value == "" || theForm.req_phone.value == "" || theForm.req_email.value == "") {
	        if(theForm.req_name.value == "") {
	            alert("이름을 입력해주세요.");
	            theForm.req_name.focus();
	            return false;
	        } else if(theForm.req_phone.value == "") {
	            alert("전화번호를 입력해주세요.");
	            theForm.req_phone.focus();
	            return false; 
	        } else if(theForm.req_email.value == "") {
	            alert("이메일을 입력해주세요");
	            theForm.req_email.focus();
	            return false; 
	        } 
	    } else {
	     	theForm.submit();
// 	    	alert('지원 요청자가 추가되었습니다.');
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
	
	/* 지원요청자 삭제하기 */
	function rowDelete(req_no) {
		if(confirm('정말 삭제하시겠습니까?') == true){
			$.ajax({
				type : 'post',
				url : 'rowDelete',
				dataType : "json",
				data : { rNo : req_no },
				success : function(data) {
					alert('삭제가 완료되었습니다.');
					location.reload();
				},
				error : function(req) {
					alert('실패');
				}
			});
		}else{
			return;
		}
	}
	/* 지원요청자 수정하기 */
	function rowModify(req_no) {
		var reqName = '#reqName_' + req_no;
		var name = $(reqName).text();
		
		var reqRank = '#reqRank_' + req_no;
		var rank = $(reqRank).text();
		
		var reqPhone = '#reqPhone_' + req_no;
		var phone = $(reqPhone).text();
		
		var reqEmail = '#reqEmail_' + req_no;
		var email = $(reqEmail).text();
		
		var reqNote = '#reqNote_' + req_no;
		var note = $(reqNote).text();
		
		var reqNo = '#reqNo_' + req_no;
		var no = $(reqNo).text();
		
		$('#req_name').val(name);
		$('#req_rank').val(rank);
		$('#req_phone').val(phone);
		$('#req_email').val(email);
		$('#req_note').val(note);
		$('#req_no').val(req_no);
		
		$('#add').val('1');
// 		$('button[onclick*=add]').html('수정하기');
	}
	
	
	$('.req_representative').on('click', function() {
		var req_rep = $('.req_representative').val();
		console.log(req_rep);
		$.ajax({
			type : 'post',
			url : 'changeRep',
			data : {req_rep : req_rep,
					req_no : req_no},
			dataType : "json",
			success : function(data) {
				alert('성공');
			},
			error : function(req) {
				alert('실패');
			}
		});
	});
	
	function changeRep(req_no) {
		var reqVal = '#reqRep_' + req_no;
		var req_rep = $(reqVal).val();
		console.log(reqVal);
		console.log(req_no);
		console.log(req_rep);
		$.ajax({
			type : 'post',
			url : 'changeRep',
			data : {req_no : req_no,
				req_rep : req_rep,
				client_no : $('#client_no').val()},
			dataType : "json",
			success : function(data) {
				alert('성공');
			},
			error : function(req) {
				alert('실패');
			}
		});
	}
	
</script>