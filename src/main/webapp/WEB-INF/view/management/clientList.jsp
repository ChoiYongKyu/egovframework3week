<!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<!--  ì£¼ ë´ì© ìì  -->
<h1 class="page-header" hidden="true">고객사 리스트</h1>
<div class="card card-plain">
	<div class="header">
	<input type="hidden" name="paramNo" id="paramNo" value="${param.no }">
		<div class="row">
		<div class="col-lg-8">
			<form method="get" action="clientList" id="form">
				<div class="form-group-sm col-lg-2">
				<select class="form-control border-input" name="searchCategory"
					style="border:none;">
					<option value="1">고객사</option>
					<option value="2">지원 요청자</option>
				</select> 
				</div>
				<div class="form-group-sm col-lg-2">
					<input type="text" class="form-control border-input" name="searchText"
						style="border:none;">
				</div>
					<div class="col-lg-3 col-xs-2">
					<button type="submit" class="commonBtn">검색</button>
				</div>
		</form>
		</div>
		<div class="col-lg-4">
		<sec:authorize access="hasRole('ADMIN')">
			<div>
				<button type="button" class="btn btn-sm btn-default hidden-xs"
					onclick="location.href='${ctx }/management/clientRegister'"
					style="float: right;">고객사 등록</button>
			</div>
		</sec:authorize>
		</div>
		</div>
	</div>
	<table class="table table-hover table-responsive">
		<colgroup>
			<col width="7%">
			<col width="12%">
			<col width="15%">
			<col width="15%">
			<col width="*">
			
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th style="white-space:nowrap;">고객사</th>
				<th>요청자</th>
				<th style="white-space:nowrap;">전화번호</th>
				<th class="hidden-xs">주소</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${list.list }">
				<tr onclick="goClientDetail(${list.CLIENT_NO});">
					<td>${list.RNUM }</td>
					<td>${list.CLIENT_NAME }</td>
					<td>${list.REQ_NAME } ${list.REQ_RANK }</td>
					<td>${list.REQ_PHONE }</td>
					<td class="hidden-xs">${list.CLIENT_ADDR }</td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 모바일 -->
<!-- 			<table class="table table-hover visible-xs"> -->
<%-- 				<c:forEach var="list" items="${list.list }"> --%>
<%-- 					<tr onclick="goDetail(${list.MN_NO});"> --%>
<!-- 						<td> -->
<!-- 							<div style="font-size: 17px;"> -->
<%-- 								<span style="font-weight: bold; font-size: 14px;">[${list.CLIENT_NAME }]</span> --%>
<%-- 								${list.CLIENT_NAME} --%>
<%-- 							</div> <span style="font-size: 12px; font-weight: bold; color: #aaa;">${list.REQ_NAME }${list.REQ_RANK } --%>
<%-- 								${list.CLIENT_ADDR }</span> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<%-- 				</c:forEach> --%>

<!-- 			</table> -->
	
	
	<div class="text-center">
	<ul class="pagination pagination-sm">
		<c:if test="${list.prevPaging ne -1 }">
			<li><a href="?no=${list.prevPaging }&searchCategory=${list.searchCategory }&searchText=${list.searchText }" aria-label="Previous"><span
					aria-hidden="true">&laquo;</span></a></li>
		</c:if>
		<c:forEach begin="${list.page - 2 <= 0 ? 1 : list.page - 2 }"
			end="${list.page + 2 > list.lastPage ? list.lastPage : list.page + 2 }"
			var="index">
			<li id="list_${index }" class="listBtn"><a href="?no=${index }&searchCategory=${list.searchCategory }&searchText=${list.searchText }">${index }</a></li>
		</c:forEach>
		<c:if test="${list.nextPaging ne -1 }">
			<li><a href="?no=${list.nextPaging }&searchCategory=${list.searchCategory }&searchText=${list.searchText }" aria-label="Next"><span
					aria-hidden="true">&raquo;</span></a></li>
		</c:if>
	</ul>
</div>


</div>
<script>
	function goClientDetail(key) {
		location.href="clientDetail?no=" + key;
	}
	
	var isMobile;
	$(window).resize(function(){
		var winWidth = $(window).width();
		var winHeight = $(window).height();
		if(winWidth < winHeight){
			$('.pcVer').addClass('hidden');
			$('.moVer').removeClass('hidden');
		}else{
			$('.pcVer').removeClass('hidden');
			$('.moVer').addClass('hidden');
		}
	});
</script>