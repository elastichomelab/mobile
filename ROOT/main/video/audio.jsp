<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=utf-8"%>
<html>
<head>
	<title>JSP World</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- jQuery/jQuery Mobile 라이브러리 사용 -->
	<%@ include file="../../include/jQueryMobile.inc" %>

	<script type="text/javascript">

		$(function() {
			$('ul li a').click(function() {
				// 클릭된 개체(this) 내의 div 엘리먼트의 데이터(text) 추출
				var videoTitle = $(this).find('div').text();

				// audio 엘리먼트 인식(배열로 반환)
				var myAudio = $("#audio");
				// 오디오(첫 번째 매열값에 해당) 중지
				myAudio.get(0).pause();
				// 오디오 소스 경로 설정
				myAudio.attr('src', "./audio/" + videoTitle);
				// 오디오(첫 번째 매열값에 해당) 실행
				myAudio.get(0).play();
			});
		});

	</script>
</head>

<body>

<section data-role="page">
	<!-- 1. 헤더 -->
	<header data-role="header" data-theme="b">
		<!-- 헤더 타이틀 -->
		<h1>오디오 목록</h1>
	</header> 

	<!-- 2. 본문 -->
	<section data-role="content">

		<%
			String[] title = {"케로로", "원피스", "코난", "퇴사", "너에게 닿기를"};
			String[] subtitle = {"양정화", "코요테", "오노 가쓰오", "10cm"};
			String[] file_name = {"1.mp3", "2.mp3", "3.mp3", "4.mp3", "5.mp3"};
			String[] time = {"01:34", "02:38", "04:26", "02:54", "2:30"};
		%>
	    <!-- 목록 -->
		<ul data-role="listview" data-inset="true" data-theme="e"> 

			<%
				for (int i=0; i<4; i++){
			%>
			<li>
				<a href="#">			
					<!-- 오디오: 제목, 아티스트, 소스, 재생시간 -->
					<h3><%= title[i] %></h3>
					<p>
						<%= subtitle[i] %><br>
						<div style="display: none"><%= file_name[i]%></div>
					</p>
					<p class="ui-li-aside"><strong><%= time[i]%></strong>분</p>
                </a>
			</li>
			<%
				}
			%>
	    <!-- 오디오 재생 영역 -->
		<center>
		<audio id="audio" controls></audio>
		</center>
	</section>

	<!-- 3. 푸터 -->
	<footer data-role="footer" data-theme="a" data-position="fixed">
        <%@ include file="../../include/businessInfo.inc" %>
	</footer>

</section> 

</body>
</html>