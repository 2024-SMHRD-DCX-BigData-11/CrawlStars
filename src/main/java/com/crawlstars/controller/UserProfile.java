package com.crawlstars.controller;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.User;
import se.michaelthelin.spotify.requests.data.users_profile.GetCurrentUsersProfileRequest;
import org.apache.hc.core5.http.ParseException;

import java.io.IOException;
import java.util.concurrent.CancellationException;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;

public class UserProfile {

  public User getCurrentUsersProfile_Sync(SpotifyApi spotifyApi) {
	  User user= null;
    try {
    	 GetCurrentUsersProfileRequest getCurrentUsersProfileRequest = spotifyApi.getCurrentUsersProfile()
    		    .build();
       user = getCurrentUsersProfileRequest.execute();

      System.out.println("Display name: " + user.getDisplayName());
    } catch (IOException | SpotifyWebApiException | ParseException e) {
      System.out.println("Error: " + e.getMessage());
    }
    return user;
  }

  public static void getCurrentUsersProfile_Async(SpotifyApi spotifyApi) {
    try {
    	GetCurrentUsersProfileRequest getCurrentUsersProfileRequest = spotifyApi.getCurrentUsersProfile()
    		    .build();
      final CompletableFuture<User> userFuture = getCurrentUsersProfileRequest.executeAsync();

      // Thread free to do other tasks...

      // Example Only. Never block in production code.
      final User user = userFuture.join();

      System.out.println("Display name: " + user.getDisplayName());
    } catch (CompletionException e) {
      System.out.println("Error: " + e.getCause().getMessage());
    } catch (CancellationException e) {
      System.out.println("Async operation cancelled.");
    }
  }

}