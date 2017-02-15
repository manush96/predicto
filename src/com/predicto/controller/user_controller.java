package com.predicto.controller;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import org.ow2.util.base64.Base64;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;



import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;
import org.apache.tomcat.util.codec.binary.StringUtils;

@Controller
@RequestMapping("/user/*")

public class user_controller {
	
	@RequestMapping("dashboard")
	public ModelAndView add()
	{
		return new ModelAndView("user_dashboard");
	}
	@RequestMapping("report")
	public ModelAndView report()
	{
		return new ModelAndView("user_report");
	}
	private static String UPLOADED_FOLDER = "D://abcd//";
	@RequestMapping(value = "upload_data", method = RequestMethod.POST)
    public String singleFileUpload(@RequestParam("report") MultipartFile file,
                                   RedirectAttributes redirectAttributes) {

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Please select a file to upload");
            System.out.println("vatsal");
            return "redirect:uploadStatus";
        }

        try {
        	
            // Get the file and save it somewhere
            byte[] bytes = file.getBytes();
            String url = "http://localhost:8084/api/test";
            char[] s=Base64.encode(bytes);
            
    		HttpClient client = new DefaultHttpClient();
    		HttpPost post = new HttpPost(url);

    		// add header

    		List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();
    		urlParameters.add(new BasicNameValuePair("image", s.toString()));
    	
    		post.setEntity(new UrlEncodedFormEntity(urlParameters));

    		HttpResponse response = client.execute(post);
    		System.out.println("\nSending 'POST' request to URL : " + url);
    		System.out.println("Post parameters : " + post.getEntity());
    		System.out.println("Response Code : " +
                                        response.getStatusLine().getStatusCode());

    		BufferedReader rd = new BufferedReader(
                            new InputStreamReader(response.getEntity().getContent()));

    		StringBuffer result = new StringBuffer();
    		String line = "";
    		while ((line = rd.readLine()) != null) {
    			result.append(line);
    		}

    		System.out.println(result.toString());


            Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
            Files.write(path, bytes);
            
            redirectAttributes.addFlashAttribute("message",
                        "You successfully uploaded '" + file.getOriginalFilename() + "'");

        } catch (IOException e) {
            e.printStackTrace();
        }

        return "upload";
    }


}
