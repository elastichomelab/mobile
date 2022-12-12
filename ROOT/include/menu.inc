<%@ page contentType="text/html;charset=utf-8"%>

<nav data-role="navbar">
	<ul> 
		<%
		// 로그아웃 상태이면 
		if (ID == null) {
		%>	
			<li><a href="../member/joinForm.jsp" data-ajax="false">회원 등록</a></li>
			<li><a href="../help/help.jsp" data-ajax="false">도움말</a></li>
		<%
        // 로그인 상태이면
		} else {	
		%>
			<li><a href="../member/memberList.jsp" data-ajax="false">회원 목록</a></li>
			<li><a href="../statistics/chart_bar_interest.jsp" data-ajax="false">회원 통계</a></li>
			<li><a href="../member/getMyInfo.jsp" data-ajax="false">내 정보</a></li>
			<li><a href="../help/help.jsp" data-ajax="false">도움말</a></li>
		<%
		}
		%>
	</ul> 
</nav>