<style>
.listTable thead tr th,
.listTable tbody tr td { text-align:center; }
.listTable tbody tr { cursor:pointer; }
.AS01 { color:orange; font-weight:bold; }
.AS02 { color:blue; font-weight:bold; }
.AS03, .AS04 { color:red; font-weight:bold; }
.AS05 { color:green; font-weight:bold; }
@media (max-width: 767px) { .card .content { padding-top: 0px; padding-bottom: 10px; } }
</style>
<c:choose>
	<c:when test="${param.type eq 'received'}">
		<c:set var="title" value="수신"/>
	</c:when>
	<c:when test="${param.type eq 'reported'}">
		<c:set var="title" value="상신"/>
	</c:when>
	<c:when test="${param.type eq 'stored'}">
		<c:set var="title" value="보관"/>
	</c:when>
</c:choose>
<h1 class="page-header" hidden="true">결재 ${title}함</h1>
<div class="card card-plain" style="padding:0px 20px;">
	<div class="header">
		<div class="content table-resposive table-full-width">
			<table class="listTable table table-hover hidden-xs">
				<thead>
					<tr class="header">
						<th>번호</th>
						<th>제목</th>
						<th>기안부서</th>
						<th>기안자</th>
						<th>시행일자</th>
						<th>결재상태</th>
						<th>첨부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="info" items="${list}" varStatus="status">
						<tr data-no="${info.aprvNo}" data-clsf="${info.aprvLnkgClsf}">
							<td>${fn:length(list) - status.index}</td>
							<td style="text-align:left">${info.title}</td>
							<td>${info.memDeptNm}</td>
							<td>${info.memName}</td>
							<td>${info.enfcDt}</td>
							<td class="${info.aprvStat}">${info.aprvStatNm}</td>
							<td>
								<c:if test="${!empty info.uploadNo}">
									<button type="button" class="btnDownload btn btn-default" data-no="${info.uploadNo}">다운로드</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(list) eq 0}">
						<tr><td colspan="9" style="padding:100px 0; text-align:center; cursor:default;">${title}된 결재가 없습니다.</td></tr>
					</c:if>
				</tbody>
			</table>
			<!-- 모바일 -->
			<!-- <div class="row visible-xs">
				<form method="get" action="list" id="form">
					<div class="row" style="margin-bottom:10px;">
						<span class="form-group-sm col-xs-12" style="min-width: 110px;">
							<select class="form-control border-input" name="searchCategory"
								style="border: none;">
								<option value="1">담당자</option>
							</select>
						</span>
					</div>
					<div class="row" style="margin-bottom:10px;">
						<span class="form-group-sm col-xs-12" style="min-width: 150px;">
							<input type="text" class="form-control border-input"
								name="searchText" style="border: none;">
						</span>
					</div>
					<div class="row form-group-sm col-xs-12" style="margin-bottom:10px;">
						<button type="submit" class="commonBtn">검색</button>
					</div>
				</form>
			</div> -->
			
			<div class="row">
				<table class="listTable table table-hover visible-xs">
					<thead>
						<tr class="header">
							<th style="text-align: left;">구분 / 이름</th>
							<th>결재상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="info" items="${list}" varStatus="status">
						<tr data-no="${info.aprvNo}" data-clsf="${info.aprvLnkgClsf}">
								<td style="text-align: left;">
									<div style="font-size: 14px;">
										${info.title} / ${info.memName}
									</div> 
									<div>
										<span style="font-size: 12px; font-weight: bold; color: #aaa;">
										${info.memDeptNm} / ${info.enfcDt}</span>
									</div>
								</td>
								<td>
									<span class="${info.aprvStat}" style="font-weight: bold; font-size: 16px; white-space: nowrap;">[${info.aprvStatNm}]</span>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(list) eq 0}">
						<tr><td colspan="9" style="padding:100px 0; text-align:center; cursor:default;">${title}된 결재가 없습니다.</td></tr>
					</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<%-- <div class="text-center">
		<ul class="pagination pagination-sm">
			<c:if test="${list.prevPaging ne -1 }">
				<li>
				<a href="?no=${list.prevPaging }"
				aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
				
			</c:if>
			<c:forEach begin="${list.page - 2 <= 0 ? 1 : list.page - 2 }"
				end="${list.page + 2 > list.lastPage ? list.lastPage : list.page + 2 }"
				var="index">
				<li id="list_${index }" class="listBtn"><a
					href="?no=${index }">${index }</a></li>
			</c:forEach>
			<c:if test="${list.nextPaging ne -1 }">
				<li>
					<a href="?no=${list.nextPaging }"
					aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
				
			</c:if>
		</ul>
	</div> --%>
</div>
<form name="frm" id="frm" method="post" target="approvalProcessing">
	<input type="hidden" name="aprvNo" id="aprvNo" value=""/>
	<input type="hidden" name="type" value="${param.type}"/>
</form>
<script>
$(document).on("click", ".listTable tbody tr td:not(:last-child)", function() {
	var thisNo = $(this).parent().data("no");
	var thisClsf = $(this).parent().data("clsf").toLowerCase();
	if(thisNo !== undefined) {
		/*
		var nWidth = "800";
		var nHeight = "600";
		var curX = window.screenLeft;
		var curY = window.screenTop;
		var curWidth = document.body.clientWidth;
		var curHeight = document.body.clientHeight;
		console.log(curX, curY, curWidth, curHeight);
		  
		var nLeft = curX + (curWidth / 2) - (nWidth / 2);
		var nTop = curY + (curHeight / 2) - (nHeight / 2);
		console.log(nLeft,nTop);
		*/
		$("#aprvNo").val(thisNo);
		var MyWindow = window.open("", "approvalProcessing", 
				"width=800, height=900, toolbar=no, menubar=no,  location=yes, scrollbars=yes, resizable=yes, user-scalable=yes, status=yes, left=0 , top=0");
		$("#frm").attr("action", "./" + thisClsf + "View").submit();  
	}
});
$(document).on("click", ".btnDownload", function() {
	window.open("${ctx}/file/download?no=" + $(this).data("no"), "_blank");
});
</script>