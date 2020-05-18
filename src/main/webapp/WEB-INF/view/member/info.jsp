
<%-- <title><spr:message code='member.info' /></title> --%>
<%-- <link rel="stylesheet" href="${ctx }/css/custom/test.css"> --%>
<script src="${ctx }/js/custom/test.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="${ctx }/js/jstree.js"></script>

<!-- <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"> -->
<h1 class="page-header" hidden="true">
	<spr:message code='member.info' />
</h1>

<div class="content">
	<div class="container-fluid">

		<div class="row">

			<div class="col-lg-4 col-md-5">
				<div class="card card-user">
					<div class="header">
						<h4 style="padding:10px">정보</h4>
						<div id="tree">tree loading</div>
					</div>
					<div class="content">
						<p class="description text-center">
							<sec:authentication property='principal.mem_id' />
							<br> <br>
							<sec:authentication property='principal.mem_name' />
							<br> <br>
							<sec:authentication property='principal.mem_tel' />

						</p>

					</div>
					<div class="form-group">
						<div class="find-info">
							<input type="hidden" class="form-control border-input"
								disabled="disabled" /> <input type="hidden"
								class="form-control border-input" name="mem_id"
								placeholder="<spr:message code='common.email' />"
								required="required" readonly="readonly" onfocus="this.blur()"
								tabindex="-1"
								value="<sec:authentication property='principal.mem_id' />" /> <input
								type="hidden" class="form-control border-input" name="mem_name"
								placeholder="<spr:message code='common.name' />"
								required="required" readonly="readonly" onfocus="this.blur()"
								tabindex="-1"
								value="<sec:authentication property='principal.mem_name' />" />
							<input type="hidden" class="form-control border-input"
								name="mem_tel" placeholder="<spr:message code='common.phone' />"
								required="required" readonly="readonly" onfocus="this.blur()"
								tabindex="-1"
								value="<sec:authentication property='principal.mem_tel' />" />
							
							<c:if test="${signInfo ne null }">
								<div style="text-align: center; font-weight: 600;">서명<br/><br/>	
									<img src="${ctx }/download/${signInfo.UPLOAD_AFTER }" style="width: 300px; height: auto; border: double 3px;" />
								</div>
								<br/><br/>
							</c:if>
							
							<p class="text-center">
								<input type="button"
									class="btn btn-info btn-fill btn-wd move_button" id="modify" 
									value="<spr:message code='menu.myinfo.modify' />" /> <br>
								<br>
							</p>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-4 col-md-5">
				<div class="card card-user">
					<div class="header">
						<h4 style="padding:10px">그룹</h4>
					</div>
					<div class="content">
						<div class="find_info">

							<c:forEach items="${grp }" var="grp" end="2">
								<div class="grp_mn my_group btn" id="my_group_${grp.group_no }">
									<div class="group_name">${grp.group_name }</div>
<%-- 									<div>${grp.members_name }</div> --%>
								</div>
							</c:forEach>
							<c:if test="${fn:length(grp) > 3}">
							<br><br>
								<div class="my_group text-center" id="info_groups">
									<img src="${ctx }/img/plus.png" id="plus" style="max-width: 50px"/>
								</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="grp_dialog" hidden="">
	<table class="table table-striped">
		<thead>
			<tr>
				<td>이메일</td>
				<td>이름</td>
			</tr>
		</thead>
	</table>
</div>
<script type="text/javascript">
$(function() {
	
	$('#tree').jstree({
		"core": {
			"data": [
                { id: "1", text: "Unit 1", parent: "#", state: { "opened": true }},
                { id: "2", text: "Unit 2", parent: "1", state: { "opened": true }},
                { id: "3", text: "Unit 3", parent: "2", state: { "opened": true }}
            ]
		},
    
		"plugins": [
      	"contextmenu"
		]
	});
	/* if($('input[name=mem_tel]').val() != 'google user'){
		$('#modify').removeClass('hidden');
	} */
});
</script>
</body>
</html>