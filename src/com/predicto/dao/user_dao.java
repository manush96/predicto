package com.predicto.dao;
import java.awt.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Map;
import java.util.Set;

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
	public void push_blood(String type,int id)
	{
		String t = "";
		if(type.equals("AP"))
			t = "('AP','AM','OP','OM')";
		else if(type.equals("AM"))
			t = "('AM','OM')";
		else if(type.equals("BP"))
			t = "('BP','BM','OP','OM')";
		else if(type.equals("BM"))
			t = "('BM','OM')";
		else if(type.equals("ABP"))
			t = "('AP','AM','BP','BM','ABP','ABM','OP','OM')";
		else if(type.equals("ABM"))
			t = "('AM','BM','ABM','OM')";
		else if(type.equals("OP"))
			t = "('OP','OM')";
		else if(type.equals("OM"))
			t = "('OM')";
		
		setDataSource();
		
		String sql="SELECT * FROM user where blood_group IN "+t+" AND id != "+id;
		
		java.util.List<Integer> listContact = template1.query(sql, new RowMapper<Integer>() {
			int id;
			String sql1;
			@Override   
			public Integer mapRow(ResultSet rs, int rowNum) throws SQLException {
				int b_id = 1;
				SqlRowSet srs =template1.queryForRowSet("SELECT COALESCE(MAX(id),1) AS id FROM blood_donate");
				if(srs.next())
					b_id = srs.getInt("id");
				
				id = rs.getInt("id");
				sql1= "INSERT INTO notifications(user_id,type,status,b_id) VALUES('"+id+"','2','0','"+b_id+"')";
				template1.update(sql1);
				return id;
			}
	    });
	}
	public void set_goals(String burn,String intake,int id)
	{
		setDataSource();
		String sql="update user set burn_goal='"+burn+"',intake_goal='"+intake+"' where id='"+id+"'";
		template1.update(sql);
	}
	public int[] get_goals(int id)
	{
		setDataSource();
		String sql="Select burn_goal,intake_goal from user where id = '"+id+"'";
		java.util.List<User> listContact = template1.query(sql, new RowMapper<User>() {
			 
			@Override   
			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
	            
	            User user1=new User();
	            user1.setBurn_goal(rs.getInt("burn_goal"));
	            user1.setIntake_goal(rs.getInt("intake_goal"));
	            
	            return user1;
	        }
	 
	    });
		int[] i=new int[2];
		i[0]=listContact.get(0).getBurn_goal();
		i[1]=listContact.get(0).getIntake_goal();
		return i;
	}
	public double get_dash_goal(int id,String a)
	{

		setDataSource();
		if(a.equals("a"))
		{
			String sql="SELECT COALESCE(SUM(calories),0) AS calories FROM daily_food_details where user_id="+id+" AND  intake_date >DATE_SUB(CURDATE(), INTERVAL 1 DAY)";
			SqlRowSet srs =template1.queryForRowSet(sql);
			double sum = 0;
			if(srs.next())
				sum = srs.getDouble("calories");
			return (int) sum/7;
		}
		else
		{
			String sql="SELECT COALESCE(SUM(calories),0) AS calories FROM daily_exercise where user_id="+id+" AND  date >DATE_SUB(CURDATE(), INTERVAL 1 DAY)";
			
			SqlRowSet srs =template1.queryForRowSet(sql);
			double sum = 0;
			if(srs.next())
				sum = srs.getDouble("calories");
			return (int) sum/7;
		}
	}
	
	public double getBmi(int id,String a)
	{
		setDataSource();
		
			String sql="select height,weight from user where id='"+id+"'";
			java.util.List<User> listContact = template1.query(sql, new RowMapper<User>() {
			 
				@Override   
				public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		            
		            User user1=new User();
		            user1.setHeight(rs.getInt("height"));
		            user1.setWeight(rs.getInt("weight"));
		            
		            return user1;
		        }
		 
		    });
			double weight=listContact.get(0).getWeight();
			double height=listContact.get(0).getHeight();
			height=height/100;
			double bmi=(weight/(height*height));
			int tmp = (int)bmi;
			return (double) tmp;
			
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
	public double[] get_analysis_details(int id)
	{
		double[] fin=new double[14];
		setDataSource();
		User u=get_user_details(id);
		fin[0]=u.getWeight();
		fin[1]=u.getHeight();
		if(u.getSmoker()==1)
		{
			fin[2]=1;
		}
		else
		{
			fin[1]=2;
		}
		
		Weekly_data week=get_weekly_data(id);
		fin[3]=week.getBlood_pressure_sys();
		fin[4]=week.getBlood_pressure_dia();
		fin[5]=get_fat(id);
		fin[6]=50;
		fin[7]=20;
		fin[8]=get_food_chol(id);
		fin[9]=week.getAlcohol_intake();
		fin[10]=week.getT_chol();
		fin[11]=week.getCholesterol_hdl();
		fin[12]=week.getTrigly();
		fin[13]=week.getCholesterol_ldl();
		return fin;
	}

	public int get_food_chol(int id)
	{
		setDataSource();
		String sql="select ROUND(avg(cholesterol)) from daily_food_details where user_id='"+id+"' and intake_date >DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
		@SuppressWarnings("deprecation")
		int fat=template1.queryForInt(sql);
		return fat;
	}
	
	public int get_fat(int id)
	{
		setDataSource();
		String sql="select ROUND(avg(fat)) from daily_food_details where user_id='"+id+"' and intake_date >DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
		int fat=template1.queryForInt(sql);
		return fat;
	}
	public Weekly_data get_weekly_data(int id)
	{
		setDataSource();
		String sql="Select * from weekly_data where user_id='"+id+"' and id=(select max(id) from weekly_data where user_id='"+id+"')";
		SqlRowSet rs =template1.queryForRowSet(sql);
		Weekly_data d=new Weekly_data();
		if(rs.next())
		{
			d.setAlcohol_intake(rs.getInt("alcohol_intake"));
	        d.setBlood_pressure_dia(rs.getInt("blood_pressure_dia"));
	        d.setBlood_pressure_sys(rs.getInt("blood_pressure_sys"));
	        d.setCholesterol_hdl(rs.getInt("cholesterol_hdl"));
	        d.setCholesterol_ldl(rs.getInt("cholesterol_ldl"));
	        d.setBlood_sugar(rs.getInt("blood_sugar"));
	        d.setT_chol(rs.getInt("t_chol"));
	        d.setTrigly(rs.getInt("trigly"));
		}
		else
		{
			d.setAlcohol_intake(0);
	        d.setBlood_pressure_dia(0);
	        d.setBlood_pressure_sys(0);
	        d.setCholesterol_hdl(0);
	        d.setCholesterol_ldl(0);
	        d.setBlood_sugar(0);
	        d.setT_chol(0);
	        d.setTrigly(0);
		}
		
		return d;
	}
	public Daily_data get_dashboard_action(int id)
	{
		String sql="SELECT COALESCE(AVG(run),0) AS run, COALESCE(AVG(walk),0) AS walk, COALESCE(AVG(cycle),0) AS cycle, COALESCE(AVG(working),0) AS working, COALESCE(AVG(calories),0) AS calories from daily_exercise where user_id='"+id+"'";
		setDataSource();
		java.util.List<Daily_data> daily_Data = template1.query(sql, new RowMapper<Daily_data>() {
			 
		     @Override   
			 public Daily_data mapRow(ResultSet rs, int rowNum) throws SQLException {
		         Daily_data daily=new Daily_data();
		         daily.setRun(rs.getDouble("run")*7+"");
		         daily.setCycle(rs.getDouble("cycle")*7+"");
		         daily.setWalk(rs.getDouble("walk")*7+"");
		         daily.setWorking(rs.getDouble("working")*7+"");
		         daily.setCalories(rs.getString("calories"));
		    	 return daily;
		        }
		 
		    });
		return daily_Data.get(0);
	}
	public String[] get_calories_comparison(int id)
	{
		setDataSource();
		String sql = "SELECT daily_exercise.calories AS c_burn, daily_food_details.calories AS c_intake, date FROM `daily_exercise` JOIN daily_food_details ON daily_exercise.date = daily_food_details.intake_date WHERE daily_exercise.user_id = "+id+" AND daily_food_details.user_id = "+id+" AND date >DATE_SUB(CURDATE(), INTERVAL 7 DAY) ORDER BY daily_food_details.intake_date ";
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
		System.out.println(date);
		System.out.println(c_burn + " || " + c_intake);
		String a[] = {date,c_burn,c_intake};
		return a;
	}	
	public void addBloodreq(String typ,String cont)
	{
		String sql="insert into blood_donate (type,contact) values ('"+typ+"','"+cont+"')";
		setDataSource();
		template1.update(sql);
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
	public void save_weekly_data(String id,String alco,String bp_1,String bp_2,String ch_1,String ch_2,String cigs,String sugar,String t_chol,String trigly)
	{
		setDataSource();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String sql="INSERT INTO `weekly_data`(user_id,alcohol_intake,blood_pressure_sys,blood_pressure_dia,blood_sugar, smokes,cholesterol_ldl, cholesterol_hdl,t_chol,trigly,week) VALUES ('"+id+"','"+alco+"','"+bp_1+"','"+bp_2+"','"+sugar+"','"+cigs+"','"+ch_1+"','"+ch_2+"','"+t_chol+"','"+trigly+"','"+dateFormat.format(date)+"')";
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
		String sql="SELECT * FROM daily_exercise where user_id="+s+" AND date >DATE_SUB(CURDATE(), INTERVAL 15 DAY)";
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
				sql = "INSERT INTO daily_food_details(user_id,intake_date,calories,fat,cholesterol,food_intake,water) VALUES('"+id+"','"+dateFormat.format(date)+"','0','0','0','','0')";
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
	public int weekly_water_average(int id)
	{
		setDataSource();
		String sql="SELECT COALESCE(water,0) AS water FROM daily_food_details where user_id="+id+" AND  intake_date >DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
		
		SqlRowSet srs= template1.queryForRowSet(sql);
		if(srs.next())
			return srs.getInt("water")/7;
		else
			return 0;
		
	}
	public double findChol(int food_id, int cnt) {
		// TODO Auto-generated method stub
		setDataSource();
		String sql="SELECT cholesterol FROM food_details where id="+food_id+"";
		SqlRowSet srs= template1.queryForRowSet(sql);
		srs.next();
		return srs.getDouble("cholesterol")*cnt;
	}
	public double findFat(int food_id, int cnt) {
		// TODO Auto-generated method stub
		setDataSource();
		String sql="SELECT fat FROM food_details where id="+food_id+"";
		SqlRowSet srs= template1.queryForRowSet(sql);
		srs.next();
		return srs.getDouble("fat")*cnt;
	}
	
	public void updateCal(int id, int total_cal,int total_fat, int total_chol, String item_str,String water) {
		setDataSource();
		int wat=Integer.parseInt(water);
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		System.out.println("jhere");
		String sq="select * from daily_food_details where user_id='"+id+"' and intake_date ='" + dateFormat.format(date)+"'";
		if(template1.queryForList(sq).size()==0)
		{
			System.out.println("inside if");
			String sql="INSERT INTO daily_food_details( `user_id`, `intake_date`, `calories`, `fat`, `cholesterol`, `food_intake`, `water`) values ('"+id+"','"+dateFormat.format(date)+"','"+total_cal+"','"+total_fat+"','"+total_chol+"','"+item_str+"','"+water+"')";
			template1.update(sql);
		}
		else
		{
			System.out.println("inside else");
			String sql="UPDATE daily_food_details SET calories = calories + "+total_cal+",fat = fat + "+total_fat+",cholesterol = cholesterol + "+total_chol+", food_intake = CONCAT(food_intake,',"+item_str+"'),water=water+"+wat+" WHERE user_id = "+id+" AND intake_date ='" + dateFormat.format(date)+"'";
			template1.update(sql);
		}
		}
	public void update_score(int id, double health1) {
		setDataSource();
		
		String sql="UPDATE user SET score = '"+health1+"' WHERE id = "+id;
		template1.update(sql);
	}
	public void change_password(int id, String cur_p, String new_p_1) {
		// TODO Auto-generated method stub
		setDataSource();
		
		String sql="SELECT password FROM user WHERE id = "+id;
		SqlRowSet srs= template1.queryForRowSet(sql);
		if(srs.next())
		{
			if(srs.getString("password").equals(cur_p))
			{
				sql = "UPDATE user SET password = '"+new_p_1+"' WHERE id = "+id;
				template1.update(sql);
			}
			else
				return;
		}
		else
			return;
	}
	public void update_profile(int id, String age, String height, String weight) {
		setDataSource();
		String sql="UPDATE user SET age = '"+age+"', height = '"+height+"', weight = '"+weight+"' WHERE id = "+id;
		template1.update(sql);
	}
	public int[] get_blood_pressure(int id) {
		setDataSource();
		int[] bp_arr = {80,120};
		String sql="SELECT blood_pressure_dia AS bp_low, blood_pressure_sys AS bp_high FROM weekly_data WHERE id="+id+" ORDER BY week DESC";
		SqlRowSet srs= template1.queryForRowSet(sql);
		if(srs.next())
		{
			bp_arr[0] = srs.getInt("bp_low");
			bp_arr[1] = srs.getInt("bp_high");
		}
		return bp_arr;
		
	}
	public boolean check_user(String username) {
		setDataSource();
		String sql="SELECT id FROM user WHERE username='"+username+"'";
		SqlRowSet srs= template1.queryForRowSet(sql);
		if(srs.next())
		{
			if(srs.getInt("id") > 0)
				return false;
			else
				return true;		
		}
		else
			return true;
	}
	
	public Blood_donate fetch_blood(String n_id, int id)
	{
		setDataSource();
		String sql="SELECT * FROM blood_donate WHERE id = (SELECT b_id FROM notifications WHERE id = '"+n_id+"')";
		SqlRowSet srs =template1.queryForRowSet(sql);
		Blood_donate b=new Blood_donate();
		if(srs.next())
		{
			b.setContact(srs.getString("contact"));
			b.setType(srs.getString("type"));
		}

		return b;
	}
}
