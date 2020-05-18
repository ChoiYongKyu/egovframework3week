
<!-- 주 내용 시작 -->
<!-- 네이버에디터  -->
<script type="text/javascript" src="../se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery/1.9.0/jquery.js"></script>

<h1 class="page-header" hidden="true">개선요구 게시판</h1>
<div class="card card-plain">
	<div class="content">
		<div class="row">
			<form action="" method="post" name="fm" encType="multiplart/form-data" id="form">
			<input type="hidden" name="table" value="IMPROVEMENT" />
				<input hidden="hidden" value='<sec:authentication property="principal.mem_no" />' id="mem_no" name="mem_no"/>
				<div class="col-lg-10 card">
					<div class="header">
						<h4>개선/요구</h4>
					</div>
					<div class="content">
						<div class="col-lg-12">
							<div class="form-group">
								<label>글 번호<span style="color:red;">*</span>
								</label>
								<textarea cols="10" name="no" class="form-control border-input" readonly="readonly">${register.IMPROVEMENT_NO_NEXT}</textarea>
							</div>
						</div>
						<div class="col-lg-12">
							<div class="form-group">
								<label>제목<span style="color:red;">*</span>
								</label>
								<textarea cols="10" name="improvement_title" class="form-control border-input"></textarea>
							</div>
						</div>

						<div class="col-lg-12">
							<div class="form-group">
								<label>내용<span style="color:red;">*</span>
								</label>
								<textarea cols="30" rows="10" id="ir1" name="improvement_content" style="width:766px; height:412px;"></textarea>
							</div>
						</div>
			
							<div class="col-lg-6 ">
								<div class="card">
									<div class="header">
										<div class="col-lg-6"><label>파일 첨부하기</label></div>
										<div class="col-lg-6 text-right"><label class="btn btn-xs btn-default" style="margin: 3px 0 15px 0;">
											<input type="file" id="Files" name="Files" class="hidden"  multiple hidden="true">
											파일 선택
											</label>
										</div>
									</div>
									<div>
										<table class="table table-hover" id="fileList">
											<tr>
												
											</tr>
										</table>
									</div>
								</div>
							</div>
						
						<div class="col-lg-12">
							<button type="button" class="btn btn-xs btn-default" onclick="location.href='${ctx }/improvement/ImpList'">취소</button>
							<button type="button" class="btn btn-xs btn-default btn-success" id="fileUpload">등록</button>
						</div>

					</div>
				</div>
			</form>
		</div>
	</div>
</div>



<%-- by최승우
 <form id="form" method="post" action="insertImprovement">
	<input hidden="hidden" value='<sec:authentication property="principal.mem_no" />' id="mem_no" name="mem_no"/>
	<div>
		제목 : <input type="text" name="improvement_title"/>
	</div>
	<div>
		내용 : <textarea name="improvement_content"></textarea>
	</div>
	<div>
		<input type="submit" value="확인" class="commonBtn"/>
		<input type="button" value="취소" class="commonBtn" onclick="location.href='${ctx }/improvement/list'"/>
	</div>
</form> --%>



<script type="text/javascript">


var oEditors = []; 
$(function(){ 
	nhn.husky.EZCreator.createInIFrame({ 
		oAppRef: oEditors, 
		elPlaceHolder: "ir1", 
		//SmartEditor2Skin.html 파일이 존재하는 경로
		sSkinURI: "../se2/SmartEditor2Skin.jsp",	
		htParams : { 
			
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseToolbar : true,	
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseVerticalResizer : true,	
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseModeChanger : true,	
			fOnBeforeUnload : function(){ } 
		}, 
		fOnAppLoad : function(){ 
			//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용 
			oEditors.getById["ir1"].exec("PASTE_HTML", ["기존 DB에 저장된 내용을 에디터에 적용할 문구"]); 
		}, 
	fCreator: "createSEditor2" }); 
});




function checkVali() {
	theForm = document.fm;

	if (theForm.bugreport_problem.value == "") {
		alert("문제를 입력해주세요.");
		theForm.bugreport_problem.focus();
		return false;
	} else if (theForm.bugreport_answer.value == "") {
		alert("해결을 입력해주세요.");
		theForm.bugreport_answer.focus();
		return false;
	} else {
		alert("글 작성이 완료되었습니다.");
	
		theForm.submit();
	}
}

function onClickImg(imgName){
// 	alert(imgName);
	console.log(this);
	var path = '..\\download\\' + imgName; 
	
	$('#modal-img').attr('src',path);
// 	modal-dialog
}

$('a[name=file]').on('click', function(e){
	e.preventDefault();
 	window.open("${ctx }/file/download?no=" + $(this).attr('id'),"_black");
});

$('a[name=delete]').on('click', function(e){
	e.preventDefault();
	if(confirm("파일을 삭제하시겠습니까?")) {
		var url = '${ctx }/file/delete?no=' + $(this).attr('id');
		$.ajax({
			type : 'get',
			url : url,
			dataType : 'json',
			success : function(data) {
				window.location.reload();
			},
			error : function(req) {
				console.log(req);
				console.log('실패');
			}
		});
	}else {
		return;
	}
});

$('#Files').on('change', function(e) {
	handleImgFileSelect(e)
});

function handleImgFileSelect(e) {
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	$('#fileList').empty();
	filesArr.forEach(function(f) {
		var sel_file = [];
		sel_file.push(f);
		var reader = new FileReader();
		reader.onload = function(e) {
			var filelist = '<tr><td>' + f.name + '</td><tr>';
			$('#fileList').append(filelist);
		}
		reader.readAsDataURL(f);
	});
}

$('#fileUpload').on('click',function(){
	var form = $('#form')[0];
	var formData = new FormData(form);
	
	console.log(formData);
	/* $.ajax({
		type : 'post',
		url : '${ctx}/file/upload',
		processData : false,
		contentType : false,
		data : formData,
		dataType : 'json',
		success : function(data) {
			//window.location.reload();
		},
		error : function(req) {
			console.log(req);
			console.log('실패');
		}
	}); */
	
	$.ajax({
		type : 'post',
		url : '${ctx}/improvement/insertImprovement',
		processData : false,
		contentType : false,
		data : formData,
		dataType : 'json',
		success : function(data) {
		},
		error : function(req) {
			console.log(req);
			console.log('실패');
		}
	});
	
	window.location.href = '${ctx}/improvement/ImpList';
	
	
});





</script>
