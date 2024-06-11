
<%@page import="se.michaelthelin.spotify.requests.data.player.StartResumeUsersPlaybackRequest"%>
<%@page import="se.michaelthelin.spotify.model_objects.miscellaneous.Device"%>
<%@page import="se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext"%>
<%@page import="se.michaelthelin.spotify.requests.data.player.GetInformationAboutUsersCurrentPlaybackRequest"%>
<%@page
	import="se.michaelthelin.spotify.requests.data.player.GetUsersAvailableDevicesRequest"%>
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

<style>
/* 스타일링을 위한 CSS */
body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

header {
	background-color: #333;
	color: #fff;
	padding: 10px;
	position: fixed; /* 헤더를 화면 상단에 고정 */
	width: 100%; /* 헤더의 너비를 화면 전체로 설정 */
	z-index: 2; /* 헤더를 사이드바 위에 표시 */
}

#menu {
	width: 200px; /* 사이드바의 너비 */
	position: fixed; /* 페이지 스크롤과 상관없이 고정 */
	top: 0; /* 화면 상단부터 고정 */
	left: -200px; /* 초기에는 사이드바를 왼쪽으로 숨김 */
	height: 100%; /* 화면 전체 높이 */
	background-color: #f4f4f4;
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

.playlist {
	margin-left: 20px; /* 사이드바가 숨겨진 경우 여백을 조정 */
	padding: 20px;
}
footer{
    position : absolute;
bottom : 0;
width: 100%;
color: white;
}
#wrapper{

width: 100%;
height: 100%;
}
.first{
    float: left;
    background-color: black;
    width : 33%;
    height: 100%;
    text-align: center;
}
.second{
    float: right;
    background-color: black;
    width : 67%;
    height: 100%;
    text-align: center;
}
.second-first{
float: left;
    background-color: black;
    width : 50%;
    height: 100%;
    text-align: center;
}
.second-second{
float: right;
    background-color: black;
    width : 50%;
    height: 100%;
    text-align: center;
}
</style>

</head>
<body>
	<%
	SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
	GetPlaylistRequest getPlaylistRequest = spotifyApi.getPlaylist("3cEYpjA9oz9GiPac4AsH4n").build();
	Playlist playlist = getPlaylistRequest.execute();
	
	GetInformationAboutUsersCurrentPlaybackRequest getInformationAboutUsersCurrentPlaybackRequest =
		    spotifyApi.getInformationAboutUsersCurrentPlayback().build();
	CurrentlyPlayingContext currentlyPlayingContext = getInformationAboutUsersCurrentPlaybackRequest.execute();
	if(currentlyPlayingContext!=null){

    System.out.println("Timestamp: " + currentlyPlayingContext.getIs_playing());
    System.out.println("currentdevice: " + currentlyPlayingContext.getDevice());
	}
	%>
	<!-- header -->
	<header>
	<!-- 나중에 적절한 이미지로 교체 -->
	<a id="menuButton" class="headericon">
	<img alt="" src="images/버튼.png" onclick="" width="30" height="27"/>
	</a>
	<a href="Mainpage.jsp" class="headericon">
	<img alt="" src="images/플리픽 로고1.png" onclick="" height="30"/ >
	</a>
	
	</header>
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

	<!-- playlist Stub -->
	<div class="playlist">
		<table border="1px">
			<tr>
				<td><img src="<%=playlist.getImages()[0].getUrl()%>"
					width="300px" height="300px"></td>
			</tr>
			<tr>
				<td align="center"><%=playlist.getName()%></td>
			</tr>
			<tr>
				<td align="center"><%=playlist.getDescription()%></td>
			</tr>

		</table>

	</div>

	<footer>
		<div id="wrapper">
        <div class="first">
        <span>a</span>
        </div>
        <div class="second">
            <div class="second-first">
                <button id="togglePlay">Toggle Play</button>
            </div>
            <div class="second-second">
            <span>abc</span>
            </div>
        </div>
    </div>


	</footer>

	<!-- player 연동을위해 필요한 javascript -->


	<!-- 사이드바를 위한 javascript -->
	<script>
		// JavaScript를 사용하여 사이드바를 토글하는 함수
		document.getElementById("menuButton")
				.addEventListener(
						"click",
						function() {
							var menu = document.getElementById("menu");
							// 사이드바가 보이는 상태에서는 숨기고, 숨겨진 상태에서는 보이게 함
							if (menu.style.left === "0px") {
								menu.style.left = "-200px";
								document.querySelector(".playlist").style.marginLeft = "20px"; // 사이드바가 숨겨진 경우 여백 조정
							} else {
								menu.style.left = "0px";
								document.querySelector(".playlist").style.marginLeft = "220px"; // 사이드바가 보이는 경우 여백 조정
							}
						});
	</script>
	<script src="https://sdk.scdn.co/spotify-player.js"></script>
	<script>


	window.onSpotifyWebPlaybackSDKReady = () => {
		
	    const token = '<%=spotifyApi.getAccessToken() %>';
	    const player = new Spotify.Player({
	        name: 'Web Playback SDK',
	        getOAuthToken: cb => { cb(token); },
	        enableMediaSession:true,
	        volume: 0.5
	      });

	 // Ready
	 player.addListener('ready', ({ device_id }) => {
	     console.log('Ready with Device ID', device_id);
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
	   player.addListener('player_state_changed', (state) => {
		   if (!state) {
		     return;
		   }

		   setTrack(state.track_window.current_track);
		   setPaused(state.paused);
		   setPosition(state.position);
		   setDuration(state.duration);

		   player.getCurrentState().then((state) => {
		     !state ? setActive(false) : setActive(true);
		   });
		 });
	   player.connect();
	   document.getElementById('togglePlay').onclick = function() {
		 
	     player.togglePlay();
	     player.getCurrentState().then(state => {
	     if (!state) {
	       console.error('User is not playing music through the Web Playback SDK');
	       return;
	     }
	     
	     var current_track = state.track_window.current_track;
	     var next_track = state.track_window.next_tracks[0];
	     
	     console.log('Currently Playing', current_track);
	     console.log('Playing Next', next_track);
	     });
	   }
	  
	   
	 }
<% GetUsersAvailableDevicesRequest getUsersAvailableDevicesRequest = spotifyApi
    		.getUsersAvailableDevices()
    		.build();
    		Device[] devices = getUsersAvailableDevicesRequest.execute();
    		if(devices!=null){
    			for(Device device:devices){
    			    System.out.println("device: " + device.getName());
    			}
    		}%>
</script>
</body>
</html>