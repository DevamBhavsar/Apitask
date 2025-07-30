package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class DatabaseConnection {
	

	public Statement stmt;
	public Connection con;
	public ResultSet res;
	
	public Connection setConnection() throws ClassNotFoundException, SQLException {
		

		Class.forName("com.mysql.cj.jdbc.Driver");


		String url = "jdbc:mysql://localhost:3306/apitask?useSSL=false&serverTimezone=UTC";
		String user = "root";
		String password = "root";
		
		con = DriverManager.getConnection(url, user, password);
		
		return con;
	}

	public ResultSet getResult(String query, Connection con){

		this.con = con;
		try{

			stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			res = stmt.executeQuery(query);

		} catch(Exception e){
			e.printStackTrace();
		}

		return res;
	}

}
