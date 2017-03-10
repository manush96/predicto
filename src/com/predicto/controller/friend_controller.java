package com.predicto.controller;

import com.predicto.model.User;

import com.predicto.dao.friend_dao;
import javax.servlet.http.HttpSession;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.json.JSONArray;
@Controller
@RequestMapping("/friend/*")

public class friend_controller {
	@Autowired
	friend_dao friend_dao;
	public boolean invalid(HttpSession session)
	{
		if(session.getAttribute("user_id") == null)
			return true;
		else
			return false;
	}
	private static String readAll(Reader rd) throws IOException {
	    StringBuilder sb = new StringBuilder();
	    int cp;
	    sb.append("{ data: ");
	    while ((cp = rd.read()) != -1) {
	      sb.append((char) cp);
	    }
	    sb.append('}');
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
	
	public String commafy_int(ArrayList<String> arr)
	{
		if (arr.size() > 0) {
		    StringBuilder nameBuilder = new StringBuilder();

		    for (String n : arr) {
		        nameBuilder.append(n.replace("'", "\\'")).append(",");
		        // can also do the following
		        // nameBuilder.append("'").append(n.replace("'", "''")).append("',");
		    }
		    nameBuilder.deleteCharAt(nameBuilder.length() - 1);
		    return nameBuilder.toString();
		} else {
		    return "";
		}
	}
	public String commafy_string(ArrayList<String> arr)
	{
		if (arr.size() > 0) {
		    StringBuilder nameBuilder = new StringBuilder();

		    for (String n : arr) {
		        nameBuilder.append("'").append(n.replace("'", "\\'")).append("',");
		        // can also do the following
		        // nameBuilder.append("'").append(n.replace("'", "''")).append("',");
		    }
		    nameBuilder.deleteCharAt(nameBuilder.length() - 1);
		    
		    return nameBuilder.toString();
		} else {
		    return "";
		}
	}
	  
	@RequestMapping("add")
	public ModelAndView add(HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		ModelAndView model=new ModelAndView();
		model.setViewName("add_friend");
		return model;
	}
	
	@RequestMapping("get_friends")
	public ModelAndView get_friends(@RequestParam("q")String q,HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		int id = (Integer) session.getAttribute("user_id");
		List<User> f = friend_dao.get_suggestions(q,id);
		
		ModelAndView model=new ModelAndView();
		model.addObject("friends",f);
		model.setViewName("get_friend_suggestion");
		return model;
	}
	
	@RequestMapping("add_friend")
	public ModelAndView add_friend(@RequestParam("id")String id,HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		int u_id = (Integer) session.getAttribute("user_id");
		friend_dao.add_friend(u_id,id);
		
		return new ModelAndView("opt_view");
	}
	
	@RequestMapping("confirm_friend")
	public ModelAndView confirm_friend(@RequestParam("id")String id,HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		int u_id = (Integer) session.getAttribute("user_id");
		friend_dao.confirm_friend(u_id,id);
		
		return new ModelAndView("opt_view");
	}
	@RequestMapping("decline_friend")
	public ModelAndView decline_friend(@RequestParam("id")String id,HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		int u_id = (Integer) session.getAttribute("user_id");
		friend_dao.decline_friend(u_id,id);
		
		return new ModelAndView("opt_view");
	}
	@RequestMapping("compare")
	public ModelAndView compare(HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		List<User> friends = friend_dao.get_friends((Integer) session.getAttribute("user_id"));
		
		ModelAndView model=new ModelAndView();
		model.addObject("friends",friends);
		return model;
	}
}
