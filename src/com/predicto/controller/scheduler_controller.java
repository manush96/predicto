package com.predicto.controller;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.stereotype.Controller;


@Controller
public class scheduler_controller implements Job {
	public void execute(JobExecutionContext arg0) throws JobExecutionException
	{
	
	System.out.println("inside job");
	
	//execute report
	java.util.Date d=new java.util.Date();	
	int i=d.getHours();
	int j=d.getMinutes();
	String i2 = String.valueOf(i);
	String j2 = String.valueOf(j);
	notification();
}	
	public void notification()
	{
		System.out.println("hakuna matata");
	}
	
}
