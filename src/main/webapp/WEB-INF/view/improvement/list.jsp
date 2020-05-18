<h1 class="page-header" hidden="true">개선 요구</h1>
<div class="card card-plain">
	<div class="col-lg-2 pull-right">
		<input type="button" value="글 작성" onclick="location.href='${ctx }/improvement/register'" class="btn btn-succese"/>
	</div>
	
	
	<div class="content">
	<div class="col-lg-12">
		<table class="table table-hover table-responsive" >
			<colgroup>
				<col width="*">
				<col width="65%">
				<col width="*">
				<col width="*">
			</colgroup>
			
				<thead>
					<tr>
						<th style="white-space: nowrap;">번호</th>
						<th style="white-space: nowrap;">제목</th>
						<th style="white-space: nowrap;">작성자</th>
						<th style="white-space: nowrap;">작성일</th>
					</tr>
				</thead>
			
				<tbody>
					<c:forEach var="list" items="${list.list }">
						<tr onclick="goDetail(${list.IMPROVEMENT_NO});">
						 	<td>${list.IMPROVEMENT_NO }</td>
							<td style="font-weight:bold; overflow: hidden; text-overflow: ellipsis; white-space: inherit;">${list.IMPROVEMENT_TITLE }</td>
							<td>${list.MEM_NAME }</td>
							<td>${list.IMPROVEMENT_WRITE_DATE }</td>
						</tr>
					</c:forEach>
				</tbody>
		</table>
	</div>
	</div>
</div>






<%--  190104 최승우
<table>
	<thead>
		<tr>
			<th>
				<span>번호</span>
			</th>
			<th>
				<span>제목</span>
			</th>
			<th>
				<span>작성자</span>
			</th>
			<th>
				<span>작성일</span>
			</th>
		</tr>
	</thead>
	
	<tbody>
	<c:forEach var="list" items="${list.list }">
		<tr onclick="goDetail(${list.IMPROVEMENT_NO});">
		 	<td>
				<span>${list.IMPROVEMENT_NO }</span>
			</td>
			<td>
				<span style="font-weight: bold; font-size: 14px;">${list.IMPROVEMENT_TITLE }</span>
			</td>
			<td>
				<span>아직 안가져온 값</span>
			</td>
			<td>
				<span>${list.IMPROVEMENT_WRITE_DATE }</span>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
 --%>








<div class="text-center">
	<ul class="pagination pagination-sm">
		<c:if test="${list.prevPaging ne -1 }">
			<li>
				<a href="?no=${list.prevPaging }" aria-label="Previous">
				<span aria-hidden="true">&laquo;</span>
			</a>
			</li>
		</c:if>
		<c:forEach begin="${list.page - 2 <= 0 ? 1 : list.page - 2 }" end="${list.page + 2 > list.lastPage ? list.lastPage : list.page + 2 }" var="index">
			<li id="list_${index }" class="${index == list.page ? 'active' : '' }">
				<a href="?no=${index }">${index }</a>
			</li>
		</c:forEach>
		<c:if test="${list.nextPaging ne -1 }">
			<li>
				<a href="?no=${list.nextPaging }" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</c:if>
	</ul>
</div>


<script>
	function goDetail(key) {
		location.href="detail?no=" + key;
	}
	
</script>