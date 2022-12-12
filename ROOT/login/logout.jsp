<%
// session 해제
session.invalidate();
// 홈페이지로 이동 
response.sendRedirect("../main/index.jsp");
%>