package com.predicto.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.predicto.dao.user_dao;
import com.predicto.services.lin_weka;

@Controller
@RequestMapping("/admin/*")
public class admin_controller {

	user_dao userDao=new user_dao();
	@RequestMapping("dashboard")
	public ModelAndView admin_panel()
	{
		return new ModelAndView("admin_dashboard");
	}
	@RequestMapping("push_daily")
	public ModelAndView push_daily(HttpSession session)
	{
		userDao.pushDaily();
		return new ModelAndView("opt_view");
	}
	@RequestMapping("train_linear_weka")
	public ModelAndView train_linear_weka() throws Exception
	{
		lin_weka.train();
		return new ModelAndView("admin_response").addObject("linear_weka","Algortihm successfully trained");
	}
	@RequestMapping("test_linear_weka")
	public ModelAndView test_linear_weka() throws Exception
	{
		double d=lin_weka.test();
		double d1=Double.parseDouble(String.format("%.3f", d));
		int dl = Integer.parseInt(String.format("%.0f", d));
		
		return new ModelAndView("admin_response_1").addObject("test_linear_weka",dl).addObject("per",d1);
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
