package com.predicto.dao;
import java.awt.List;
import java.util.Map;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
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
	setDataSource();
	String sql="select * from user where username="+user.getUserName()+"and password="+user.getPassword();
	java.util.List<Map<String, Object>> l=template1.queryForList(sql);
	if(l.size()==1)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

}
