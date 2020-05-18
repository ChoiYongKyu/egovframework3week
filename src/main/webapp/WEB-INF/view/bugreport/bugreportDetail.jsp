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
							<pre>${detail.BUGREPORT_PROBLEM }</pre>
						</div>
					</div>

					<div class="col-lg-12">
						<div class="form-group">
							<label>내용</label>
							<pre style="min-height: 10rem;" ><c:out value="${detail.BUGREPORT_ANSWER }" escapeXml="" /></pre>
						</div>
					</div>

					<div class="col-lg-12 text-right">
						<div class="button-group">
							<sec:authorize access="hasRole('ADMIN')">
								<button type="button" class="btn btn-xs btn-default" onclick="goTroubleModify(${detail.BUGREPORT_NO});">수정하기</button>
								<button type="button" class="btn btn-xs btn-default btn-danger" onclick="doDelete(${detail.BUGREPORT_NO});">삭제하기</button>
							</sec:authorize>
							<button type="button" class="btn btn-xs btn-default" onclick="location.href='bugreportList';">목록으로</button>
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
										<pre id="${reply.BUGREPORT_REPLY_NO }">${reply.BUGREPORT_REPLY_ANSWER }</pre>
									</div>
									<div>
										<span style="float: right;">
											<a href="#" class="replyModify" id="${reply.BUGREPORT_REPLY_NO }">수정</a>
											/
											<a href="#this" onclick="replyDelete(${reply.BUGREPORT_REPLY_NO })">삭제</a>
										</span>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<!-- 댓글 목록 끝 -->
					<!-- 댓글 달기 -->
					<form action="insertReply" method="post" name="fm"> 
						<input hidden="hidden" value="${detail.BUGREPORT_NO }" name="bugreport_no"/>
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
				url: 'deletebugreport',
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
			location.href = "bugreportList";
		} else {
			return false;
		}
	}
</script>

