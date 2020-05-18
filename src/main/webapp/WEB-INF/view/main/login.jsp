<html>
<head>
<meta name="google-signin-client_id" content="490697450654-hpq1m3k9nmnrr76iuibta85i3aijuve0.apps.googleusercontent.com">
<title><spr:message code='common.title' /></title>
<link rel="stylesheet" href="${ctx }/css/custom/test.css">
<script src="${ctx }/js/custom/test.js"></script>
</head>
<body>
<script>
	function postMove(url) {
		var post = document.getElementById("postMove");
		post.action = url;
		post.submit();
	};
	
	function addData(name, value) {
		var element = document.createElement("input");
	    element.setAttribute("type", "hidden");
	    element.setAttribute("name", name);
	    element.setAttribute("value", value);
	 
	    return element;
	};
</script>
<form id="postMove" method="post" action="" hidden="">
   	<sec:csrfInput/>
</form>

<sec:authorize access="hasRole('WAIT')"> 
	<!-- <sec:authentication property="principal.authorities" /> -->
	<script>
		postMove('${ctx }/logout');
		alert("승인대기중");
	</script>
</sec:authorize>
<sec:authorize access="hasAnyRole('MEMBER, ADMIN')">
	<script>
		$(location).prop('href', '${ctx }/home/chart');
	</script>
</sec:authorize>

<div class="login_form">
	<a href="${ctx}"><img id="login_logo" src="${ctx }/img/logo.jpg" /></a>
    
    <form method="post" action="${ctx }/login">
    
    <!-- 스프링 시큐리티 csrf 설정시 form마다 추가해줘야 함 -->
    <!-- 아니면 폼:폼을 사용하면 됨-->
    <sec:csrfInput/>
    <!-- =============== csrf ================ -->
    	
    	<input type="text" name="mem_id" placeholder="<spr:message code='common.email' />" required="required" />
        <input type="password" name="mem_pw" placeholder="<spr:message code='common.password' />" required="required" />
		<c:if test="${param eq '{error=}'}">
			<span style="margin: 30px; color: red;">아이디 혹은 비밀번호가 맞지 않습니다</span>
		</c:if>        
        
        <input type="submit" value="<spr:message code='common.login' />" />
    </form>
    
    <input type="button" class="move_button" value="<spr:message code='common.join' />" id="join"/>
    
    <input type="button" class="move_button" id="find" value="<spr:message code="common.find" />">

	<input type="button" id="googleLogin" value="구글로그인" onclick="login()">
    <input type="button" id="signOut" value="구글로그아웃" onclick="auth2.signOut();" hidden="">
    <input type="button" id="disconnect" value="연동 해제" onclick="auth2.disconnect();" hidden="">
	
	<script>
	var auth2 = {};
	var user= {};
	
	function login() {
		if(typeof(auth2.signIn) == 'undefined') {
			console.log('reload');
			if(gapi.auth2) {
				auth2 = gapi.auth2.getAuthInstance(); // 인증정보
				login();
			} else {
				console.log('Login is required');
				auth2.signIn();
				return;
			}
		}
		
		auth2.signIn().then(function() {
			user = auth2.currentUser.get().getBasicProfile();

			$.ajax({
				url : ctx + '/google',
				type : 'post',
				data : user,
				dataType : 'json',
				success : function(result) {
					console.log(result);
					var post = document.getElementById("postMove");
					post.action = ctx + '/login';
					post.appendChild(addData("mem_id", result.mem_id));
					post.appendChild(addData("mem_pw", result.mem_pw));
					post.submit();
				},
				error : function() {
					console.log('fail');
				}
			});
		}).catch(function(err) {
			/*if(err.error.indexOf('popup_blocked_by_browser') != -1) {
				alert('팝업 허용 바랍니다.');
			} else {
				alert(err);
			}*/
		});
	}
	
	function init() {
		gapi.load('auth2', function() {
			gapi.auth2.init({
				client_id : '490697450654-hpq1m3k9nmnrr76iuibta85i3aijuve0.apps.googleusercontent.com',
				scope : 'email profile', // 구글에서 받아오는 데이터
			}).then(function() {
				auth2 = gapi.auth2.getAuthInstance(); // 인증정보
			});
			
				//apiKey : 'AIzaSyADLbSClmOp4Yof8QL4SKVbhX2_4rVoUhw',
		});
	}

	</script>
	<%-- <script src="https://apis.google.com/js/platform.js?onload=init"></script> --%>
	
	<script>
	// 로그인페이지에서 바로 구글로그인 실행하기
	$.getScript('https://apis.google.com/js/platform.js?onload=init', function() {
		var userDevice = navigator.userAgent;
		var mobileDevice = ['iphone', 'ipad', 'ipot', 'android']; // 디바이스 이름을 소문자로 추가바람
		
		for(i = 0; i < mobileDevice.length; i++) {
			if (userDevice.toLowerCase().indexOf(mobileDevice[i]) != -1) {
				console.log("모바일 접속" + mobileDevice[i]);
				break;
			}
			if(i == mobileDevice.length - 1 && location.search.indexOf('logout') == -1) {
				setTimeout(function() {
					login();
				}, 400);	
				//$('#googleLogin').trigger('click');
			}
		}
	});
	</script>
</div>
</body>
</html>