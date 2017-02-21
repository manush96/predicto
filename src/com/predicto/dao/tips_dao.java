package com.predicto.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.predicto.model.Tips;
import com.predicto.model.User;

@Repository("tips_dao")
public class tips_dao {
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
	public List<Tips> get_tips(String s)
	{
		String sql="select * from tips where id IN ("+s+")";
		
		setDataSource();
		java.util.List<Tips> tip = template1.query(sql, new RowMapper<Tips>() {
			 
		     @Override   
			 public Tips mapRow(ResultSet rs, int rowNum) throws SQLException {
		    	 Tips tips=new Tips();
		    	 tips.setId(Integer.parseInt(rs.getString("id")));
		    	 tips.setTip(rs.getString("tip"));
		    	 tips.setTitle(rs.getString("tip_title"));
		    	 tips.setDisease(1);
		    	 return tips;
		        }
		 
		    });
		return tip;

	}
}
