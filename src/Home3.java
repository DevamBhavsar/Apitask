

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


@WebServlet("/Home3")
public class Home3 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	Connection con;
	ResultSet res;
	DatabaseConnection dbconn;
	
	String query_get_company, employee_id;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
    	employee_id = (String)session.getAttribute("emp_id");
    	
    	if(employee_id == null || employee_id == ""){
    		response.sendRedirect("/APITask/index.jsp");
    		return;
    	}
    	
		dbconn = new DatabaseConnection();
		try {
			con = dbconn.setConnection();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		
		try 
		{
			
			
			RequestDispatcher rd = request.getRequestDispatcher("/home3.jsp");
			rd.forward(request, response);
			
		}finally{
    		try {
				//res.close();
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
    	}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request,response);
	}
	

}