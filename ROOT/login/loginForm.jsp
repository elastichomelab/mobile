<!DOCTYPE html>
<%@ page contentType="text/html;charset=utf-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JSP World</title>
<%@ include file="../include/jQueryMobile.inc" %>
</head>
<body>

<section data-role="page">

	<!-- 1. 헤더 -->
	<header data-role="header" data-theme="b">
		<%@ include file="../include/header.inc" %>
		<%@ include file="../include/menu.inc" %>
	</header> 

	<!-- 2. 본문 -->
	<section data-role="content"> 

		<form method=post action="login.jsp" data-ajax="false">
		<fieldset data-role="fieldcontain">
		
		    <!-- 회원ID -->
			<label for="ID">회원ID:</label>
			<input type="text" id="ID" name="ID" size="10" maxlength="10" required="required"/>
			
		    <!-- 비밀번호 -->
			<label for="pswd">비밀번호:</label>
			<input type="password" id="pswd" name="pswd" size="10" maxlength="10" required="required"/>
			
		    <!-- 로그인 버튼 -->
			<p align="center">
			<button type="submit" data-role="button" data-inline="true">로그인</button>
			</p>
			
		</fieldset>
		</form>
			
	</section>

	<!-- 3. 푸터 -->
	<footer data-role="footer" data-theme="a" data-position="fixed">
		<%@ include file="../include/businessInfo.inc" %>
	</footer>

</section>
</body>
</html>