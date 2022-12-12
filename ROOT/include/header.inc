<%@ page contentType="text/html;charset=utf-8"%>

<!-- 세션정보 및 전역변수 -->
<%
String ID   = (String)session.getAttribute("ID");
String name = (String)session.getAttribute("name");
%>

<!-- 홈 -->
<a href="../main/index.jsp" data-icon="home" data-iconpos="notext" data-ajax="false">Home</a>
<h1>회원관리시스템</h1>
<%
// 로그아웃 상태이면 
if (ID == null) {
%>	
    <a href="../login/loginForm.jsp" data-role="button" data-theme="d" data-icon="arrow-r" data-inline="true" data-ajax="false">Login</a>	
<%
// 로그인 상태이면
} else { 
%>
    <a href="../login/logout.jsp" data-role="button" data-theme="d" data-icon="arrow-r" data-inline="true" data-ajax="false"><%= ID %>님, Logout</a>	
<%
} // if
%>