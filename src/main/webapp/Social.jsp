<%@page import="se.michaelthelin.spotify.model_objects.specification.User"%>
<%@page import="se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest"%>
<%@page import="com.crawlstars.model.follows"%>
<%@page import="com.crawlstars.model.followsDAO"%>
<%@page import="java.util.List"%>
<%@page import="se.michaelthelin.spotify.model_objects.specification.Image"%>
<%@page import="se.michaelthelin.spotify.model_objects.specification.Playlist"%>
<%@page import="se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest"%>
<%@page import="se.michaelthelin.spotify.SpotifyApi"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
.PlaylistDetail{
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
	padding:0px;
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
	margin-bottom:25px;
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
.pl-detail-info h1{
	display:inline-block;
}
.pl-detail-info button:hover{
	background-color: violet;
}
.Song-info div:hover{
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
#SongAddPDiv ,#SongAddInPToggle{
		position: absolute;
        width: 250px;
        background-color: rgb(18, 18, 18);
        border: 1px solid #333;
        cursor: pointer;
        text-align: center;
		color:white;
}
#SongAddPDiv div:hover{
	background-color: #333;
}
#CInputPL{
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
.Pl-reply{
	display:grid;
	grid-template-columns: 20px 1fr 2fr 1fr 1fr;
}

.Ch_userList{
	width: 25%;
	float: left;
	color: white;
}

.Ch_chatRoom{
	width: 50%;
	float: left;
	color: white;
}

.SC_userList{
	width: 25%;
	float: right;
	color: white;
	margin: 10px;
	border-radius: 10px;
	background-color: rgb(18, 18, 18);
}

.SC_userList_buttonbox{
	width: 100%;
}

.SC_userList_button{
	width: 120px;
	height: 50px;
	font-size: 15px;
	float: left;
}

.SC_FLlist_content{
	width: 250px;
	list-style:none;
	padding-left:0px;
	line-height: 1.8;
  	margin: 0;
  	padding-inline-start: 1em;
  	float: left;
}

.SC_FolloweeList{
	padding: 20px;
}

.SC_FollowerList{
	padding: 20px;
}

.SC_BlockList{
	padding: 20px;
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
Playlist playlist =  getPlaylistRequest.execute();

GetCurrentUsersProfileRequest getCurrentUsersProfileRequest = spotifyApi.getCurrentUsersProfile()
.build();
User user = getCurrentUsersProfileRequest.execute(); %>
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
<button class="SC_userList_button" onclick="SC_showFolloweeList()"><span>팔로잉</span></button>
<button class="SC_userList_button" onclick="SC_showFollowerList()"><span>팔로워</span></button>
<button class="SC_userList_button" onclick="SC_showBlockList()"><span>블락</span></button>
</div>

<!-- 팔로잉 리스트 -->
<div class="SC_FolloweeList" id="SC_FolloweeList">
<%
String follower = user.getId();
List<follows> followees = new followsDAO().getFollowees(follower);

%>
	<ul class="SC_FLlist_content">
	<% if(followees != null){
		for(int i=0; i<followees.size(); i++){ %>
		<li><img src="./ProfileImg/defaultmp.png" width="40px">
		<%-- <img src="<%=user.getImages() %>" width="40px"> --%>
		<span><%=followees.get(i).getFollowee() %></span>
		<button onclick="followCancel('<%=follower %>', '<%=followees.get(i).getFollowee() %>')">
		<img src="./images/X버튼.png" width="15px" height="15px"></button>
		</li>
		
 	<% }
	} %>
	</ul>
</div>

<!-- 팔로워 리스트 -->
<div class="SC_FollowerList" id="SC_FollowerList" style="display: none;">
<%
String followee = user.getId();
List<follows> followers = new followsDAO().getFollowers(followee);
%>
	<ul>
	<% if(followers != null){
		for(int i=0; i<followers.size(); i++){ %>
		<li><img src="./ProfileImg/defaultmp.png" width="40px">
		<%-- <img src="<%=user.getImages() %>" width="40px"> --%>
		<span><%= followers.get(i).getFollower() %></span>
		</li>
		
 	<% }
	} %>
	</ul>
</div>

<!-- 블락 리스트 -->
<div class="SC_BlockList" id="SC_BlockList" style="display: none;">
<%
String blockuser = user.getId();
%>
<div><span>여기에 블락유저</span></div>

</div>

</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
// JavaScript를 사용하여 사이드바를 토글하는 함수
document.getElementById("menuButton").addEventListener("click", function() {
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

function followCancel(follower, followee){
	$.ajax({
		
        url: 'followsController/deleteFollower',
        
        data: {
            follower: follower,
            followee: followee
        },
        type: 'POST',
        
        success: function(response) {
            // 성공적으로 팔로우가 취소되었을 때의 처리
            console.log('팔로우 취소 성공');
        },
        error: function(error) {
            // 팔로우 취소 실패 시 처리
            console.error('팔로우 취소 실패', error);
        }
    });
}

</script>

</body>
</html>