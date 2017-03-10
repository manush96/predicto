package com.predicto.dao;
import java.awt.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

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

	public int addUser(User user)
	{
		setDataSource();
		String sql="insert into user(username,password,email,heredity) values('"+user.getUsername()+"','"+user.getPassword()+"','"+user.getEmail()+"','No data for now')";
		template1.update(sql);
		return template1.queryForInt("select MAX(id) from user");
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
		String sql="INSERT INTO daily_exercise (user_id,run,walk,cycle,working,calories) values ('"+id+"','"+run+"','"+walk+"','"+cycle+"','"+working+"','"+cal+"')";
		template1.update(sql);
	}
}
