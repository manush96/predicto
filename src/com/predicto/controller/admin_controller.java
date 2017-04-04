package com.predicto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin/*")
public class admin_controller {

	@RequestMapping("dashboard")
	public ModelAndView admin_panel()
	{
		return new ModelAndView("admin_dashboard");
	}
}
