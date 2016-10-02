package com.predicto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/user/*")

public class user_controller {
	
	@RequestMapping("add")
	public ModelAndView add()
	{
		return new ModelAndView("add_user");
	}
}
