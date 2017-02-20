package com.predicto.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.predicto.dao.tips_dao;
import com.predicto.dao.user_dao;
import com.predicto.model.Tips;
import com.predicto.model.User;

@Controller
@RequestMapping("/tips/*")
public class tips_controller {
	@Autowired
	user_dao userDao;
	@Autowired
	tips_dao tipsDao;
	@RequestMapping("tips_view")
	public ModelAndView tips_view(HttpSession session)
	{
		System.out.println("jingalala");
		ModelAndView model = new ModelAndView();
		int id = (Integer)session.getAttribute("user_id");
		
		User user= userDao.get_tips(id);
		int gender=user.getGender();
		int age=user.getAge();
		int smoker=user.getSmoker();
		int alcho=user.getAlcoholic();
		int height=user.getHeight();
		int weight=user.getWeight();
		String s="1,3,4,5,8,10,11,12,14,15,16,17";
		if(smoker==1)
		{
			s=s+",7,13";
		}
		float w=(float) ((float)weight*2.2046226218);
		float h=(float)((float)height/2.54);
		w=(float) (w*0.45);
		h=(float)(h*0.025);
		h=h*h;
		float bmi=w/h;
		if(bmi>25)
		{
			s=s+",2,9";
		}
		if(alcho==1)
		{
			s=s+",6";
		}
		
		List<Tips> l=tipsDao.get_tips(s);
	
		model.addObject("tips",l);
		
		model.setViewName("Tips_View");
		return model;
	}
}