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
<!-- div로 태그 바꿀게요 -->
<form action="" method="post">
	<table>
		<tr>
			<td>사용자 이름</td>
			<td><input name="SP_name" value="<%=user.getId() %>" readonly></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="nick"> <input type="button" value="중복확인"></td>
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
				<select name="birthdate_year" id="birthdate_year">
    			<% 
    				// 1950년부터 2000년까지의 옵션 생성
    				for (int i = 1950; i <= 2024; i++) {
   				 %>
        		<option value="<%= i %>"><%= i %></option>
    			<% 
    				}
    			%>
				</select>

				<!-- 생년월일 월 드롭다운 -->
				<select name="birthdate_month" id="birthdate_month">
   		 		<% 
    				// 1월부터 12월까지의 옵션 생성
    				for (int i = 1; i <= 12; i++) {
    			%>
        		<option value="<%= i %>"><%= i %>월</option>
    			<% 
   	 				}
    			%>
				</select>

				<!-- 생년월일 일 드롭다운 -->
				<select name="birthdate_day" id="birthdate_day">
    			<% 
    				// 1일부터 31일까지의 옵션 생성
    				for (int i = 1; i <= 31; i++) {
    			%>
        			<option value="<%= i %>"><%= i %>일</option>
    			<% 
    				}
    			%>
				</select>
			</td>
		</tr>
		<tr>
			<td>프로필 이미지</td>
			<td><input type="file" name="user_img"></td>
		</tr>
		<tr>
			<td>플레이리스트 연동</td>
			<td>
			<input type="radio" name="PL_link" value="Y">예 
			<input type="radio" name="PL_link" value="N">아니오
			</td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="회원가입"></td>
		</tr>
	</table>

</form>

</body>
</html>