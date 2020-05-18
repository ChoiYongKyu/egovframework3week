<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spr" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes">
<!-- user-scalable=no   모바일에서 확대 금지-->
<meta name="description" content="">
<meta name="author" content="">
<title>유지보수관리</title>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<script>
	var ctx = "${ctx}";
</script>

<!-- 파비콘 -->
<link rel="shortcut icon" href="${ctx }/img/logo.ico">

<!-- bootstrap -->
<!-- 	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<!-- Bootstrap core CSS     -->
<link href="${ctx}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Animation library for notifications   -->
<link href="${ctx}/bootstrap/css/animate.min.css" rel="stylesheet">
<!--  Paper Dashboard core CSS    -->
<link href="${ctx}/bootstrap/css/paper-dashboard.css" rel="stylesheet">
<%--     <link href="${ctx}/css/dashboard.css" rel="stylesheet"> --%>
<script src="${ctx}/bootstrap/js/ie-emulation-modes-warning.js"></script>
<link href="${ctx}/bootstrap/css/themify-icons.css" rel="stylesheet">

<!-- 폰트 -->
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Nanum+Gothic" rel="stylesheet">

<!--   Core JS Files   -->
<script src="${ctx}/bootstrap/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="${ctx}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<!--  Checkbox, Radio & Switch Plugins -->
<script src="${ctx}/bootstrap/js/bootstrap-checkbox-radio.js"></script>
<!--  Charts Plugin -->
<script src="${ctx}/bootstrap/js/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${ctx}/bootstrap/js/bootstrap-notify.js"></script>
<!-- Paper Dashboard Core javascript and methods for Demo purpose -->
<script src="${ctx}/bootstrap/js/paper-dashboard.js"></script>
<!-- bootstrap end -->
<script src="${ctx}/js/common.js"></script>



<!--날짜 선택하기-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<!--날짜 선택하기 끝-->
<!--날짜 시간 선택하기-->
<link rel="stylesheet" href="${ctx}/css/jquery-ui-timepicker-addon.css" />
<!--    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />-->
<!--    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>-->
<script src="${ctx}/js/jquery-ui-timepicker-addon.js"></script>
<!--날짜 시간 선택하기 끝-->
<!--차트 부분-->
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<!-- 지도 부분 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=193848b4dadaf11f071524faabb396bd&libraries=services"></script>
<script>
// jQuery import 바로아래에 넣어 주면 됩니다.
// Cannot read property 'msie' of undefined 에러 나올때
jQuery.browser = {};
(function () {
    jQuery.browser.msie = false;
    jQuery.browser.version = 0;
    if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
        jQuery.browser.msie = true;
        jQuery.browser.version = RegExp.$1;
    }
})();
</script>
<script>
	var path;
	$(function() {
		var pageHeader = $('h1[class=page-header]').html();
		//헤드라인
		$('a[class=navbar-brand]').html(pageHeader);
		$('h1[class=page-header]').attr('hidden', 'false');

		//사이드바에 표시
		path = $(location).attr('href').split('/').pop();
		pathhome = $(location).attr('href').split('/')[3];
		pathmenu = $(location).attr('href').split('/')[4];
		$("[href='/" + pathhome + "/" + pathmenu + "/" + path + "']").parents("li").addClass('active').css('background-color', '#eef');

		//라디오버튼 컨트롤
		$('input[type=radio]').click(function() {
			$('input:radio').parent().removeClass('btn-fill');
			$('input:radio:checked').parent().addClass('btn-fill');
		});

		$('input:radio:checked').parent().addClass('btn-fill');
		$('span[class=icons]').addClass('hidden');

		// 톰캣 세션 유지시간 6시간으로 변경
		setInterval("autoSession()", 21600000); 
		
		// 페이징 색

		var paramNo = $('#paramNo').val();
		if(paramNo == "") {
			$('#list_1').addClass('active');
		} else {
			$('#list_' + paramNo).addClass('active');
		}
	});
	
	
	function autoSession() {
		location.href = "${ctx}/";
	}
</script>
<style>
	#navId {
		background-color: white;
	}
	
	body {
		font-family: 'Nanum Gothic', sans-serif;
		/* 	overflow-x:hidden; */
		/* 	overflow-y:auto; */
	}
	
	/* The Modal (background) */
	.modal {
		display: none; /* Hidden by default */
		position: fixed; /* Stay in place */
		z-index: 1; /* Sit on top */
		padding-top: 100px; /* Location of the box */
		left: 0;
		top: 0;
		width: 100%; /* Full width */
		height: 100%; /* Full height */
		overflow: auto; /* Enable scroll if needed */
		background-color: rgb(0, 0, 0); /* Fallback color */
		background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
	}
	
	/* Modal Content */
	.modal-content {
		background-color: #fefefe;
		margin: auto;
		padding: 20px;
		border: 1px solid #888;
		width: 80%;
	}
	
	/* The Close Button */
	.close {
		color: #aaaaaa;
		float: right;
		font-size: 28px;
		font-weight: bold;
	}
	
	.close:hover, .close:focus {
		color: #000;
		text-decoration: none;
		cursor: pointer;
	}
	pre {
	 white-space:pre-wrap;
	 min-height: 39px;
	}
	
	.commonBtn {
		border: none;
		background-color: #c6b1d5;
		width: 100px;
		height: 30px;
		color: white;
		margin-bottom: 7px;
	}
</style>
</head>
<c:set var="loc" value="${pageContext.request.contextPath}/se2/SmartEditor2Skin.jsp"/>
<c:set var="vacationView" value="${pageContext.request.contextPath}/WEB-INF/view/approval/vacationView.jsp"/>
<c:set var="consultationView" value="${pageContext.request.contextPath}/WEB-INF/view/approval/consultationView.jsp"/>
<c:set var="expenseView" value="${pageContext.request.contextPath}/WEB-INF/view/approval/expenseView.jsp"/>
<c:set var="expenseView2" value="${pageContext.request.contextPath}/WEB-INF/view/approval/expenseView2.jsp"/>
<c:set var="URL" value="${pageContext.request.requestURI}"/>
<c:if test="${noNav != 0 && URL != loc && URL != vacationView && URL != consultationView && URL != expenseView && URL != expenseView2}">
	<%@include file = "common.jsp" %>
	<%-- <jsp:include page="/WEB-INF/common/common.jsp" flush="true"/> --%>
</c:if>
<div id="chkSession"></div>