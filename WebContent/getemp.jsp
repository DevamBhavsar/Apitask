<%@ page import="java.sql.*"%>
<%@page import="com.DatabaseConnection"%>
<%	
	String company_name = (String) session.getAttribute("company_code");

	//String department=request.getParameter("department");  
	String designation=request.getParameter("designation"); 


	String buffer="<select><option value='0'>---SELECT---</option>";
	
	
	try
	{
		Connection con;
		ResultSet res;
		DatabaseConnection dbconn;
	
		dbconn = new DatabaseConnection();
		con = dbconn.setConnection();
	 
		 Statement stmt = con.createStatement();
		 
		 res = stmt.executeQuery("select id,name from "+company_name+"_employee_detail where designation_id='"+designation+"'");
		 while(res.next())
		 {
			buffer=buffer+"<option value='"+res.getString("id")+"'>"+res.getString("name")+"</option>";  
		 }  
		 buffer=buffer+"</select>";  
		 response.getWriter().println(buffer); 
		 }
		 catch(Exception e){
		     System.out.println(e);
		 }


	
%> 