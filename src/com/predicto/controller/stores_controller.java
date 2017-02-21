package com.predicto.controller;

import com.predicto.model.Store;

import com.predicto.dao.stores_dao;
import javax.servlet.http.HttpSession;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONArray;
@Controller
@RequestMapping("/stores/*")

public class stores_controller {
	@Autowired
	stores_dao stores_dao;
	public boolean invalid(HttpSession session)
	{
		if(session.getAttribute("user_id") == null)
			return true;
		else
			return false;
	}
	private static String readAll(Reader rd) throws IOException {
	    StringBuilder sb = new StringBuilder();
	    int cp;
	    sb.append("{ data: ");
	    while ((cp = rd.read()) != -1) {
	      sb.append((char) cp);
	    }
	    sb.append('}');
	    return sb.toString();
	  }

	  public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
	    InputStream is = new URL(url).openStream();
	    try {
	      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
	      String jsonText = readAll(rd);
	      JSONObject json = new JSONObject(jsonText);
	      return json;
	    } finally {
	      is.close();
	    }
	  }
	
	public String commafy_int(ArrayList<String> arr)
	{
		if (arr.size() > 0) {
		    StringBuilder nameBuilder = new StringBuilder();

		    for (String n : arr) {
		        nameBuilder.append(n.replace("'", "\\'")).append(",");
		        // can also do the following
		        // nameBuilder.append("'").append(n.replace("'", "''")).append("',");
		    }
		    nameBuilder.deleteCharAt(nameBuilder.length() - 1);
		    return nameBuilder.toString();
		} else {
		    return "";
		}
	}
	public String commafy_string(ArrayList<String> arr)
	{
		if (arr.size() > 0) {
		    StringBuilder nameBuilder = new StringBuilder();

		    for (String n : arr) {
		        nameBuilder.append("'").append(n.replace("'", "\\'")).append("',");
		        // can also do the following
		        // nameBuilder.append("'").append(n.replace("'", "''")).append("',");
		    }
		    nameBuilder.deleteCharAt(nameBuilder.length() - 1);
		    
		    return nameBuilder.toString();
		} else {
		    return "";
		}
	}
	  
	@RequestMapping("locate")
	public ModelAndView locate(HttpSession session)
	{
		if(invalid(session))
			return new ModelAndView("goto_login");
		HashMap<String,Store> hm=new HashMap<String,Store>();
		ModelAndView model=new ModelAndView();
		
		List<Store> ls = stores_dao.getStores();
		HashMap<String,Store> nearby_stores = new HashMap<String,Store>();
		for(Store s : ls)
		{
			hm.put(s.getStore_id(), s);
		}
		ArrayList<String> lats = new ArrayList<String>(), lngs = new ArrayList<String>(), names = new ArrayList<String>(), contacts = new ArrayList<String>(), addresses = new ArrayList<String>();

		try {
			
			String lat = (String)session.getAttribute("latitude");
			String lng = (String)session.getAttribute("longitude");
			if(lat == null || lng == null)
			{
				lat = "23.0225";
				lng = "72.5714";
			}
			String url = "http://www.medplusmart.com/GetStores.mart?latLong=("+lat+",%20"+lng+")";
			
			JSONObject json = readJsonFromUrl(url);
			JSONArray data = (JSONArray)json.get("data");
			JSONObject store;
			
			Store str = new Store();
			Store chk_store = new Store();
			String store_id, name, location, locality, contact, address, city, state, pincode;
			Iterator<Object> iterator = data.iterator();
            
			while (iterator.hasNext())
            {
            	store = (JSONObject) iterator.next();
            	store_id = store.getString("storeId_s");
            	name = store.getString("name_s");
            	location = store.getString("locationLatLong");
            	locality = store.getString("locality_s");
            	contact = store.getString("phoneNumber_s");
            	address = store.getString("address_s");
            	city = store.getString("city_s");
            	state = store.getString("state_s");
            	pincode = store.getString("pincode_s");
            	
            	String coords[] = location.split(",");
            	lat = coords[0];
            	lng = coords[1];
            	
            	str.setStore_id(store_id);
            	str.setName(name);
            	str.setLatitude(lat);
            	str.setLongitude(lng);
            	str.setLocality(locality);
            	str.setContact(contact);
            	str.setAddress(address);
            	str.setCity(city);
            	str.setState(state);
            	str.setPincode(pincode);
            	nearby_stores.put(name,str);
            	
            	chk_store = hm.get(store_id);
            	if(chk_store != null)
            	{}
            	else
            		stores_dao.addStore(str);
            	
            	lats.add(lat);
            	lngs.add(lng);
            	names.add(name);
            	contacts.add(contact);
            	addresses.add(address);
            }
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addObject("nearby_stores",nearby_stores);
		model.addObject("lats",commafy_int(lats));
		model.addObject("lngs",commafy_int(lngs));
		model.addObject("names",commafy_string(names));
		model.addObject("contacts",commafy_string(contacts));
		model.addObject("addresses",commafy_string(addresses));
		model.setViewName("stores_index");
		return model;
	}
	@RequestMapping("set_lat_long")
	public ModelAndView set_lat_long(@RequestParam("lat")String lat,@RequestParam("lng")String lng,HttpSession session)
	{
		session.setAttribute("latitude", lat);
		session.setAttribute("longitude", lng);
		return new ModelAndView("opt_view");
	}
}
