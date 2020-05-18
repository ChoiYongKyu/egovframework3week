<html>
<head>
<title>
<c:choose>
	<c:when test="${find_info eq 'email'}">
		<spr:message code='find.email' />
	</c:when>
	<c:when test="${find_info eq 'pw'}">
		<spr:message code='find.pw' />
	</c:when>
</c:choose>
</title>
<link rel="stylesheet" href="${ctx }/css/custom/test.css">
<script src="${ctx }/js/custom/test.js"></script>
</head>
<body>
<c:choose>
	<c:when test="${find_info eq 'email' }"> <!-- 이메일 찾기 -->
		<c:choose>
			<c:when test="${exist }"> <!-- 존재하는 이메일 -->
				<h1 class="mem_theme"><spr:message code='find.email.check' arguments='${name }, ${email }' /></h1>
				<div class="find_form">
	    			<input type="button" class="move_button" value="<spr:message code='find.pw' />" id="find" />
	    			<input type="button" class="move_button" value="<spr:message code="common.login" />" id="${ctx }" />
	   			</div>
			</c:when>
			
			<c:otherwise> <!-- 존재하지 않는 이메일 -->
				<h1 class="mem_theme"><spr:message code='find.nothing' /></h1>
				<div class="find_form">
			   		<input type="button" class="move_button" value="<spr:message code='find.email' />" id="find" />
			   		<input type="button" class="move_button" value="<spr:message code="common.login" />" id="${ctx }" />
		  		</div>
			</c:otherwise>
		</c:choose>	
    </c:when>
	
	<c:when test="${find_info eq 'pw'}"> <!-- 비밀번호 찾기 -->
		<c:choose>
			<c:when test="${exist }"> <!-- 해당 정보에 맞는 계정 존재 -->
				<h1 class="mem_theme"><spr:message code='find.pw.check' arguments='${email }' /></h1>
				<div class="find_form">
		    		<input type="button" class="move_button" value="<spr:message code="common.login" />" id="${ctx }" />
		   		</div>
			</c:when>
			
			<c:otherwise> <!-- 해당 정보에 맞는 계정 없음 -->
				<h1 class="mem_theme"><spr:message code='find.nothing' /></h1>
				<div class="find_form">
			   		<input type="button" class="move_button" value="<spr:message code='find.pw' />" id="find" />
			   		<input type="button" class="move_button" value="<spr:message code="common.login" />" id="${ctx }" />
		  		</div>
			</c:otherwise>
		</c:choose>
	</c:when>
</c:choose>
</body>
</html>