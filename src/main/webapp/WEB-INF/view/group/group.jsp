<%-- <link rel="stylesheet" href="${ctx }/css/custom/test.css"> --%>
<script src="${ctx}/js/custom/test.js"></script>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	<h1 class="page-header" hidden="">
		나의 그룹 리스트
	</h1>
</div>
<c:forEach items="${grp}" var="grp">
	<div class="group col-lg-3 col-md-5">
		<div class="card group">
			<div class="header grp_mn group_manage" id="group_manage_${grp.group_no}">
				<h4 class="group_name">${grp.group_name}</h4>
				<div>${grp.members_name}</div>
			</div>
		</div>
	</div>
</c:forEach>
<div class="grp_dialog" hidden="">
	<table class="table table-striped">
		<thead>
			<tr>
				<td>이메일</td>
-				<td>이름</td>
			</tr>
		</thead>
	</table>
</div>
