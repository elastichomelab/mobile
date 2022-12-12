<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JSP World</title>
<%@ include file="../include/jQueryMobile.inc" %>
</head>
</head>
<body>

<section data-role="page" id="page1">

	<!-- 1. 헤더 -->
	<header data-role="header" data-theme="b">
		<%@ include file="../include/header.inc" %>
		<%@ include file="../include/menu.inc" %>
	</header> 

	<!-- 2. 본문 -->
	<section data-role="content"> 

		<form method="post" action="join.jsp" data-ajax="false">
		
			<fieldset data-role="fieldcontain">
			
			    <!-- 고객ID -->
				<label for="ID">회원ID:</label>
				<input type="text" id="ID" name="ID" size=10 maxlength=10 required="required"/>
				
			    <!-- 성명 -->
				<label for="name">성명:</label>
				<input type="text" id="name" name="name" size=10 maxlength=10 required="required"/>
				
			    <!-- 비밀번호 -->
				<label for="pswd">비밀번호:</label>
				<input type="password" id="pswd" name="pswd" size=10 maxlength=10 required="required"/>
				
                <!-- 성별 -->
				<fieldset data-role="controlgroup" data-type="horizontal">
					<legend>성별:</legend>
						<input type="radio" name="gender" id="gender-1" value="남"/>
						<label for="gender-1">남</label>

						<input type="radio" name="gender" id="gender-2" value="여"/>
						<label for="gender-2">여</label>
				</fieldset>
				
                <!-- 생일 -->
				<label for="birthday2">생일:</label>
				<input type="date" id="birthday2" name="birthday" required="required"/>

				<!-- 관심분야 -->				    
				<fieldset data-role="controlgroup">
					<legend>관심분야:</legend>
					
					<%
					String interest    = "";
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
						// 관심분야명 추출  
						sql = "select 관심분야명 " + 
							  " from 관심분야 " +        
							  "order by 관심분야명 ";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();		
                        int i=1;						
						while(rs.next()) {
						    interest = rs.getString("관심분야명");
						    %>
							<input type="checkbox" name="interest" id="checkbox-<%= i %>" value="<%= interest %>" />
							<label for="checkbox-<%= i %>"><%= interest %></label>
					        <%
						    i++;
						}
						%>
					
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
					
				</fieldset>				
	
			</fieldset>
			
			<p align="center">
			<button type=submit data-role="button" data-inline="true">등록</button>
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