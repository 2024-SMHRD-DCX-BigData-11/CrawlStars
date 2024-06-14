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
   	background-color:#333;
    color: #fff;
    padding: 10px;
    position: fixed; /* 헤더를 화면 상단에 고정 */
    width: 100%; /* 헤더의 너비를 화면 전체로 설정 */
    z-index: 2; /* 헤더를 사이드바 위에 표시 */
    border-width: 1px;
    border-color: grey;
    
}

.headerdiv{
	line-height: 10px;

}

#menuButton{
	margin-right:20px; 
	margin-left:10px; 
}





#menu {
    width: 200px; /* 사이드바의 너비 */
    position: fixed; /* 페이지 스크롤과 상관없이 고정 */
    top: 0; /* 화면 상단부터 고정 */
    left: -200px; /* 초기에는 사이드바를 왼쪽으로 숨김 */
    height: 100%; /* 화면 전체 높이 */
    background-color: #181818;
    padding-top: 60px; /* 헤더와 겹치지 않도록 조정 */
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
    color: grey;
}

#menu li a:hover {
    background-color: #ddd;
}

.stub_box{ /*플레이리스트 div태그를 감싸주는 태그.*/
	margin : 20px; 
    padding: 20px;
    padding-bottom:40px;
    width: 95%;
	float: center;
	background-color: rgb(18, 18, 18);
	border-radius: 20px;
}

.playlist {
	
    display: flex;
    overflow: auto;
  	white-space: nowrap;
}
.playlist_best { /*플레이리스트와는 별개의 베스트 음악 리스트.*/
    display: flex;
    overflow: auto;
  	white-space: nowrap;
}
.playlistmusic{ /*플레이리스트 div태그를 내부의 각각의 리스트 음악들.*/
	margin: 10px;
	margin-bottom: 20px;
	flow:left;
}
h1{
	color:grey;
}

.search-input {
        border-radius: 20px;
        padding: 10px;
        
        border-width:2px;
        border-color: grey;
        width: 400px;
        height:20px;
        background-image: url('images/SearchQ.png');
        background-repeat: no-repeat;
        background-position: left center;
        padding-left: 20px; 
        background-size: 20px 20px;
        background-color: #181818;

    }



</style>

</head>
<body>

<% 
SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
GetPlaylistRequest getPlaylistRequest = spotifyApi.getPlaylist("3cEYpjA9oz9GiPac4AsH4n").build();
Playlist playlist =  getPlaylistRequest.execute();
%>
<!-- header -->
<header>
	<!-- 나중에 적절한 이미지로 교체 -->
	<div class="headerdiv">
	<a id="menuButton" class="headericon">
	<img alt="" src="images/메뉴버튼.png"  width="30" height="30"/>
	</a>
	<a href="Mainpage.jsp" class="headericon">
	<img alt="" src="images/플리픽 로고1.png" onclick="" height="30"/>
	</a>
	</div>
		
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



<!--플레이리스트와는 별개의 베스트 음악 리스트 -->
<div class="stub_box">

<div class="PlaylistSearch" align="center">
	<input type="text" placeholder="검색어를 입력하세요..." class="search-input">
</div>

	<h1>Best Music</h1>
<div class="playlist_best">
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
</div>
</div>



<!-- playlist Stub -->
<div class="stub_box">
<h1>추천 음악</h1>
<div class="playlist">
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>
<div class="playlistmusic">
<table>
	<tr>
		<td><img src="<%= playlist.getImages()[0].getUrl() %>" width="250px" height="250px"></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getName() %></td>
	</tr>
	<tr>
		<td align="center"><%= playlist.getDescription() %></td>
	</tr>
</table>
</div>


</div>

</div>


<script src="./jquery-3.7.1.min.js"></script>

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





</script>

</body>
</html>