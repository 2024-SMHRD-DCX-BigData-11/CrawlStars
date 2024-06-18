<%@page import="se.michaelthelin.spotify.model_objects.specification.User"%>
<%@page import="se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest"%>
<%@page import="se.michaelthelin.spotify.SpotifyApi"%>
<%@page import="se.michaelthelin.spotify.SpotifyHttpManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
    background-color: black;
    color: white;
   
}

table {
  border-spacing: 30px;
}

form {
  
}

div{
	width: 585px;
	margin: 0 auto;
}

select {
  -moz-appearance: none;
  -webkit-appearance: none;
  appearance: none;
  
  font-size: 15px;
  text-align:center;
  
  color: white;
  background-color: black;
  
  padding: .6em 1em .5em 1em;
  margin: 0;
  
  border: 1px solid grey;
  border-radius: 5px;
  box-shadow: 0 1px 0 1px rgba(0,0,0,.04);
}

select:focus {
  border-color: grey;
  color: white;
}

[type="radio"] {
  align: center;
  appearance: none;
  border: max(2px, 0.1em) solid gray;
  border-radius: 50%;
  width: 1.25em;
  height: 1.25em;
}

[type="radio"]:checked {
  background-color: white;
  box-shadow: 0 0 0 1px white;
}

.JoinTitle{
	padding-top:30px;
	padding-left:30px;
}

.JoinLabel{
	color: white;
	font-size: 20px;
	font-weight: bold;
}

.JoinInputData{
	font-size: 15px;
	background-color: black;
	color: white;
	padding: .6em 1.4em .5em .8em;
	border: 1px solid grey;
	border-radius:5px;
}

.JoinSubmitButton{
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	
	background-color: #e74c3c;
    color: white;
    border: none;
    border-radius: 30px;
    padding: 10px 25px 10px 25px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
	float: right;
	
}

.NickCheckButton{
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	
	background-color: black;
    color: white;
    border: 2px solid white;
    border-radius: 30px;
    font-size: 16px;
    font-weight: bold;
}

#resultCheck{
	padding-top: 5px;
	font-size: 15px;
	color: lightgrey;
}

.BirthdateLabelText{
	font-size: 15px;
	padding: 0 1em 0 1em;
}

#birthdate_year{
	width: 50px;
}

#JoinPageLogo{
	
}

</style>
</head>
<body>
<%SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi"); %>
<!-- https://github.com/spotify-web-api-java/spotify-web-api-java?tab=readme-ov-file 에서 예시보면서 api속 기능 확인하기 -->
<!-- https://developer.spotify.com/documentation/web-api 확인 -->
<% GetCurrentUsersProfileRequest getCurrentUsersProfileRequest = spotifyApi.getCurrentUsersProfile()
.build();
User user = getCurrentUsersProfileRequest.execute(); %>
<div>
<form action="JoinCon" method="post" enctype="multipart/form-data" name="JoinForm">
	<table>
		<img class="JoinPageLogo" alt="" src="images/플리픽 로고1.png" height="30"/>
		<h1 class="JoinTitle">회원가입</h1>
		<tr>
			<td><span class="JoinLabel">사용자 이름</span></td>
			<td><input class="JoinInputData" name="SP_name" value="<%=user.getId() %>" style="border-color:black;" readonly></td>
		</tr>
		<tr>
			<td><span class="JoinLabel">닉네임</span></td>
			<td><input class="JoinInputData" type="text" id="inputNick" name="nick"> <input class="NickCheckButton" type="button" value="중복확인" onclick="checkNick()"><br><span id="resultCheck">중복확인을 해주세요</span></td>
		</tr>
		<tr>
			<td><span class="JoinLabel">성별</span></td>
			<td>
			<input type="radio" name="gender" value="M">남성
			<input type="radio" name="gender" value="F">여성
			</td>
		</tr>
		<tr>
			<td><span class="JoinLabel">생년월일</span></td>
			<td><!-- 생년월일 연도 입력 -->
				<input class="JoinInputData" type="text" name="birthdate_year" id="birthdate_year"><span class="BirthdateLabelText">년</span>
    			

				<!-- 생년월일 월 드롭다운 -->
				<select name="birthdate_month" id="birthdate_month">
   		 		<% 
    				// 1월부터 12월까지의 옵션 생성
    				for (int i = 1; i <= 12; i++) {
    			%>
        		<option value="<%= i %>"><%= i %></option>
    			<% 
   	 				}
    			%>
				</select><span class="BirthdateLabelText">월</span>

				<!-- 생년월일 일 드롭다운 -->
				<select name="birthdate_day" id="birthdate_day">
    			<% 
    				// 1일부터 31일까지의 옵션 생성
    				for (int i = 1; i <= 31; i++) {
    			%>
        			<option value="<%= i %>"><%= i %></option>
    			<% 
    				}
    			%>
				</select><span class="BirthdateLabelText">일</span>
			</td>
		</tr>
		<tr>
			<td><span class="JoinLabel">프로필 이미지</span></td>
			<td><input type="file" name="user_img"></td>
		</tr>
		<tr>
			<td><span class="JoinLabel">플레이리스트 연동</span></td>
			<td>
			<input type="radio" name="Sync_Playlist" value="Y">예 
			<input type="radio" name="Sync_Playlist" value="N">아니오
			</td>
		</tr>
		<tr>
			<td colspan="2"><input class="JoinSubmitButton" type="button" value="회원가입" onclick="CheckForm()"></td>
		</tr>
	</table>

</form>
<a href="Mainpage.jsp">임시탈출</a>
<a href="insertSonglist?PL_ID=1HU4Ik89RuPE9WH1cBbpvm">아이유</a>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	function checkNick(){
		var inputNick = $('#inputNick').val();
		
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
	function CheckForm(){
		if(JoinForm.nick.value==""){
			alert("닉네임을 확인해주세요.");
			myform.id.focus();
			return false;
		}
		
		flag = false;
		for(i=0; i < JoinForm.gender.length; i++){
			if(JoinForm.gender[i].checked){
				flag = true;
				break;
			}
		}
		
		if(flag == false){
			alert("성별을 확인해주세요.");
			return false;
		}
		
		if(JoinForm.birthdate_year.value==""){
			alert("생년월일을 확인해주세요.");
			JoinForm.birthdate_year.focus();
			return false;
		}
		
		flag = false;
		for(i=0; i < JoinForm.Sync_Playlist.length; i++){
			if(JoinForm.Sync_Playlist[i].checked){
				flag = true;
				break;
			}
		}
		
		if(flag == false){
			alert("플레이리스트 연동을 확인해주세요.");
			return false;
		}
		
		JoinForm.submit();
		
	}
		
</script>

</body>
</html>