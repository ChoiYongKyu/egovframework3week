
<script src="${ctx }/js/custom/test.js"></script>
<%--             <link rel="stylesheet" href="${ctx }/css/custom/test.css"> --%>
<div class="card card-plain">
	<h1 class="page-header" hidden="true">사용자 리스트</h1>
	<div class="form-group">
		<form class="navbar-form pull-left" action="">
			<input type="text" class="form-control border-input" name="keyword" style="color: black;">
			<button type="submit" class="btn btn-xs btn-default">검색</button>
		</form>
	</div>
	<input type="hidden" name="paramNo" id="paramNo" value="${param.no }">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>이메일</th>
				<th>권한</th>
				<th>그룹명</th>
				<th>비밀번호 초기화</th>
				<th>탈퇴 처리</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${member.list }" var="member">
				<tr>
					<td>${member.MEM_NO }</td>
					<td>${member.MEM_NAME }</td>
					<td>${member.MEM_ID }</td>
					<td><select class="auth" title="${member.MEM_NO }">
							<option value="${member.AUTH_NO }">${member.AUTH_NAME }</option>
					</select></td>
					<td>${member.groups }</td>
					<td>
						<c:if test="${member.MEM_TEL != 'google user'}">
							<button type="button" id="member_list_reset"
								class="btn btn-xs btn-warning" value="${member.MEM_NO }">비밀번호
								초기화</button>
						</c:if>
					</td>
					<td>
						<button type="button" id="member_list_del"
							class="btn btn-xs btn-default" value="${member.MEM_NO }">
							<img src="${ctx }/img/delete.png" />
						</button>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="text-center">
		<ul class="pagination pagination-sm">
			<c:if test="${member.prevPaging ne -1 }">
				<li><a href="?no=${member.prevPaging }" aria-label="Previous"><span
						aria-hidden="true">&laquo;</span></a></li>
			</c:if>
			<c:forEach begin="${member.page - 2 <= 0 ? 1 : member.page - 2 }"
				end="${member.page + 2 > member.lastPage ? member.lastPage : member.page + 2 }"
				var="index">
				<li id="list_${index }" class="listBtn"><a href="?no=${index }">${index }</a></li>
			</c:forEach>
			<c:if test="${member.nextPaging ne -1 }">
				<li><a href="?no=${member.nextPaging }" aria-label="Next"><span
						aria-hidden="true">&raquo;</span></a></li>
			</c:if>
		</ul>
	</div>
</div>
<div id="member_list_diglog" hidden="">
	<div class="member_list_reset">비밀번호 초기화 하시겠습니까?</div>
	<div class="member_list_del">삭제하시겠습니까?</div>
</div>