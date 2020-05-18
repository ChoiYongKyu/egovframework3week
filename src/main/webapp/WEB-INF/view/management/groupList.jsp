
<%-- <link rel="stylesheet" href="${ctx }/css/custom/test.css"> --%>
<script src="${ctx }/js/custom/test.js"></script>
	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<h1 class="page-header" hidden="true">
			<spr:message code='group.title' />
		</h1>
	</div>
<div class="groupBox">
<c:forEach items="${allGroup }" var="grp">
	<div class="group col-lg-3 col-md-5">
		<div class="card group">
			<div class="content grp_mn" id="group_admin_${grp.MN_GROUP_NO }">
				<ul class="list-unstyled team-members">
					<li>
						<div class="row">
							<div class="col-xs-3">
								<div class="avatar">
									<img src="../img/add.png" alt="Circle Image"
										class="img-circle img-no-padding img-responsive">
								</div>
							</div>
							<div class="header group_manage" >
								<h4 class="title group_name">${grp.MN_GROUP_NAME }</h4></div>
<!-- 							<div class="col-xs-6"> -->
<!-- 								test<br />  -->
<!-- 								<span class="text-muted"><small>ì¬ì</small></span> -->
<!-- 							</div> -->
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</c:forEach>
</div>
<div class="group col-lg-3 col-md-5"><button class="btn btn-lg btn-primary grp_mn group_manage" id="grp_add"><i class="ti-plus"></i></button></div>
<div class="grp_dialog" hidden="">
	<table class="table table-striped" id="grp_mn">
		<thead>
			<tr>
				<td>이름</td>
				<td>아이디</td>
			</tr>
		</thead>
	</table>
	<table class="table table-striped" id="grp_add_dialog">
		<thead>
			<tr>
				<td>그룹명</td>
				<td><input type="text" id="grp_name" maxlength="20"></td>
			</tr>
		</thead>
	</table>
</div>
