package com.crawlstars.pkce;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.SpotifyHttpManager;
import se.michaelthelin.spotify.requests.authorization.authorization_code.AuthorizationCodeUriRequest;

import java.net.URI;
import java.util.concurrent.CancellationException;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;

public class AuthorizationCodeUriExample {
	private static final String clientId = "d2c6f681b6a64ad2b59cebe730b55597";
	private static final String clientSecret = "01564ad8f8ac4f9dafa71c156aa99038";
	private static final URI redirectUri = SpotifyHttpManager.makeUri("http://localhost:8081/Plypick/callback");

  private static final SpotifyApi spotifyApi = new SpotifyApi.Builder()
    .setClientId(clientId)
    .setClientSecret(clientSecret)
    .setRedirectUri(redirectUri)
    .build();
  private static final AuthorizationCodeUriRequest authorizationCodeUriRequest = spotifyApi.authorizationCodeUri()
//          .state("x4xkmn9pu3j6ukrs8n")
            .scope("user-read-email,ugc-image-upload,user-read-private,user-read-playback-state,user-modify-playback-state,streaming,playlist-modify-public,playlist-modify-private")
//          .show_dialog(true)
    .build();

  public static URI authorizationCodeUri_Sync() {
    final URI uri = authorizationCodeUriRequest.execute();

    return uri;
  }

  public static void authorizationCodeUri_Async() {
    try {
      final CompletableFuture<URI> uriFuture = authorizationCodeUriRequest.executeAsync();

      // Thread free to do other tasks...

      // Example Only. Never block in production code.
      final URI uri = uriFuture.join();

      System.out.println("URI: " + uri.toString());
    } catch (CompletionException e) {
      System.out.println("Error: " + e.getCause().getMessage());
    } catch (CancellationException e) {
      System.out.println("Async operation cancelled.");
    }
  }

  public static void main(String[] args) {
    authorizationCodeUri_Sync();
    authorizationCodeUri_Async();
  }
}