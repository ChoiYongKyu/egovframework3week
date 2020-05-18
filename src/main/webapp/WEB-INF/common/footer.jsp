</div>
<c:set var="vacationView" value="${pageContext.request.contextPath}/WEB-INF/view/approval/vacationView.jsp"/>
<c:set var="consultationView" value="${pageContext.request.contextPath}/WEB-INF/view/approval/consultationView.jsp"/>
<c:set var="expenseView" value="${pageContext.request.contextPath}/WEB-INF/view/approval/expenseView.jsp"/>
<c:set var="expenseView2" value="${pageContext.request.contextPath}/WEB-INF/view/approval/expenseView2.jsp"/>
<c:set var="URL" value="${pageContext.request.requestURI}"/>
<c:if test="${URL != vacationView && URL != consultationView && URL != expenseView && URL != expenseView2}">
	<footer class="footer">
		<div class="container-fluid">
			<nav class="pull-left">
				<ul>
					<li><a href="http://nat.nineonesoft.com:8000/login/" target="_blank"> NAS </a></li>
					<li><a href="https://drive.google.com/drive/u/0/team-drives" target="_blank"> Team Drive </a></li>
					<li><a href="https://drive.google.com/drive/folders/1z3BTZf0AHC60WZG7QexAeVBVVjUt9S7l" target="_blank"> OJT Drive </a></li>
				</ul>
			</nav>
			<div class="copyright pull-right">
				&copy;
				<script>
					document.write(new Date().getFullYear())
				</script>
				, made with <i class="fa fa-heart heart"></i> by <a href="http://www.nineonesoft.com" target="_blank"> NineoneSoft </a> Intern
			</div>
		</div>
	</footer>
</c:if>
</body>
</html>