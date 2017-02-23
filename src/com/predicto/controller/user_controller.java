package com.predicto.controller;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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

import com.predicto.dao.scheduler_dao;
import com.predicto.dao.user_dao;
import com.predicto.model.User;

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
        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            return "redirect:uploadStatus";
        }

        try {
        	byte[] bytes = file.getBytes();
        	System.out.println(System.getProperty("user.dir"));
        	String user_id=session.getAttribute("user_id").toString();
            Path path = Paths.get(System.getProperty("user.dir")+"\\img\\fulls\\"+user_id+"\\" + file.getOriginalFilename());
            System.out.println(System.getProperty("user.dir")+"\\img\\fulls\\"+user_id+"\\" + file.getOriginalFilename());
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
	public ModelAndView daily_data_collect(@RequestParam(value = "id", required=false) Integer id)
	{
		ModelAndView model = new ModelAndView();
		model.addObject("notif_id",id);
		model.setViewName("daily_exercise");
		return model;
	}
	@RequestMapping("save_daily_data")
	public String save_daily_data(@RequestParam("notif_id")int notif_id, HttpSession session)
	{
		if(invalid(session))
			return "redirect: login";
		userDao.delete_notif(notif_id);
		return "redirect:dashboard";
	}
	@RequestMapping("weekly_data")
	public ModelAndView weekly_data_collect(@RequestParam(value = "id", required=false) Integer id)
	{
		return new ModelAndView("daily_exercise");
		
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
