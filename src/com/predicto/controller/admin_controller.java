package com.predicto.controller;



import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.predicto.dao.user_dao;
import com.predicto.services.lin_algo;
import com.predicto.services.lin_weka;
import com.predicto.services.neural_net;

@Controller
@RequestMapping("/admin/*")
public class admin_controller {

	user_dao userDao=new user_dao();
	@RequestMapping("login")
	public ModelAndView login()
	{
		return new ModelAndView("admin_login");
	}
	@RequestMapping("signin")
	public String signin(@RequestParam("username")String username,@RequestParam("password")String password,HttpSession session)
	{
		if(username.equals("admin") && password.equals("admin"))
		{
			session.setAttribute("admin_id", 1);
			return "redirect:dashboard";
		}
		else
			return "redirect:login";
	}
	@RequestMapping("dashboard")
	public ModelAndView admin_panel(HttpSession session)
	{
		if(session.getAttribute("admin_id") != null)
		{
			int id = (int) session.getAttribute("admin_id");
			if(id != 1)
				return new ModelAndView("goto_admin");
			else
				return new ModelAndView("admin_dashboard");
		}
		else
			return new ModelAndView("goto_admin");
	}
	@RequestMapping("push_daily")
	public String push_daily(HttpSession session)
	{
		userDao.pushDaily();
		return "redirect:dashboard";
	}
	@RequestMapping("train_linear_weka")
	public ModelAndView train_linear_weka() throws Exception
	{
		lin_weka.train();
		return new ModelAndView("admin_response").addObject("linear_weka","Algortihm successfully trained");
	}
	@RequestMapping("train_linear_algo")
	public ModelAndView train_linear_algo() throws Exception
	{
		lin_algo.train();
		return new ModelAndView("admin_response").addObject("linear_weka","Algortihm successfully trained");
	}
	@RequestMapping("train_neural")
	public ModelAndView train_neural() throws Exception
	{
		neural_net.train();
		return new ModelAndView("admin_response").addObject("linear_weka","Algortihm successfully trained");
	}
	@RequestMapping("test_neural")
	public ModelAndView test_neural() throws Exception
	{
		double d=neural_net.test();
		double d1=Double.parseDouble(String.format("%.3f", d));
		int dl = Integer.parseInt(String.format("%.0f", d));
		
		return new ModelAndView("admin_response_1").addObject("test_linear_weka",dl).addObject("per",d1);
	}
	@RequestMapping("test_linear_weka")
	public ModelAndView test_linear_weka() throws Exception
	{
		double d=lin_weka.test();
		double d1=Double.parseDouble(String.format("%.3f", d));
		int dl = Integer.parseInt(String.format("%.0f", d));
		
		return new ModelAndView("admin_response_1").addObject("test_linear_weka",dl).addObject("per",d1);
	}
	@RequestMapping("test_linear_algo")
	public ModelAndView test_linear_algo() throws Exception
	{
		double d=lin_algo.test();
		double d1=Double.parseDouble(String.format("%.3f", d));
		int dl = Integer.parseInt(String.format("%.0f", d));
		
		return new ModelAndView("admin_response_1").addObject("test_linear_weka",dl).addObject("per",d1);
	}
	
	@RequestMapping("push_weekly")
	public String push_weekly(HttpSession session)
	{
		userDao.pushWeekly();
		return "redirect:dashboard";
	}
	@RequestMapping("push_food")
	public String push_food(HttpSession session)
	{
		userDao.pushFood();
		return "redirect:dashboard";
	}
	@RequestMapping("logout")
	public String logout(HttpSession session)
	{
		session.removeAttribute("admin_id");
		return "redirect:login";
	}
}
