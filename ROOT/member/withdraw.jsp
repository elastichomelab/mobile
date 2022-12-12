<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*" %>

<%
// Session 변수값 추출
String ID   = (String)session.getAttribute("ID");
// 로그인되지 않았으면, 홈으로 이동
if (ID == null)
    response.sendRedirect("../main/index.jsp");
%>

<%
// DB 관련 객체 
Connection        conn  = null;
PreparedStatement pstmt = null;
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
   	// 해당 회원 삭제
    sql = "delete from 회원 " + 
          " where 회원ID = ? ";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, ID);
    pstmt.executeUpdate();
	%>

<%	
} catch(SQLException e) {
	rst = "시스템에러";
	msg = e.getMessage();
} finally {
   	if(pstmt != null) 
   	    pstmt.close();
   	if(conn != null) 
   	    conn.close();
} // try
%>

<!-- 실행 후, 분기 -->
<%
// 삭제 후, 로그아웃으로 이동
if(rst.equals("success"))
	response.sendRedirect("../login/logout.jsp");
// DB 에러 시, 에러출력화면으로 이동
else
	response.sendRedirect("../error/showError.jsp?rst=" + rst + "&msg=" + msg);
%>