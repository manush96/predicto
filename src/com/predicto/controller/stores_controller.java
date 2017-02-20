package com.predicto.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import org.json.JSONException;
import org.json.JSONObject;
@Controller
@RequestMapping("/stores/*")

public class stores_controller {
	
	private static String readAll(Reader rd) throws IOException {
	    StringBuilder sb = new StringBuilder();
	    int cp;
	    while ((cp = rd.read()) != -1) {
	      sb.append((char) cp);
	    }
	    return sb.toString();
	  }

	  public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
	    InputStream is = new URL(url).openStream();
	    try {
	      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
	      String jsonText = readAll(rd);
	      JSONObject json = new JSONObject(jsonText);
	      return json;
	    } finally {
	      is.close();
	    }
	  }
	  
	@RequestMapping("locate")
	public ModelAndView locate(HttpSession session)
	{
		try {
			
			String lat = (String)session.getAttribute("latitude");
			String lng = (String)session.getAttribute("longitude");
			JSONObject json = readJsonFromUrl("http://www.medplusmart.com/GetStores.mart?latLong=("+lat+", "+lng+")");
			
			System.out.println("Saavn...");
		    System.out.println(json.toString());
		    System.out.println(json.get("id"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return new ModelAndView("stores_index");
	}
	@RequestMapping("set_lat_long")
	public ModelAndView set_lat_long(@RequestParam("lat")String lat,@RequestParam("lng")String lng,HttpSession session)
	{
		session.setAttribute("latitude", lat);
		session.setAttribute("longitude", lng);
		return new ModelAndView("opt_view");
	}
}
