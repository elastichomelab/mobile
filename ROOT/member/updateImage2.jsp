<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*" %>

<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>

<!-- 썸네일 라이브러리 -->
<%@ page import = "java.awt.image.BufferedImage" %>
<%@ page import = "javax.imageio.ImageIO" %>
<%@ page import = "net.coobird.thumbnailator.Thumbnails" %>

<!-- 세션정보 및 전역변수 -->
<%
String ID   = (String)session.getAttribute("ID");
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

	<!-- 전역변수 선언 및 입력 매개변수값 추출 -->
	<%
	// 한글 처리
	String encoding    = "utf-8";
	// Upload 파일의 최대 크기(10 MBytes) 
	int sizeLimit = 10 * 1024 * 1024; 
	// Upload 파일이 저장되는 폴더(현재 폴더로부터의 상대경로) 
	String relativeDirectory = "contents/member_uploaded";
	ServletContext context = getServletContext();
	// Upload 파일이 저장되는 절대경로(상대경로로부터 인식)
	String realDirectory = context.getRealPath(relativeDirectory);
	// Upload 파일을 저장함
	// 이미지명 중복 시, 다른 이름으로 저장  
	// MultipartRequest multi = new MultipartRequest(request, realDirectory, sizeLimit, encoding, new DefaultFileRenamePolicy());
	// 이미지명 중복 시, 덮어 씀
	MultipartRequest multi = new MultipartRequest(request, realDirectory, sizeLimit, encoding);

	// 파일명 추출
	String my_image = multi.getOriginalFileName("my_image");	
	
	// 원본 파일 읽기
	BufferedImage originalImage = ImageIO.read(new File("C:/jsp_proj/" + relativeDirectory + "/" + my_image));
	// 썸네일 만들기
	Thumbnails.of(originalImage).size(160, 160).toFile(new File("C:/jsp_proj/" + relativeDirectory + "/" + "thumbnail_" + my_image));
    %>
	
	<!-- DB Open -->
	<%@ include file="../include/dbOpen.inc" %>

	<%
	// 이미 등록된 아이디가 있는지 검사
	sql = "update 회원 " + 
		  "   set 회원사진명 = ? " + 
		  "where 회원ID   = ? ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, my_image);
	pstmt.setString(2, ID);
	pstmt.executeUpdate();
	%>				

<%
} catch(IOException e) {
	rst = "시스템에러";
	msg = e.getMessage();
} catch(SQLException e) {
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
// DB 에러 시, 에러 출력화면으로 이동
if(rst.equals("success")) 
	response.sendRedirect("getMyInfo.jsp");
else 
	response.sendRedirect("../error/showError.jsp?rst=" + rst + "&msg=" + msg);
%>