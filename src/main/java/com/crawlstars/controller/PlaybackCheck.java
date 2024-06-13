package com.crawlstars.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.hc.core5.http.ParseException;
import org.json.JSONObject;


import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.miscellaneous.Device;
import se.michaelthelin.spotify.requests.data.player.GetUsersAvailableDevicesRequest;

/**
 * Servlet implementation class PlaybackCheck
 */
public class PlaybackCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =  request.getSession();
		 
		SpotifyApi spotifyApi = (SpotifyApi) session.getAttribute("spotifyApi");
				GetUsersAvailableDevicesRequest getUsersAvailableDevicesRequest = spotifyApi
			    .getUsersAvailableDevices()
			    .build();
				

				JSONObject data = new JSONObject();
		try  {
			Device[] devices = getUsersAvailableDevicesRequest.execute();
			int i = 0;
			for(Device device:devices) {
				data.put("device"+i+"id", device.getId());
				data.put("device"+i+"name", device.getName());
				i++;
			}
			data.put("device", i);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SpotifyWebApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		PrintWriter out = response.getWriter();
        out.print(data);
        out.flush();
	
	}

}
