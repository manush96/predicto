package com.predicto.controller;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import org.ow2.util.base64.Base64;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

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
	@Autowired
	user_dao userDao;
	@RequestMapping("dashboard")
	public ModelAndView add(HttpSession session)
	{
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
	public String signin(@RequestParam("username")String username,@RequestParam("password")String password,HttpSession session)
	{
		User user=new User();
		user.setPassword(password);
		user.setUsername(username);
		int i=userDao.checkLogin(user);
		if(i!=0)
		{
			session.setAttribute("user_id",i);
			return "redirect:dashboard";
		}
		else
		{
			return "redirect:login";
		}
	}
	
	@RequestMapping("register")
	public String register(@RequestParam("username")String username,@RequestParam("password")String password,@RequestParam("email")String email)
	{
		User user=new User();
		user.setPassword(password);
		user.setEmail(email);
		user.setUsername(username);
		userDao.addUser(user);
		return "redirect:success_signup";
	}
	
	@RequestMapping("success_signup")
	public ModelAndView success()
	{
		return new ModelAndView("success_signup");
	}
	@RequestMapping("save_one_time_data")
	public String save_one_time_data(@RequestParam("gender")int gender,@RequestParam("age")int age,@RequestParam("height")int height,@RequestParam("weight")int weight,@RequestParam("diabetic")int diabetic,HttpSession session)
	{
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
	@RequestMapping("report_view")
	public ModelAndView report_view()
	{
		return new ModelAndView("user_report_view");
	}
	@RequestMapping(value = "upload_data", method = RequestMethod.POST)
    public String singleFileUpload(@RequestParam("report") MultipartFile file,
                                   RedirectAttributes redirectAttributes) {

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            System.out.println("vatsal");
            return "redirect:uploadStatus";
        }

        try {
        	
            // Get the file and save it somewhere
            byte[] bytes = file.getBytes();
            Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
            Files.write(path, bytes);
            
            redirectAttributes.addFlashAttribute("message",
                        "You successfully uploaded '" + file.getOriginalFilename() + "'");

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
	
}
