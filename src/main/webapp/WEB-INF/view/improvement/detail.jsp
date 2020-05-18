
<div style="width:auto ; margin:0 auto;">
	<div class="card" style="border:1px solid #d9d9d9;background: white; ">
		<div style="padding:15px;">
			<div style="border-bottom:1px dashed #bfbfbf; height:40px; padding:5px; virtical-align:middle;">
				<span>${detail.IMPROVEMENT_TITLE }</span>
				<span style="float:right;">${detail.IMPROVEMENT_WRITE_DATE }</span>
			</div>
			<div style="height:600px;">
				<div style="margin:5px; float: right; padding-top: 5px;">
					<span>${detail.MEM_NAME }</span>				
				</div>
				<div style="padding:20px; padding-top: 30px;" >
					<span><c:out value="${detail.IMPROVEMENT_CONTENT }" escapeXml="flase" /></span>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 파일추가 폼 -->
	<form action="" method="post" encType="multiplart/form-data" id="form">	
		<input type="hidden" name="table" value="IMPROVEMENT" />
		<input hidden="hidden" value="${detail.IMPROVEMENT_NO }" name="no"/>
		<div class="row">
			
			<div class="col-lg-6 ">
				<div class="card">
					<div class="alert">
						<ul class="pagination">
							<li><label>첨부파일</label></li>
						</ul>
						
						<table class="table table-hover">
							<c:forEach items="${fileList }" var="fileList">
								<tr>
									<td><a href="#this" name="file" id="${fileList.UPLOAD_NO }">${fileList.UPLOAD_BEFORE }</a></td>
									<td style="color: black;">${fileList.UPLOAD_TIME }</td> 
									<sec:authorize access="hasRole('ADMIN')">
										<td><a href="#" name="delete" id="${fileList.UPLOAD_NO }" class="hidden-xs">삭제</a></td>
									</sec:authorize>
								</tr>
							</c:forEach>
						</table>
						
					</div>
				</div>
			</div>
			<sec:authorize access="hasRole('ADMIN')">
				<div class="col-lg-6 ">
					<div class="card">
						<div class="header">
							<div class="col-lg-6" style="margin-top: 19px;"><label>파일 첨부하기</label></div>
							<div class="col-lg-6 text-right"><label class="btn btn-xs btn-default" style="margin: 15px 10px 15px 0px;">
								<input type="file" id="Files" name="Files" class="hidden"  multiple hidden="true">
								파일 선택
								</label>
								<a href="#" id="fileUpload">파일추가</a>
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
			</sec:authorize>
		</div>
		</form>
	
	
	
	<div style="text-align:right; margin-top:20px;">
		<input type="button" value="수정하기" class="commonBtn" onclick="location.href='${ctx }/improvement/modify?no=${detail.IMPROVEMENT_NO}'"/>
		<input type="button" value="목록으로" class="commonBtn" onclick="location.href='${ctx }/improvement/ImpList'"/>
		<input type="button" value="삭제하기" class="commonBtn" onclick="doDelete(${detail.IMPROVEMENT_NO});"/>
	</div>
</div>


<script>
function doDelete(no) {
	if (confirm("정말 삭제하시겠습니까?")) {
		
		$.ajax({
			type: 'get',
			url: 'deleteImprovement',
			data: {
				no: no
			},
			dataType: "json",
			success: function (data) {
				alert("삭제가 완료되었습니다.");
			},
			error: function (req) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				console.log('에러');
			}
		});
		location.href = "ImpList";
	} else {
		return false;
	}
}

function doModify(no) {
	
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
	$.ajax({
		type : 'post',
		url : '${ctx}/file/upload',
		processData : false,
		contentType : false,
		data : formData,
		dataType : 'json',
		success : function(data) {
			window.location.reload();
		},
		error : function(req) {
			console.log(req);
			console.log('실패');
		}
	});
});
</script>