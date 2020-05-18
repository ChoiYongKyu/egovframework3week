<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${error eq null}">
			새로고침하고 이동 바랍니다<br/>
			잠시 후 다시 이동바랍니다<br/>
			500 error 발생
		</c:when>
		<c:otherwise>
			새로고침하고 이동 바랍니다<br/>
			잠시 후 다시 이동바랍니다<br/>
			${error }
		</c:otherwise>
	</c:choose>
</body>
</html>