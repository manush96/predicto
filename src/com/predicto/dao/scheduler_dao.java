package com.predicto.dao;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SimpleTrigger;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.stereotype.Repository;

import com.predicto.controller.scheduler_controller;

@Repository("scheduler_dao")
public class scheduler_dao {
	public void scheduler1() throws SchedulerException
	{		
		System.out.println("scheduler");
		String sql="select start_time,job_name from scheduler";
		String job_name="notification push";
		String start_time="23:00";
			JobDetail job = new JobDetail();
	    	job.setName(job_name);
	    	System.out.println(start_time);
	    	
	    	job.setJobClass(scheduler_controller.class);
	    	System.out.println(job_name);
	    	//configure the scheduler time
	    	
	    	SimpleTrigger trigger = new SimpleTrigger();
	    	Random r=new Random();
	    	int triggerRank=r.nextInt(1000);
	    	trigger.setName("dumb"+triggerRank);
	    	java.util.Calendar c=java.util.Calendar.getInstance();
	    	java.util.Date d=new java.util.Date();
	    	String a=start_time.replace(":", "");
	    	
	    	
	    	int a1=Integer.parseInt(a);
	    	System.out.println(a1);	    	
	    	int h=a1/100;
	    	int m1=a1%100;
	    	
	    	System.out.println(a+"--- "+h+" : "+m1);
	    	
	    	trigger.setStartTime(new java.util.Date(d.getYear(),d.getMonth(),d.getDate(),h		,m1));
	    	trigger.setRepeatInterval(24*60*60*1000);
	    	
	    	//schedule it
	    	Scheduler scheduler = null;
			try 
			{
				scheduler = new StdSchedulerFactory().getScheduler();
				scheduler.start();
				scheduler.scheduleJob(job, trigger);
			}
			catch (Exception e) 
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    			
		}
	}


