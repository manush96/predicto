package com.predicto.dao;
import java.util.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.predicto.model.Friend;
import com.predicto.model.User;

@Repository("friend_dao")
public class friend_dao {
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
	
	public List<User> get_suggestions(String q, int id)
	{
		HashMap<String,User> hm=new HashMap<String,User>();
		setDataSource();
		String sql = "SELECT * FROM user WHERE username LIKE '"+q+"%' AND id != "+id+" AND id NOT IN (SELECT friend_id FROM friends WHERE user_id = "+id+") AND id NOT IN (SELECT user_id FROM friends WHERE friend_id = "+id+")";
		
		java.util.List<User> listContact = template1.query(sql, new RowMapper<User>() {
			 
			@Override   
			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				return u;
			}
	 
	    });
		return listContact;
	}
	public void add_friend(int u_id, String id)
	{
		setDataSource();
		String sql = "INSERT INTO friends(user_id,friend_id,status) VALUES ("+u_id+","+id+",0)";
		template1.update(sql);
	}
	public void confirm_friend(int u_id, String id)
	{
		setDataSource();
		String sql = "UPDATE friends SET status='1' WHERE (user_id = '"+u_id+"' AND friend_id = '"+id+"') OR (user_id = '"+id+"' AND friend_id = '"+u_id+"')";
		template1.update(sql);
	}
	public void decline_friend(int u_id, String id)
	{
		setDataSource();
		String sql = "UPDATE friends SET status='2' WHERE (user_id = '"+u_id+"' AND friend_id = '"+id+"') OR (user_id = '"+id+"' AND friend_id = '"+u_id+"')";
		template1.update(sql);
	}
	public List<User> get_friends(int id)
	{
		setDataSource();
		String sql = "SELECT * FROM user WHERE id != "+id+" AND id IN (SELECT friend_id FROM friends WHERE user_id = "+id+" AND status=1) OR id IN (SELECT user_id FROM friends WHERE friend_id = "+id+" AND status=1)";
		
		java.util.List<User> listContact = template1.query(sql, new RowMapper<User>() {
			 
			@Override   
			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
				User u = new User();
				u.setId(rs.getInt("id"));
				u.setUsername(rs.getString("username"));
				return u;
			}
	 
	    });
		return listContact;
	}
	public List<Friend> get_comparison(int id, String ids)
	{
		setDataSource();
		String sql = "SELECT * FROM user WHERE id="+id+" OR id IN ("+ids+") ORDER BY CASE WHEN (id = "+id+") THEN 0 ELSE 1 END LIMIT 5";
		
		java.util.List<Friend> listContact = template1.query(sql, new RowMapper<Friend>() {
			 
			@Override   
			public Friend mapRow(ResultSet rs, int rowNum) throws SQLException {
				Friend f = new Friend();
				f.setId(rs.getInt("id"));
				f.setUsername(rs.getString("username"));
				int w = rs.getInt("weight");
				int h = rs.getInt("height");
				f.setBmi(round(w*10000/(h*h),1));
				f.setAge(rs.getInt("age"));
				f.setHeight(rs.getInt("height"));
				f.setWeight(rs.getInt("weight"));
				return f;
			}
	 
	    });
		return listContact;
	}
	private static double round (double value, int precision) {
	    int scale = (int) Math.pow(10, precision);
	    return (double) Math.round(value * scale) / scale;
	}
}
