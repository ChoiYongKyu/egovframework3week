
<!--  주 내용 시작  -->
<h1 class="page-header" hidden="true">공통코드 관리하기</h1>

<div class="row">
	<div class="col-lg-6">
		<div class="col-lg-12 col-xs-10">
			<form action="insertCode" method="post" name="codefm">
			<div class="row">
				<div class="form-group col-lg-7">
					<label><h4>공통코드 추가</h4></label>
				</div>
			</div>
			<div>
			<span class="form-group form-group-sm col-lg-4">
				<input type="text" class="form-control" name="code_key" id="code_key" placeholder="코드 key 값을 입력해주세요."/>
			</span>
			<span class="form-group form-group-sm col-lg-4">
				<input type="text" class="form-control" name="code_value" id="code_value" placeholder="코드 value 값을 입력해주세요."/>
			</span>
				<button type="button" onclick="insertButton()" class="commonBtn">추가</button>
			</div>
			</form>
		</div>
		
	</div>
	
	<!-- --------------------------------------------------------------------------------- -->
	
	<div class="col-lg-6">
		<div class="col-lg-12 col-xs-10">
			<form action="addCode" method="post" name="fm">
			<div class="row">
				<div class="form-group form-group-sm col-lg-7">
				
					<label><h4>공통코드 내용 관리</h4></label>
						<select name="common_code" class="form-control" id="common_code">
							<option value="0">- 선택 -</option>
							<c:forEach var="list" items="${list }">
								<option value="${list.COMMON_CODE_KEY }">${list.COMMON_CODE_VALUE }</option>
							</c:forEach>
						</select>
				</div>
			</div>
			<span class="form-group form-group-sm col-lg-4">
				<input type="text" class="form-control" name="textContent" id="textContent"/>
			</span>
				<button type="button" onclick="addButton()" class="commonBtn">추가</button>
			</form>
			<div id="listDiv" class="col-lg-12 card" hidden="hidden">
				
				<h4>코드 목록${codeList}</h4>
				<ul>
				
				</ul>
			</div>
		</div>
		
	</div>
</div>


<!--  주 내용 끝  -->

<script>
	$('select[name=common_code]').on('change', function() {
		console.log('값 = ' + $('#common_code').val());
		var common_code = $('#common_code').val();
		console.log(common_code);
		if(common_code != 0) {
			$.ajax({
				type : 'post',
				url : 'selectCode',
				data : {
					common_code : common_code
				},
				dataType : "json",
				success : function(data) {
					$('#listDiv').show();
					getResultList(data);
				},
				error : function(request,status,error) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					alert('실패');
				}
			});
		} else {
			$('#listDiv').hide();
		}
	});
	
	function getResultList(data) {
		var dVal = data;
		console.log(dVal);
		console.log(dVal.length);
		
		var html = ""; // var html;  --> 로 초기화 하면 첫칸에 undefind가 뜸
		for (var i = 0; i < dVal.length; i++) {
			html += '<li style="height: 32px" value=' + dVal[i].COMMON_CODE_KEY + '>' + dVal[i].COMMON_CODE_VALUE + '<button class="pull-right" onclick="rowDelete(' + dVal[i].COMMON_CODE_KEY + ',\'' + dVal[i].COMMON_CODE + '\');"><img src="../img/trash.png"></button></li>';
		}
		$('#listDiv').html(html);
// 		html = ""; // var html;  다시 초기화
	}
	
	
	function rowDelete(code_key,code) {
		if(confirm('정말 삭제하시겠습니까?') == true){
			location.href="${ctx }/code/codeDelete?code_key=" + code_key + "&code=" + code;
		}else{
			return;
		}
	}
	
	function insertButton() {
		if(confirm('코드를 추가하시겠습니까?') == true) {
			if (codefm.code_key.value == "") {
				alert('key 값을 입력하세요.');
				codefm.code_key.focus();
				return false;
			} else if(codefm.code_value.value == "") {
				alert('value 값을 입력하세요.');
				codefm.code_value.focus();
				return false;
			} else {
				codefm.submit();
				alert('코드 추가가 완료되었습니다.');
			}
		} else {
			return;
		}
		
	}
	
	function addButton() {
		if (fm.textContent.value == "") {
			alert('추가할 코드 값을 입력하세요.');
			fm.textContent.focus();
			return false;
		} else {
			fm.submit();
		}
	}
</script>

<style>
	
</style>