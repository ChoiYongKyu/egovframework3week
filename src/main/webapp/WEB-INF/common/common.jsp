<style>
.smallMenu {
	margin = 0;
}
#totalSearchText {
	width : 400px;
	border: 1px solid #c6b1d5;
}
#totalSearchTextBtn {
	height: 40px;
	border: 1px solid #c6b1d5;
	background: #c6b1d5;
	border-radius: 3px;
}

a {
	padding-top: 0px;
	padding-bottom: 0px;
}

.nav li a {
	margin: 5px !important;
}
</style>
<body>
	<div class="wrapper">
		<div class="sidebar" data-background-color="orange" data-active-color="info">
			<div class="sidebar-wrapper" >
				<div class="logo text-center">
					<a href="${ctx}/home/chart"><img src="${ctx}/img/logo.jpg" style="height: 50px;" /></a>
				</div>

				<ul class="nav">
					<li>
						<div id="myName" class="text-center" style="padding: 20px 0; border-bottom: 1px solid #cccccc; width: 220px; cursor:pointer;">
							<sec:authentication property="principal.mem_name"/>님 안녕하세요 !
						</div>
					</li>
					<c:forEach items="${menu}" var="menu">
						<li>
							<a href="${menu.url}">
								<p>
									<c:forEach begin="3" end="${menu.level}">
										&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;
									</c:forEach>${menu.menu_name}
								</p>
							</a>
						</li>

					</c:forEach>

					<sec:authorize access="hasRole('ADMIN')">
						<li><a href="${ctx}/member_manage">사용자 관리</a></li>
						<li><a href="${ctx}/member_manage/member">&nbsp;&nbsp;&nbsp;사용자 리스트</a></li>
						<li><a href="${ctx}/member_manage/group">&nbsp;&nbsp;&nbsp;그룹 리스트</a></li>
						<li><a href="${ctx}/menu/menu">메뉴 관리</a></li>
						<!-- 최용규 -->
						<li><a href="http://www.naver.com"><spr:message code="common.naver"/></a></li>
					</sec:authorize>
				</ul>
			</div>
		</div>

		<div class="main-panel">
			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar bar1"></span> <span class="icon-bar bar2"></span>
							<span class="icon-bar bar3"></span>
						</button>
						<a class="navbar-brand" href="#"></a>
					</div>

					<div class="collapse navbar-collapse" >
						<ul class="nav navbar-nav navbar-right">
							<li><sec:authorize access="isAuthenticated()">
									<form method="post" action="${ctx}/logout">
										<sec:csrfInput />
										<button class="btn btn-danger" type="submit" value="로그아웃">로그아웃</button>
									</form>
								</sec:authorize></li>

						</ul>
						<form action="../totalSearch/totalList" method="post" name="totalSearchForm">
							<ul class="nav navbar-nav navbar-right " style="margin: 50px;">
								<li><input type="text" class="form-control" name="totalSearchText" id="totalSearchText" placeholder="통합검색"/></li>
								<li><button type="button" id="totalSearchTextBtn" onclick="checkVali();"><img src="../img/search.png"></button></li>
							</ul>
						</form>
					</div>
				</div>
			</nav>
			<div class="content">
<script>
// function totalSearch() {
// 	console.log($('#totalSearchText').val());
// 	var totalSearchText = $('#totalSearchText').val();
// 	console.log(totalSearchText);
// 	$.ajax({
// 		type: 'post',
// 		url: '${ctx}/totalSearch/totalSearch',
// 		data: {totalSearchText : totalSearchText},
// 		dataType: 'json',
// 		success: function (data) {
// 			alert('성공');
// 		},
// 		error: function (req) {
// 			alert('실패');
// 		}
// 	});
// }
	function checkVali() {
		theForm = document.totalSearchForm;

		if (theForm.totalSearchText.value == "" ) {
			alert("검색어를 입력해주세요.");
			theForm.totalSearchText.focus();
			return false;
		} else {
			theForm.submit();
			alret("고객사 등록이 완료되었습니다.");
		}
	}
	
	$(document).on("click", "#myName", function() {
		location.href = "${ctx}/mypage";
	});
</script>