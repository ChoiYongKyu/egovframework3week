<script src="https://cdn.jsdelivr.net/npm/signature_pad@2.3.2/dist/signature_pad.min.js"></script>
<script src="${ctx }/js/custom/test.js"></script>

<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<h1 class="page-header" hidden="true"><spr:message code='member.modify'/></h1>
<div class="text-center">
	<div class="modify_form card card-user col-lg-3" style="padding:15px;">
	    <form id="modify" method="post" autocomplete="off">
	    	<input type="hidden" name="mem_no" value="${memberInfo.memNo}"/>
	    	<input type="hidden" name="table" value="member"/>
	    	<input type="hidden" name="upload_no" value="${signInfo.UPLOAD_NO != null ? signInfo.UPLOAD_NO : 0 }"/>
	    	
	    	<div><input type="text" class="infoText form-control border-input" name="mem_id" value="${memberInfo.memId}" readonly/></div>
	    	<div>
	    		<input type="text" class="infoText form-control border-input" name="mem_name" placeholder="${memberInfo.memName}" value="${memberInfo.memName}" required/>
	    		<p id="name_valid" hidden="true"><spr:message code='join.name.valid'/></p>
	    	</div>
	    	
	    	<sec:authentication property='principal.mem_tel' var="mem_tel" />
	    	
	    	<div>
	    		<spr:message code='common.password' var="ps" />
	        	<input type="password" class="infoText form-control border-input" name="mem_pw" ${mem_tel == 'google user' ? 'value=\'********\' readonly disabled' : 'required placeholder='.concat(ps) } />
	        	<p id="password_valid" hidden="true"><spr:message code='join.password.valid'/></p>
	        </div>
	        <div>
	        	<spr:message code='join.password.confirm' var="ps_cn" />
	        	<input type="password" class="infoText form-control border-input" name="mem_pw_confirm" ${mem_tel == 'google user' ? 'value=\'********\' readonly disabled' : 'required placeholder='.concat(ps_cn) } />
	       		<p id="password_confirm_valid" hidden="true"><spr:message code='join.password.confirm.valid'/></p>
	       	</div>
	       	<div>
	       		<input type="text" class="infoText form-control border-input" name="mem_tel" ${mem_tel == 'google user' ? 'readonly' : 'required' } value="${memberInfo.memTel}" placeholder="${memberInfo.memTel}" />
	        	<p id="phone_valid" hidden="true"><spr:message code='join.phone.valid'/></p>
	        </div>
	       	<div>
	       		<select name="mem_dept" class="form-control" style="border:1px solid #CCC5B9;" required>
					<option value="">-소속 선택-</option>
	       			<c:forEach var="deptInfo" items="${deptList}">
	       				<option value="${deptInfo.COMMON_CODE_KEY}" <c:if test="${memberInfo.memDept eq deptInfo.COMMON_CODE_KEY}">selected</c:if>>${deptInfo.COMMON_CODE_VALUE}</option>
	       			</c:forEach>
	       		</select>
	        </div>
	       	<div>
	       		<select name="mem_grade" class="form-control" style="border:1px solid #CCC5B9;" required>
					<option value="">-직급 선택-</option>
	       			<c:forEach var="gradeInfo" items="${gradeList}">
	       				<option value="${gradeInfo.COMMON_CODE_KEY}" <c:if test="${memberInfo.memGrade eq gradeInfo.COMMON_CODE_KEY}">selected</c:if>>${gradeInfo.COMMON_CODE_VALUE}</option>
	       			</c:forEach>
	       		</select>
	        </div>
	        
	        <c:set value="${signInfo.UPLOAD_AFTER }" var="signAddr" />
	        <br/>
	        
			<div class="wrapper" style="height:200px; min-height:200px;">
			  <canvas id="signature-pad" class="signature-pad" style="width:300px; height:150px; border: ridge;"></canvas>
			  <input type="text" id="sign_upload" name="sign_upload">
			</div>
			<div>
				<input type="button" class="btn btn-danger" value="지우기" id="clear"/>
			</div>
			
	        <!-- 
	        <div><p style="text-align: left; font-weight: 600;">서명 업로드</p><input type="file" id="sign_upload" name="sign_upload" style="width:300px; height:330px; border: double 3px; background:url('${ctx }${signAddr == null ? "/img/upload_image.png" : "/download/".concat(signAddr) }') center center no-repeat /contain;" onchange="preview(this)" value="${signInfo.UPLOAD_BEFORE }"/></div>
	        -->
	        <br/>
	        <input type="submit" class="btn btn-success" value="<spr:message code='member.modify'/>"/>
	        <input type="button" class="move_button btn btn-danger" value="<spr:message code='common.cancel'/>" id="${ctx}/mypage"/>
	    </form>
	</div>
</div>

<script>
var signaturePad = new SignaturePad(document.getElementById('signature-pad'), {
	  backgroundColor: 'rgba(255, 255, 255, 1)',
	  penColor: 'rgb(0, 0, 0)'
});
var cancelButton = document.getElementById('clear');

cancelButton.addEventListener('click', function (event) {
  signaturePad.clear();
});

signaturePad.onEnd = function() {
	$('#sign_upload').val(signaturePad.toDataURL());
}

$(function() {
	signaturePad.fromDataURL('${signAddr }');
});

<!--
function preview(input) {
	var sign_img_id = '#' + $(input).prop('id');
	
	if(!$(sign_img_id).val()) {
		$(sign_img_id).css('background', 'url("${ctx }/img/upload_image.png")');
	}
	
    if(input.files && input.files[0]){
      var fileName= input.files[0].name;
      var ext=fileName.substr(fileName.length-3, fileName.length);
      var isCheck=false; 
          if(ext.toLowerCase()=='jpg' || ext.toLowerCase()=='gif' || ext.toLowerCase()=='png'){
          isCheck=true;               
      }
      if(isCheck==false){
          alert("jpg, gif, png만 가능합니다");
          $(input).val("");
          return;
      }
      var reader = new FileReader();
      reader.readAsDataURL(input.files[0]);          
      reader.onload = function(e) {
		$(sign_img_id).css('background', 'url("' + e.target.result + '")');
		$(sign_img_id).css('background-repeat', 'no-repeat');
		$(sign_img_id).css('background-position', 'center center');
		$(sign_img_id).css('background-size', 'contain');
      }
    }
}
-->
</script>