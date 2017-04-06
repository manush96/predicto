package com.predicto.dao;
import java.awt.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import com.predicto.model.*;
@Repository("user_dao")
public class user_dao {

	JdbcTemplate template1;
	String user1="root";
	String password="";
	String classname="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/predicto";
	public void setDataSource() {
			BasicDataSource datasource=new BasicDataSource();
			datasource.setDriverClassName(classname);
			datasource.setUsername(user1);
			datasource.setPassword(password);
			datasource.setUrl(url);
	        template1 = new JdbcTemplate(datasource);
	}
	public void pushDaily()
	{
		setDataSource();
		
		String sql = "DELETE FROM notifications WHERE type = '0' AND status = '0'";
		template1.update(sql);
		
		sql="SELECT * FROM user";
		
		java.util.List<Integer> listContact = template1.query(sql, new RowMapper<Integer>() {
			int id;
			String sql;
			@Override   
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				id = rs.getInt("id");
				sql = "INSERT INTO notifications(user_id,type,status) VALUES('"+id+"','0','0')";
				template1.update(sql);
				return id;
			}
	    });
	}
	public void pushWeekly()
	{
		setDataSource();
		
		String sql = "DELETE FROM notifications WHERE type = '1' AND status = '0'";
		template1.update(sql);
		
		sql="SELECT * FROM user";
		
		java.util.List<Integer> listContact = template1.query(sql, new RowMapper<Integer>() {
			int id;
			String sql;
			@Override   
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				id = rs.getInt("id");
				sql = "INSERT INTO notifications(user_id,type,status) VALUES('"+id+"','1','0')";
				template1.update(sql);
				return id;
			}
	    });
	}
	public Daily_data get_dashboard_action(int id)
	{
		String sql="SELECT COALESCE(SUM(run),0) AS run, COALESCE(SUM(walk),0) AS walk, COALESCE(SUM(cycle),0) AS cycle, COALESCE(SUM(working),0) AS working, COALESCE(SUM(calories),0) AS calories from daily_exercise where user_id='"+id+"'";
		setDataSource();
		java.util.List<Daily_data> daily_Data = template1.query(sql, new RowMapper<Daily_data>() {
			 
		     @Override   
			 public Daily_data mapRow(ResultSet rs, int rowNum) throws SQLException {
		         Daily_data daily=new Daily_data();
		         daily.setRun(rs.getString("run"));
		         daily.setCycle(rs.getString("cycle"));
		         daily.setWalk(rs.getString("walk"));
		         daily.setWorking(rs.getString("working"));
		         daily.setCalories(rs.getString("calories"));
		    	 return daily;
		        }
		 
		    });
		return daily_Data.get(0);
	}
	public String[] get_calories_comparison(int id)
	{
		setDataSource();
		String sql = "SELECT daily_exercise.calories AS c_burn, daily_food_details.calories AS c_intake, date FROM `daily_exercise` JOIN daily_food_details ON daily_exercise.date = daily_food_details.intake_date WHERE daily_exercise.user_id = "+id+" AND date >DATE_SUB(CURDATE(), INTERVAL 7 DAY) ORDER BY daily_food_details.intake_date ";
		SqlRowSet srs =template1.queryForRowSet(sql);
		String c_burn="",c_intake="",date="";
		int count = 0;
		while(srs.next())
		{
			count++;
			c_burn += (int) Double.parseDouble(srs.getString("c_burn"))+",";
			c_intake += (int) Double.parseDouble(srs.getString("c_intake"))+",";
			date += "'"+srs.getString("date")+"',";
		}
		if(count > 0)
		{
			c_burn = c_burn.substring(0,c_burn.length()-1);
			c_intake = c_intake.substring(0,c_intake.length()-1);
			date = date.substring(0,date.length()-1);
		}
		
		String a[] = {date,c_burn,c_intake};
		return a;
	}	
	public int[] get_growth(int id)
	{
		setDataSource();
		String sql = "SELECT COALESCE(SUM(run),0) AS run, COALESCE(SUM(walk),0) AS walk, COALESCE(SUM(working),0) AS working, COALESCE(SUM(cycle),0) AS cycle FROM `daily_exercise` WHERE user_id = "+id+" AND date > DATE_SUB(CURDATE(), INTERVAL 14 DAY) AND date <= DATE_SUB(CURDATE(), INTERVAL 7 DAY) UNION SELECT COALESCE(SUM(run),0) AS run, COALESCE(SUM(walk),0) AS walk, COALESCE(SUM(working),0) AS working, COALESCE(SUM(cycle),0) AS cycle FROM `daily_exercise` WHERE user_id = "+id+" AND date > DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
		SqlRowSet srs =template1.queryForRowSet(sql);
		int p_run = 0,p_walk = 0,p_cycle = 0,p_working = 0,c_run = 0,c_walk = 0,c_cycle = 0,c_working = 0,d_run,d_walk,d_cycle,d_working;
		
		if(srs.next())
		{
			p_run = (int) Double.parseDouble(srs.getString("run"));
			p_walk = (int) Double.parseDouble(srs.getString("walk"));
			p_cycle = (int) Double.parseDouble(srs.getString("cycle"));
			p_working = (int) Double.parseDouble(srs.getString("working"));
		}
			
		if(srs.next())
		{
			c_run = (int) Double.parseDouble(srs.getString("run")) ;
			c_walk = (int) Double.parseDouble(srs.getString("walk"));
			c_cycle = (int) Double.parseDouble(srs.getString("cycle"));
			c_working = (int) Double.parseDouble(srs.getString("working"));
		}
		d_run = (p_run == 0 ? (c_run == 0 ? 0 : 100) : (c_run - p_run)*100/p_run);
		d_walk = (p_walk == 0 ? (c_walk == 0 ? 0 : 100) : (c_walk - p_walk)*100/p_walk);
		d_cycle = (p_cycle == 0 ? (c_cycle == 0 ? 0 : 100) : (c_cycle - p_cycle)*100/p_cycle);
		d_working = (p_working == 0 ? (c_working == 0 ? 0 : 100) : (c_working - p_working)*100/p_working);
		
		int a[] = {c_run,d_run,c_walk,d_walk,c_cycle,d_cycle,c_working,d_working};
		return a;
	}
	public int addUser(User user)
	{
		setDataSource();
		String sql="insert into user(username,password,email,heredity) values('"+user.getUsername()+"','"+user.getPassword()+"','"+user.getEmail()+"','No data for now')";
		template1.update(sql);
		return template1.queryForInt("select MAX(id) from user");
	}
	public void save_weekly_data(String id,String alco,String bp_1,String bp_2,String ch_1,String ch_2,String cigs,String sugar)
	{
		setDataSource();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String sql="INSERT INTO `weekly_data`(user_id,alcohol_intake,blood_pressure_sys,blood_pressure_dia,blood_sugar, smokes,cholesterol_ldl, cholesterol_hdl,week) VALUES ('"+id+"','"+alco+"','"+bp_1+"','"+bp_2+"','"+sugar+"','"+cigs+"','"+ch_1+"','"+ch_2+"','"+dateFormat.format(date)+"')";
		template1.update(sql);
	}
	public void addInitialData(User user, int id)
	{
		setDataSource();
		String sql="UPDATE user SET age =" + user.getAge()+", height = "+user.getHeight()+", weight = "+user.getWeight()+", gender = "+user.getGender()+", diabetic = "+user.getDiabetic()+", status = "+user.getStatus() + " WHERE id=" + id;
		template1.update(sql);
	}
	public int checkLogin(User user)
	{
		final User user1 = new User();
		setDataSource();
		String sql="select * from user where username='"+user.getUsername()+"' and password='"+user.getPassword()+"'";
		 java.util.List<User> listContact = template1.query(sql, new RowMapper<User>() {
			 
		     @Override   
			 public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		            
		            System.out.println(rs.getInt("id")+"jakob");
		            user1.setId(rs.getInt("id"));
		            user1.setUsername(rs.getString("username"));
		            user1.setEmail(rs.getString("email"));
		            
		            return user1;
		        }
		 
		    });
		System.out.println(user.getId()+"hakoba");
	 if(listContact.size()==1)
		{
			return user1.getId();
		}
		else
		{
			return 0;
		}
	}

	public int checkStatus(int id)
	{
		final User user = new User();
		setDataSource();
		String sql="SELECT status FROM user WHERE id="+id;
		java.util.List<User> listContact = template1.query(sql, new RowMapper<User>() {
			 
		     @Override   
			 public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		            user.setStatus(rs.getInt("status"));
		            return user;
		        }
		 
		    });
		return user.getStatus();
	}
	public User get_user_details(int id)
	{
		final User user = new User();
		setDataSource();
		String sql="SELECT * FROM user WHERE id="+id;
		java.util.List<User> listContact = template1.query(sql, new RowMapper<User>() {
			 
		     @Override   
			 public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		            user.setAge(rs.getInt("age"));
		            user.setHeight(rs.getInt("height"));
		            user.setWeight(rs.getInt("weight"));
		            user.setGender(rs.getInt("gender"));
		            user.setDiabetic(rs.getInt("diabetic"));
		            user.setSmoker(rs.getInt("smoker"));
		            user.setAlcoholic(rs.getInt("alcoholic"));
		            return user;
		        }
		 
		    });
		return user;
	}
	
	public void set_notif_read(int id)
	{
		setDataSource();
		String sql="UPDATE notifications SET status = 1 WHERE user_id="+id;
		template1.update(sql);
	}
	public void delete_notif(int id)
	{
		setDataSource();
		String sql="DELETE FROM notifications WHERE id="+id;
		template1.update(sql);
	}
	public void save_daily_exercise(String run,String walk,String cycle,String working,String id,String cal)
	{
		setDataSource();
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String sql="INSERT INTO daily_exercise (user_id,run,walk,cycle,working,date,calories) values ('"+id+"','"+run+"','"+walk+"','"+cycle+"','"+working+"','"+dateFormat.format(date)+"','"+cal+"')";
		template1.update(sql);
	}
	public java.util.List<Daily_data> get_daily_data(String s)
	{
		setDataSource();
		System.out.println("user_Dao ma");
		String sql="SELECT * FROM daily_exercise where user_id="+s+" AND  DATE_ADD(date,INTERVAL 7 DAY)";
		java.util.List<Daily_data> daily_Data = template1.query(sql, new RowMapper<Daily_data>() {
			 
		     @Override   
			 public Daily_data mapRow(ResultSet rs, int rowNum) throws SQLException {
		         Daily_data daily=new Daily_data();
		         daily.setRun(rs.getString("run"));
		         daily.setCycle(rs.getString("cycle"));
		         daily.setWalk(rs.getString("walk"));
		        
		         daily.setWorking(rs.getString("working"));
		         daily.setCalories(rs.getString("calories"));
		         daily.setDate(rs.getString("date"));
		    	 return daily;
		        }
		 
		    });
		return daily_Data;	
	}
	public void pushFood()
	{
		setDataSource();
		
		String sql="SELECT * FROM user";
		
		final DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		final Date date = new Date();
		
		java.util.List<Integer> listContact = template1.query(sql, new RowMapper<Integer>() {
			int id;
			String sql;
			@Override   
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				id = rs.getInt("id");
				sql = "INSERT INTO daily_food_details(user_id,intake_date,calories,food_intake) VALUES('"+id+"','"+dateFormat.format(date)+"','0','')";
				template1.update(sql);
				return id;
			}
	    });
	}

	public double findCal(int food_id, int cnt) {
		// TODO Auto-generated method stub
		setDataSource();
		String sql="SELECT calories FROM food_details where id="+food_id+"";
		SqlRowSet srs= template1.queryForRowSet(sql);
		srs.next();
		return srs.getDouble("calories")*cnt;
	}
	
	public void updateCal(int id, double total_cal, String item_str) {
		setDataSource();

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String sql="UPDATE daily_food_details SET calories = calories + "+total_cal+", food_intake = CONCAT(food_intake,',"+item_str+"') WHERE user_id = "+id+" AND intake_date ='" + dateFormat.format(date)+"'";
		template1.update(sql);
	}
}
