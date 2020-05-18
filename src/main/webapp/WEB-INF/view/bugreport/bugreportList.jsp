<h1 class="page-header" hidden="true">버그리포트</h1>
<div class="card card-plain">
	<div class="header">
	<input type="hidden" name="paramNo" id="paramNo" value="${param.no }">
		<div >
			<div class="col-lg-12">
				<form method="post" action="bugreportList" id="form">
					<div class="form-group-sm col-lg-2">
						<input type="text" class="form-control border-input" name="searchText" style="color: black;">
					</div>
					<div class="col-lg-3 col-xs-2">
						<button type="submit" class="commonBtn">검색</button>
					</div>
					<div class="col-lg-2 pull-right" style="margin-bottom: 10px;">
						<a href="${ctx }/bugreport/register" class="btn btn-succese">버그등록</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="content">
	<div class="col-lg-12">
	<table class="table table-hover table-responsive" >
	<colgroup>
		<col width="65%">
		<col width="*">
		<col width="*">
	
	</colgroup>
		<thead>
			<tr>
				<th>제목</th>
				<th style="white-space: nowrap;">작성자</th>
				<th>날짜</th>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${list.list }">
				<tr onclick="goBugDetail(${list.BUGREPORT_NO});">
					<td class="more" style="overflow: hidden; text-overflow: ellipsis; white-space: inherit;"><span style="font-weight:bold; overflow: hidden; text-overflow: ellipsis; white-space: inherit;">${list.BUGREPORT_PROBLEM }</span> <br><span style="overflow: hidden; text-overflow: ellipsis; white-space: inherit;">${list.BUGREPORT_ANSWER }</span> </td>
					<td>${list.MEM_NAME }</td>
					<td>${list.BUGREPORT_WRITE_DATE }</td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	</div>
	<div class="text-center">
		<ul class="pagination pagination-sm">
			<c:if test="${list.prevPaging ne -1 }">
				<li><a href="?no=${list.page - 5 <= 0 ? 1 : list.page - 5 }" aria-label="Previous"><span
				 			aria-hidden="true">&laquo;</span></a></li>
			
				<%-- <li><a href="?no=${list.prevPaging }" aria-label="Previous"><span
			 			aria-hidden="true">&laquo;</span></a></li> --%>
			</c:if>
			<c:forEach begin="${list.page - 5 <= 0 ? 1 : list.page - 5 }"
				end="${list.page + 5 > list.lastPage ? list.lastPage : list.page + 5 }"
				var="index">
				<li id="list_${index }" class="listBtn"><a href="?no=${index }">${index }</a></li>
			</c:forEach>
			<c:if test="${list.nextPaging ne -1 }">
				<li><a href="?no=${list.page + 5 > list.lastPage ? list.lastPage : list.page + 5 }" aria-label="Next"><span
						aria-hidden="true">&raquo;</span></a></li>
				<%-- <li><a href="?no=${list.nextPaging }" aria-label="Next"><span
						aria-hidden="true">&raquo;</span></a></li> --%>
			</c:if>
		</ul>
	</div>
</div>
<script>
	function goBugDetail(key) {
// 		location.href="detail?no=" + key;
		window.open("detail?no="+key);
	}
</script>
<style type="text/css">
.more{
	font-size:1em;
	overflow:hidden;
	white-space:inherit;
	text-overflow:ellipsis;
	max-width: 150px;
}

</style>