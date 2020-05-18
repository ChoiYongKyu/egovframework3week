<h1 class="page-header" hidden="true">지식/질문 리스트</h1>
<div class="card card-plain">
	<div class="header">
	<input type="hidden" name="paramNo" id="paramNo" value="${param.no }">
		<div>
			<div class="col-lg-12">
				<form method="get" action="troubleList" id="form">
					<div class="form-group-sm col-lg-2">
						<input type="text" class="form-control border-input" name="searchText" style="color: black;">
					</div>
					<div class="col-lg-3 col-xs-2">
						<button type="submit" class="commonBtn">검색</button>
					</div>
					<div class="col-lg-2 pull-right" style="margin-bottom: 10px;">
						<a href="${ctx }/trouble/register" class="btn btn-succese">글 등록</a>
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
		<col width="*" class="hidden-xs">
	</colgroup>
		<thead>
			<tr>
				<th>이슈</th>
				<th style="white-space: nowrap;">작성자</th>
				<th>날짜</th>
				<th class="hidden-xs">첨부파일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${list.list }">
				<tr>
<%-- 					<td class="more" style="max-width: 300px;"><span class="header">${list.TROUBLE_PROBLEM }</span> <br/><span class="content">${list.TROUBLE_ANSWER }</span> </td> --%>
					<td onclick="goTroubleDetail(${list.TROUBLE_NO});" class="more" style="overflow: hidden; text-overflow: ellipsis; white-space: inherit;"><span style="font-weight:bold; overflow: hidden; text-overflow: ellipsis; white-space: inherit;">${list.TROUBLE_PROBLEM }</span><br><span style="overflow: hidden; text-overflow: ellipsis; white-space: inherit;">${list.TROUBLE_ANSWER }</span> </td>
					<td onclick="goTroubleDetail(${list.TROUBLE_NO});">${list.MEM_NAME }</td>
					<td onclick="goTroubleDetail(${list.TROUBLE_NO});">${list.TROUBLE_WRITE_DATE }</td>
				
					<td class="hidden-xs"
						<%-- <c:set var="string1" value="${list.UPLOAD_BEFORE }" />
						<c:set var="string2" value="${fn:substringAfter(string1, '.')}"/> --%>
						<%-- <a href="#this" name="file" id="${list.UPLOAD_NO }" data-toggle="tooltip" title='${list.UPLOAD_LIST }' data-original-title="Default tooltip">${string2 }</a> --%>
						data-toggle="tooltip" title='${list.UPLOAD_LIST }' data-original-title="Default tooltip" >보기
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	</div>
	<div class="text-center">
		<ul class="pagination pagination-sm">
			<c:if test="${list.prevPaging ne -1 }">
			
				<li><a href="?no=${list.page - 10 <= 0 ? 1 : list.page - 10 }
						<c:if test='${searchText ne null}' >&searchText=${searchText}</c:if>" aria-label="Previous"><span
				 			aria-hidden="true">&laquo;</span></a></li> 
			
				<%-- <li><a href="?no=${list.prevPaging }" aria-label="Previous"><span
			 			aria-hidden="true">&laquo;</span></a></li> --%>
			</c:if>
			<c:forEach begin="${list.page - 10 <= 0 ? 1 : list.page - 10 }"
				end="${list.page + 10 > list.lastPage ? list.lastPage : list.page + 10 }"
				var="index">
				<li id="list_${index }" class="listBtn"><a href="?no=${index }<c:if test='${searchText ne null}'>&searchText=${searchText}</c:if>">${index }</a></li>
			</c:forEach>
			<c:if test="${list.nextPaging ne -1 }">
				<li><a href="?no=${list.page + 10 > list.lastPage ? list.lastPage : list.page + 10 }
						<c:if test='${searchText ne null}'>&searchText=${searchText}</c:if>" aria-label="Next"><span
						aria-hidden="true">&raquo;</span></a></li>
				<%-- <li><a href="?no=${list.nextPaging }" aria-label="Next"><span
						aria-hidden="true">&raquo;</span></a></li> --%>
			</c:if>
		</ul>
	</div>
</div>
<script>
	function goTroubleDetail(key) {
// 		location.href="detail?no=" + key;
		window.open("detail?no="+key);
	}
	
	/* $('a[name=file]').on('click', function(e){
		e.preventDefault();
	 	window.open("${ctx }/file/download?no=" + $(this).attr('id'),"_black");
	}); */
	
	/* $("[data-toggle='tooltip']").tooltip(); */
	
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