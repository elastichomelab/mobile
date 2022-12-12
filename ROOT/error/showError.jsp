<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=utf-8"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JSP World</title>
<%@ include file="../include/jQueryMobile.inc" %>
</head>
</head>
<body>

<!-- 전역변수 선언 및 입력 매개변수값 추출 -->
<%
// 입력정보 한글 처리
request.setCharacterEncoding("utf-8");
// 입력 에러정보 추출 
String rst = request.getParameter("rst");
String msg = request.getParameter("msg");
%>

<section data-role="page">

	<!-- 1. 헤더 -->
	<header data-role="header" data-theme="b">
		<%@ include file="../include/header.inc" %>
		<%@ include file="../include/menu.inc" %>
	</header> 

	<!-- 2. 본문 -->
	<section data-role="content"> 

		<frameset>
			<legend>에러 내용</legend>  
			결과: <%= rst %><br>
			에러: <%= msg %>
		</frameset>
			
	</section>

	<!-- 3. 푸터 -->
	<footer data-role="footer" data-theme="a" data-position="fixed">
		<%@ include file="../include/businessInfo.inc" %>
	</footer>

</section>
</body>
</html>