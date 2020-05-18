<html>
<head>
<title><spr:message code='common.find' /></title>
<link rel="stylesheet" href="${ctx }/css/custom/test.css">
<script src="${ctx }/js/custom/test.js"></script>
</head>
<body>
<h1 class="mem_theme"><spr:message code='common.find' /></h1>
<div class="find">
	<div class="find_info">
	    <form method="post" action="find"> <!-- ${ctx }/findemail -->
	    	<sec:csrfInput/>
    		<input type="text" disabled="disabled" />
	    	<input type="text" name="mem_name" placeholder="<spr:message code='common.name' />" required="required" />
	        <input type="text" name="mem_tel" placeholder="<spr:message code='common.phone' />" required="required" />
	        <input type="submit" value="<spr:message code='find.email' />" />
	    </form>
	</div>
	<div class="find_info">
	    <form method="post" action="find">
	    	<sec:csrfInput/>
	    	<input type="text" name="mem_id" placeholder="<spr:message code='common.email' />" required="required" />
	        <input type="text" name="mem_name" placeholder="<spr:message code='common.name' />" required="required" />
	        <input type="text" name="mem_tel" placeholder="<spr:message code='common.phone' />" required="required" />
	        <input type="submit" value="<spr:message code='find.pw' />" />
	    </form>
	</div>
	<input type="button" class="move_button" value="<spr:message code='common.cancel' />" id="${ctx }" />
</div>
</body>
</html>