package com.predicto.dao;
import java.util.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.predicto.model.*;

@Repository("stores_dao")
public class stores_dao {
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
	
	public int addStore(Store store)
	{
		setDataSource();
		String sql="INSERT INTO stores (store_id,name,latitude,longitude,locality,contact,address,city,state,pincode) VALUES ('"+store.getStore_id() +"','"+store.getName() +"','"+store.getLatitude() +"','"+store.getLongitude() +"','"+store.getLocality() +"','"+store.getContact() +"','"+store.getAddress() +"','"+store.getCity() +"','"+store.getState() +"','"+store.getPincode() + "')";
		template1.update(sql);
		return template1.queryForInt("SELECT MAX(id) FROM stores");
	}
	public List<Store> getStores()
	{
		HashMap<String,Store> hm=new HashMap<String,Store>();
		
		setDataSource();
		String sql="SELECT * FROM stores";
		
		java.util.List<Store> listContact = template1.query(sql, new RowMapper<Store>() {
			 
			@Override   
			public Store mapRow(ResultSet rs, int rowNum) throws SQLException {
				Store s = new Store(rs.getString("store_id"),rs.getString("name"),rs.getString("name"),rs.getString("name"),rs.getString("name"),rs.getString("name"),rs.getString("name"),rs.getString("name"),rs.getString("name"),rs.getString("name"));
				return s;
			}
	 
	    });
		return listContact;
	}
	public void pushDaily()
	{
		setDataSource();
		String sql="SELECT * FROM user";
		
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
}
