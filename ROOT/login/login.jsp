<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*" %>

<!-- 전역변수 선언 및 입력정보 추출 -->
<%
// 입력정보 한글 처리
request.setCharacterEncoding("utf-8");
// 사용자 입력정보 추출
String ID   = request.getParameter("ID");
String pswd = request.getParameter("pswd");
String name = "";
// DB 관련 객체/변수
Connection        conn  = null;
PreparedStatement pstmt = null;
ResultSet         rs    = null;
String            sql   = "";
String            rst   = "success";
String            msg   = "";
int               cnt   = 0;
%>

<!-- 로그인 처리 -->
<%
try {
%>
    <%@ include file="../include/dbOpen.inc" %>
    
    <%
   	// 등록된 아이디의 여부 검사
	sql = "select 성명 " + 
		  "  from 회원 " + 
		  " where 회원ID   = ? " +
		  "   and 비밀번호 = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, ID);
   	pstmt.setString(2, pswd);
    rs = pstmt.executeQuery();
    
    // 등록된 아이디의 경우, 성명 추출
    if (rs.next()) {
        name = rs.getString("성명");
			
        // 세션 저장
		session.setAttribute("ID", ID);
		session.setAttribute("name", name);
    // 등록된 아이디가 아닌 경우          
    } else {
	    rst = "로그인에러";
		msg = "회원이 아닙니다!";
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

<!-- 실행 후, 분기 -->
<%
// 로그인 후, 사용자 홈으로 이동
if(rst.equals("success")) 
	response.sendRedirect("/main/index.jsp");
// 회원이 아니거나 DB 에러 시, 에러출력 화면으로 이동 
else
	response.sendRedirect("../error/showError.jsp?rst=" + rst + "&msg=" + msg);
%>