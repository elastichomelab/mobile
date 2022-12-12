<!DOCTYPE html>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JSP World</title>
<%@ include file="../include/jQueryMobile.inc" %>

<script type="text/javascript">
$(document).ready(function () {
	$("#btnUpdate").click(function (e) {
		location.href = "updateForm.jsp";
	});
	$("#btnImgUpdate").click(function (e) {
		location.href = "updateImageForm.jsp";
	});
});
</script>

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
		String pswd        = "";
		String gender      = "";
		String birthday    = "";
		String image       = "";
		String interest    = "";
		String date_joined = ""; 
		// DB 관련 객체 
		Connection        conn  = null;
		PreparedStatement pstmt = null;
		ResultSet         rs    = null;
		ResultSet         rs2   = null;
		String            sql   = "";
		String            rst   = "success";
		String            msg   = "";
		%>	

		<%
		try {
		%>
			<!-- DB Open -->
			<%@ include file="../include/dbOpen.inc" %>
			
			<%
			// 사용자 회원정보 추출  
			sql = "select * " + 
				  " from 회원 " +        
				  "where 회원ID   = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ID);
			rs = pstmt.executeQuery();
			
			// 등록된 회원인 경우
			if (rs.next()) {
				name        = rs.getString("성명");
				gender      = rs.getString("성별");
				birthday    = rs.getString("생일");
				image       = rs.getString("회원사진명");
				date_joined = rs.getString("등록일");
				
				if (image == null || image.equals(""))
				    image = "sample.png";
				%>
				<br>
				<img width=50% src="../contents/member_uploaded/<%= image %>">
				<h1><%= name %>(<%= ID %>)</h1>
				<b>성별</b>: <%= gender %><br>
				<b>생일</b>: <%= birthday %><br>
				<b>관심 </b>: 
				<%
				// 관심분야 추출 
				sql = "select * " + 
					  " from 회원관심분야 " +        
					  "where 회원ID   = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, ID);
				rs2 = pstmt.executeQuery();
				while (rs2.next()) {
					interest = rs2.getString("관심분야명");
					%>
					<%= interest %>&nbsp 
				<%	
				}
				%>
				<br>
				
				<b>등록 </b>: <%= date_joined %><br>
								
				<center>
				<button id="btnUpdate" data-role="button" data-inline="true">개인정보수정</button>
				<button id="btnImgUpdate" data-role="button" data-inline="true">사진수정</button>
                <a href="#page2" data-role="button" data-inline="true" data-rel="dialog" dta-transition="pop">회원탈퇴</a>				</center>
				
			<%	 
			// 등록된 회원이 아닌 겨우 
			} else {
				rst = "비회원";
				msg = "등록된 회원이 아닙니다!";  
			}
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

<section data-role="page" id="page2">

	<!-- 1. 헤더 -->
	<header data-role="header" data-theme="b">
		<!-- 헤더 타이틀 -->
        <h1>회원탈퇴 확인</h1>
	</header> 

	<!-- 2. 본문 -->
	<section data-role="content"> 

	    <center>
		<br>
		회원탈퇴 시는 모든 정보가 삭제됩니다.<br>
		회원을 탈퇴하시겠습니까?<br><br>
		<a href="withdraw.jsp" data-role="button" data-inline="true" data-theme="b">확인</a>
		<a href="#page1" data-role="button" data-inline="true" data-rel="back" data-theme="c">취소</a>
		</center>
		
	</section>

</section>

<!-- 실행 후, 분기 -->
<%
// DB 에러 시, 에러 출력화면으로 이동
if(!rst.equals("success")) 
	response.sendRedirect("../error/showError.jsp?rst=" + rst + "&msg=" + msg);
%>
</body>
</html>