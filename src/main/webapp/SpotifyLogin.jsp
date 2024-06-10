<%@page import="com.crawlstars.pkce.AuthorizationCodeUriExample"%>
<%@page import="java.util.concurrent.CancellationException"%>
<%@page import="java.util.concurrent.CompletionException"%>
<%@page import="java.util.concurrent.CompletableFuture"%>
<%@page import="se.michaelthelin.spotify.requests.authorization.authorization_code.AuthorizationCodeUriRequest"%>
<%@page import="se.michaelthelin.spotify.SpotifyHttpManager"%>
<%@page import="java.net.URI"%>
<%@page import="se.michaelthelin.spotify.SpotifyApi"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<%
URI uri = new AuthorizationCodeUriExample().authorizationCodeUri_Sync();
response.sendRedirect(uri.toString());
%>
<a href="<%=uri%>">로그인해주세요</a>
<img src='https://i.scdn.co/image/ab67616d0000b2732c5b24ecfa39523a75c993c4'>
</body>
</html>