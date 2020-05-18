<!--             <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">프로젝트 보기</h1>
<div class="card card-plain">
	<table class="table table-bordered">
		<tbody>
			<tr>
				<th>프로젝트명</th>
				<td width="30%">
					<pre>${pj_view.PJ_NAME }</pre>
				</td>
				
				<th>고객사</th>
				<td width="30%">
					<pre>${pj_view.CLIENT_NAME }</pre>
				</td>
			</tr>
			<tr>
				<th>프로젝트 시작일</th>
				<td>
					<pre>${pj_view.PJ_START_DATE }</pre>
				</td>
				<th>프로젝트 종료일</th>
				<td>
					<pre>${pj_view.PJ_END_DATE }</pre>
				</td>
			</tr>
			<tr>
				<th>구분</th>
				<td colspan="3">
				<c:forEach items="${projectScope }" var="project_scope">
					<label class="checkbox-inline"> 
						<input type="checkbox" name="project_scope_no" value="${project_scope.COMMON_CODE_KEY }" onclick="return false;">${project_scope.COMMON_CODE_VALUE }
					</label>
				</c:forEach>
				</td>
			</tr>
			<tr>
				<th>프로젝트 멤버</th>
				<td colspan="3">
				<c:forEach items="${pj_view.pj_join }" var="project_member">
					<pre>${project_member.MEM_NAME } ${project_member.MEM_START_DATE } ~ ${project_member.MEM_END_DATE }</pre>
				</c:forEach>
				</td>
			</tr>
			<tr>
				<th>설명</th>
				<td colspan="3">
					<pre>${pj_view.PJ_EXPLANATION }</pre>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<sec:authentication property="principal" var="principal" />
					<c:set var="_break" value="true" />
					<c:forEach items="${pj_view.pj_join }" var="pj_mem">
						<c:if test="${(pj_mem.MEM_NO == principal.mem_no || principal.auth_no == 1) && _break }">
							<button type="button" class="btn btn-xs btn-default" onclick="doDelete(${pj_view.PJ_NO })">삭제하기</button>
							<button type="button" class="btn btn-xs btn-default btn-danger" onclick="location.href='${pj_view.PJ_NO }/modify'">수정하기</button>
							<c:set var="_break" value="false" />
						</c:if>
					</c:forEach>
					<button type="button" class="btn btn-xs btn-default" onclick="location.href='${ctx }/management/projectList'">목록으로</button>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!--  주 내용 끝  -->

<script>
$(function() {
	// 체크박스 체크용
	<c:forEach items="${pj_view.pj_type }" var="pj_type">
		$('input[name=project_scope_no]').each(function() {
			if(this.value == '${pj_type.PJ_TYPE }') {
				this.checked = true;
			}
		});
	</c:forEach>
});

function doDelete(key) {
	if(confirm("정말 삭제하시겠습니까?")) {
		$.ajax ({
			type : 'delete',
			url : ctx + '/management/projectList/' + key,
			data : 
				{ no : key },
			dataType : "json",
			success : function(data) {
				console.log(data);
				console.log(data.success);
				
			}, error : function(req) {
				console.log('안돼');
			}
		});
		location.href="${ctx }/management/projectList";
	} else {
		return false;
	}
	console.log(key);
}
</script>