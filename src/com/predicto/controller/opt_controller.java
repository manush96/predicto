package com.predicto.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/opt/*")

public class opt_controller {
	
	@RequestMapping("neww")
	public ModelAndView neww()
	{
		return new ModelAndView("opt_view");
	}
}
