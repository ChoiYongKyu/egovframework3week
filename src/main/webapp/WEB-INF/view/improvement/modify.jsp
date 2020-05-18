<h1>개선요구 게시판</h1>
<form id="form" method="post" action="insertModify">
	<input hidden="hidden" value='<sec:authentication property="principal.mem_no" />' id="mem_no" name="mem_no"/>
	<input hidden="hidden" value='${modify.IMPROVEMENT_NO }' id="improvement_no" name="improvement_no"/>
	<div>
		제목 : <input type="text" name="improvement_title" value="${modify.IMPROVEMENT_TITLE }"/>
	</div>
	<div>
		내용 : <textarea name="improvement_content">${modify.IMPROVEMENT_CONTENT }</textarea>
	</div>
	<div>
		<input type="submit" value="확인" class="commonBtn"/>
		<input type="button" value="취소" class="commonBtn" onclick="location.href='${ctx }/improvement/ImpList'"/>
	</div>
</form>
