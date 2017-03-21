package com.predicto.controller;

import com.predicto.model.Daily_data;
import com.predicto.model.Friend;
import com.predicto.model.User;
import com.ibm.icu.text.SimpleDateFormat;
import com.predicto.dao.friend_dao;
import com.predicto.dao.user_dao;

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
import java.text.ParseException;

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
		model.setViewName("compare_friends");
		return model;
	}
	
	@RequestMapping("get_comparison")
	public ModelAndView get_comparison(@RequestParam("ids")String ids,HttpSession session) throws Exception
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		List<Friend> friends = friend_dao.get_comparison((Integer) session.getAttribute("user_id"),ids);
		
		ModelAndView model=new ModelAndView();
		
		model.addObject("friends",friends);
		ArrayList<String> run1=new ArrayList<String>();
		ArrayList<String> walk1=new ArrayList<String>();
		ArrayList<String> cycle1=new ArrayList<String>();
		ArrayList<String> work1=new ArrayList<String>();
		for(Friend f:friends)
		{
			List<Daily_data> l1=get_Daily(String.valueOf(f.getId()));
			String run="";
			String walk="";
			String cycle="";
			String work="";
			String ss="";

			String calories="";
			for(int i=0;i<l1.size();i++)
			{
				Daily_data d=new Daily_data();
				d=l1.get(i);
				if(i==0)
				{
					String te=d.getDate();
					te=te.substring(0,10);
					Date date=new SimpleDateFormat("yyyy-mm-dd").parse(te);
					Calendar c = Calendar.getInstance();
					c.setTime(date);
					String[] days={"","sunday","monday","tuesday","wednesday","thursday","friday","saturday"};
					int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
					ss="'"+days[dayOfWeek]+ss+te+"'";
					run=run+d.getRun();
					walk=walk+d.getWalk();
					cycle=cycle+d.getCycle();
					work=work+d.getWorking();
					calories=calories+d.getCalories();
					
				}
				else
				{ 
					String te=d.getDate();
					te=te.substring(0, 10);
					Date date=new SimpleDateFormat("yyyy-mm-dd").parse(te);
					Calendar c = Calendar.getInstance();
					c.setTime(date);
					String[] days={"","sunday","monday","tuesday","wednesday","thursday","friday","saturday"};
					int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
					ss=ss+","+"'"+days[dayOfWeek]+te+"'";
					
					run=run+","+d.getRun();
					walk=walk+","+d.getWalk();
					cycle=cycle+","+d.getCycle();
					work=work+","+d.getWorking();
					calories=calories+","+d.getCalories();
				}
			}
			System.out.println(work+"ebol");
			run1.add(run);
			walk1.add(walk);
			cycle1.add(cycle);
			work1.add(work);
		}
		model.addObject("run",run1);
		model.addObject("walk",walk1);
		model.addObject("cycle",cycle1);
		model.addObject("work",work1);
		model.setViewName("get_comparison");
		return model;
	}
	user_dao userDao=new user_dao();
	public List<Daily_data> get_Daily(String s1) throws ParseException
	{
		System.out.println("it is here");
		List<Daily_data> l=userDao.get_daily_data(s1);

		return l;
	}

}
