<%@page
	import="se.michaelthelin.spotify.model_objects.specification.User"%>
<%@page
	import="se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.specification.Recommendations"%>
<%@page
	import="se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.specification.Paging"%>
<%@page
	import="se.michaelthelin.spotify.requests.data.playlists.GetListOfCurrentUsersPlaylistsRequest"%>
<%@page
	import="se.michaelthelin.spotify.requests.authorization.authorization_code.AuthorizationCodeRefreshRequest"%>
<%@page
	import="se.michaelthelin.spotify.model_objects.credentials.AuthorizationCodeCredentials"%>
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
#SongAddPDiv ,#SongAddPO{
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
</style>

</head>
<body>
	<%
	SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
	AuthorizationCodeRefreshRequest authorizationCodeRefreshRequest = spotifyApi.authorizationCodeRefresh()
		    .build();
	AuthorizationCodeCredentials authorizationCodeCredentials = authorizationCodeRefreshRequest.execute();
	spotifyApi.setAccessToken(authorizationCodeCredentials.getAccessToken());
	session.setAttribute("spotifyApi", spotifyApi);


	
	%>
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
	<!-- 플레이리스트 페이지 메인기능 -->
	<div class="PlaylistMain">
		<div class="PlaylistLibSearch">
			<div class="PlaylistSearch">
				<input type="text" placeholder="검색어를 입력하세요..." class="search-input">
					<button onclick="BackPage()">뒤로</button>
				<button onclick="RefreshPage()">홈으로</button>
				<button onclick="ForwardPage()">앞으로</button>
			</div>
			<div class="PlaylistLibrary">
				<span>내 라이브러리</span>
				<button class="MakePlaylist" onclick="CInputPL(event)">+</button>
				<br>
				<div Id="MyPlaylist">
					<%	GetListOfCurrentUsersPlaylistsRequest getListOfCurrentUsersPlaylistsRequest = spotifyApi
		    .getListOfCurrentUsersPlaylists().build();
					if(getListOfCurrentUsersPlaylistsRequest!=null){
	Paging<PlaylistSimplified> playlistSimplifiedPaging = getListOfCurrentUsersPlaylistsRequest.execute();
	playlistSimplifiedPaging.getItems()[0].getId(); //나중에 온클릭요소로 넣자
	playlistSimplifiedPaging.getItems()[0].getUri(); //나중에 온클릭요소로 넣자
	for(int i =0; i<playlistSimplifiedPaging.getItems().length;i++){
		String plImg = "images/플리픽도안2.png";
		if(playlistSimplifiedPaging.getItems()[i].getImages()!=null){
			 plImg = playlistSimplifiedPaging.getItems()[i].getImages()[0].getUrl();}
		
		%>
					<div class="first">
						<div class="first-first">
							<img class="nextAlbum" src="<%=plImg%>"
								onclick="DetailP('<%=playlistSimplifiedPaging.getItems()[i].getId()%>')">
						</div>
						<div class="first-second">
							<span><%=playlistSimplifiedPaging.getItems()[i].getName() %></span><br>
							<span><%=playlistSimplifiedPaging.getItems()[i].getOwner().getDisplayName() %></span>
						</div>
					</div>
					<%}}
	
	%>

				</div>
				
			<span>좋아요한 플레이리스트</span>
			</div>

		</div>
		<div class="PlaylistDetail">
			<% 
	GetRecommendationsRequest getRecommendationsRequest=spotifyApi.getRecommendations()
          .seed_artists("0LcJLqbBmaGUft1e9Mm8HV")
          .seed_genres("electro")
          .seed_tracks("01iyCAUm8EvOFqVWYJ3dVX").build();
	Recommendations recommendations = getRecommendationsRequest.execute();
	for(int i =0;i<recommendations.getTracks().length;){
		%>
			<div class="playlistLine">
				<%
		for(int j=0;j<3;j++){
			if(i<recommendations.getTracks().length){
				String recName=recommendations.getTracks()[i].getArtists()[0].getName();
				if(recommendations.getTracks()[i].getArtists().length>1){
				for(int a=1;a<recommendations.getTracks()[i].getArtists().length;a++){
					recName +=","+recommendations.getTracks()[i].getArtists()[a].getName();
				}}
			%>
				<div class="playlist">
					<table>
						<tr>
							<td><img
								src="<%=recommendations.getTracks()[i].getAlbum().getImages()[0].getUrl()%>"
								width="250px" height="250px"
								onclick="DetailA('<%=recommendations.getTracks()[i].getAlbum().getId()%>')">
							</td>
						</tr>
						<tr>
							<td align="center" onclick="SearchP('<%=recommendations.getTracks()[i].getName()%>')"><%=recommendations.getTracks()[i].getName()%></td>
						</tr>
						<tr>
							<td align="center" onclick="SearchP('<%=recName%>')"><%=recName%></td>
						</tr>

					</table>

				</div>

				<%
			i++;}}
		%>
			</div>
			<%
	}
	%>
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
	<!-- 사이드바를 위한 javascript -->
	<script>
		// JavaScript를 사용하여 사이드바를 토글하는 함수
		document.getElementById("menuButton").addEventListener("click", function() {
    var menu = document.getElementById("menu");
    // 사이드바가 보이는 상태에서는 숨기고, 숨겨진 상태에서는 보이게 함
    if (menu.style.left === "0px") {
        menu.style.left = "-200px";
        document.querySelector(".PlaylistMain").style.marginLeft = "20px"; // 사이드바가 숨겨진 경우 여백 조정
    } else {
        menu.style.left = "0px";
        document.querySelector(".PlaylistMain").style.marginLeft = "220px"; // 사이드바가 보이는 경우 여백 조정
    }
});
		
	</script>
	<!-- playlist 상세및 만들기 -->
	<script>
		var CInputPLDiv ;
		const MyPlaylist = document.getElementById('MyPlaylist');
		var SongAdd;
	const CInputPL = (event)=>{
		CInputPLDiv = document.getElementById('CInputPLDiv');
		if (CInputPLDiv) {
	        document.body.removeChild(CInputPLDiv);
	    }else{
		var x = event.clientX;
	    var y = event.clientY;
	    var newDiv = document.createElement('div');
	    newDiv.id = 'CInputPLDiv';
	    newDiv.innerHTML = "<input type=text id='CInputPL'> <button onclick='CreateP()'>만들기</button>";
	    newDiv.style.left = x + 'px';
	    newDiv.style.top = y + 'px';
	    document.body.appendChild(newDiv);}
};
 	const SongAddP = (event,songUri,Songid)=>{
	 SongAddPDiv = document.getElementById('SongAddPDiv');
	 console.log("X 좌표:"+event.clientX+"Y좌표 : "+ event.clientX)
	 if (SongAddPDiv) {
		 document.body.removeChild(SongAddPDiv)
	 }else{
		 var x = event.clientX;
		 var y = event.clientY;
		 var newDiv = document.createElement('div');
		 newDiv.id = 'SongAddPDiv';
		 newDiv.innerHTML = "<div onclick='SongAddPO(event,\""+songUri+"\",\""+Songid+"\")'><span>플레이리스트에 추가하기</span></div><div onclick='SongAddInQ(\""+songUri+"\")'><span>재생목록에 추가하기</span></div>";
		 newDiv.style.left = x + 'px';
		 newDiv.style.top = y + 'px';
		 document.body.appendChild(newDiv);
	 } };
	 const addSongToPlaylist=(track_id, pl_id)=> {
		    var xhr = new XMLHttpRequest();
		    var url = 'insertSonglist';  // 서블릿 URL
		    var params = 'PL_ID=' + encodeURIComponent(pl_id) + '&track_id=' + encodeURIComponent(track_id);
		    
		    xhr.open('POST', url, true);
		    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

		    xhr.onreadystatechange = function() {
		        if (xhr.readyState == XMLHttpRequest.DONE) {
		            if (xhr.status == 200) {
		                var response = xhr.responseText;
		                if (response.trim() === 'True') {
		                    console.log('Song added successfully.');
		                    // Handle success case here
		                } else {
		                    console.log('Failed to add song.');
		                    // Handle failure case here
		                }
		            } else {
		                console.error('Error:', xhr.status, xhr.statusText);
		                // Handle other HTTP status codes
		            }
		        }
		    };

		    xhr.send(params);
		}
	  const getPL =  (pl_id) => {
		    var xhr = new XMLHttpRequest();
		    console.log('데이터',pl_id)
		    var url = 'GetPLCon?PL_ID='+encodeURIComponent(pl_id);  // 서블릿 URL
		    
		    

		    // 클로저 활용
		    let responseData = 2;  // 외부에서 접근할 데이터 변수
		    return new Promise((resolve, reject) => {
		    xhr.onreadystatechange =   function() {
		        if (xhr.readyState == XMLHttpRequest.DONE) {
		            if (xhr.status == 200) {
		                var response = xhr.responseText;
		                responseData = JSON.parse(response);
		                resolve(responseData);
		               	console.log("비동기",responseData)              // 여기서 다른 작업 수행 가능
		            } else {
		                console.error('Error:', xhr.status, xhr.statusText);
		                console.log('에러')
		                // Handle other HTTP status codes
		            }
		        }
		    };
		    xhr.open('GET', url, true);
		    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
		    xhr.send();
		    })
		    

		    // 클로저를 통해 외부에서 접근 가능한 데이터 반환
		    
		   /*  return {
		        getData: function() {
		        	
		           responseData
		         } 
		    }; */
		};
	const SongAddPO = (event, songUri, Songid)=>{
		var Url="https://api.spotify.com/v1/me/playlists"
		fetch(Url,{
			method: 'GET',
			headers:{
				 'Authorization': `Bearer <%=spotifyApi.getAccessToken()%>`
			}
			
		}).then(response => {
			   if (!response.ok) {
				     throw new Error('Network response was not ok');
				   }
				   return response.json();
				 })
				 .then(data => {
		var Div = document.getElementById('')
		if (Div){
			document.body.removeChild(Div)
		}else{
			var x = event.clientX;
			 var y = event.clientY;
			 var newDiv = document.createElement('div');
			 newDiv.id = 'SongAddPDiv';
			 if(data.total!=0){
			 for(i=0;i<data.total;i++){
			 newDiv.innerHTML = newDiv.innerHTML + "<div onclick='SongAddInP(\""+songUri+"\",\""+data.items[i].id+"\",\""+Songid+"\")'>"
			 +"<span>"+data.items[i].name+"</span>"
			 }
			 }else{
				 newDiv.innerHTML="<span>플레이리스트가 없습니다.</span>"
			 }
			 newDiv.style.left = x + 'px';
			 newDiv.style.top = y + 'px';
			 document.body.appendChild(newDiv);
		}
						
				 }).catch(error => {
					    console.error('Error adding track:', error);
					});
	}
	const SongAddInQ = (songUri=>{
		var Url = "https://api.spotify.com/v1/me/player/queue?uri="+songUri;
		fetch(Url, {
			method: 'POST',
			headers:{
				 'Authorization': `Bearer <%=spotifyApi.getAccessToken()%>`
			}			
		}).then(response=>{
			 if (!response.ok) {
			        throw new Error('Network response was not ok');
			    }
			})
			.then(data => {
			    console.log('Successfully added track:', data);
			    document.body.removeChild(SongAddPDiv);
			})
			.catch(error => {
			    console.error('Error adding track:', error);
			});
		})
		
		
	const SongAddInP = (songUri, playlistId, Songid)=>{
		var apiUrl = "https://api.spotify.com/v1/playlists/"+playlistId+"/tracks";
		const postData = {
			    uris: [songUri], // 예시로 사용할 트랙 URI
			    position: 0
			};
		fetch(apiUrl, {
		    method: 'POST',
		    headers: {
		        'Authorization': `Bearer <%=spotifyApi.getAccessToken()%>`,
		        'Content-Type': 'application/json'
		    },
		    body: JSON.stringify(postData)
		})
		.then(response => {
		    if (!response.ok) {
		        throw new Error('Network response was not ok');
		    }
		    return response.json();
		})
		.then(data => {
		    console.log('Successfully added track:', data);
		    addSongToPlaylist(Songid,playlistId)
		})
		.catch(error => {
		    console.error('Error adding track:', error);
		});
	};


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
	const PlaylistDetail = document.getElementsByClassName("PlaylistDetail")[0]
	const DetailP =  (id) =>{
		var url = "https://api.spotify.com/v1/playlists/"+id
		 fetch(url, {
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
			   PlaylistDetail.replaceChildren();
			   console.log('데이터1',data.id)
			   
			   var dbPLdata =  getPL(data.id).then(result => console.log('넘어온 데이터 ', result))
			   
			   
			   if(data.tracks.total	 != 0){
				    	var plInfoImg = data.images[0].url
				    }else{
				    	var plInfoImg = "images/플리픽도안2.png"
				    }
				    	var temp = document.createElement("div");
				    	temp.className = "pl-info"
				    	temp.innerHTML = "<div>"+
				    	'<img class="plInfoImg" src="'+plInfoImg+'"></div>'+
				    	'<div class="pl-detail-info"><div class="pl-detail-type"><span>플레이리스트</span></div>'+
				    	'<div class="pl-detail-name"><h1>'+data.name+'</h1><button>Like</button><div>'+
				    	'<div class="pl-detail-owner"><span>'+data.owner.display_name+'</span><button>Like</button></div>'+
				    	'</div>';
				    	PlaylistDetail.append(temp);
				    	temp = document.createElement("hr");
				    	PlaylistDetail.append(temp);
				    	temp = document.createElement("div");
				    	temp.className = "Song-info"
				    	temp.innerHTML = 
				    	'<div class="song-num">'+
				    	'<span>#</span></div>'+
				    	'<div class="song-name"><span>제목</span></div>'+
				    	'<div class="song-album"><span>앨범</span></div>'+
				    	'<div class="song-addtime"><span>추가한날짜</span></div>'+
				    	'<div class="song-time"><span>time</span></div>';
				    	PlaylistDetail.append(temp);
				    	temp = document.createElement("hr");
				    	PlaylistDetail.append(temp);
				        for(let i = 0; i < data.tracks.total; i++){
				        	var songsinger=data.tracks.items[i].track.artists[0].name
				        	for(let j =1; j<data.tracks.items[i].track.artists.length;j++){
				        		songsinger=songsinger+","+data.tracks.items[i].track.artists[j].name
				        	}
				        temp = document.createElement("div");
				        temp.className = "Song-info"
				        temp.innerHTML = 
				    	'<div class="song-num">'+
				    	'<span>'+(i+1)+'</span></div>'+
				    	'<div class="song-name">'+
				    	'<div class="first-first">' +
				        '<img class="nextAlbum" src="' + data.tracks.items[i].track.album.images[2].url + 
				        '">' +
				        '</div>' +
				        '<div class="first-second">' +
				            '<span onclick="SearchP(\''+data.tracks.items[i].track.name+'\')">' + data.tracks.items[i].track.name + '</span><br>' +
				            '<span onclick="SearchP(\''+songsinger+'\')">' + songsinger + '</span>' +
				        '</div></div>'+
				    	'<div class="song-album" onclick="DetailA(\''+data.tracks.items[i].track.album.id+'\')"><span>'+data.tracks.items[i].track.album.name+'</span></div>'+
				    	'<div class="song-addtime"><span>'+data.tracks.items[i].added_at.substr(0,10)+'</span></div>'+
				    	'<div class="song-time"><span>'+msToTime(data.tracks.items[i].track.duration_ms)+'</span><button onclick="SongAddP(event,\''+data.tracks.items[i].track.uri+'\',\''+data.tracks.items[i].track.id+'\')">+</button></div>';
				        temp.querySelector('img').addEventListener('click', function() {
				            ChangeSonginQ(i+1); // 이미 생성된 변수 i를 사용하여 함수 호출
				        });
				        
				        PlaylistDetail.append(temp); 
				    }
				        temp = document.createElement("hr");
				    	PlaylistDetail.append(temp);
				    	temp = document.createElement("div");
				    	temp.className="Pl-reply"
				    	temp.innerHTML = 
				    		'<div class="pl-reply-num"><span>#</span></div>'+
				    		'<div class="pl-reply-owner"><span>이름</span></div>'+
				    		'<div class="pl-reply-content"></div>'+
				    		'<div class="pl-reply-hashtag"><span>hashtag<span></div>'
				    	PlaylistDetail.append(temp);
				    	temp = document.createElement("hr");
				    	PlaylistDetail.append(temp);
				    	//리플내용달기
				    	temp = document.createElement("div");
				    	temp.id="Pl-reply-input"
				    	temp.innerHTML=
				    		'<input id="pl-reply-input" type="text"><button onclick="InsertPlreply(\''+data.id+'\')">제출</button>'
				    	PlaylistDetail.append(temp);
			 })
			 .catch(error => {
			   console.error('There was a problem with your fetch operation:', error);
			 });
	}
	<%
	GetCurrentUsersProfileRequest getcurrentusersprofile= spotifyApi.getCurrentUsersProfile().build();
	User user= getcurrentusersprofile.execute();
	%>
	 const CreateP=()=>{
		const url = 'https://api.spotify.com/v1/users/'+"<%=user.getId()%>"+'/playlists';
		var name;
		if(document.getElementById('CInputPL').value==null){
			name = "My Playlist"
	        document.body.removeChild(CInputPLDiv);
		}else{
			name = document.getElementById('CInputPL').value
		 }
		const data = {
		  name: name,
		  public: true
		};

		fetch(url, {
		  method: 'POST',
		  headers: {
		    'Authorization': `Bearer <%=spotifyApi.getAccessToken()%>`,
		    'Content-Type': 'application/json'
		  },
		  body: JSON.stringify(data)
		})
		.then(response => {
		  if (!response.ok) {
		    throw new Error('Network response was not ok');
		  }
		  return response.json();
		})
		.then(data => {
		  console.log('Success:', data);
		  //만든 데이터를 화면에 구현
		  var temp = document.createElement("div");
				    	temp.className = "first"
				    	temp.innerHTML = '<div class="first-first">'+
							'<img class="nextAlbum" src="images/플리픽도안2.png" onclick="DetailP(\''+data.id+'\')">'+
						'</div><div class="first-second"><span>'+data.name+'</span><br>'+
						'<span>'+'<%=user.getDisplayName() %>'+'</span></div>'
					
						MyPlaylist.append(temp);
						var CInputPLDiv = document.getElementById('CInputPLDiv');
						document.body.removeChild(CInputPLDiv);
		  //만든 데이터를 db에 전송data.id
						var xhr = new XMLHttpRequest();
					    var url = 'CreatePLCon';  // 서블릿 URL
					    var params = 'PL_ID=' + encodeURIComponent(data.id) + '&PL_TITLE=' + encodeURIComponent(data.name);
					    
					    xhr.open('POST', url, true);
					    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

					    xhr.onreadystatechange = function() {
					        if (xhr.readyState == XMLHttpRequest.DONE) {
					            if (xhr.status == 200) {
					                var response = xhr.responseText;
					                if (response.trim() === 'True') {
					                    console.log('PL added successfully.');
					                    // Handle success case here
					                } else {
					                    console.log('Failed to add PL');
					                    // Handle failure case here
					                }
					            } else {
					                console.error('Error:', xhr.status, xhr.statusText);
					                // Handle other HTTP status codes
					            }
					        }
					    };

					    xhr.send(params);
					
		})
		.catch(error => {
		  console.error('Error:', error);
		});
	} 
	const RefreshPage =()=>{
		location.reload(true);
		//location.href = location.href;
		//history.go(0);
	}
	const BackPage =()=>{
		history.go(-1);
	}
	const ForwardPage =()=>{
		history.go(1);		
	}
	const DetailA = (id) =>{
		var url = "https://api.spotify.com/v1/albums/"+id
		fetch(url, {
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
			   PlaylistDetail.replaceChildren();
			   if(data.tracks.total != 0){
				    console.log(data)
				    	var plInfoImg = data.images[0].url
				    }else{
				    	var plInfoImg = "images/플리픽도안2.png"
				    }
							
						
						var albumArtists= data.artists[0].name
			   			for(i=1;i<data.artists.length;i++){
							albumArtists = albumArtists + ","+data.artists[i].name}
			   			var temp = document.createElement("div");
				    	temp.className = "pl-info"
				    	temp.innerHTML = "<div>"+
				    	'<img class="plInfoImg" src="'+plInfoImg+'"></div>'+
				    	'<div class="pl-detail-info"><div class="pl-detail-type"><span>앨범</span></div>'+
				    	'<div class="pl-detail-name" onclick="SearchP(\''+data.name+'\')"><h1>'+data.name+'</h1><div>'+
				    	'<div class="pl-detail-owner" onclick="SearchP(\''+albumArtists+'\')"><span>'+albumArtists+'</span></div>'+
				    	'</div>';
				    	PlaylistDetail.append(temp);
				    	temp = document.createElement("hr");
				    	PlaylistDetail.append(temp);
				    	temp = document.createElement("div");
				    	temp.className = "Song-info"
				    	temp.innerHTML = 
				    	'<div class="song-num">'+
				    	'<span>#</span></div>'+
				    	'<div class="song-name"><span>제목</span></div>'+
				    	'<div class="song-album"><span>앨범</span></div>'+
				    	'<div class="song-addtime"><span>추가한날짜</span></div>'+
				    	'<div class="song-time"><span>time</span></div>';
				    	PlaylistDetail.append(temp);
				    	temp = document.createElement("hr");
				    	PlaylistDetail.append(temp);
				        for(let i = 0; i < data.tracks.total; i++){
				        	var songsinger=data.tracks.items[i].artists[0].name
				        	for(let j =1; j<data.tracks.items[i].artists.length;j++){
				        		songsinger=songsinger+","+data.tracks.items[i].artists[j].name
				        	}
				        temp = document.createElement("div");
				        temp.className = "Song-info"
				        temp.innerHTML = 
				    	'<div class="song-num">'+
				    	'<span>'+(i+1)+'</span></div>'+
				    	'<div class="song-name">'+
				    	'<div class="first-first">' +
				        '<img class="nextAlbum" src="' + plInfoImg + 
				        '">' +
				        '</div>' +
				        '<div class="first-second">' +
				            '<span onclick="SearchP(\''+data.tracks.items[i].name+'\')" >' + data.tracks.items[i].name + '</span><br>' +
				            '<span onclick="SearchP(\''+songsinger+'\')">' + songsinger + '</span>' +
				        '</div></div>'+
				    	'<div class="song-album" onclick="SearchP(\''+data.name+'\')"><span>'+data.name+'</span></div>'+
				    	'<div class="song-addtime"><span>'+data.release_date+'</span></div>'+
				    	'<div class="song-time"><span>'+msToTime(data.tracks.items[i].duration_ms)+'</span><button onclick="SongAddP(event,\''+data.tracks.items[i].uri+'\',\''+data.tracks.items[i].id+'\')">+</button></div>';
				        temp.querySelector('img').addEventListener('click', function() {
				            ChangeSonginQ(i+1); // 이미 생성된 변수 i를 사용하여 함수 호출
				        });   
				        PlaylistDetail.append(temp); 
				    }
			 })
			 .catch(error => {
			   console.error('There was a problem with your fetch operation:', error);
			 });
	}
	var searchInput = document.getElementsByClassName("search-input")[0];
	searchInput.addEventListener('keypress', function(event) {
	    // keyCode 혹은 key를 사용하여 Enter 키를 확인합니다.
	    if (event.keyCode === 13 || event.key === 'Enter') {
	        // 입력된 값 가져오기
	        var value = searchInput.value.trim();
	        // 값이 비어 있지 않으면 메소드 실행
	        if (value) {
			SearchP(value);
	        }

	        // 입력창 비우기 (선택사항)
	        searchInput.value = '';
	    }
	});
	const SearchP = (q)=>{
		var url = 'https://api.spotify.com/v1/search?q='+q+'&type=playlist%2Ctrack&limit=30&offset=30'
		   fetch(url, {
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
		 .then(data =>{
			 console.log(data);
			 PlaylistDetail.replaceChildren();
			 for(i=0;i<data.tracks.items.length;){
			 	var temp = document.createElement("div");
		        temp.className = "playlistLine"
		        for(j=0;j<3;j++){
		        	var trackSinger = data.tracks.items[i].album.artists[0].name;
		        	for(r=1;r<data.tracks.items[i].album.artists.length;r++){
		        		trackSinger = trackSinger+data.tracks.items[i].album.artists[r].name;
		        	}
		        	temp.innerHTML=temp.innerHTML+ "<div class='playlist'>"+
		        	'<table><tr><td><img src="'+data.tracks.items[i].album.images[0].url+'"width="250px" height="250px" onclick="DetailA(\''+data.tracks.items[i].album.id+'\')">'+
					'</td></tr><tr>'+
					'<td align="center" onclick="SearchP(\''+data.tracks.items[i].name+'\')">'+data.tracks.items[i].name+'</td>'+
					'</tr><tr><td align="center" onclick="SearchP(\''+trackSinger+'\')">'+trackSinger+'</td></tr></table></div>';
				 i++
		        }
			 PlaylistDetail.append(temp);
			 }				    	
			 temp = document.createElement("hr");
		     PlaylistDetail.append(temp);
			 for(i=0;i<data.playlists.items.length;){
				 	var temp = document.createElement("div");
			        temp.className = "playlistLine"
			        for(j=0;j<3;j++){
			        	temp.innerHTML=temp.innerHTML+ "<div class='playlist'>"+
			        	'<table><tr><td><img src="'+data.playlists.items[i].images[0].url+'"width="250px" height="250px" onclick="DetailP(\''+data.playlists.items[i].id+'\')">'+
						'</td></tr><tr>'+
						'<td align="center" onclick="SearchP(\''+data.playlists.items[i].name+'\')">'+data.playlists.items[i].name+'</td>'+
						'</tr><tr><td align="center" onclick="SearchP(\''+data.playlists.items[i].owner.display_name+'\')">'+data.playlists.items[i].owner.display_name+'</td></tr></table></div>';
					 i++
			        }
			 PlaylistDetail.append(temp);
				 }
		 }).catch(error => {
			   console.error('There was a problem with your fetch operation:', error);
		 });
	}
	const InsertPlreply = (pl_id)=>{
		var xhr = new XMLHttpRequest();
		var reply_input = document.getElementById('pl-reply-input');
	    var url = 'AddReplyCon';  // 서블릿 URL
	    var input_value = reply_input.value;
	    var params = 'PL_ID=' + encodeURIComponent(pl_id)+ '&reply_body=' + encodeURIComponent(input_value);
	    
	    xhr.open('POST', url, true);
	    xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

	    xhr.onreadystatechange = function() {
	        if (xhr.readyState == XMLHttpRequest.DONE) {
	            if (xhr.status == 200) {
	                var response = xhr.responseText;
	                consol.log(response);
	                if (response.trim() === 'True') {
	                    console.log('PL_reply added successfully.');
	                    // Handle success case here
	                } else {
	                    console.log('Failed to add PL_reply');
	                    // Handle failure case here
	                }
	            } else {
	                console.error('Error:', xhr.status, xhr.statusText);
	                // Handle other HTTP status codes
	            }
	        }
	    };

	    xhr.send(params);
	
}
	
	</script>
	<script src="https://sdk.scdn.co/spotify-player.js"></script>
	<!-- player 연동을위해 필요한 javascript -->
	<script>
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
				        '<div class="first-second" onclick="DetailA(\'' + data.queue[i].album.id + '\')">' +
				            '<span onclick="SearchP(\''+data.queue[i].name+'\')">' + data.queue[i].name + '</span><br>' +
				            '<span onclick="SearchP(\''+queueSinger+'\')">' + queueSinger + '</span>' +
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
	    	sessionStorage.setItem("playingNow",1);
	    }	    
	 }
	
	</script>
</body>
</html>