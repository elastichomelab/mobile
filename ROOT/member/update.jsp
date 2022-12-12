<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*" %>

<!-- 세션정보 -->
<%
// Session 변수값 추출
String ID   = (String)session.getAttribute("ID");
// 로그인되지 않았으면, 홈으로 이동
if (ID == null)
    response.sendRedirect("../main/index.jsp");
%>

<!-- 전역변수 선언 및 입력 매개변수값 추출 -->
<%
// DB 관련 객체 
Connection        conn  = null;
PreparedStatement pstmt = null;
String            sql   = "";
String            rst   = "success";
String            msg   = "";
%>

<%
// 입력정보 한글 처리
request.setCharacterEncoding("utf-8");
// 회원 관련 수정정보 추출
String name       = request.getParameter("name");
String pswd       = request.getParameter("pswd");
String gender     = request.getParameter("gender");
String birthday   = request.getParameter("birthday");
String[] interest = request.getParameterValues("interest");
%>

<!-- 비즈니스 로직과 데이터 처리 -->
<%
try {
%>
    <!-- DB Open -->
    <%@ include file="../include/dbOpen.inc" %>
	
    <%
	// 트랜잭션 내의 여러 테이블 수정을 위해 AutoCommit을 중지
	conn.setAutoCommit(false);
	
   	// 회원정보 수정
    sql = "update 회원 " + 
          "   set 성명     = ?, " + 
          "       비밀번호 = ?, " + 
          "       성별     = ?,  " +
          "       생일     = ?  " +
          " where 회원ID   = ? ";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, name);
    pstmt.setString(2, pswd);
    pstmt.setString(3, gender);
	pstmt.setString(4, birthday);
	pstmt.setString(5, ID);    
    pstmt.executeUpdate();
	
	// 관심분야 수정 
	sql = "delete from 회원관심분야 " + 
		  " where 회원ID = ? ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, ID);
	pstmt.executeUpdate();

	// 입력한 각 관심분야 등록
    if (interest != null) {	
		for(int i=0; i<interest.length; i++) {
			sql = "insert into 회원관심분야(회원ID, 관심분야명) " + 
				  " values (?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ID);
			pstmt.setString(2, interest[i]);
			pstmt.executeUpdate();
		}
	}
	
	// 여러 테이블 수정 시 에러가 없으면 commit 처리
	conn.commit();
	
} catch(SQLException e) {
	// 여러 테이블 수정 시 에러가 있으면 rollback 처리
	conn.rollback();

	rst = "시스템에러";
	msg = e.getMessage();
} finally {
   	if(pstmt != null) 
   	    pstmt.close();
   	if(conn != null) 
   	    conn.close();
} 
%>

<!-- 실행 후, 분기 -->
<%
// 수정 후, 조회화면으로 이동
if(rst.equals("success"))
	response.sendRedirect("getMyInfo.jsp");
// DB 에러 시, 에러출력화면으로 이동 
else
	response.sendRedirect("../error/showError.jsp?rst=" + rst + "&msg=" + msg);
%>