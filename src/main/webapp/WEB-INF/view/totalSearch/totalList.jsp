<h1 class="page-header" hidden="true">통합 검색</h1>
<!-- -------------------------------------------------------------------------------------- -->
<div class="card card-plain" style="border-top: 2px solid #999999;">
<div class="titleName">지식/질문 목록</div>
<div class="header">
<c:choose>
	<c:when test="${list.count.trCount eq 0}">
		<div>검색 결과가 없습니다.</div>
	</c:when>	
	<c:otherwise>
		<table class="table table-hover table-responsive" >
	<colgroup>
	<col width="65%">
	<col width="*">
	<col width="*">
	<col width="*">
	</colgroup>
		<thead>
			<tr>
				<th>이슈</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>참고사항</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="tList" items="${list.trouble }">
				<tr onclick="goTroubleDetail(${tList.TROUBLE_NO});">
<%-- 					<td class="more" style="max-width: 300px;"><span class="header">${list.TROUBLE_PROBLEM }</span> <br/><span class="content">${list.TROUBLE_ANSWER }</span> </td> --%>
					<td class="more" style="max-width: 300px;"><h5>${tList.TROUBLE_PROBLEM }</h5> <span class="content">${tList.TROUBLE_ANSWER }</span> </td>
					<td>${tList.MEM_NAME }</td>
					<td>${tList.TROUBLE_WRITE_DATE }</td>
					<td> ${tList.CLIENT_NAME }
					<br/>
					${tList.PRODUCT_NAME } <br/>
					<c:if test="${tList.VERSION_KIND eq 1}">운영</c:if>
					<c:if test="${tList.VERSION_KIND eq 2}">개발</c:if> 
					${tList.VERSION }
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:otherwise>
</c:choose>
	
	</div>
</div>
<!-- --------------------------------------------------------------------------------------------- -->
<div class="card card-plain" style="border-top: 2px solid #999999;">
<div class="titleName">버그리포트 목록</div>
<div class="header">
<c:choose>
	<c:when test="${list.count.bgCount eq 0}">
		<div>검색 결과가 없습니다.</div>
	</c:when>
	<c:otherwise>
		<table class="table table-hover table-responsive" >
	<colgroup>
	<col width="65%">
	<col width="*">
	<col width="*">
	<col width="*">
	</colgroup>
		<thead>
			<tr>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
		
				<th>참고사항</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="brList" items="${list.bugreport }">
				<tr onclick="goBugDetail(${brList.BUGREPORT_NO});">
					<td class="more" style="max-width: 300px;"><h5>${brList.BUGREPORT_PROBLEM }</h5> <span class="content">${brList.BUGREPORT_ANSWER }</span> </td>
					<td>${brList.MEM_NAME }</td>
					<td>${brList.BUGREPORT_WRITE_DATE }</td>
					<td> ${brList.CLIENT_NAME }
					<br/>
					${brList.PRODUCT_NAME } <br/>
					<c:if test="${brList.VERSION_KIND eq 1}">ì´ì</c:if>
					<c:if test="${brList.VERSION_KIND eq 2}">ê°ë°</c:if> 
					${brList.VERSION }
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:otherwise>
</c:choose>
	
	</div>
</div>
<!-- ---------------------------------------------------------------------------------- -->
<div class="card card-plain" style="border-top: 2px solid #999999;">
<div class="titleName">유지보수 목록</div>
<div class="header">
<c:choose>
	<c:when test="${list.count.mnCount eq 0}">
		<div>검색 결과가 없습니다.</div>
	</c:when>
	<c:otherwise>
		<div class="content table-resposive table-full-width">
		<table class="table table-hover hidden-xs">
			<thead>

				<tr class="header">
					<th>번호</th>
					<th>고객사</th>
					<th>업무구분</th>
					<th>담당자 / 담당그룹</th>
<!-- 					<td>지원 시작일 <br />~ 지원 종료일</td> -->
					<th>지원 시작일</th>
					<th>지원 종료일</th>
					<th>작업 상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="mmList" items="${list.maintenance }">
					<tr onclick="goDetail(${mmList.MN_NO});">
						<td>${mmList.MN_NO }</td>
						<td>${mmList.CLIENT_NAME}<c:if
									test="${mmList.MN_REPLY_COUNT2 ne 0}">
									<span style="color: red;">[${mmList.MN_REPLY_COUNT2 }]</span>
								</c:if>
							</td>
						<td>${mmList.WORK_SCOPE_NAME }</td>
						<td>${mmList.MEM_NAME }${mmList.MN_GROUP_NAME }</td>
<%-- 						<td>${list.MN_START_DATE }<br />~ ${list.MN_END_DATE } --%>
						<c:if test="${mmList.MN_START_DATE == NULL || mmList.MN_END_DATE == NULL }">
							<td>-</td>
							<td>-</td>
						</c:if>
						<c:if test="${mmList.MN_START_DATE != NULL || mmList.MN_END_DATE != NULL }">
							<td>${mmList.MN_START_DATE }</td>
							<td>${mmList.MN_END_DATE }</td>
						</c:if>
						<c:choose>
							<c:when test="${mmList.MN_DONE_NO eq 1 }">
								<td style="color:#ff3333; font-weight: bold;">${mmList.MN_DONE_NAME }</td>
							</c:when>
							<c:when test="${mmList.MN_DONE_NO eq 2 }">
								<td style="color:#cc00cc; font-weight: bold;">${mmList.MN_DONE_NAME }</td>
							</c:when>
							<c:when test="${mmList.MN_DONE_NO eq 3 }">
								<td style="color:#3385ff; font-weight: bold;">${mmList.MN_DONE_NAME }</td>
							</c:when>
						</c:choose>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
		<table class="table table-hover visible-xs">
		<!-- 모바일 -->
				<c:forEach var="mmList" items="${list.maintenance }">
					<tr onclick="goDetail(${mmList.MN_NO});">
						<td>
							<div style="font-size: 17px;">
								<span style="font-weight: bold; font-size: 14px;">[${mmList.WORK_SCOPE_NAME }]</span>
								${mmList.CLIENT_NAME}
							</div> <span style="font-size: 12px; font-weight: bold; color: #aaa;">${mmList.MEM_NAME }${mmList.MN_GROUP_NAME }
								${mmList.MN_START_DATE } ~ ${mmList.MN_END_DATE }</span>
						</td>
					</tr>
				</c:forEach>
		
		<!-- 모바일 -->
		
		
		
		</table>
	</div>
	</c:otherwise>
</c:choose>
	
</div>

</div>
<!-- -------------------------------------------------------------------------------------- -->
<div class="card card-plain" style="border-top: 2px solid #999999;">
<div class="titleName">고객사 목록</div>
<div class="header">
<c:choose>
	<c:when test="${list.count.clCount eq 0}">
		<div>검색 결과가 없습니다.</div>
	</c:when>
	<c:otherwise>
		<table class="table table-hover table-responsive">
		<thead>
			<tr>
				<th>번호</th>
				<th>고객사</th>
				<th>지원 요청자</th>
				<th>전화번호</th>
				<th class="hidden-xs">주소</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="cList" items="${list.client }">
				<tr onclick="goClientDetail(${cList.CLIENT_NO});">
					<td>${cList.RNUM }</td>
					<td>${cList.CLIENT_NAME }</td>
					<td>${cList.REQ_NAME }${cList.REQ_RANK }</td>
					<td>${cList.REQ_PHONE }</td>
					<td class="hidden-xs">${cList.CLIENT_ADDR }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:otherwise>	
</c:choose>	
	
</div>
</div>



<script>
	function goDetail(key) {
		window.open("/nos.mm/maintenance/detail?no=" + key);
	}
	function goClientDetail(key) {
		window.open("/nos.mm/management/clientDetail?no=" + key);
	}
	function goTroubleDetail(key) {
		window.open("/nos.mm/trouble/detail?no=" + key);
	}
	function goBugDetail(key) {
		window.open("/nos.mm/bugreport/bugreportList?no=" + key);
	}

</script>
<style>
	.titleName {
		font-size: 18px;
		font-weight: bold;
		margin: 50px 20px 5px 20px;
	}
</style>