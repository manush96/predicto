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

public void addUser(User user)
{
	setDataSource();
	String sql="insert into user(username,password,email) values('"+user.getUserName()+"','"+user.getPassword()+"','"+user.getEmail()+"')";
	template1.update(sql);
}
public int checkLogin(User user)
{
	final User user1 = new User();
	setDataSource();
	String sql="select * from user where username='"+user.getUserName()+"' and password='"+user.getPassword()+"'";
	 java.util.List<User> listContact = template1.query(sql, new RowMapper<User>() {
		 
	     @Override   
		 public User mapRow(ResultSet rs, int rowNum) throws SQLException {
	            
	            System.out.println(rs.getInt("id")+"jakob");
	            user1.setId(rs.getInt("id"));
	            user1.setUserName(rs.getString("username"));
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

}
