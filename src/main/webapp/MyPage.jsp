<%@page import="com.crawlstars.model.Posts"%>
<%@page import="com.crawlstars.model.PostsDAO"%>
<%@page import="com.crawlstars.model.playlistsDAO"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="com.crawlstars.model.Like_pls"%>
<%@page import="java.util.List"%>
<%@page import="com.crawlstars.model.playlists"%>
<%@page import="com.crawlstars.model.Like_plsDAO"%>
<%@page import="com.crawlstars.model.usersDAO"%>
<%@page import="com.crawlstars.model.followsDAO"%>
<%@page import="com.crawlstars.model.users"%>
<%@page import="se.michaelthelin.spotify.model_objects.specification.Image"%>
<%@page import="se.michaelthelin.spotify.model_objects.specification.Playlist"%>
<%@page import="se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest"%>
<%@page import="se.michaelthelin.spotify.SpotifyApi"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PlyPick</title>
<style>
/*마이포스트 게시물 팝업창*/
.post-container {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    
}

.postup {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #181818;
    padding: 20px;
    padding-top : 40px;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    max-width: 1500px;
    text-align: center;
    color: #fff;
    height: 50vh;
    overflow-x:	auto;
}

#posted_img{
	width: 300px;
	height: 300px;
	vertical-align: left;
}
#post_pl_img{
	width: 200px;
	height: 200px;
	vertical-align: left;
}
#post_PL{
	width: 100%;
	display: grid;
	grid-template-columns: 4fr 6fr;
	text-align:center;
}
#post_pl_info{
	text-align: left;
}
.post_reply{
	display: grid;
	grid-template-columns: 10px 5fr 2fr 1.5fr 1.5fr;
}


</style>
<style>
/* 마이포스트 버튼토글 */

#setting{
	padding : 20px;
    width: 40%;
    position: fixed;
    display: none;
    background-color: #181818;
    top: 109px;
    right: 250px;
}
</style>
<style>
/* 게시물 업로드 팝업 */

.popup-container {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}

.popup {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #181818;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    max-width: 800px;
    text-align: center;
    color: #fff;
    z-index: 1;
}

.close-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 20px;
    cursor: pointer;
}
#post_content{
 text-align: left;
}
.post_input{
	width:400px;
	float: right;
	background-color: #BCC6CC;
	border: none;
		
}
.post_musicsearch{
	width:400px;
	float: right;
	background-color: #BCC6CC;
	border: none;
	background-image: url('images/SearchQ.png');
	background-repeat: no-repeat;
    background-position: right center;
    background-size: 20px 20px;
}

.leftinput{
	background-color: #BCC6CC;
	border: none;
}

#input_content{
width: 400px;
height: 150px;
resize: none;
	background-color: #BCC6CC;
	border: none;
}
.post_button{
	background-color: #181818;
	border: none;
	color: white; 	
}
.post_button:hover{
	background-color: #ED1C24;
}
#preview img{
	width: 150px;
	height: 150px;
	float: left;
}
.post_musiclist{
	background-color:#BCC6CC; 
}
.post_musiclist{
height:80px;
overflow-y: auto;
}
</style>
<style>
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://fastly.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}
/* 스타일링을 위한 CSS */
body {
    margin: 0;
    padding: 0;
    font-family: 'Pretendard-Regular';
    background-color: black;
    color: white;
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

.PlaylistSearch{
float:left;
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

.profile-container {
    background-color: rgb(18, 18, 18);
    border-radius: 15px;
    padding: 100px;
    text-align: center;
    margin: 20px;
    margin-top: 30px;
}

.profile-header {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 50px;
}

.profile-picture {
    border-radius: 50%;
    width: 140px;
    height: 140px;
    background-color: #666;
    margin-right: 40px; /* 이미지와 텍스트 사이의 여백 */
}

.profile-info {
    text-align: left; /* 텍스트를 왼쪽 정렬 */
}

.profile-info h1 {
    margin: 0;
    text-align: center;
    font-size: 30px; /* 폰트 크기를 조정 */
}

.profile-info button {
    background-color: #e74c3c;
    text-align: center;
    color: white;
    border: none;
    border-radius: 50px;
    padding: 20px 25px;
    cursor: pointer;
    margin-top: 10px; /* 버튼과 이름 사이의 여백 */
    width: 100%; /* 버튼이 가로로 늘어나도록 조정 */
}

.profile-info button:hover {
    background-color: #c0392b;
}

.profile-stats {
    display: flex;
    justify-content: space-around;
    margin-left:100px;
    margin-right:100px;
}

.stat {
    text-align: center;
}

.stat .number {
    display: block;
    font-size: 20px;
    font-weight: bold;
}

.stat .label {
    font-size: 14px;
    color: #aaa;
}
.MyPage-Main{
   height: 84vh;
   overflow-y: auto;   
}


/* 레이어 팝업 스타일 */
.hidden {
    display: none;
}

.popup-container {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
}

.popup {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #181818;
    padding: 20px;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    width: 500px;
    height: 350px;
    text-align: center;
    color: #fff;
}

.close-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 20px;
    cursor: pointer;
}
#post_content{
    text-align: left;
}
.save-btn{
   background-color: #e74c3c;
    color: white;
    border: none;
    border-radius: 30px;
    padding: 12px 20px;
    cursor: pointer;
    width: 70px;
    font-size: 13px;
    position: absolute; /* 버튼을 absolute로 설정 */
    right: 20px; /* 오른쪽 여백 */
    bottom: 20px; /* 하단 여백 */
}
.popup-profile-picture{
width: 100px;
height:100px;
border-radius:50%;

}
.change-photo-btn{
     background-color: white;
     color: black;
    border-radius: 50px;
    padding: 13px 20px;
    cursor: pointer;
    width:120px;
    height:70;
    font-size: 12px;
    
}
.confirm-btn{
   background-color:#333;
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 12px;
    width: 120px;
}
.nick_name{
   font-size:50px;
   margin: 0 0 0 10px;
}
#preview img{
   width:150px;
   height:150px;
   float:left;
}



/* grid 섹션 */
.profile-sections {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    
.section-content{
   /* margin: 20px 80px 100px 50px ; */
   margin-left : 90px;
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
users user = (users)session.getAttribute("user");
String sp_id = user.getSP_id(); 
if(request.getParameter("sp_id")!=null){
	sp_id = request.getParameter("sp_id");
}
%>
<!-- header -->
<!-- 나중에 적절한 이미지로 교체 -->
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

<!-- 프로필 수정 -->
<div class="MyPage-Main">
<div class="profile-container">
        <div class="profile-header">
            <img src="./ProfileImg/defaultmp.png" alt="프로필 사진" class="profile-picture">
           <div class="profile-info">
           <%
           String userNick = new usersDAO().getUserNick(sp_id);
           int FolloweeCnt = new followsDAO().followee_cnt(sp_id);
           int FollowerCnt = new followsDAO().follower_cnt(sp_id);
           %>	
           		<!-- 사용자 이름 -->
                <p class="nick_name"><%=userNick %></p>
                <%if(request.getParameter("sp_id")==null){ %>
                <button id="showPopup">프로필 수정</button>
                <%} else{%>
                <button id="followButton" onclick="pageuserFollows()">
					<%
					String follower = user.getSP_id();
					String followee = sp_id;
					int FollowCheck = new followsDAO().followCheck(follower, followee);
					if(FollowCheck == 1){ %>언팔로우
					<%} else{ %>
						팔로우
					<%} %>
				</button>
                <%} %>
            </div>
        </div>
        <div class="profile-stats">
            <div class="stat">
                <span class="label">팔로잉</span>
                <span class="number"><%=FolloweeCnt %></span>
            </div>
            <div class="stat">
                <span class="label">팔로워</span>
                <span class="number"><%=FollowerCnt %></span>
            </div>
            <%int likecnt = new Like_plsDAO().gettotalLike(sp_id); %>
            <div class="stat">
                <span class="label">좋아요</span>
                <span class="number"><%=likecnt%></span>
            </div>
        </div>
</div>

<!-- 프로필 수정 팝업 -->
<div id="popupContainer" class="popup-container">
   <div class="popup">
   <span id="closePopup" class="close-btn">×</span>
   <div id = "post_content">
            
               <h2>프로필 변경</h2>
               <p style="font-size: 13px;">개인 정보는 비공개로 유지하세요. 여기에 추가한 정보는 회원님의 프로필을 볼 수 있는 모든 사람에게 표시됩니다.</p>
               <table id="profile_pic">
               <tr>
               <td>
               <!-- <img src="./ProfileImg/defaultmp.png" alt="프로필 사진" class="popup-profile-picture"> -->
               <div id="preview">
               
               </div>
               </td>
              <td>
               <button class="change-photo-btn" onclick="triggerFileInput()">사진 변경</button>
               <input type="file" id="fileInput" class="hidden" accept="image/*" onchange="handleFileChange(event)">
               </td>
               </tr>
               </table>
               <br>     
                <form>
                <label for="name" style="font-size:14px;">닉네임</label><br>
                
                <input type="text" id="inputName" name="inputname" placeholder="Enter your Name">
                <button type="button" class="confirm-btn" onclick="checkNick()">중복확인</button>
                <span id="resultCheck">중복확인을 해주세요</span>
                
               
                <button type="button" class="save-btn" onclick="">저 장</button>
                </form>
          
   </div>
 </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
    
 // 레이어 팝업 열기
    document.getElementById('showPopup').addEventListener('click', function() {
        document.getElementById('popupContainer').style.display = 'block';
    });

    // 레이어 팝업 닫기
    document.getElementById('closePopup').addEventListener('click', function() {
        document.getElementById('popupContainer').style.display = 'none';
    });
   
    
    
 // 파일 입력 요소의 클릭 이벤트를 트리거하는 함수
    function triggerFileInput() {
        document.getElementById('fileInput').click();
    }

    // 파일이 선택되면 이미지 미리보기를 표시하는 함수
    function handleFileChange(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('profileImage').src = e.target.result;
            }
            reader.readAsDataURL(file);
        }
    }
    
    function pageuserFollows(){
    	var myUser = '<%=user.getSP_id() %>';
    	var pageUser = '<%=sp_id %>'
    	$.ajax({
			url : 'FollowsCon',

			data : {
				follower : myUser,
				followee : pageUser
			},
			type : 'POST',

			success : function(response) {
				
			},
			error : function(error) {
				
			}
		});

		location.reload();

	}
    
    function checkNick(){
		var inputNick = $('#inputName').val();
		
		$.ajax({ // {key1: value1, key2: value2, key3: {}}
			//어디로 요청할건지
			url : 'NickCheckCon',
			// 요청 데이터 타입(json)
			data : {'inputNick' : inputNick},
			// 요청방식
			type : 'get',
			// 요청-응답-성공
			success : function(data){
				/* alert(data); */
				if(data=='true'){
					$('#resultCheck').text('사용중인 닉네임입니다');
					$('#resultCheck').css('color','coral');
				}else if(data=='false'){
					$('#resultCheck').text('사용할 수 있는 닉네임입니다');
					$('#resultCheck').css('color','skyblue');
				}
			},
			error : function(){
				alert('error');
			}
			
		})
	}
    
    
    
</script>
    
<script>
// 게시물 작성 팝업 이미지 미리보기
        document.getElementById('fileInput').addEventListener('change',function(event) {
            var files = event.target.files;
            if(files && files[0]){
                var reader = new FileReader();

                reader.onload = function(e) {

                    var imgelement = document.createElement('img');
                    imgelement.src = e.target.result;
                    imgelement.alt = "Upload Image";

                    var previewContainer = document.getElementById('preview');
                    previewContainer.innerHTML = '';
                    previewContainer.appendChild(imgelement);
                };

                reader.readAsDataURL(files[0]);
            }
        });      
</script>




<div class="profile-sections">
            <div class="section" id="MyPlaylist">
                <h2 style="text-align: center;">My Music</h2>
                <div class="section-content">
                <%List<playlists> MyPlaylist = new playlistsDAO().getMyPl(sp_id); 
                if(MyPlaylist!=null){
                	for(int i=0;i<MyPlaylist.size();i++){
                	%>
                	<div class="playlist">
                  <table>
                     <tr>
                        <td><img onclick="redirectToPlaylist('<%=MyPlaylist.get(i).getPl_id() %>')" onerror=this.src="images/플리픽도안2.png" src="<%= MyPlaylist.get(i).getPl_image() %>" width="250px" height="250px"alt="My following"></td>
                     </tr>
                     <tr>
                        <td><%= MyPlaylist.get(i).getPl_title() %></td>
                     </tr>
                     <tr>
                        <td><%= MyPlaylist.get(i).getSp_id() %></td>
                     </tr>
                     </table>
               </div>
                	
                	
                	<% 
                	}
                }
                List<Posts> posts = new PostsDAO().getPost(sp_id);
                for(int i=0;i<posts.size();i++){	
            		if(posts.get(i).getSp_id().equals(sp_id)){
            			
            		%>
            		<div class="playlist">
                  <table>
                     <tr>
                        <td><img onclick="getPost('<%=posts.get(i).getPost_id() %>')" onerror=this.src="images/플리픽도안2.png" src="<%= posts.get(i).getPost_img() %>" width="250px" height="250px"alt="My following"></td>
                     </tr>
                     <tr>
                        <td><%= posts.get(i).getPost_title()  %></td>
                     </tr>
                     <tr>
                        <td onclick="redirectToMyPage('<%=posts.get(i).getSp_id()%>')"><%= posts.get(i).getUpdated_at() %></td>
                     </tr>
                     </table>
               </div>	
            		<% 	
            		
            			}
            		}
                
                %>

                </div>
            </div>
            <div class="section">
                <h2 style="text-align: center;">My following</h2>
                <div class="section-content">
                     <% List<users> fuser = new usersDAO().getfollowee(sp_id); 
                     System.out.print(fuser.get(0).toString());
                     if(fuser!=null){
                    	 for(int i =0;i<fuser.size();i++){
                    		
                    		%>
                    		
                     <div class="playlist">
                  <table >
                     <tr>
                        <td><img onclick="redirectToMyPage('<%=fuser.get(i).getSP_id()%>')" onerror=this.src="images/플리픽도안2.png" src="<%= fuser.get(i).getUser_img() %>" width="250px" height="250px"alt="My following"></td>
                     </tr>
                     <tr>
                        <td><%= fuser.get(i).getNick() %></td>
                     </tr>
                     </table>
               </div>
                    		<%
                    	 }}
                    	 %>
                     
                </div>
            </div>
            <div class="section">
                <h2 style="text-align: center;">Like</h2>
                <div class="section-content">
                    <% List<Like_pls> like_pl = new Like_plsDAO().GetLikePL(sp_id);
                
                if(like_pl!=null){
                	for(int i=0;i<like_pl.size();i++){
                		%>
                	<div class="playlist">
                  <table >
                     <tr>
                        <td><img onclick="redirectToPlaylist('<%=like_pl.get(i).getLiked_at() %>')" onerror=this.src="images/플리픽도안2.png" src="<%= like_pl.get(i).getPl_img() %>" width="250px" height="250px"alt="My Music"></td>
                     </tr>
                     <tr>
                        <td><%= like_pl.get(i).getPl_id() %></td>
                     </tr>
                     <tr>
                        <td><%= like_pl.get(i).getSp_id() %></td>
                     </tr>
                     </table>
               </div>
                		
                		
                <%	}
                	}
                %>
                </div>
            </div>
        </div>
    </div>
<div id="postContainer" class="post-container">
	<div class="postup">
	<span id="closePost" class="close-btn">×</span>
	<div id = "post_content">
					<img alt="" src="images/플리픽 로고1.png" style="width:250px; margin-left: 30px">
					<div style="display: inline-block; width: 400px; margin-left: 15px;"id="pl_title">제목</div>
					
					<div style="display: flex">
					<div>
					<img onerror=this.src="images/플리픽도안2.png" src="images/플리픽도안2.png" id="posted_img">
					</div>
					<div>
					<div style="width: 500px; height: 200px; padding-top: 30px; "id="pl_body">내용</div>
					<div id="pl_owner">
					주인
					</div>
					<div id="pl_hashtag">
					#해시태그	
					</div>
					<div id="pl_update_date">
					등록일
					</div> 
					</div>
					</div>
	</div>
	<hr>
	<div id = "post_PL">
		<div><img onerror=this.src="images/플리픽도안2.png" src="images/플리픽도안2.png" id="post_pl_img"></div>
		<div id="post_pl_info">
			<div id="post_pl_name"><span></span></div>
			<br><br><br>
			<div id="post_pl_owner"><span></span></div>
		</div>
	</div>
	<hr>

	<div class="post_reply">
		<div>#</div>   
		<div>내용</div> 
		<div>해시태그</div> 
		<div>이름</div> 
		<div>등록일</div> 
	</div>
		<div id ="post_replies">
	</div>
	<hr>
	<div id ="post_replies_inputdiv">
	</div>
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
   
 <script>
 function redirectToPlaylist(playlistId) {
	    var url = 'Playlist.jsp?PL_ID=' + playlistId;
	    window.location.href = url;
	}
	function redirectToMyPage(sp_id) {
	    var url = 'MyPage.jsp?sp_id=' + sp_id;
	    window.location.href = url;
	}

	const getPost = (post_id) =>{
		var pl_title= document.getElementById('pl_title')
		var posted_img= document.getElementById('posted_img')
		var pl_body= document.getElementById('pl_body')
		var pl_owner= document.getElementById('pl_owner')
		var pl_hashtag= document.getElementById('pl_hashtag')
		var pl_update_date= document.getElementById('pl_update_date')
		var post_replies = document.getElementById('post_replies');
		var post_PL = document.getElementById('post_PL');
		var post_pl_name = document.getElementById('post_pl_name');
		var post_pl_owner = document.getElementById('post_pl_owner');
		var post_pl_img = document.getElementById('post_pl_img');
		var post_replies_input = document.getElementById('post_replies_input');
		var post_replies_inputdiv = document.getElementById('post_replies_inputdiv');
		var searchDb = document.getElementById('searchDb');
	    	var url = "getMypost?Post_id="+post_id;
	    	fetch(url,{
	    		method: 'GET',
				headers:{
					'Content-Type': 'application/json; charset=utf-8'
				}
	    	}).then(response=>{
				 if (!response.ok) {
				        throw new Error('Network response was not ok');
				    }
				 return response.json();
				})
				.then(data => {
					console.log(data);
	    		pl_title.innerText=data.Post.post_title;
	    		posted_img.src=data.Post.post_img;
	    		pl_body.innerText=data.Post.post_body;
	    		pl_owner.innerText=data.Post.post_id;
	    		pl_hashtag.innerHTML ="";
	    		if(data.post_hashtag!=null){
	    			for(i=0;i<data.post_hashtag.length;i++){
	    				pl_hashtag.innerHTML= pl_hashtag.innerHTML + "<span>#"+data.post_hashtag[i]+"</span>"
	    			}
	    		}
	    		pl_update_date.innerText = data.Post.created_at;
	    		post_replies.innerHTML ="";
	    		var hashtags ="";
	    		if(data.post_replies!=null){
	    			var j=1;
	    			console.log(data.post_replies);
	    			for(i=0;i<data.post_replies.length;i++){
	    				console.log("시작"+i)
	    				var temp = document.createElement("div");
	    				temp.className =  "post_reply"
	    				temp.innerHTML= "<div>"+j+"</div><div>"+data.post_replies[i].reply_content
							+"</div>";
							console.log(data.post_replies[i].reply_content+":"+i);
						var reply_hashtagTemp = document.createElement("div");
						reply_hashtagTemp.innerHTML= "<div class='post_hashtag'>#"+data.post_replies[i].hashtag+"</div>"
	    				while(true){
	    					if(data.post_replies[i]!=null){
	    					if(data.post_replies[i].hashtag!=null){
	    						if(i!=0){
	    						if(data.post_replies[i].post_reply_id==data.post_replies[i-1].post_reply_id){
	    							reply_hashtagTemp.innerHTML= reply_hashtagTemp.innerHTML+"<div class='post_hashtag'>#"+data.post_replies[i].hashtag+"</div>";
	    							if(data.post_replies.length-1>i){
	    								if(data.post_replies[i].post_reply_id==data.post_replies[i+1].post){
	    								i++;}else{break;}
	    							}else{
	    								break;
	    							}
	    							
	    						}else{
	    							break;
	    						}}else{
	    							if(data.post_replies.length-1>i){
	    							i++;}else{break;}
	    						}
	    					}else{
	        					break;
	        				}}else{
	        					break;
	        				}
	    				}
	    				temp.append(reply_hashtagTemp);    				
						temp.innerHTML = temp.innerHTML+"<div>"+data.post_replies[i].sp_id+"</div><div>"+data.post_replies[i].replied_at.substr(0,10)+"</div>"
						post_replies.append(temp);
						j++
	    			}
	    		}
	    		if(data.Post.pl_id!=null){
	    			post_PL.style.display='grid';
	    			post_pl_img.src=data.Post.pl_img;
	    			post_pl_name.innerHTML = "<span onclick='redirectToPlaylist(\""+data.Post.pl_id+"\")'>"+data.Post.pl_title+"</span>"
	    			post_pl_owner.innerHTML = "<span onclick='redirectToMyPage(\""+data.Post.pl_owner+"\")'>"+data.Post.pl_owner+"</span>"
	    		}else{
	    			post_PL.style.display='none';
	    		}
	    		post_replies_inputdiv.innerHTML = "<input id='post_replies_input'><button onclick='InsertPostreply(\""+post_id+"\")'>입력</button>" 		
	    		document.getElementById('postContainer').style.display = 'block';
	    		})
	    	.catch(error => {
			  console.error('Error:', error);
			});}
	document.getElementById('closePost').addEventListener('click', function() {
        document.getElementById('postContainer').style.display = 'none';
    });
 </script>  
</body>
</html>