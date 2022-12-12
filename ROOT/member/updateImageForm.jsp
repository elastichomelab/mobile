<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=utf-8"%>
<html>
<head>
<title>JSP World</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
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

		<form method="post" action="updateImage2.jsp" enctype="multipart/form-data" data-ajax="false">
		
			<fieldset data-role="fieldcontain">

  				<h1><%= name %>(<%= ID %>)</h1>
                <!-- 사진 -->				    
				<fieldset data-role="controlgroup">
				    <legend for="my_image">수정 사진:</legend>
                    <input type="file" name="my_image" id="my_image" />
				</fieldset>					
	
			</fieldset>
			
			<p align="center">
			<button type="submit" data-role="button" data-inline="true">수정</button>
			</p>
		</form>
		
	</section>

	<!-- 3. 푸터 -->
	<footer data-role="footer" data-theme="a" data-position="fixed">
		<%@ include file="../include/businessInfo.inc" %>
	</footer>

</section>
</body>
</html>