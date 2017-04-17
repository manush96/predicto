<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*,java.io.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection c = DriverManager.getConnection("jdbc:mysql://localhost/predicto","root","");
	Statement stmt = c.createStatement();
	Statement s = c.createStatement();
%>
<%!
	public int r(int min,int max)
	{
		return min + (int)(Math.random() * ((max - min) + 1));
	}
	public double f()
	{
		double[] arr = {0.0,0.25,0.5,0.75,1.0,1.25,1.5,1.75,2};
		int min = 0, max = arr.length-1;
		int ind = min + (int)(Math.random() * ((max - min) + 1));
		return arr[ind];
	}
%>
<%
    String sql = "SELECT * FROM user";
    ResultSet rs = stmt.executeQuery(sql);
    String date;
    int id,alc,bl,bh,bs,smk,cldl,chdl,tcl,tgl;
    String[] marr = {"2017-03-13","2017-03-20","2017-03-27","2017-04-03","2017-04-10","2017-04-17"};
    while(rs.next())
    {
    	id = rs.getInt("id");
    	
    	for(String d : marr)
    	{
    		date = d;
    		alc = r(0,8)*25;
    		bl = r(60,100);
    		bh = r(90,160);
    		bs = r(75,200);
    		smk = r(0,1);
    		cldl = r(50,250);
    		chdl = r(20,120);
    		tcl = r(80,350);
    		tgl = r(30,200);
    		sql = "INSERT INTO weekly_data(`user_id`, `alcohol_intake`, `blood_pressure_sys`, `blood_pressure_dia`, `blood_sugar`, `smokes`, `cholesterol_ldl`, `cholesterol_hdl`, `t_chol`, `trigly`, `week`) VALUES("+id+",'"+alc+"','"+bh+"','"+bl+"','"+bs+"','"+smk+"','"+cldl+"','"+chdl+"','"+tcl+"','"+tgl+"','"+date+"')";
    		//out.println(sql+"<br/>");
    		s.executeUpdate(sql);
    	}
    }
%>