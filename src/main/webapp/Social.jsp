<%@page import="com.crawlstars.model.blocksDAO"%>
<%@page import="com.crawlstars.model.blocks"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.specification.User"%>
<%@page
	import="se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest"%>
<%@page import="com.crawlstars.model.follows"%>
<%@page import="com.crawlstars.model.followsDAO"%>
<%@page import="java.util.List"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.specification.Image"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.specification.Playlist"%>
<%@page
	import="se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest"%>
<%@page import="se.michaelthelin.spotify.SpotifyApi"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 음악플레이어를 위한 css -->
<style>

#wrapper {
   width: 100%;
   height: 100%;
}

.first {
   float: left;
   background-color: black;
   width: 33%;
   height: 64px;
   text-align: center;
}

.second {
   float: right;
   background-color: black;
   width: 67%;
   height: 64px;
   text-align: center;
}

.second-first {
   float: left;
   background-color: black;
   width: 50%;
   height: 100%;
   text-align: center;
}

.second-second {
   float: right;
   background-color: black;
   width: 50%;
   height: 100%;
   text-align: center;
}

.first-first {
   float: left;
   background-color: black;
   width: 20%;
   height: 64px;
   text-align: center;
}

.first-second {
   float: right;
   background-color: black;
   width: 80%;
   height: 64px;
   text-align: left;
   vertical-align: middle;
}

.playingAlbum {
   height: 64px;
   width: 64px;
   border-radius: 10px;
}

.nextAlbum {
   height: 64px;
   width: 64px;
   border-radius: 10px;
}

.music-bar-container {
   width: 100%;
   height: 2px;
   background-color: #ddd;
}

.music-bar {
   height: 100%;
   background-color: #4CAF50;
   width: 0%; /* 초기 너비는 0으로 설정 */
}

#playerCon {
   height: 70%;
}

#playerCon button {
   position: relative;
   top: 10px;
}

#volumeSlider {
   -webkit-appearance: none;
   width: 100px;
   height: 3px;
   border-radius: 5px;
   background: gray; /* 왼쪽은 초록색, 나머지는 하얀색 */
   outline: none;
   opacity: 0.7;
   -webkit-transition: .2s;
   transition: opacity .2s;
}

#volumeSlider:hover {
   opacity: 1;
   background: white;
}

#volumeSlider::-webkit-slider-thumb {
   -webkit-appearance: none;
   appearance: none;
   width: 20px;
   height: 20px;
   border-radius: 50%;
   background: #40ad65; /* 썸 색상을 변경 */
   cursor: pointer;
   border: 2px solid #4CAF50; /* 썸 테두리 색상 변경 */
   -webkit-transition: .3s;
   transition: background .3s;
}

#volumeSlider::-webkit-slider-thumb:hover {
   background: #388E3C; /* hover 시 썸 색상 변경 */
}

#volumCon {
   height: 100%;
   float: right;
   width: 70;
}

#CurrentTrack_Detail {
   background-color: rgb(18, 18, 18);
   color: #fff;
   padding: 20px;
   position: fixed;
   top: 0;
   right: 0; /* 오른쪽으로 고정 */
   width: 300px; /* 네비게이션 바의 너비 */
   height: 100%; /* 화면 높이 만큼 확장 */
   display: none;
   box-sizing: border-box; /* padding을 포함하여 전체 너비를 유지 */
   overflow-y: auto; /* 만약 네비게이션 바가 화면보다 길면 스크롤을 생성 */
}

#CurrentTrack_Detail .first {
   float: none;
   background-color: rgb(18, 18, 18);
   width: 100%;
   height: 64px;
   text-align: center;
}

#CurrentTrack_Detail .first-first {
   float: left;
   background-color: rgb(18, 18, 18);
   width: 30%;
   height: 64px;
   text-align: center;
}

#CurrentTrack_Detail .first-second {
   float: right;
   background-color: rgb(18, 18, 18);
   width: 70%;
   height: 64px;
   text-align: left;
}

#CurrentTrack_Detail div:hover {
   background-color: #555;
}

#CurrentTrack_Detail_close {
   float: right;
}

#CurrentTrack_Detail #NextQueue .first {
   margin: 10% auto;
}

.MakePlaylist {
   float: right;
}

#playerPosition {
   float: left;
   margin-top: 25px;
   font-size: 10px;
   color: gray;
}

#playerDuration {
   float: right;
   margin-top: 25px;
   font-size: 10px;
   color: gray;
}

#playerDuration:hover, #playerPosition:hover {
   color: white;
}

.plInfoImg {
   width: 300px;
   height: 265px;
}

.PlaylistLibrary span {
   margin-left: 10px;
}

#MyPlaylist {
   margin-top: 25px;
}

Button {
   background-color: rgb(18, 18, 18);
   color: white;
   border: none;
   padding: 10px 20px;
   font-size: 16px;
   font-weight: bold;
   text-transform: uppercase;
   cursor: pointer;
   border-radius: 5px;
   transition: background-color 0.3s ease;
   height: 16px;
   line-height: 0px;
}

Button:hover {
   background-color: #333; /* 마우스 오버 시 약간 어두운 색상으로 변경 */
}

/* 버튼 간 간격 설정 */
#togglePlay {
   margin-left: 5px;
   margin-right: 5px;
}


</style>
<style>
/* 스타일링을 위한 CSS */
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background-color: black;
}

header {
	background-color: #333;
	color: #fff;
	padding: 10px;
	position: fixed; /* 헤더를 화면 상단에 고정 */
	width: 100%; /* 헤더의 너비를 화면 전체로 설정 */
	z-index: 2; /* 헤더를 사이드바 위에 표시 */
}

.PlaylistMain {
	width: 100%;
	color: white;
	margin-left: 20px;
}

.PlaylistLibSearch {
	width: 20%;
	float: left;
	margin-right: 5px;
	height: 600px;
	position: fixed;
}

.PlaylistSearch {
	width: 100%;
	height: 20%;
	background-color: rgb(18, 18, 18);
	border-radius: 20px;
	margin-bottom: 10px;
	text-align: center;
}

.PlaylistDetail {
	overflow-y: auto;
	height: 600px;
}

.PlaylistSearch button {
	margin-bottom: 5px;
}

input {
	border-radius: 20px;
	padding: 10px;
	outline: none;
	width: 230px;
	background-image: url('images/SearchQ.png');
	background-repeat: no-repeat;
	background-position: left center;
	padding-left: 20px;
	background-size: 20px 20px;
	background-color: rgb(36, 36, 36);
	margin: 20px;
	margin-bottom: 25px;
	color: white;
}

input:hover {
	border: 1px solid white;
}

input:focus {
	border: 1px solid white;
}

.PlaylistLibrary {
	width: 100%;
	height: 77%;
	background-color: rgb(18, 18, 18);
	border-radius: 20px;
	padding-top: 10px;
}

.PlaylistDetail {
	width: 78%;
	float: right;
	background-color: rgb(18, 18, 18);
	border-radius: 20px;
	margin-bottom: 64px;
}

#menu {
	width: 200px; /* 사이드바의 너비 */
	position: fixed; /* 페이지 스크롤과 상관없이 고정 */
	top: 0; /* 화면 상단부터 고정 */
	left: -200px; /* 초기에는 사이드바를 왼쪽으로 숨김 */
	height: 100%; /* 화면 전체 높이 */
	background-color: rgb(18, 18, 18);
	padding-top: 50px; /* 헤더와 겹치지 않도록 조정 */
	transition: left 0.3s ease; /* 부드러운 이동 효과를 위한 transition */
}

#menu ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

#menu li a {
	display: block;
	padding: 10px;
	text-decoration: none;
	color: #333;
}

#menu li a:hover {
	background-color: #ddd;
}

.playlistLine {
	display: grid;
	grid-template-columns: repeat(4, 1fr);
}

.playlist {
	margin-left: 20px; /* 사이드바가 숨겨진 경우 여백을 조정 */
	padding: 20px;
}

footer {
	position: fixed;
	bottom: 0;
	width: 100%;
	color: white;
}

#wrapper {
	width: 100%;
	height: 100%;
}

.first {
	float: left;
	background-color: black;
	width: 33%;
	height: 64px;
	text-align: center;
}

.second {
	float: right;
	background-color: black;
	width: 67%;
	height: 64px;
	text-align: center;
}

.second-first {
	float: left;
	background-color: black;
	width: 50%;
	height: 100%;
	text-align: center;
}

.second-second {
	float: right;
	background-color: black;
	width: 50%;
	height: 100%;
	text-align: center;
}

.first-first {
	float: left;
	background-color: black;
	width: 20%;
	height: 64px;
	text-align: center;
}

.first-second {
	float: right;
	background-color: black;
	width: 80%;
	height: 64px;
	text-align: left;
	vertical-align: middle;
}

.playingAlbum {
	height: 64px;
	width: 64px;
	border-radius: 10px;
}

.nextAlbum {
	height: 64px;
	width: 64px;
	border-radius: 10px;
}

.music-bar-container {
	width: 100%;
	height: 2px;
	background-color: #ddd;
}

.music-bar {
	height: 100%;
	background-color: #4CAF50;
	width: 0%; /* 초기 너비는 0으로 설정 */
}

#playerCon {
	height: 70%;
}

#playerCon button {
	position: relative;
	top: 10px;
}

#volumeSlider {
	-webkit-appearance: none;
	width: 100px;
	height: 3px;
	border-radius: 5px;
	background: gray; /* 왼쪽은 초록색, 나머지는 하얀색 */
	outline: none;
	opacity: 0.7;
	-webkit-transition: .2s;
	transition: opacity .2s;
	margin: 0px;
	padding: 0px;
}

#volumeSlider:hover {
	opacity: 1;
	background: white;
}

#volumeSlider::-webkit-slider-thumb {
	-webkit-appearance: none;
	appearance: none;
	width: 20px;
	height: 20px;
	border-radius: 50%;
	background: #40ad65; /* 썸 색상을 변경 */
	cursor: pointer;
	border: 2px solid #4CAF50; /* 썸 테두리 색상 변경 */
	-webkit-transition: .3s;
	transition: background .3s;
}

#volumeSlider::-webkit-slider-thumb:hover {
	background: #388E3C; /* hover 시 썸 색상 변경 */
}

#volumCon {
	height: 100%;
	float: right;
	width: 70;
}

#CurrentTrack_Detail {
	background-color: rgb(18, 18, 18);
	color: #fff;
	padding: 20px;
	position: fixed;
	top: 0;
	right: 0; /* 오른쪽으로 고정 */
	width: 300px; /* 네비게이션 바의 너비 */
	height: 100%; /* 화면 높이 만큼 확장 */
	display: none;
	box-sizing: border-box; /* padding을 포함하여 전체 너비를 유지 */
	overflow-y: auto; /* 만약 네비게이션 바가 화면보다 길면 스크롤을 생성 */
}

#CurrentTrack_Detail .first {
	float: none;
	background-color: rgb(18, 18, 18);
	width: 100%;
	height: 64px;
	text-align: center;
}

#CurrentTrack_Detail .first-first {
	float: left;
	background-color: rgb(18, 18, 18);
	width: 30%;
	height: 64px;
	text-align: center;
}

#CurrentTrack_Detail .first-second {
	float: right;
	background-color: rgb(18, 18, 18);
	width: 70%;
	height: 64px;
	text-align: left;
}

#MyPlaylist .first {
	float: none;
	background-color: rgb(18, 18, 18);
	width: 100%;
	height: 64px;
	text-align: center;
}

#MyPlaylist .first-first {
	float: left;
	background-color: rgb(18, 18, 18);
	width: 30%;
	height: 64px;
	text-align: center;
}

#MyPlaylist .first-second {
	float: right;
	background-color: rgb(18, 18, 18);
	width: 70%;
	height: 64px;
	text-align: left;
}

#MyPlaylist div:hover {
	background-color: #555;
}

.Song-info {
	display: grid;
	margin-bottom: 20px;
	grid-template-columns: 20px 1fr 1fr 1fr 1fr;
}

.song-name .first-first {
	float: left;
	background-color: rgb(18, 18, 18);
	width: 30%;
	height: 64px;
	text-align: center;
}

.song-name .first-second {
	float: right;
	background-color: rgb(18, 18, 18);
	width: 70%;
	height: 64px;
	text-align: left;
}

#CurrentTrack_Detail div:hover {
	background-color: #555;
}

#CurrentTrack_Detail_close {
	float: right;
}

#CurrentTrack_Detail #NextQueue .first {
	margin: 10% auto;
}

.MakePlaylist {
	float: right;
}

#playerPosition {
	float: left;
	margin-top: 25px;
	font-size: 10px;
	color: gray;
}

#playerDuration {
	float: right;
	margin-top: 25px;
	font-size: 10px;
	color: gray;
}

#playerDuration:hover, #playerPosition:hover {
	color: white;
}

.plInfoImg {
	width: 300px;
	height: 265px;
}

.PlaylistLibrary span {
	margin-left: 10px;
}

#MyPlaylist {
	margin-top: 25px;
	margin-bottom: 25px;
}

Button {
	background-color: rgb(18, 18, 18);
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	font-weight: bold;
	text-transform: uppercase;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s ease;
	height: 16px;
	line-height: 0px;
}

Button:hover {
	background-color: #333; /* 마우스 오버 시 약간 어두운 색상으로 변경 */
}

/* 버튼 간 간격 설정 */
#togglePlay {
	margin-left: 5px;
	margin-right: 5px;
}

.pl-info {
	display: grid;
	grid-template-columns: 300px 1fr;
}

.pl-detail-info {
	margin-left: 10px;
}

.pl-detail-info h1 {
	display: inline-block;
}

.pl-detail-info button:hover {
	background-color: violet;
}

.Song-info div:hover {
	background-color: #333;
}
/*클릭했을때 뜨기*/
#CInputPLDiv {
	position: absolute;
	width: 250px;
	height: 28px;
	background-color: rgb(18, 18, 18);
	border: 1px solid #333;
	cursor: pointer;
	text-align: center;
	border-radius: 10px;
}

#SongAddPDiv, #SongAddInPToggle {
	position: absolute;
	width: 250px;
	background-color: rgb(18, 18, 18);
	border: 1px solid #333;
	cursor: pointer;
	text-align: center;
	color: white;
}

#SongAddPDiv div:hover {
	background-color: #333;
}

#CInputPL {
	background-image: none;
	padding: 0px;
	outline: none;
	width: 150px;
	height: 25px;
	background-position: left center;
	background-size: 0px 0px;
	background-color: rgb(36, 36, 36);
	margin: 0px;
	color: white;
}

.Pl-reply {
	display: grid;
	grid-template-columns: 20px 1fr 2fr 1fr 1fr;
}

.Ch_userList {
	width: 25%;
	float: left;
	color: white;
}

.Ch_chatRoom {
	width: 50%;
	float: left;
	color: white;
}

.SC_userList {
	width: 25%;
	float: right;
	color: white;
	margin: 10px;
	border-radius: 10px;
	background-color: rgb(18, 18, 18);
}

.SC_userList_buttonbox {
	width: 100%;
}

.SC_userList_button {
	width: 120px;
	height: 50px;
	float: left;
}

.SC_FLlist_content {
	width: 300px;
	list-style: none;
	padding-left: 0px;
	line-height: 1.8 margin: 0;
	padding-inline-start: 1em;
	float: left;
}

.SC_FLlist_content li {
	font-size: 15px;
	margin-bottom: 10px;
}

.SC_FolloweeList {
	padding: 20px;
}

.SC_FollowerList {
	padding: 20px;
}

.SC_BlockList {
	padding: 20px;
}

#SC_FLlist_content_FLName {
	position: absolute;
	float: left;
	margin-left: 20px;
}

#SC_FLlist_content_FollowCancel_Button {
	float: right;
}

#SC_FLlist_content_BlockCancel_Button {
	float: right;
}
</style>
<!-- 음악플레이어를 위한 css -->
<style>
#wrapper {
	width: 100%;
	height: 100%;
}

.first {
	float: left;
	background-color: black;
	width: 33%;
	height: 64px;
	text-align: center;
}

.second {
	float: right;
	background-color: black;
	width: 67%;
	height: 64px;
	text-align: center;
}

.second-first {
	float: left;
	background-color: black;
	width: 50%;
	height: 100%;
	text-align: center;
}

.second-second {
	float: right;
	background-color: black;
	width: 50%;
	height: 100%;
	text-align: center;
}

.first-first {
	float: left;
	background-color: black;
	width: 20%;
	height: 64px;
	text-align: center;
}

.first-second {
	float: right;
	background-color: black;
	width: 80%;
	height: 64px;
	text-align: left;
	vertical-align: middle;
}

.playingAlbum {
	height: 64px;
	width: 64px;
	border-radius: 10px;
}

.nextAlbum {
	height: 64px;
	width: 64px;
	border-radius: 10px;
}

.music-bar-container {
	width: 100%;
	height: 2px;
	background-color: #ddd;
}

.music-bar {
	height: 100%;
	background-color: #4CAF50;
	width: 0%; /* 초기 너비는 0으로 설정 */
}

#playerCon {
	height: 70%;
}

#playerCon button {
	position: relative;
	top: 10px;
}

#volumeSlider {
	-webkit-appearance: none;
	width: 100px;
	height: 3px;
	border-radius: 5px;
	background: gray; /* 왼쪽은 초록색, 나머지는 하얀색 */
	outline: none;
	opacity: 0.7;
	-webkit-transition: .2s;
	transition: opacity .2s;
}

#volumeSlider:hover {
	opacity: 1;
	background: white;
}

#volumeSlider::-webkit-slider-thumb {
	-webkit-appearance: none;
	appearance: none;
	width: 20px;
	height: 20px;
	border-radius: 50%;
	background: #40ad65; /* 썸 색상을 변경 */
	cursor: pointer;
	border: 2px solid #4CAF50; /* 썸 테두리 색상 변경 */
	-webkit-transition: .3s;
	transition: background .3s;
}

#volumeSlider::-webkit-slider-thumb:hover {
	background: #388E3C; /* hover 시 썸 색상 변경 */
}

#volumCon {
	height: 100%;
	float: right;
	width: 70;
}

#CurrentTrack_Detail {
	background-color: rgb(18, 18, 18);
	color: #fff;
	padding: 20px;
	position: fixed;
	top: 0;
	right: 0; /* 오른쪽으로 고정 */
	width: 300px; /* 네비게이션 바의 너비 */
	height: 100%; /* 화면 높이 만큼 확장 */
	display: none;
	box-sizing: border-box; /* padding을 포함하여 전체 너비를 유지 */
	overflow-y: auto; /* 만약 네비게이션 바가 화면보다 길면 스크롤을 생성 */
}

#CurrentTrack_Detail .first {
	float: none;
	background-color: rgb(18, 18, 18);
	width: 100%;
	height: 64px;
	text-align: center;
}

#CurrentTrack_Detail .first-first {
	float: left;
	background-color: rgb(18, 18, 18);
	width: 30%;
	height: 64px;
	text-align: center;
}

#CurrentTrack_Detail .first-second {
	float: right;
	background-color: rgb(18, 18, 18);
	width: 70%;
	height: 64px;
	text-align: left;
}

#CurrentTrack_Detail div:hover {
	background-color: #555;
}

#CurrentTrack_Detail_close {
	float: right;
}

#CurrentTrack_Detail #NextQueue .first {
	margin: 10% auto;
}

.MakePlaylist {
	float: right;
}

#playerPosition {
	float: left;
	margin-top: 25px;
	font-size: 10px;
	color: gray;
}

#playerDuration {
	float: right;
	margin-top: 25px;
	font-size: 10px;
	color: gray;
}

#playerDuration:hover, #playerPosition:hover {
	color: white;
}

.plInfoImg {
	width: 300px;
	height: 265px;
}

.PlaylistLibrary span {
	margin-left: 10px;
}

#MyPlaylist {
	margin-top: 25px;
}

Button {
	background-color: rgb(18, 18, 18);
	color: white;
	border: none;
	padding: 10px 20px;
	font-size: 16px;
	font-weight: bold;
	text-transform: uppercase;
	cursor: pointer;
	border-radius: 5px;
	transition: background-color 0.3s ease;
	height: 16px;
	line-height: 0px;
}

Button:hover {
	background-color: #333; /* 마우스 오버 시 약간 어두운 색상으로 변경 */
}

/* 버튼 간 간격 설정 */
#togglePlay {
	margin-left: 5px;
	margin-right: 5px;
}
</style>
</head>
<body>

	<%
	SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");

	GetPlaylistRequest getPlaylistRequest = spotifyApi.getPlaylist("3cEYpjA9oz9GiPac4AsH4n").build();
	Playlist playlist = getPlaylistRequest.execute();

	GetCurrentUsersProfileRequest getCurrentUsersProfileRequest = spotifyApi.getCurrentUsersProfile().build();
	User user = getCurrentUsersProfileRequest.execute();
	%>
	<!-- header -->
	<!-- header -->
	<header>
		<!-- 나중에 적절한 이미지로 교체 -->
		<a id="menuButton" class="headericon"> <img alt=""
			src="images/메뉴버튼.png" onclick="" width="30" height="27" />
		</a> <a href="Mainpage.jsp" class="headericon"> <img alt=""
			src="images/플리픽 로고1.png" onclick="" height="30">
		</a>

	</header>
	<br>
	<br>
	<br>
	<!-- Sidebar -->
	<nav id="menu">
		<ul>
			<li><a href="Mainpage.jsp">MainPage</a></li>
			<li><a href="Playlist.jsp">Playlist</a></li>
			<li><a href="Social.jsp">Social</a></li>
			<li><a href="MyPage.jsp">MyPage</a></li>
		</ul>
	</nav>

	<div class="Ch_userList">
		<span>여기에 채팅방목록</span>
	</div>

	<div class="Ch_chatRoom">
		<span>여기에 채팅</span>
	</div>

	<div class="SC_userList">
		<div class="SC_userList_buttonbox">
			<button class="SC_userList_button" onclick="SC_showFolloweeList()">
				<span>팔로잉</span>
			</button>
			<button class="SC_userList_button" onclick="SC_showFollowerList()">
				<span>팔로워</span>
			</button>
			<button class="SC_userList_button" onclick="SC_showBlockList()">
				<span>블락</span>
			</button>
		</div>

		<!-- 팔로잉 리스트 -->
		<div class="SC_FolloweeList" id="SC_FolloweeList">

			<%
			String follower = user.getId();
			List<follows> followees = new followsDAO().getFollowees(follower);
			%>

			<ul class="SC_FLlist_content">
				<%
				if (followees != null) {
					for (int i = 0; i < followees.size(); i++) {
				%>
				<li><img src="./ProfileImg/defaultmp.png" width="40px"
					style="border-radius: 50%;"> <%-- <img src="<%=user.getImages() %>" width="40px"> --%>
					<span id="SC_FLlist_content_FLName" onclick="redirectToUsersPage('<%=followees.get(i).getFollowee()%>')"><%=new followsDAO().getNickByfolloweeId(follower).get(i)%></span>
					<button id="SC_FLlist_content_FollowCancel_Button"
						onclick="followCancel('<%=follower%>', '<%=followees.get(i).getFollowee()%>')">
						<img src="./images/X버튼.png" width="15px" height="15px">
					</button></li>

				<%
				}
				}
				%>
			</ul>
		</div>

		<!-- 팔로워 리스트 -->
		<div class="SC_FollowerList" id="SC_FollowerList"
			style="display: none;">
			<%
			String followee = user.getId();
			List<follows> followers = new followsDAO().getFollowers(followee);
			%>

			<ul class="SC_FLlist_content">
				<%
				if (followers != null) {
					for (int i = 0; i < followers.size(); i++) {
				%>
				<li><img src="./ProfileImg/defaultmp.png" width="40px"
					style="border-radius: 50%;"> <%-- <img src="<%=user.getImages() %>" width="40px"> --%>
					<span id="SC_FLlist_content_FLName" onclick="redirectToUsersPage('<%=followers.get(i).getFollower()%>')"><%=new followsDAO().getNickByfollowerId(followee).get(i)%></span>
				</li>

				<%
				}
				}
				%>
			</ul>
		</div>

		<!-- 블락 리스트 -->
		<div class="SC_BlockList" id="SC_BlockList" style="display: none;">
			<%
			String myuser = user.getId();
			List<blocks> blocks = new blocksDAO().getBlockusers(myuser);
			%>
			<ul class="SC_FLlist_content">
				<%
				if (blocks != null) {
					for (int i = 0; i < blocks.size(); i++) {
				%>
				<li><img src="./ProfileImg/defaultmp.png" width="40px"
					style="border-radius: 50%;"> <%-- <img src="<%=user.getImages() %>" width="40px"> --%>
					<span id="SC_FLlist_content_FLName"><%=new blocksDAO().getNickByBlockuserId(myuser).get(i)%></span>
					<button id="SC_FLlist_content_BlockCancel_Button"
						onclick="blockCancel('<%=myuser%>', '<%=blocks.get(i).getBlock_sp_id()%>')">
						<img src="./images/X버튼.png" width="15px" height="15px">
					</button></li>

				<%
				}
				}
				%>
			</ul>

		</div>

	</div>
	
	<!-- 재생 목록 -->
	<div id="CurrentTrack_Detail">
		<br> <br>
		<div>
			<span>재생목록</span>
			<button id="CurrentTrack_Detail_close">X</button>
		</div>
		<br>
		<div>
			<span>현재 재생목록</span>
		</div>
		<div class="first">
			<div class="first-first">
				<img class="playingAlbum" src="images/플리픽도안2.png">
			</div>
			<div class="first-second">
				<span class="current_track"></span><br> <span
					class="current_singer"></span>
			</div>
		</div>
		<br> <span>다음 재생</span> <br>
		<div id="NextQueue"></div>
	</div>
<!-- 플레이어 -->
	<footer>
		<div id="wrapper">
			<div class="first">
				<div class="first-first">
					<img class="playingAlbum" src="images/플리픽도안2.png">
				</div>
				<div class="first-second">
					<br> <span class="current_track"></span><br> <span
						class="current_singer"></span>
				</div>
			</div>
			<div class="second">
				<div class="second-first">
					<div id="playerCon">
						<span id="playerPosition"></span>
						<button id="SongPre">뒤로</button>
						<button id="togglePlay">연결하기</button>
						<button id="SongPost">앞으로</button>
						<span id="playerDuration"></span>
					</div>
					<div class="music-bar-container">
						<div class="music-bar"></div>
					</div>
				</div>

				<div class="second-second">
					<div id="volumCon">
						<br> <input type="range" min="0" max="1" step="0.01"
							value="1" id="volumeSlider">
						<button id="CurrentTrack_Detail_Btn">재생목록</button>
					</div>
				</div>
			</div>
		</div>


	</footer>
	
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script>
		// JavaScript를 사용하여 사이드바를 토글하는 함수
		document.getElementById("menuButton").addEventListener("click",
				function() {
					var menu = document.getElementById("menu");
					// 사이드바가 보이는 상태에서는 숨기고, 숨겨진 상태에서는 보이게 함
					if (menu.style.left === "0px") {
						menu.style.left = "-200px";
						//document.querySelectorAll(".stub_box")[0].style.marginLeft = "20px"; // 사이드바가 숨겨진 경우 여백 조정
						//document.querySelectorAll(".stub_box")[1].style.marginLeft = "20px"; // 사이드바가 숨겨진 경우 여백 조정

					} else {
						menu.style.left = "0px";
						//document.querySelectorAll(".stub_box")[0].style.marginLeft = "220px"; // 사이드바가 보이는 경우 여백 조정
						//document.querySelectorAll(".stub_box")[1].style.marginLeft = "220px";
					}
				});

		function SC_showFolloweeList() {
			document.getElementById("SC_FolloweeList").style.display = "";
			document.getElementById("SC_FollowerList").style.display = "none";
			document.getElementById("SC_BlockList").style.display = "none";
		}

		function SC_showFollowerList() {
			document.getElementById("SC_FolloweeList").style.display = "none";
			document.getElementById("SC_FollowerList").style.display = "";
			document.getElementById("SC_BlockList").style.display = "none";
		}

		function SC_showBlockList() {
			document.getElementById("SC_FolloweeList").style.display = "none";
			document.getElementById("SC_FollowerList").style.display = "none";
			document.getElementById("SC_BlockList").style.display = "";
		}

		function followCancel(follower, followee) {

			$.ajax({
				url : 'FollowsController',

				data : {
					follower : follower,
					followee : followee
				},
				type : 'POST',

				success : function(response) {
					// 성공적으로 팔로우가 취소되었을 때의 처리
					console.log('팔로우 취소 성공', response);
				},
				error : function(error) {
					// 팔로우 취소 실패 시 처리
					console.error('팔로우 취소 실패', error);
				}
			});
			alert("팔로우를 취소하였습니다.");
			location.reload();

		}

		function blockCancel(myuser, blockuser){
		 $.ajax({
		 url: 'BlockCancelController',
		
		 data: {
		 sp_id: myuser,
		 block_sp_id: block_sp_id
		 },
		 type: 'POST',
		
		 success: function(response) {
		 // 성공적으로 팔로우가 취소되었을 때의 처리
		 console.log('블락 취소 성공', response);
		 },
		 error: function(error) {
		 // 팔로우 취소 실패 시 처리
		 console.error('블락 취소 실패', error);
		 }
		 });
		 alert("블락을 취소하였습니다.");
		 location.reload();
		
		
		 }
		
		function redirectToUsersPage(sp_id) {
		    var url = 'MyPage.jsp?sp_id=' + sp_id;
		    window.location.href = url;
		}
	</script>
<script src="https://sdk.scdn.co/spotify-player.js"></script>
<script>
	const msToTime = (msd)=>{
		// 전달된 밀리초(ms)를 분과 초로 나누기
	    var minutes = Math.floor(msd / 60000);
	    var seconds = ((msd % 60000) / 1000).toFixed(0);
	    
	    // 분이 한 자리수일 때 앞에 0 추가
	    if (minutes < 10) {
	        minutes = '0' + minutes;
	    }
	    // 초가 한 자리수일 때 앞에 0 추가
	    if (seconds < 10) {
	        seconds = '0' + seconds;
	    }
	    
	    // 분:초 형식의 문자열 반환
	    return minutes + ':' + seconds;
	}
	const playingimg = document.getElementsByClassName("playingAlbum")
	const current_trackn =document.getElementsByClassName("current_track")
	const current_singer =document.getElementsByClassName("current_singer")
	const toggleplay = document.getElementById("togglePlay")
	const NextQueue = document.getElementById("NextQueue")
	var volumeSlider = document.getElementById("volumeSlider");
	var playerPosition = document.getElementById("playerPosition");
	var playerDuration = document.getElementById("playerDuration");
	document.getElementById('CurrentTrack_Detail_Btn').addEventListener('click', function() {
	    var CurrentTrack_Detail = document.getElementById('CurrentTrack_Detail');
	    if (CurrentTrack_Detail.style.display === 'none' || CurrentTrack_Detail.style.display === '') {
	        CurrentTrack_Detail.style.display = 'block';
	    } else {
	        CurrentTrack_Detail.style.display = 'none';
	    }
	});
	document.getElementById("CurrentTrack_Detail_close").addEventListener("click", function() {
		CurrentTrack_Detail.style.display = 'none';});
    // 총 노래 길이와 현재 진행 시간을 받아서 음악 바를 업데이트하는 함수
        function updateMusicBar(totalDuration, currentTime) {
            // 총 노래 길이와 현재 진행 시간을 퍼센트로 변환
            var percentComplete = (currentTime / totalDuration) * 100;
            playerPosition.innerText=msToTime(currentTime)
            // 음악 바 업데이트
            var musicBar = document.querySelector('.music-bar');
            musicBar.style.width = percentComplete + '%';
        }
    
    
    
    
    
	window.onSpotifyWebPlaybackSDKReady = () => {
	
	  const token = '<%=spotifyApi.getAccessToken()%>';
	  const player = new Spotify.Player({
	      name: 'Web Playback SDK',
	      getOAuthToken: cb => { cb(token); },
	      enableMediaSession:true,
	      volume: document.getElementById("volumeSlider").value
	      });

	 // Ready
	 player.addListener('ready', ({ device_id }) => {
	     console.log('Ready with Device ID', device_id);
	     savedDeviceId = device_id;
				   if(sessionStorage.getItem("playingNow")==1){
					   const options = {
							   method: 'PUT',
							   headers: {
							     'Authorization': `Bearer <%=spotifyApi.getAccessToken()%>`,
							     'Content-Type': 'application/json'
							   },
							   body: JSON.stringify({
							     device_ids: [savedDeviceId]
							   })
							 };
					   

							 fetch('https://api.spotify.com/v1/me/player', options)
							   .then(response => {
							     if (!response.ok) {
							       throw new Error('Network response was not ok');
							     }else{

									 player.togglePlay().then(() => {
										 toggleplay.innerText="일시정지"
											 intervalId = setInterval(() => {
								    			    player.getCurrentState().then(state => {
								    			        if (!state) {
								    			            console.error('User is not playing music through the Web Playback SDK');
								    			            return;
								    			        }
								    			        
								    			        // 현재 재생 중인 트랙의 position을 추적
								    			        var position = state.position;
								    			        
								    			        // updateMusicBar 함수를 호출하여 음악 바 업데이트
								    			        updateMusicBar(state.duration, position);
								    			    });
								    			}, 1000); // 1초마다 확인
								    		   
										});
							     }
							   }) 
							   .then(data => console.log("as ",data))
							   .catch(error => console.error('There was a problem with your fetch operation:', error));
							 first_toggle = 1;  
				   
				   }
			   });
	   // Not Ready
	   player.addListener('not_ready', ({ device_id }) => {
	     console.log('Device ID has gone offline', device_id);
	   });
	   player.addListener('initialization_error', ({ message }) => {
	       console.error(message);
	   });

	   player.addListener('authentication_error', ({ message }) => {
	       console.error(message);
	   });

	   player.addListener('account_error', ({ message }) => {
	       console.error(message);
	   });
	   
	   player.addListener('autoplay_failed', () => {
	 	  console.log('Autoplay is not allowed by the browser autoplay rules');
	 	});
	   player.on('playback_error', ({ message }) => {
	 	  console.error('Failed to perform playback', message);
	 	});
	   
	   player.addListener('player_state_changed', ({
		   position,
		   duration,
		   track_window: { current_track }
		 }) => {
				 for(i=0;i<current_trackn.length;i++){
				 playingimg[i].src = current_track.album.images[1].url
				 current_trackn[i].innerText=current_track.name
				 current_singer[i].innerText=current_track.artists[0].name
				 for(j=1;j<current_track.artists.length;j++){
					 current_singer.innerText = current_singer.innerText +", "+current_track.artists[j].name
				 }}
		   console.log('Currently Playing', current_track);
		   console.log('Position in Song', position);
		   console.log('Duration of Song', duration);
		   playerDuration.innerText=msToTime(duration);
		   fetch('https://api.spotify.com/v1/me/player/queue', {
			   method: 'GET',
			   headers: {
			     'Authorization': `Bearer <%=spotifyApi.getAccessToken()%>`
			   }
			 })
			 .then(response => {
			   if (!response.ok) {
			     throw new Error('Network response was not ok');
			   }
			   return response.json();
			 })
			 .then(data => {
			   console.log(data); // 응답 데이터를 콘솔에 출력하거나 필요한 처리를 수행합니다.
			   if(data.queue.length != 0){
				    NextQueue.replaceChildren();
				    console.log(data.queue.length)
				    for(let i = 0; i < data.queue.length; i++){
				    	var queueSinger= data.queue[i].artists[0].name
				    	for(j=1;j<data.queue[i].artists.length;j++){
				    		queueSinger = queueSinger+","+data.queue[i].artists[j].name;
				    	}
				    	const temp = document.createElement("div");
				        temp.innerHTML = '<div class="first-first">' +
				        '<img class="nextAlbum" src="' + data.queue[i].album.images[2].url + '" onclick="ChangeSonginQ(' + (i+1) + ')">' +
				        '</div>' +
				        '<div class="first-second" onclick="ChangeSonginQ(' + (i+1) + ')">' +
				            '<span>' + data.queue[i].name + '</span><br>' +
				            '<span>' + queueSinger + '</span>' +
				        '</div><br>';
				        temp.querySelector('img').addEventListener('click', function() {
				            ChangeSonginQ(i+1); // 이미 생성된 변수 i를 사용하여 함수 호출
				        });   
				        NextQueue.append(temp);
				    }
				}else{
					console.log("재생목록이 비었습니다.");
				}
			 })
			 .catch(error => {
			   console.error('There was a problem with your fetch operation:', error);
			 });
		   
		   
		   
		   
		   
		 });
	   player.connect().then(success => {
		   if (success) {
			   if(sessionStorage.getItem("playingNow")==1){
				   const options = {
						   method: 'PUT',
						   headers: {
						     'Authorization': `Bearer <%=spotifyApi.getAccessToken()%>`,
						     'Content-Type': 'application/json'
						   },
						   body: JSON.stringify({
						     device_ids: [savedDeviceId]
						   })
						 };
				   

						 fetch('https://api.spotify.com/v1/me/player', options)
						   .then(response => {
						     if (!response.ok) {
						       throw new Error('Network response was not ok');
						     }else{

								 player.togglePlay().then(() => {
									 toggleplay.innerText="일시정지"
										 intervalId = setInterval(() => {
							    			    player.getCurrentState().then(state => {
							    			        if (!state) {
							    			            console.error('User is not playing music through the Web Playback SDK');
							    			            return;
							    			        }
							    			        
							    			        // 현재 재생 중인 트랙의 position을 추적
							    			        var position = state.position;
							    			        
							    			        // updateMusicBar 함수를 호출하여 음악 바 업데이트
							    			        updateMusicBar(state.duration, position);
							    			    });
							    			}, 1000); // 1초마다 확인
							    		   
									});
						     }
						   }) 
						   .then(data => console.log("as ",data))
						   .catch(error => console.error('There was a problem with your fetch operation:', error));
						 first_toggle = 1;  
			   
			   }
		   }
		 })
	   //player.connect();
	  var first_toggle= 0;
	  var intervalId;
	   document.getElementById('togglePlay').onclick = function() {
		     if(first_toggle==0){
		    	 <!-- 플레이어 연결-->
		   const options = {
				   method: 'PUT',
				   headers: {
				     'Authorization': `Bearer <%=spotifyApi.getAccessToken()%>`,
				     'Content-Type': 'application/json'
				   },
				   body: JSON.stringify({
				     device_ids: [savedDeviceId]
				   })
				 };
		   
				
				 fetch('https://api.spotify.com/v1/me/player', options)
				   .then(response => {
				     if (!response.ok) {
				    	 console.log("aa:"+options)
				       throw new Error('Network response was not ok');
				     }else{

						 player.togglePlay().then(() => {
							 toggleplay.innerText="일시정지"
								 intervalId = setInterval(() => {
					    			    player.getCurrentState().then(state => {
					    			        if (!state) {
					    			            console.error('User is not playing music through the Web Playback SDK');
					    			            return;
					    			        }
					    			        
					    			        // 현재 재생 중인 트랙의 position을 추적
					    			        var position = state.position;
					    			        
					    			        // updateMusicBar 함수를 호출하여 음악 바 업데이트
					    			        updateMusicBar(state.duration, position);
					    			    });
					    			}, 1000); // 1초마다 확인
					    		   
							});
				     }
				     
				   })
				   .then(data => console.log("as ",data))
				   .catch(error => console.error('There was a problem with your fetch operation:', error));
				 first_toggle = 1;
				 sessionStorage.setItem("playingNow", 1 );
		     }else if(first_toggle==1){
		    	 console.log(first_toggle);
		    	 player.togglePlay().then(() => {
					  if(toggleplay.innerText=="일시정지"){
						  toggleplay.innerText="재생"
							  sessionStorage.setItem("playingNow", 0 );
						  clearInterval(intervalId);
					  }else if(toggleplay.innerText=="재생"){
						  toggleplay.innerText="일시정지"
							  sessionStorage.setItem("playingNow", 1 );
							  intervalId = setInterval(() => {
				    			    player.getCurrentState().then(state => {
				    			        if (!state) {
				    			            console.error('User is not playing music through the Web Playback SDK');
				    			            return;
				    			        }
				    			        
				    			        // 현재 재생 중인 트랙의 position을 추적
				    			        var position = state.position;
				    			        
				    			        // updateMusicBar 함수를 호출하여 음악 바 업데이트
				    			        updateMusicBar(state.duration, position);
				    			    });
				    			}, 1000);  
					  }
					});
			     
		     }

	   }

	   volumeSlider.addEventListener("input", function() {
		   player.setVolume(volumeSlider.value).then(() => {
			   console.log('Volume updated!');
			 });
		});
	   
	   document.getElementById('SongPre').onclick= function(){
		   player.previousTrack().then(() => {
			   console.log('Set to previous track!');
			 });   
	   }
	   document.getElementById('SongPost').onclick= function(){
		   player.nextTrack().then(() => {
			   console.log('Skipped to next track!');
			 });
	   }
	   <!-- 재생목록에서 이동 -->
	    var ChangeSonginQ=(i) =>{
	    	for(j=0;j<i;j++){
	    		setTimeout(() => {
		    		player.nextTrack().then(() => {
					   console.log('Skipped to next track!');
					});	    			
	    		}, j * 500);
	    	}
	    	if(sessionStorage.getItem("playingNow")!=1){
	    		toggleplay.innerText="일시정지"
					 intervalId = setInterval(() => {
		    			    player.getCurrentState().then(state => {
		    			        if (!state) {
		    			            console.error('User is not playing music through the Web Playback SDK');
		    			            return;
		    			        }
		    			        
		    			        // 현재 재생 중인 트랙의 position을 추적
		    			        var position = state.position;
		    			        
		    			        // updateMusicBar 함수를 호출하여 음악 바 업데이트
		    			        updateMusicBar(state.duration, position);
		    			    });
		    			}, 1000); // 1초마다 확인
	    	}
	    }
	    
	    
	 }
	
	</script>
</body>
</html>