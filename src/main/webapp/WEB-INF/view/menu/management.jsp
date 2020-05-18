<script src="${ctx }/js/custom/test.js"></script>
<!-- <link rel="stylesheet" href="${ctx }/css/custom/test.css"> -->
<h1 class="page-header">메뉴 관리</h1>
<button id="top_1" type="button" class="add_menu btn btn-sm btn-info">+
	최상위 메뉴 추가</button>
<br>
	<c:forEach items="${menuList }" var="menu" varStatus="index">
		<br>
		<c:choose>
			<c:when test="${menu.level eq 2 }">
				<h4 id="menu_${menu.menu_no }">
					<span>${menu.menu_name }</span> <input type="text" hidden=""
						value="${menu.menu_no }">
					<button type="button" id="add_${menu.menu_no }"
						class="add_menu btn btn-xs btn-primary">추가</button>
					<button type="button" id="del_${menu.menu_no }"
						class="del_menu btn btn-xs btn-danger">삭제</button>
				</h4>
			</c:when>
			<c:otherwise>
				<h6 id="menu_${menu.menu_no }">
					<c:forEach begin="3" end="${menu.level }">
						<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					</c:forEach>
					<span>${menu.menu_name }</span> <input type="text" hidden=""
						value="${menu.menu_no }">
					<button type="button" id="add_${menu.menu_no }"
						class="add_menu btn btn-xs btn-primary">추가</button>
					<button type="button" id="del_${menu.menu_no }"
						class="del_menu btn btn-xs btn-danger">삭제</button>
				</h6>
			</c:otherwise>
		</c:choose>
	</c:forEach>

<div id="menu_dialog" hidden="">
	<table class="table">
		<tr class="menu_add">
			<td><label for="menu_name">메뉴</label> <input type="text"
				id="menu_name"></td>
		</tr>
		<tr class="menu_add">
			<td><label for="url">URL</label> <input type="text" id="url">
			</td>
		</tr>
		<tr class="menu_del">
			<td>삭제하시겠습니까?</td>
		</tr>
	</table>
</div>
<style>
.addDelBox {
	display: inline-block;
	height: 250px;
	margin: 30px 70px 30px 70px;
	width: 20%;
}
</style>