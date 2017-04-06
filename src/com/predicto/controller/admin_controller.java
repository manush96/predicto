package com.predicto.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.predicto.dao.user_dao;

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
