<%@ page import="java.sql.*"%>
<%@page import="com.DatabaseConnection"%>
<%	
	String state=request.getParameter("state");  
	String buffer="<select name='state' onchange='showCity(this.value);'><option value='-1'>---SELECT---</option>";
	
	
	try
	{
		Connection con;
		ResultSet res;
		DatabaseConnection dbconn;
	
		dbconn = new DatabaseConnection();
		con = dbconn.setConnection();
	 
		 Statement stmt = con.createStatement();// select product_id,product_name from product_master  
		 res = stmt.executeQuery("select city from city_state where state='"+state+"' ");
		 
		 while(res.next())
		 {
			buffer=buffer+"<option value='"+res.getString("city")+"'>"+res.getString("city")+"</option>";  
		 }  
		 buffer=buffer+"</select>";  
		 response.getWriter().println(buffer); 
		 }
		 catch(Exception e){
		     System.out.println(e);
		 }


	
%> 