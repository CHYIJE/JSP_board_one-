<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/common.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/signIn.css">
</head>
<body>
	<div class="container">
		<h2>로그인</h2>
		<c:if test="${not empty errorMessage}">
			<p style="color: red;">${errorMessage}</p>
		</c:if>
		
		<form action="${pageContext.request.contextPath}/user/signin" method="post">
			<div class="form-group">
				<label for="usernme" >Username : </label>
				<input type="text" id="username" name="username" value="이성계" required>
			</div>
			
			<div class="form-group">
				<label for="password" >Password : </label>
				<input type="text" id="password" name="password" value="asd123" required>
			</div>
			
			<div class="form-group">
				<input class = "btn btn-primary" type="submit" value="로그인">
			</div>			
		</form>
	</div>
	
</body>
</html>