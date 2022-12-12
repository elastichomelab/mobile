<!DOCTYPE html>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*" %>
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
	
		<!-- 전역변수 선언 및 입력 매개변수값 추출 -->
		<%
		// 회원 관련 객체 
		String member_ID   = "";
		String member_name = "";
		String pswd     = "";
		String gender   = "";
		String birthday = "";
		String image    = "";
		String date_joined = ""; 
		// DB 관련 객체 
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		String            sql   = "";
		String            rst   = "success";
		String            msg   = "";
		%>	

		<%
		try {
		%>
			<!-- DB Open -->
			<%@ include file="../include/dbOpen.inc" %>
			
			<ul data-role="listview" data-inset="true" data-theme="e"> 
			
			<li date-role="list-divider" data-theme="a">회원 목록</li>  
			
			<%
			// 사용자 회원정보 추출  
			sql = "select * " + 
				  " from 회원 " +
				  "order by 성명 "; 
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// 등록된 회원인 경우
			while(rs.next()) {
				member_ID   = rs.getString("회원ID");
				member_name = rs.getString("성명");
				gender      = rs.getString("성별");
				birthday    = rs.getString("생일");
				image       = rs.getString("회원사진명");
				date_joined = rs.getString("등록일");
				
				if (image == null || image.equals(""))
				    image = "sample.png";
				%>
				
				<li data-role="list-divider">
				<a href="memberDialog.jsp?member_ID=<%= member_ID %>" data-rel="dialog" data-transition="pop">
					<img src="../contents/member_uploaded/<%= image %>" width=100% height=100%>
					<h3><%= member_name %>(<%= member_ID %>)</h3>
					<p>성별: <%= gender %>, 생일: <%= birthday %></p>
					<p>등록: <%= date_joined.substring(0, 10) %></p>
				</a>
				</li>				
			<%	 
			} 
			%>
			
			</ul>	
			
        <%			
		} catch(SQLException e) {
			rst = "시스템에러";
			msg = e.getMessage();
		} finally {
			if(rs != null) 
				rs.close();
			if(pstmt != null) 
				pstmt.close();
			if(conn != null) 
				conn.close();
		} 
		%>
				
	</section>

	<!-- 3. 푸터 -->
	<footer data-role="footer" data-theme="a" data-position="fixed">
		<%@ include file="../include/businessInfo.inc" %>
	</footer>

</section>

<!-- 실행 후, 분기 -->
<%
// DB 에러 시, 에러 출력화면으로 이동
if(!rst.equals("success")) 
	response.sendRedirect("../error/showError.jsp?rst=" + rst + "&msg=" + msg);
%>
</body>
</html>