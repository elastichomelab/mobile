<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*" %>

<!-- 전역변수 선언 및 입력 매개변수값 추출 -->
<%
// 입력정보 한글 처리
request.setCharacterEncoding("utf-8");
// 회원 관련 입력정보 추출
String ID         = request.getParameter("ID");
String name       = request.getParameter("name");
String pswd       = request.getParameter("pswd");
String gender     = request.getParameter("gender");
String birthday   = request.getParameter("birthday");
String[] interest = request.getParameterValues("interest");
%>

<%
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

	<%
	// 이미 등록된 아이디가 있는지 검사
	sql = "select * " + 
		  " from 회원 " + 
		  "where 회원ID   = ? ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, ID);
	rs = pstmt.executeQuery();
	
	// 등록된 아이디가 있는 경우          
	if (rs.next()) {
	
		rst = "중복아이디";
		msg = "이미 등록된 아이디입니다!";
		
	// 등록된 아이디가 아닌 경우          
	} else {
	
		// 트랜잭션 내의 여러 테이블 수정을 위해 AutoCommit을 중지
		conn.setAutoCommit(false);
	
		// 회원으로 등록 
		sql = "insert into 회원(회원ID, 성명, 비밀번호, 성별, 생일, 등록일) " + 
			  " values (?, ?, ?, ?, ?, getdate())";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, ID);
		pstmt.setString(2, name);
		pstmt.setString(3, pswd);
		pstmt.setString(4, gender);
		pstmt.setString(5, birthday);
		pstmt.executeUpdate();
		
		for(int i=0; i<interest.length; i++) {
		%>
			<%
			// 회원의 관심분야 등록 
			sql = "insert into 회원관심분야(회원ID, 관심분야명) " + 
				  " values (?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ID);
			pstmt.setString(2, interest[i]);
			pstmt.executeUpdate();
			%>
		<%
		}
		
		// 여러 테이블 수정 시 에러가 없으면 commit 처리
		conn.commit();
		%>
		
		<%
        // 세션 저장
		session.setAttribute("ID", ID);
		session.setAttribute("name", name);
		%>
		
	<%	
	} 
	%>

<%
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