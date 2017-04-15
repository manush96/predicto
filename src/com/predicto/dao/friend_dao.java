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
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import com.predicto.model.Daily_data;
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
		String sql = "SELECT * FROM user WHERE id != "+id+" AND id IN (SELECT friend_id FROM friends WHERE user_id = "+id+" AND status=1) OR id IN (SELECT user_id FROM friends WHERE friend_id = "+id+" AND status=1) ORDER BY id";
		
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
				double sc = rs.getInt("score");
				f.setBmi(round(w*10000/(h*h),1));
				f.setAge(rs.getInt("age"));
				f.setHeight(rs.getInt("height"));
				f.setWeight(rs.getInt("weight"));
				f.setScore(round(sc,1));
				return f;
			}
	 
	    });
		return listContact;
	}
	public String[] get_calorie_data(String type,int id, String ids)
	{
		setDataSource();
		int i = 0;
		String[] all_ids = ids.split(",");
		i = all_ids.length;
		String sql;
		if(type == "burn")
			sql = "SELECT user_id,date, COALESCE(calories,0) AS str FROM daily_exercise WHERE (user_id="+id+" OR user_id IN ("+ids+")) AND (date > DATE_SUB(CURDATE(), INTERVAL 7 DAY)) ORDER BY date, CASE WHEN (user_id = "+id+") THEN 0 ELSE 1 END,user_id";
		else
			sql = "SELECT user_id,intake_date AS date, COALESCE(calories,0) AS str FROM daily_food_details WHERE (user_id="+id+" OR user_id IN ("+ids+")) AND (intake_date > DATE_SUB(CURDATE(), INTERVAL 7 DAY)) ORDER BY intake_date, CASE WHEN (user_id = "+id+") THEN 0 ELSE 1 END,user_id";
		SqlRowSet srs =template1.queryForRowSet(sql);
		String u_string="";
		String[] others = new String[i];
		for(int k = 1; k <= i; k++)
			others[k-1] = "";
		int count = 0;
		String dates = "";
		for(int j = 1; j <= 7; j++)
		{
			if(srs.next())
			{
				if(srs.getString("user_id").equals(""+id))
					u_string += (int) Double.parseDouble(srs.getString("str"))+",";
				else
				{
					u_string += "0,";
					srs.previous();
					break;
				}
				dates += "'"+srs.getString("date")+"',";
				for(int k = 1; k <= i; k++)
				{
					if(srs.next())
					{
						if(srs.getString("user_id").equals(""+all_ids[k-1]))
							others[k-1] += (int) Double.parseDouble(srs.getString("str"))+",";
						else
						{
							others[k-1] += "0,";
							srs.previous();
						}
					}
					else
					{
						srs.previous();
						break;
					}
				}
				count++;
			}
			else
				break;
		}
		String[] s = new String[i+2];
		if(count > 0)
		{
			dates = dates.substring(0,dates.length()-1);
			s[0] = dates;
			u_string = u_string.substring(0,u_string.length()-1);
			s[1] = u_string;
			for(int k = 1; k <= i; k++)
			{
				others[k-1] = others[k-1].substring(0, others[k-1].length()-1);
				s[k+1] = others[k-1];
			}
		}
		return s;
	}
	public String[] get_chart_data(String type, int id, String ids)
	{
		setDataSource();
		int i = 0;
		String[] all_ids = ids.split(",");
		i = all_ids.length;
		
		String sql = "SELECT user_id,date, COALESCE("+type+",0) AS str FROM daily_exercise WHERE (user_id="+id+" OR user_id IN ("+ids+")) AND (date >DATE_SUB(CURDATE(), INTERVAL 7 DAY)) ORDER BY date, CASE WHEN (user_id = "+id+") THEN 0 ELSE 1 END,user_id";
		SqlRowSet srs =template1.queryForRowSet(sql);
		String u_string="";
		String[] others = new String[i];
		for(int k = 1; k <= i; k++)
			others[k-1] = "";
		int count = 0;
		String dates = "";
		for(int j = 1; j <= 7; j++)
		{
			if(srs.next())
			{
				if(srs.getString("user_id").equals(""+id))
					u_string += (int) Double.parseDouble(srs.getString("str"))+",";
				else
				{
					u_string += "0,";
					srs.previous();
					break;
				}
				dates += "'"+srs.getString("date")+"',";
				for(int k = 1; k <= i; k++)
				{
					if(srs.next())
					{
						if(srs.getString("user_id").equals(""+all_ids[k-1]))
							others[k-1] += (int) Double.parseDouble(srs.getString("str"))+",";
						else
						{
							others[k-1] += "0,";
							srs.previous();
						}
					}
					else
					{
						srs.previous();
						break;
					}
				}
				count++;
			}
			else
				break;
		}
		String[] s = new String[i+2];
		if(count > 0)
		{
			dates = dates.substring(0,dates.length()-1);
			s[0] = dates;
			u_string = u_string.substring(0,u_string.length()-1);
			s[1] = u_string;
			for(int k = 1; k <= i; k++)
			{
				others[k-1] = others[k-1].substring(0, others[k-1].length()-1);
				s[k+1] = others[k-1];
			}
		}
		return s;
	}
	private static double round (double value, int precision) {
	    int scale = (int) Math.pow(10, precision);
	    return (double) Math.round(value * scale) / scale;
	}
}
