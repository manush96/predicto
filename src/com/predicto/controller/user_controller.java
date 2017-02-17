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
	@RequestMapping("dashboard")
	public ModelAndView add()
	{
		return new ModelAndView("user_dashboard");
	}
	@Autowired
	user_dao userDao;
	@RequestMapping("login")
	public ModelAndView login()
	{
		return new ModelAndView("user_login");
	}
	@RequestMapping("signin")
	public String signin(@RequestParam("username")String username,@RequestParam("password")String password)
	{
		User user=new User();
		user.setPassword(password);
		user.setUserName(username);
		int i=userDao.checkLogin(user);
		if(i==1)
		{
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
		user.setUserName(username);
		userDao.addUser(user);
		return "redirect:success_signup";
	}
	
	@RequestMapping("success_signup")
	public ModelAndView success()
	{
		return new ModelAndView("success_signup");
	}
	@RequestMapping("report")
	public ModelAndView report()
	{
		return new ModelAndView("user_report");
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
	
}
