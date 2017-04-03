package com.predicto.controller;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.*;
import org.ow2.util.base64.Base64;
import org.quartz.SchedulerException;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ibm.icu.text.SimpleDateFormat;
import com.predicto.dao.scheduler_dao;
import com.predicto.dao.user_dao;
import com.predicto.model.Daily_data;
import com.predicto.model.User;
import com.predicto.services.conversion;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;
import org.apache.tomcat.util.codec.binary.StringUtils;

@Controller
@RequestMapping("/user/*")

public class user_controller {
	private static String UPLOADED_FOLDER = "C:\\Uploads\\";
	public boolean invalid(HttpSession session)
	{
		if(session.getAttribute("user_id") == null)
			return true;
		else
			return false;
	}
	@Autowired
	user_dao userDao;
	@Autowired
	scheduler_dao scheduler_dao;
	
	@RequestMapping("dashboard")
	public ModelAndView add(HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		int id = (Integer)session.getAttribute("user_id");
		int status = userDao.checkStatus(id);
		if(status == 1)
			return new ModelAndView("user_dashboard");
		else
			return new ModelAndView("one_time_form");
	}
	@RequestMapping("login")
	public ModelAndView login()
	{
		return new ModelAndView("user_login");
	}
	@RequestMapping("signin")
	public String signin(@RequestParam("username")String username,@RequestParam("password")String password,HttpSession session) throws SchedulerException
	{
		
		User user=new User();
		user.setPassword(password);
		user.setUsername(username);
		int i=userDao.checkLogin(user);
	
		if(i!=0)
		{
			scheduler_dao.scheduler1();
			session.setAttribute("user_id",i);
			session.setAttribute("username",username);
			return "redirect:dashboard";
		}
		else
		{
			return "redirect:login";
		}
	}
	@Autowired
	ServletContext context;
    
	@RequestMapping("register")
	public String register(@RequestParam("username")String username,@RequestParam("password")String password,@RequestParam("email")String email,HttpSession session)
	{
		User user=new User();
		user.setPassword(password);
		user.setEmail(email);
		user.setUsername(username);
		int k=userDao.addUser(user);
		String path=System.getProperty("user.dir")+"\\img\\fulls\\"+k;
		new File(path).mkdir();
		session.setAttribute("user_id",k);
		session.setAttribute("username",username);
		return "redirect:dashboard";
	}
	
	@RequestMapping("success_signup")
	public ModelAndView success()
	{
		return new ModelAndView("success_signup");
	}
	@RequestMapping("save_one_time_data")
	public String save_one_time_data(@RequestParam("gender")int gender,@RequestParam("age")int age,@RequestParam("height")int height,@RequestParam("weight")int weight,@RequestParam("diabetic")int diabetic,HttpSession session)
	{
		if(invalid(session))
			return "redirect: login";
		User user = new User();
		user.setAge(age);
		user.setHeight(height);
		user.setWeight(weight);
		user.setGender(gender);
		user.setDiabetic(diabetic);
		user.setStatus(1);
		int id = (Integer)session.getAttribute("user_id");
		userDao.addInitialData(user,id);
		return "redirect:dashboard";
	}
	@RequestMapping("report")
	public ModelAndView report(HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		return new ModelAndView("user_report");
	}
	@RequestMapping("report_view")
	public ModelAndView report_view(HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		return new ModelAndView("user_report_view");
	}
	@RequestMapping(value = "upload_data", method = RequestMethod.POST)
    public String singleFileUpload(@RequestParam("report") MultipartFile file,
                       RedirectAttributes redirectAttributes,HttpSession session)
	{
		if(invalid(session))
			return "redirect: login";
        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            return "redirect:uploadStatus";
        }

        try {
        	byte[] bytes = file.getBytes();
        	DateFormat dateFormat = new java.text.SimpleDateFormat("dd_MM_ss");
        	Date date = new Date();
        	System.out.println(System.getProperty("user.dir"));
        	String user_id=session.getAttribute("user_id").toString();
        	System.out.println(dateFormat.format(date)+"budh-");
        	String name=dateFormat.format(date)+".jpg";
            Path path = Paths.get(System.getProperty("user.dir")+"\\img\\fulls\\"+user_id+"\\" +name);
            System.out.println(System.getProperty("user.dir")+"\\img\\fulls\\"+user_id+"\\" +name);
            System.out.println(path);
            Files.write(path, bytes);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "upload";
    }
	@RequestMapping("logout")
	public String logout(HttpSession session)
	{
		session.removeAttribute("user_id");
		return "redirect:login";
	}
	@RequestMapping("daily_data")
	public ModelAndView daily_data_collect(@RequestParam(value = "id", required=false) Integer id,HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		ModelAndView model = new ModelAndView();
		model.addObject("notif_id",id);
		model.setViewName("daily_exercise");
		return model;
	}
	@RequestMapping("save_daily_data")
	public String save_daily_data(@RequestParam("notif_id")int notif_id,@RequestParam("working")String working,@RequestParam("running")String run,@RequestParam("walking")String walk,@RequestParam("cycling")String cycle,@RequestParam("running-unit")String run_unit,@RequestParam("walking-unit")String walk_unit,@RequestParam("cycling-unit")String cycle_unit, HttpSession session)
	{
		if(invalid(session))
			return "redirect:login";

		System.out.println(run_unit+walk_unit+cycle_unit+run+walk+cycle+working);
		if(run_unit.equals("2"))
		{
			float f=Float.parseFloat(run);
			f=(float) (f*1.60934);
			run=String.valueOf(f);
		}
		else if(run_unit.equals("3"))
		{
			float f=Float.parseFloat(run);
			f=(float) (f*(12.5/60));
			f=(float) (f*1.60934);
			run=String.valueOf(f);
		}
		if(walk_unit.equals("2"))
		{
			float f=Float.parseFloat(walk);
			f=(float) (f*1.60934);
			walk=String.valueOf(f);
		}
		else if(walk_unit.equals("3"))
		{
			float f=Float.parseFloat(walk);
			f=(float) (f*(3.1/60));
			f=(float) (f*1.60934);
			walk=String.valueOf(f);
		}
		
		if(cycle_unit.equals("2"))
		{
			float f=Float.parseFloat(cycle);
			f=(float) (f*1.60934);
			cycle=String.valueOf(f);
			
		}
		else if(cycle_unit.equals("3"))
		{
			float f=Float.parseFloat(cycle);
			f=(float) (f*(9.6/60));
			f=(float) (f*1.60934);
			cycle=String.valueOf(f);
		}

		System.out.println(run+walk+cycle+working+"aka");
		String ans1=conversion.convert_calories_cycle(cycle);
		String ans2=conversion.convert_calories_run(run);
		String ans3=conversion.convert_calories_walk(walk);
		String ans4=conversion.convert_calories_work(working);
		float a=Float.parseFloat(ans1)+Float.parseFloat(ans2)+Float.parseFloat(ans3)+Float.parseFloat(ans4);
		String cal=String.valueOf(a);
		userDao.delete_notif(notif_id);
		userDao.save_daily_exercise(run,walk,cycle,working,session.getAttribute("user_id").toString(),cal);
		return "redirect:dashboard";
	}
	@RequestMapping("daily_report_view")
	public ModelAndView daily_report_view(HttpSession session) throws ParseException
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		int user_id=(Integer) session.getAttribute("user_id");
		String s1=Integer.toString(user_id);
		List<Daily_data> l=userDao.get_daily_data(s1);
		
		ModelAndView model=new ModelAndView();
		String run="";
		String walk="";
		String cycle="";
		String work="";
		String ss="";

		String calories="";
		for(int i=0;i<l.size();i++)
		{
			Daily_data d=new Daily_data();
			d=l.get(i);
			
			String date = d.getDate();
			date = date.substring(0, 10);
			run += "{ year: '"+ date +"', value: "+d.getRun()+" },";
			walk += "{ year: '"+ date +"', value: "+d.getWalk()+" },";
			cycle += "{ year: '"+ date +"', value: "+d.getCycle()+" },";
			work += "{ year: '"+ date +"', value: "+d.getWorking()+" },";
			calories += "{ year: '"+ date +"', value: "+d.getCalories()+" },";
		}
		run = run.substring(0,run.length()-1);
		walk = walk.substring(0,walk.length()-1);
		cycle = cycle.substring(0,cycle.length()-1);
		work = work.substring(0,work.length()-1);
		calories = calories.substring(0,calories.length()-1);
		
		model.addObject("run",run);
		model.addObject("walk",walk);
		model.addObject("cycle",cycle);
		model.addObject("work",work);
		model.addObject("x",ss);
		model.addObject("calories",calories);
		
		model.setViewName("daily_charts");
		return model;
	}
	@RequestMapping("weekly_data")
	public ModelAndView weekly_data_collect(@RequestParam(value = "id", required=false) Integer id,HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		ModelAndView model = new ModelAndView();
		model.addObject("notif_id",id);
		model.setViewName("weekly_form");
		return model;
	}
	@RequestMapping("save_weekly_data")
	public String save_weekly_data(HttpSession session,@RequestParam("alcohol")String alco,@RequestParam("bp_sys") String bp_1,@RequestParam("bp_2")String bp_2,@RequestParam("ch_1")String ch_1,@RequestParam("ch_2")String ch_2,@RequestParam("cigs")String cigs,@RequestParam("sugar")String sugar,@RequestParam("notif_id")int notif_id)
	{
		
		int i=(Integer)session.getAttribute("user_id");
		String id=String.valueOf(i);
		userDao.delete_notif(notif_id);
		userDao.save_weekly_data(id,alco,bp_1,bp_2,ch_1,ch_2,cigs,sugar);	
		return "redirect:dashboard";
	
	}
	@RequestMapping("daily_food_details")
	public ModelAndView daily_food_details(@RequestParam(value = "id", required=false) Integer id,HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		ModelAndView model = new ModelAndView();
		model.setViewName("daily_food_details");
		return model;
	}
	@RequestMapping("save_daily_food")
	public String save_daily_food(@RequestParam("items") String item_str,HttpSession session)
	{
		if(invalid(session))
			return "redirect:login";
		
		int id,cnt;
		double total_cal = 0;
		String[] items = item_str.split(",");
		for(String i : items)
		{
			String[] vals = i.split(":");
			id = Integer.parseInt(vals[0]);
			cnt = Integer.parseInt(vals[1]);
			//id - of food item, cnt - number of items consumed
			System.out.println("ID: " + id + ", Count: " + cnt);
			total_cal += userDao.findCal(id, cnt);
		}
		userDao.updateCal((Integer)session.getAttribute("user_id"), total_cal, item_str);
		return "redirect:daily_food_details";
		
	}
	@RequestMapping("set_notif_read")
	public ModelAndView set_notif_read(HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		
		int id = (Integer)session.getAttribute("user_id");
		userDao.set_notif_read(id);
		return new ModelAndView("opt_view");
	}
	@RequestMapping("push_daily")
	public ModelAndView push_daily(HttpSession session)
	{
		userDao.pushDaily();
		return new ModelAndView("opt_view");
	}
	@RequestMapping("push_weekly")
	public ModelAndView push_weekly(HttpSession session)
	{
		userDao.pushWeekly();
		return new ModelAndView("opt_view");
	}
	@RequestMapping("push_food")
	public ModelAndView push_food(HttpSession session)
	{
		userDao.pushFood();
		return new ModelAndView("opt_view");
	}
}
