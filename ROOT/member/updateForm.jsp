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
			// 회원정보 추출
			sql = "select * " + 
				  " from 회원 " +        
				  "where 회원ID = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pswd     = rs.getString("비밀번호");
				gender   = rs.getString("성별");	 
				birthday = rs.getString("생일");	 
				image    = rs.getString("회원사진명");	 
				date_joined = rs.getString("등록일");
				
				if (image == null || image.equals(""))
				    image = "sample.png";
				%>
				
				<img width=50% src="../contents/member_uploaded/<%= image %>">
				
				<form method="post" action="update.jsp" data-ajax="false">
				
					<fieldset data-role="fieldcontain">
					
						<!-- 고객ID -->
						<label for="ID">회원ID:</label>
						<input type="text" id="ID" name="ID" value="<%= ID %>" size=10 maxlength=10 readonly />
						
						<!-- 성명 -->
						<label for="name">성명:</label>
						<input type="text" id="name" name="name" value="<%= name %>" size=10 maxlength=10 required="required"/>
						
						<!-- 비밀번호 -->
						<label for="pswd">비밀번호:</label>
						<input type="password" id="pswd" name="pswd" value="<%= pswd %>" size=10 maxlength=10 required="required"/>
						
						<!-- 성별 -->
						<fieldset data-role="controlgroup" data-type="horizontal">
						
						    <legend>성별:</legend>
							<%
							String check_gender = "";
							if (gender.equals("남")) 
								check_gender = "checked";
							%>	
							<input type="radio" name="gender" id="gender-1" value="남" <%= check_gender %> />
							<label for="gender-1">남</label>

							<%
							check_gender = "";
							if (gender.equals("여")) 
								check_gender = "checked";
							%>	
							<input type="radio" name="gender" id="gender-2" value="여" <%= check_gender %> />
							<label for="gender-2">여</label>
								
						</fieldset>
						
						<!-- 생일 -->
						<label for="birthday">생일:</label>
						<input type="date" id="birthday" name="birthday" value="<%= birthday %>" required="required"/>

						<!-- 관심분야 -->				    
						<fieldset data-role="controlgroup">
							<legend>관심분야:</legend>
							<%
							// 관심분야명 추출  
							sql = "select 관심분야명 " + 
								  " from 관심분야 " +        
								  "order by 관심분야명 ";
							pstmt = conn.prepareStatement(sql);
							rs = pstmt.executeQuery();		
							int i=1;
                   			int cnt_interest = 0;				
							while(rs.next()) {
								interest = rs.getString("관심분야명");
								
								// 회원관심분야명 추출  
								sql = "select count(*) as cnt " + 
									  " from 회원관심분야 " +        
									  "where 회원ID = ? " +
									  "  and 관심분야명 = ? ";
								pstmt = conn.prepareStatement(sql);
								pstmt.setString(1, ID);
								pstmt.setString(2, interest);
								rs2 = pstmt.executeQuery();
                                rs2.next(); 								
                                cnt_interest = rs2.getInt("cnt");	
                                String check_interest = "";
                                if (cnt_interest > 0) 
                                    check_interest = "checked";	
          					    %>
								<input type="checkbox" name="interest" id="checkbox-<%=i%>" value="<%= interest %>" <%= check_interest %> />
								<label for="checkbox-<%=i%>"><%= interest %></label>
								<%
								i++;
							} // while(125행)
							%>
							
					    </fieldset>
					
					</fieldset>
					
					<p align="center">
					<button type=submit data-role="button" data-inline="true">수정</button>
					</p>
				</form>
		
		    <%	    
			} // if(58행)
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
		} // try
        %>
		
		<!-- 실행 후, 분기 -->
		<%
		// DB 에러 시, 에러출력화면으로 이동
		if(!rst.equals("success"))
			response.sendRedirect("../error/showError.jsp?rst=" + rst + "&msg=" + msg);
		%>
		
	</section>

	<!-- 3. 푸터 -->
	<footer data-role="footer" data-theme="a" data-position="fixed">
		<%@ include file="../include/businessInfo.inc" %>
	</footer>

</section>
</body>
</html>