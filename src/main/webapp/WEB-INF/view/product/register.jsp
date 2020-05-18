
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">제품 등록</h1>
<div class="card card-plain">
	<form action="productRegister" method="post" name="fm">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th>제품이름 <span style="color: red;">*</span></th>
					<td><input type="text" placeholder="제품명을 입력하세요."
						name="product_name" class="form-control" maxlength="100" /></td>

				</tr>
				<tr>
					<th>비고</th>
					<td colspan="4"><textarea cols="10" placeholder="내용을 입력하세요. "
							name="product_note" class="form-control"></textarea></td>
				</tr>
				<tr>
					<td colspan="4">
						<button type="button" class="btn btn-xs btn-default"
							onclick="history.back();">취소</button>
						<button type="button" class="btn btn-xs btn-default btn-success"
							onclick="checkVali();">등록</button>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<!--  주 내용 끝  -->

<script>
	function checkVali() {
		theForm = document.fm;

		if (theForm.product_name.value == "") {
			alert("제품 이름을 입력해주세요.");
			theForm.product_name.focus();
			return false;
		} else {
			theForm.submit();
			alret("제품 등록이 완료되었습니다.");
		}
	}
</script>