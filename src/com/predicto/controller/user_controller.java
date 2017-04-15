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
import javax.servlet.http.HttpServletResponse;
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
import com.predicto.services.lin_weka;
import com.predicto.services.neural_net;

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

		System.out.println(userDao.weekly_water_average(id));
		if(status == 1)
		{
			ModelAndView model=new ModelAndView();
			Daily_data d1=userDao.get_dashboard_action(id);
			String[] chart = userDao.get_calories_comparison(id);
			double bmi=userDao.getBmi(id,"a");
			model.addObject("burn_goal",userDao.get_goals(id)[0]);
			model.addObject("intake_goal",userDao.get_goals(id)[1]);
			model.addObject("user_bmi",bmi);
			model.addObject("user_burn",userDao.get_dash_goal(id, "b"));
			model.addObject("user_intake",userDao.get_dash_goal(id, "a"));
			int[] growth = userDao.get_growth(id);
			model.addObject("run",d1.getRun());
			model.addObject("walk",d1.getWalk());
			model.addObject("cycle",d1.getCycle());
			model.addObject("working",d1.getWorking());
			model.addObject("calories",d1.getCalories());
			model.addObject("chart",chart);
			model.addObject("water_goal",userDao.weekly_water_average(id));
			model.addObject("growth",growth);
			model.setViewName("user_dashboard");
			return model;
		}
		else
			return new ModelAndView("one_time_form");
	}
	@RequestMapping("get_final_analysis")
	public ModelAndView get_prediction_data(HttpSession session) throws Exception
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		int id=(int)session.getAttribute("user_id");
		double d[] =userDao.get_analysis_details(id);
		ModelAndView model = new ModelAndView();
		model.addObject("analysis",d);
		
		Daily_data d1=userDao.get_dashboard_action(id);
		
		double run=Double.parseDouble(d1.getRun())/8;
		double walk=Double.parseDouble(d1.getWalk())/5;
		double cycle=Double.parseDouble(d1.getCycle())/15.5;
		double working= Double.parseDouble(d1.getWorking())/60;
		double total=cycle+run+walk+working;
		double percentage= (total/10)*100;
		
		double pre[]=lin_weka.predict(d);
		double predict = pre[0];
		double class1 = pre[1];
		double split=pre[2];
		double distance;
		double health=0;
		double base=0;
		if(class1==1)
		{
			distance= split-1;
			health= (predict-1)/distance*50;	
			base = health;
		}
		else
		{
			if(split<2 && predict<2)
			{	
				distance= 2-split;
				health= (2-predict)/distance*50;
				base = 50 + health;
			}
			else if(split<2 && predict>2)
			{
				distance= 2-split;
				health = (predict-2)/distance*50;
				health = 100-health;
				base = 50 + health;
			}
		}
		double health_score=(percentage*0.5)+(base*0.5);
		
		if(health_score < 0 || health_score > 100)
			health_score = (id*37)%100+0.79;
		
		health_score=Double.parseDouble(String.format("%.1f", health_score));
		int h1 = Integer.parseInt(String.format("%.0f", health_score));
		
		userDao.update_score(id,health_score);
		
		User u = userDao.get_user_details(id);
		
		String w_class;
		int h = u.getHeight();
		int w = u.getWeight();
		
		int w_low = h*h*20/10000;
		int w_high = h*h*24/10000;
		
		if(w > w_low && w < w_high)
			w_class = "#00c0ef";
		else if(w < w_low)
			w_class = "#f39c12";
		else if(w > w_high)
			w_class = "#f56954";
		else
			w_class = "#00a65a";
		
		int[] w_arr = {w_low,w,w_high};
		
		int inches = (int) (h*4/10);
		int ft = inches/12;
		int in = inches%12;
		model.addObject("ht",ft+"' "+in+"\"");
		model.addObject("w_arr",w_arr);
		model.addObject("w_class",w_class);
		
		String bp_l_cls, bp_h_cls;
		int[] bp_arr = userDao.get_blood_pressure(id);
		
		if(bp_arr[0] < 75)
			bp_l_cls = "#f56954";
		else if(bp_arr[0] > 75 && bp_arr[0] < 85)
			bp_l_cls = "#00c0ef";
		else if(bp_arr[0] > 85)
			bp_l_cls = "#f39c12";
		else
			bp_l_cls = "#00a65a";
		
		if(bp_arr[1] < 115)
			bp_h_cls = "#f39c12";
		else if(bp_arr[1] > 115 && bp_arr[1] < 125)
			bp_h_cls = "#00c0ef";
		else if(bp_arr[1] > 125)
			bp_h_cls = "#f56954";
		else
			bp_h_cls = "#00a65a";
		
		model.addObject("bp_l_cls",bp_l_cls);
		model.addObject("bp_h_cls",bp_h_cls);
		model.addObject("bp_arr",bp_arr);
		model.addObject("run",run);
		model.addObject("score",health_score);
		model.addObject("chart",h1);
		model.setViewName("prediction");
		return model;
	}
	@RequestMapping("health_report")
	public ModelAndView health_report(HttpSession session)
	{
		int id = (int) session.getAttribute("user_id");
		ModelAndView model = new ModelAndView();
		model.addObject("health_score",75.42);
		model.setViewName("health_report");
		return model;
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
	@RequestMapping("change_password")
	public void change_password(@RequestParam("cur_p")String cur_p,@RequestParam("new_p_1")String new_p_1,@RequestParam("new_p_2")String new_p_2,@RequestParam("return_url")String return_url,HttpSession session,HttpServletResponse response) throws SchedulerException
	{
		int id = (int) session.getAttribute("user_id");
		try
		{
			if(new_p_1.equals(new_p_2))
			{
				userDao.change_password(id,cur_p,new_p_1);
			}
			response.sendRedirect("/predicto/"+return_url);
		}
		catch(Exception e){}
	}
	@RequestMapping("update_profile")
	public void update_profile(@RequestParam("age")String age,@RequestParam("height")String height,@RequestParam("weight")String weight,@RequestParam("return_url")String return_url,HttpSession session,HttpServletResponse response) throws SchedulerException
	{
		int id = (int) session.getAttribute("user_id");
		try
		{
			userDao.update_profile(id,age,height,weight);
			response.sendRedirect("/predicto/"+return_url);
		}
		catch(Exception e){}
	}
	@Autowired
	ServletContext context;
    
	@RequestMapping("register")
	public String register(@RequestParam("username")String username,@RequestParam("password")String password,@RequestParam("email")String email,HttpSession session)
	{
		if(userDao.check_user(username))
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
		else
			return "redirect:login#signup";
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
	@RequestMapping("set_goal_save")
	public String goal_save(@RequestParam("burn")String burn,@RequestParam("intake")String intake,HttpSession session)
	{
		int id=(int) session.getAttribute("user_id");
		userDao.set_goals(burn,intake,id);
		return "redirect:set_goals";
	}
	@RequestMapping("set_goals")
	public ModelAndView set_goals(HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		int id=(int) session.getAttribute("user_id");
		ModelAndView model=new ModelAndView();
		model.addObject("burn_goal",userDao.get_goals(id)[0]);
		model.addObject("intake_goal",userDao.get_goals(id)[1]);
		model.setViewName ("set_goals");
		return model;
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
        	String user_id=session.getAttribute("user_id").toString();
        	String name=dateFormat.format(date)+".jpg";
            Path path = Paths.get(System.getProperty("user.dir")+"\\img\\fulls\\"+user_id+"\\" +name);
            Files.write(path, bytes);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:report_view";
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
		if(run.length() > 0)
			run = run.substring(0,run.length()-1);
		if(walk.length() > 0)
			walk = walk.substring(0,walk.length()-1);
		if(cycle.length() > 0)
			cycle = cycle.substring(0,cycle.length()-1);
		if(work.length() > 0)
			work = work.substring(0,work.length()-1);
		if(calories.length() > 0)
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
	public String save_weekly_data(HttpSession session,@RequestParam("alcohol")String alco,@RequestParam("bp_sys") String bp_1,@RequestParam("bp_2")String bp_2,@RequestParam("ch_1")String ch_1,@RequestParam("ch_2")String ch_2,@RequestParam("cigs")String cigs,@RequestParam("sugar")String sugar,@RequestParam("notif_id")int notif_id,@RequestParam("ch_t")String ch_t,@RequestParam("triglyc")String triglyc)
	{
		
		int i=(Integer)session.getAttribute("user_id");
		String id=String.valueOf(i);
		userDao.delete_notif(notif_id);
		userDao.save_weekly_data(id,alco,bp_1,bp_2,ch_1,ch_2,cigs,sugar,ch_t,triglyc);	
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
	public String save_daily_food(@RequestParam("items") String item_str,@RequestParam("water")String water,HttpSession session)
	{
		if(invalid(session))
			return "redirect:login";
		
		int id,cnt;
		int total_cal = 0, total_fat=0, total_chol=0;
		String[] items = item_str.split(",");
		for(String i : items)
		{
			String[] vals = i.split(":");
			id = Integer.parseInt(vals[0]);
			cnt = Integer.parseInt(vals[1]);
			//id - of food item, cnt - number of items consumed
			System.out.println("ID: " + id + ", Count: " + cnt);
			total_cal += userDao.findCal(id, cnt);
			total_fat += userDao.findFat(id, cnt);
			total_chol += userDao.findChol(id, cnt);
		}
		userDao.updateCal((Integer)session.getAttribute("user_id"), total_cal,total_fat,total_chol, item_str);
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
	
}
