

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DatabaseConnection;


@WebServlet("/Home")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Connection con;
	ResultSet res,res1,res_data,res2,res3,res4;
	DatabaseConnection dbconn;
	
	String employee_id,company_code,company_id;
	
	int i;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
    	employee_id = (String)session.getAttribute("emp_id");
    	company_code = (String)session.getAttribute("company_code");
    	
    	if(employee_id == null || employee_id == ""){
    		response.sendRedirect("/APITask/index.jsp");
    		return;
    	}
    	
		
    	dbconn = new DatabaseConnection();
		try {
			con = dbconn.setConnection();
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	
		try
		{
			
			RequestDispatcher rd = request.getRequestDispatcher("/home.jsp");
			rd.forward(request, response);
			
			
		}
		finally
		{
			try
			{
				if(res!=null)
					res.close();
				con.close();
			} 
			catch (SQLException e) 
			{
				e.printStackTrace();
			}
    	}
		

	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doPost(request,response);
	}

}
