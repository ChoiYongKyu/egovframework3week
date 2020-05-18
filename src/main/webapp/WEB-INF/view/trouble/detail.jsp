<!-- 주 내용 시작 -->
<h1 class="page-header" hidden="true">지식/질문 관리 게시판</h1>
<div class="card card-plain">
	<div class="content">
		<div class="row">
			<div class="col-lg-10 card">
				<div class="header">
					<h4>참고 정보</h4>
				</div>
				<div class="content">
					<div class="row">
						<div class="col-lg-3">
							<div class="form-group">
								<label>고객사</label>
								<pre>${detail.CLIENT_NAME }</pre>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="form-group">
								<label>제품 명</label>
								<pre>${detail.PRODUCT_NAME }</pre>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="form-group">
								<label>버전 종류</label>
								<c:choose>
									<c:when test="${detail.VERSION_KIND eq 1}">
										<pre>운영</pre>
									</c:when>
									<c:when test="${detail.VERSION_KIND eq 2}">
										<pre>개발</pre>
									</c:when>
									<c:otherwise>
										<pre></pre>
									</c:otherwise>
								</c:choose>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="form-group">
								<label>버전</label>
								<pre>${detail.VERSION }</pre>
							</div>
						</div>
					</div>
				</div>
				<div class="header">
					<h4>이슈</h4>
				</div>
				<div class="content">
					<div class="col-lg-12">
						<div class="form-group">
							<label>문제 내역</label>
							<pre>${detail.TROUBLE_PROBLEM }</pre>
						</div>
					</div>

					<div class="col-lg-12">
						<div class="form-group">
							<label>내용</label>
							<pre style="min-height: 10rem;" ><c:out value="${detail.TROUBLE_ANSWER }" escapeXml="false" /></pre>
						</div>
					</div>
		<form action="" method="post" encType="multiplart/form-data" id="form">	
		<input type="hidden" name="table" value="TROUBLE" />
		<input hidden="hidden" value="${detail.TROUBLE_NO }" name="no"/>
		<div class="row">
			
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

					<div class="col-lg-12 text-right">
						<div class="button-group">
							<sec:authorize access="hasRole('ADMIN')">
								<button type="button" class="btn btn-xs btn-default" onclick="goTroubleModify(${detail.TROUBLE_NO});">수정하기</button>
								<button type="button" class="btn btn-xs btn-default btn-danger" onclick="doDelete(${detail.TROUBLE_NO});">삭제하기</button>
							</sec:authorize>
							<button type="button" class="btn btn-xs btn-default" onclick="location.href='troubleList';">목록으로</button>
							<br/>
						</div>
					</div>

				</div>
			</div>

			<!-- 댓글 목록 -->
			<div class="col-lg-10 card">
				<div class="content">
					<div style="margin-top:50px;">
						<h4>해결 방안</h4>
						<div>
							<c:forEach var="reply" items="${reply }">
								<div style="border-bottom:1px solid #cccccc; padding:15px;">
									<div style="margin-bottom:12px;">
										<!-- <span><img src="../img/logo.ico"></span> -->
										<span style="font-size:16px; font-weight: bold;">${reply.MEM_NAME }</span>
										<span style="float: right;">${reply.REPLY_WRITE_DATE }</span>

									</div>
									<div>
										<pre id="${reply.REPLY_NO }">${reply.REPLY_ANSWER }</pre>
									</div>
									<div>
										<span style="float: right;">
											<a href="#" class="replyModify" id="${reply.REPLY_NO }">수정</a>
											/
											<a href="#this" onclick="replyDelete(${reply.REPLY_NO })">삭제</a>
										</span>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<!-- 댓글 목록 끝 -->
					<!-- 댓글 달기 -->
					<form action="insertReply" method="post" name="fm">
					<input type="hidden" name="table" value="TROUBLE" />
						<input hidden="hidden" value="${detail.TROUBLE_NO }" name="trouble_no"/>
						<input hidden="hidden" value='<sec:authentication property="principal.mem_no" />' id="mem_no" name="mem_no"/>
						<div id="replyInput">
							<h4 id="replyTitle">답변 달기</h4>
							<div>
								<div class="col-lg-11">
									<textarea rows="5" class="form-control border-input" id="insertReply" name="insertReply" style="resize: vertical;"></textarea>
								</div>
								<div class="col-lg-1 text-center">
									<a href="#" class="btn btn-lg btn-default" id="addButton" onclick="addButton()">답변</a>
								</div>
							</div>
						</div>
		
					</form>
					<!-- 댓글 달기 끝 -->
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	var isAddMod = true;
	var reply_no = 0;
	function goTroubleModify(key) {
		location.href = "modify?no=" + key;
	}

	function addButton() {
		if (isAddMod) {
			if (fm.insertReply.value == "") {
				alert('내용을 입력해주세요.');
				fm.insertReply.focus();
				return false;
			} else {
				fm.submit();
			}
		} else {
			$.ajax({
				type: "post",
				url: "replyModify",
				data: {
					reply_no: reply_no,
					reply_answer: $('textarea[name=insertReply]').val()
				},
				dataType: "json",
				success: function (data) {
					location.reload();
				},
				error: function (req) {
					alert('실패');
				}
			});
		}
	}
	var temptemp;
	$('.replyModify').on('click', function (e) {
		e.preventDefault();
		reply_no = this.getAttribute('id');
		$('#replyTitle').html('수정하기');
		$('#addButton').html('수정');
		isAddMod = false;
		$('textarea[name=insertReply]').val($('#' + this.getAttribute("id")).html()).focus().attr('rows', $('#' + this.getAttribute("id")).html().match(/\n/g).length + 1);

	});

	function replyDelete(REPLY_NO) {
		if (confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				type: "post",
				url: "replyDelete",
				data: {
					no: REPLY_NO
				},
				dataType: "json",
				success: function (data) {
					location.reload();
				},
				error: function (req) {
					console.log('실패');
				}
			});
		} else {
			return;
		}
	}

	function doDelete(no) {
		if (confirm("정말 삭제하시겠습니까?")) {
			$.ajax({
				type: 'get',
				url: 'deleteTrouble',
				data: {
					no: no
				},
				dataType: "json",
				success: function (data) {
					alert("삭제가 완료되었습니다.");
				},
				error: function (req) {
					console.log('에러');
				}
			});
			location.href = "troubleList";
		} else {
			return false;
		}
	}
	
	
	function onClickImg(imgName){
//	 	alert(imgName);
		console.log(this);
		var path = '..\\download\\' + imgName; 
		
		$('#modal-img').attr('src',path);
//	 	modal-dialog
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

<%--
<table class="table table-bordered hidden-xs">
<colgroup>
<col width="10%"/>
<col width="*"/>
<col width="10%"/>
<col width="*"/>
</colgroup>
<tbody>
<tr>
<th>고객사</th>
<td>
							<span>${detail.CLIENT_NAME }</span>
	</td>
	<th>제품 명</th>
	<td colspan="3">
								<span>${detail.PRODUCT_NAME }</span>
		</td>
		</tr>

		<tr>
		<th>버전 종류</th>
		<td>
									<c:if test="${detail.VERSION_KIND eq 1}">
			<span>운영</span>
										</c:if>
											<c:if test="${detail.VERSION_KIND eq 2}">
					<span>개발</span>
												</c:if>
						</td>
						<th>버전</th>
						<td>
													<span>${detail.VERSION }</span>
							</td>
							</tr>

							<tr>
							<th>문제 내역</th>
							<td colspan="5">
																				<textarea class="form-control" cols="150" rows="7" readonly="readonly" style="resize: vertical; overflow: auto;" wrap="soft">${detail.TROUBLE_PROBLEM }</textarea>
																<pre>${detail.TROUBLE_PROBLEM }</pre>
									</td>
									</tr>
									<tr>
									<th>내용</th>
									<td colspan="5">
																							<textarea class="form-control" cols="150" rows="7" readonly="readonly" style="resize: vertical; overflow: auto;" wrap="soft">${detail.TROUBLE_ANSWER }</textarea>
																			<pre style="min-height: 10rem;" >${detail.TROUBLE_ANSWER }</pre>
											</td>
											</tr>
											<tr>
											<td colspan="6">
																				<sec:authorize access="hasRole('ADMIN')">
																						<button type="button" class="btn btn-xs btn-default" onclick="goTroubleModify(${detail.TROUBLE_NO});">수정하기</button>
																							<button type="button" class="btn btn-xs btn-default btn-danger" onclick="doDelete(${detail.TROUBLE_NO});">삭제하기</button>
																							</sec:authorize>
															<button type="button" class="btn btn-xs btn-default" onclick="location.href='troubleList';">목록으로</button>
															</td>
															</tr>
															</tbody>
															</table>
															--%>
