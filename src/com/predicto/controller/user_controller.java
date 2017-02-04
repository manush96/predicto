package com.predicto.controller;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;

@Controller
@RequestMapping("/user/*")

public class user_controller {
	
	@RequestMapping("dashboard")
	public ModelAndView add()
	{
		return new ModelAndView("user_dashboard");
	}
	
	@RequestMapping("upload_report")
	public ModelAndView upload_report(HttpServletRequest request)
	{
		String filePath = "V:\\JAVA\\Workspace\\predicto\\WebContent\\resources\\uploads\\";
		int maxFileSize = 50 * 1024;
		int maxMemSize = 4 * 1024;
		File file ;
		
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		factory.setSizeThreshold(maxMemSize);
		factory.setRepository(new File("C:\\temp"));
	
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax( maxFileSize );
	
		try
		{
			List fileItems = upload.parseRequest(request);
			Iterator i = fileItems.iterator();
	
			while ( i.hasNext () ) 
			{
				FileItem fi = (FileItem)i.next();
				if ( !fi.isFormField () )	
				{
					String fieldName = fi.getFieldName();
					String fileName = fi.getName();
					String contentType = fi.getContentType();
					boolean isInMemory = fi.isInMemory();
					long sizeInBytes = fi.getSize();
					if( fileName.lastIndexOf("\\") >= 0 ){
					   file = new File( filePath + 
					   fileName.substring( fileName.lastIndexOf("\\"))) ;
					}else{
					   file = new File( filePath + 
					   fileName.substring(fileName.lastIndexOf("\\")+1)) ;
					}
					fi.write( file ) ;
				}
			}
		}
		catch(Exception ex) {
	       System.out.println(ex);
		}
		return new ModelAndView("user_dashboard");
	}
}
