
<%@page import="se.michaelthelin.spotify.requests.authorization.authorization_code.AuthorizationCodeRefreshRequest"%>
<%@page import="se.michaelthelin.spotify.model_objects.credentials.AuthorizationCodeCredentials"%>
<%@page
	import="se.michaelthelin.spotify.requests.data.player.StartResumeUsersPlaybackRequest"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.miscellaneous.Device"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.miscellaneous.CurrentlyPlayingContext"%>
<%@page
	import="se.michaelthelin.spotify.requests.data.player.GetInformationAboutUsersCurrentPlaybackRequest"%>
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

footer {
	position: absolute;
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


#popupBtn {
  background-color: #007bff;
  color: #fff; /* 텍스트 색상을 지정하세요 */
  border: none; /* 테두리 제거 */
  cursor: pointer;
}
#modalWrap {
  position: fixed; /* 화면에 고정 */
  z-index: 1; /* 상위에 위치 */
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.7); /* 반투명한 배경색 */
  display: none; /* 초기에는 숨김 */
}

#modalBody {
  width: 500px;
  height: 300px;
  padding: 30px 30px;
  margin: 0 auto;
  border: 1px solid #777;
  background-color: #fff;
}

#closeBtn {
  float: right;
  font-weight: bold;
  color: #777;
  font-size: 25px;
  cursor: pointer;
}
#playingAlbum{
	height: 64px;
	width: 64px;
	border-radius: 10px;
}
</style>

</head>
<body>
	<%
	SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
	GetPlaylistRequest getPlaylistRequest = spotifyApi.getPlaylist("3cEYpjA9oz9GiPac4AsH4n").build();
	Playlist playlist = getPlaylistRequest.execute();

	GetInformationAboutUsersCurrentPlaybackRequest getInformationAboutUsersCurrentPlaybackRequest = spotifyApi
			.getInformationAboutUsersCurrentPlayback().build();
	CurrentlyPlayingContext currentlyPlayingContext = getInformationAboutUsersCurrentPlaybackRequest.execute();
	if (currentlyPlayingContext != null) {

		System.out.println("Timestamp: " + currentlyPlayingContext.getIs_playing());
		System.out.println("currentdevice: " + currentlyPlayingContext.getDevice());
	}
	AuthorizationCodeRefreshRequest authorizationCodeRefreshRequest = spotifyApi.authorizationCodeRefresh()
		    .build();
	AuthorizationCodeCredentials authorizationCodeCredentials = authorizationCodeRefreshRequest.execute();
	session.setAttribute("spotifyApi", spotifyApi);
	%>
	<!-- header -->
	<header>
		<!-- 나중에 적절한 이미지로 교체 -->
		<a id="menuButton" class="headericon"> <img alt=""
			src="images/버튼.png" onclick="" width="30" height="27" />
		</a> <a href="Mainpage.jsp" class="headericon"> <img alt=""
			src="images/플리픽 로고1.png" onclick="" height="30"/ >
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
	

    <div id="modalWrap"> <!-- 모달 창을 감싸는 div -->
      <div id="modalBody">
        <span id="closeBtn">&times;</span> <!-- 모달을 닫는 X 버튼 -->
        <p id=>이용 가능한 플레이어가 없습니다.</p> <!-- 모달 창 내용 -->
      </div>
    </div>
	
	<footer>
		<div id="wrapper">
			<div class="first">
				<div class="first-first">
					<img id="playingAlbum" src="https://i.scdn.co/image/ab67616d000048516ef45ebf3d55567ebdece7f0">
				</div>
				<div class="first-second">
					<span class="current_track">current_track</span><br>
					<span class="current_singer">current_singer</span>
				</div>
			</div>
			<div class="second">
				<div class="second-first">
					
					<button id="SongPre">뒤로</button>
					<button id="togglePlay">연결하기</button>
					<button id="SongPost">앞으로</button>
					
				</div>
				<div class="second-second">
					<div id="btnWrap">
      					<button typ="button" id="popupBtn">device</button> <!-- 모달을 띄우는 버튼 -->
    				</div>
				</div>
			</div>
		</div>


	</footer>
	<!-- 사이드바를 위한 javascript -->
	<script>
		// JavaScript를 사용하여 사이드바를 토글하는 함수
		document.getElementById("menuButton").addEventListener("click", function() {
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
	<!-- player 연동을위해 필요한 javascript -->
	<script>
	const playingimg = document.getElementById("playingAlbum")
	const current_trackn =document.getElementsByClassName("current_track")[0]
	const current_singer =document.getElementsByClassName("current_singer")[0]
	const toggleplay = document.getElementById("togglePlay")
	
	window.onSpotifyWebPlaybackSDKReady = () => {
	
	  const token = '<%=spotifyApi.getAccessToken()%>';
	  const player = new Spotify.Player({
	      name: 'Web Playback SDK',
	      getOAuthToken: cb => { cb(token); },
	      enableMediaSession:true,
	      volume: 0.5
	      });

	 // Ready
	 player.addListener('ready', ({ device_id }) => {
	     console.log('Ready with Device ID', device_id);
	     savedDeviceId = device_id;
	   });
	 function getSavedDeviceId() {
		    return savedDeviceId;
		}
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
				 playingimg.src = current_track.album.images[1].url
				 current_trackn.innerText=current_track.name
				 current_singer.innerText=current_track.artists[0].name
				 for(i=1;i<current_track.artists.length;i++){
					 current_singer.innerText = current_singer.innerText +", "+current_track.artists[i].name
				 }
		   console.log('Currently Playing', current_track);
		   console.log('Position in Song', position);
		   console.log('Duration of Song', duration);
		 });

	   player.connect().then(success => {
		   if (success) {
		     console.log('The Web Playback SDK successfully connected to Spotify!');
		     getSavedDeviceId();
		   }
		 })
	   //player.connect();
	  var first_toggle= 0;
	   document.getElementById('togglePlay').onclick = function() {
		     if(first_toggle==0){
		    	 console.log('first_toggle',first_toggle);
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
							});

					     player.getCurrentState().then(state => {
						     if (!state) {
						       console.error('User is not playing music through the Web Playback SDK', state);
						       return;
						     }
					
						     
						     var current_track = state.track_window.current_track;
						     var next_track = state.track_window.next_tracks[0];
						     
						     console.log('Currently Playing', current_track);
						     console.log('Playing Next', next_track);
					     });
					     console.log('response ok');
				     }
				     
				   })
				   .then(data => console.log("as ",data))
				   .catch(error => console.error('There was a problem with your fetch operation:', error));
				 first_toggle = 1;
		     }else if(first_toggle==1){
		    	 console.log(first_toggle);
		    	 player.togglePlay().then(() => {
					  console.log('Toggled playback!');
					  if(toggleplay.innerText=="일시정지"){
						  toggleplay.innerText="재생"
					  }else if(toggleplay.innerText=="재생"){
						  toggleplay.innerText="일시정지"
					  }
					});

			     player.getCurrentState().then(state => {
				     if (!state) {
				       console.error('User is not playing music through the Web Playback SDK', state);
				       return;
				     }
			
				     
				     var current_track = state.track_window.current_track;
				     var next_track = state.track_window.next_tracks[0];
				     
				     console.log('Currently Playing', current_track);
				     console.log('Playing Next', next_track);
			     });
		     }

	   }
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
	 }
	</script>
	<script>
	const btn = document.getElementById("popupBtn"); // 모달을 띄우는 버튼 요소 가져오기
	const modal = document.getElementById("modalWrap"); // 모달 창 요소 가져오기
	const closeBtn = document.getElementById("closeBtn"); // 모달을 닫는 버튼(X) 요소 가져오기

	btn.onclick = function () {
	  modal.style.display = "block"; // 버튼을 클릭하면 모달을 보이게 함
	  var xhr = new XMLHttpRequest();
	  xhr.open("GET", "MyServletURL", true);
	  xhr.onreadystatechange = function () {
	      if (xhr.readyState == 4 && xhr.status == 200) {
	          var response = JSON.parse(xhr.responseText);
	          // 받은 JSON 데이터 사용하기
	         for(i = 0; i<response.getdevice;i++){
	        	 
	         }
	        	 
	      }
	  };
	};

	closeBtn.onclick = function () {
	  modal.style.display = "none"; // 모달을 닫는 버튼(X)을 클릭하면 모달을 숨김
	};

	window.onclick = function (event) {
	  if (event.target == modal) {
	    modal.style.display = "none"; // 모달 외부를 클릭하면 모달을 숨김
	  }
	};
	</script>
</body>
</html>