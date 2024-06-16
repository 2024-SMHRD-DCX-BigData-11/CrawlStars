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
</head>
<body>
<%SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi"); %>
<!-- https://github.com/spotify-web-api-java/spotify-web-api-java?tab=readme-ov-file 에서 예시보면서 api속 기능 확인하기 -->
<!-- https://developer.spotify.com/documentation/web-api 확인 -->
<% GetCurrentUsersProfileRequest getCurrentUsersProfileRequest = spotifyApi.getCurrentUsersProfile()
.build();
User user = getCurrentUsersProfileRequest.execute(); %>
<form action="JoinCon" method="post" enctype="multipart/form-data" name="JoinForm">
	<table>
		<tr>
			<td>사용자 이름</td>
			<td><input name="SP_name" value="<%=user.getId() %>" readonly></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" id="inputNick" name="nick"> <input type="button" value="중복확인" onclick="checkNick()"><span id="resultCheck"></span></td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
			<input type="radio" name="gender" value="M">남성
			<input type="radio" name="gender" value="F">여성
			</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><!-- 생년월일 연도 드롭다운 -->
				<input type="text" name="birthdate_year" id="birthdate_year">년
    			

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
				</select>월

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
				</select>일
			</td>
		</tr>
		<tr>
			<td>프로필 이미지</td>
			<td><input type="file" name="user_img"></td>
		</tr>
		<tr>
			<td>플레이리스트 연동</td>
			<td>
			<input type="radio" name="Sync_Playlist" value="Y">예 
			<input type="radio" name="Sync_Playlist" value="N">아니오
			</td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" value="회원가입" onclick="CheckForm()"></td>
		</tr>
	</table>

</form>
<a href="Mainpage.jsp">임시탈출</a>
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
				$('#resultCheck').text('중복확인을 해주세요')
				if(data=='true'){
					$('#resultCheck').text('사용중인 닉네임입니다');
					$('#resultCheck').css('color','red');
				}else if(data=='false'){
					$('#resultCheck').text('사용할 수 있는 닉네임입니다');
					$('#resultCheck').css('color','blue');
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