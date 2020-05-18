<html>
<head>
<sec:csrfMetaTags/>
<!-- 스프링 시큐리티 csrf 설정시 ajax로 form을 보낼 경우 추가해줘야 함 -->
<!-- 자바스크립트에도 추가해줘야 할 것이 있음 -->
<title><spr:message code='common.join' /></title>
<link rel="stylesheet" href="${ctx }/css/custom/test.css">
<script src="${ctx }/js/custom/test.js"></script>
</head>
<body>
<h1 class="mem_theme"><spr:message code='common.join' /></h1>
<div class="join_form">
	<form:form commandName="memberVO" method="post" action="join">
    	<div class="join">
    		<spr:message code="common.email" var="common_email" />
	    	<form:input path="mem_id" placeholder="${common_email }" require="required" />
	    	<p id="email_valid" hidden="true"><spr:message code='join.email.valid' /></p>
	    	<p id="email_check" hidden="true"><spr:message code='join.email.check' /></p>
	    	<form:errors cssClass="join_error" path="mem_id" />
    	</div>
    	<div class="join">
    		<spr:message code="common.name" var="common_name" />
    		<form:input path="mem_name" placeholder="${common_name }" required="required" maxlength="10"/> 
    		<p id="name_valid" hidden="true"><spr:message code='join.name.valid' /></p>
    		<form:errors cssClass="join_error" path="mem_name"/>
    	</div>
    	<div class="join">
    		<spr:message code="common.password" var="common_pw" />
        	<form:password path="mem_pw" placeholder="${common_pw }" required="required" />
        	<p id="password_valid" hidden="true"><spr:message code='join.password.valid' /></p>
        	<form:errors cssClass="join_error" path="mem_pw" />
        </div>
        <div class="join">
        	<input type="password" id="mem_pw_confirm" placeholder="<spr:message code="join.password.confirm" />" required="required" />
       		<p id="password_confirm_valid" hidden="true"><spr:message code='join.password.confirm.valid' /></p>
       	</div>
       	<div class="join">
       		<spr:message code="common.phone" var="common_phone" />
        	<form:input path="mem_tel" placeholder="${common_phone }" required="required" maxlength="13" />
        	<p id="phone_valid" hidden="true"><spr:message code='join.phone.valid' /></p>
        	<form:errors cssClass="join_error" path="mem_tel"/>
        </div>
        <input type="submit" value="<spr:message code='common.join' />" />
   	</form:form>
    <input type="button" class="move_button" value="<spr:message code='common.cancel' />" id="${ctx }" />
</div>
<script>
	$(function() {
		$('#mem_tel').on('keyup', autoHypen);
	});
	
	// 전화번호 입력시 하이픈(-) 자동 입력
	function autoHypen() {
	    var x = document.getElementById("mem_tel");
	    x.value = x.value.replace(/[^0-9]/g, '');
	    var tmp = "";
	
	    if (x.value.length > 3 && x.value.length <= 7) {
	        tmp += x.value.substr(0, 3);
	        tmp += '-';
	        tmp += x.value.substr(3);
	        x.value = tmp;
	    } else if (x.value.length > 7) {
	        tmp += x.value.substr(0, 3);
	        tmp += '-';
	        tmp += x.value.substr(3, 4);
	        tmp += '-';
	        tmp += x.value.substr(7);
	        x.value = tmp;
	    }
	}
</script>
</body>
</html>