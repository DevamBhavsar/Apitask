

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DatabaseConnection;


@WebServlet("/ValidateLogin")
public class ValidateLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	Connection con;
	ResultSet res,res1,res2;
	DatabaseConnection dbconn;
	
	String username, password, query, employee_id, employee_name,company_code,emp_id,login_company_name,login_type,
		company_status,package_status="Expired";
	
	int company_id;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
			HttpSession session = request.getSession();
			
			username = request.getParameter("username");
			password = request.getParameter("password");
			company_code = request.getParameter("company_code");
			login_type = request.getParameter("login_type");
			
			dbconn = new DatabaseConnection();
			con = dbconn.setConnection();
			
			employee_id = null;
			
			
			company_code=company_code.replaceAll(" ", "_");
			
			
			
			
			//================================
			
			if(login_type.equalsIgnoreCase("Niall Login"))
			{
				query = "select * from niall_user_master where username = '"+username+"' and password = '"+password+"'";
			}
			else
			{
				query = "select * from "+company_code+"_user_master where username = '"+username+"' and password = '"+password+"'";
			}
			res = dbconn.getResult(query, con);
			if(res.next())
			{
				
				employee_id = res.getString("user_id");
				employee_name = res.getString("username");
				
				emp_id = res.getString("emp_id");
				
				
				
    			if(login_type.equalsIgnoreCase("Niall Login"))
    			{
    				login_company_name="Niall Services";
    			}
    			
				
				session.setAttribute("emp_id", employee_id);
				session.setAttribute("emp_name", employee_name);
				session.setAttribute("company_code", company_code);
				session.setAttribute("login_company_name", login_company_name);
				session.setAttribute("login_type", login_type);
			}
			
			if(employee_id == null)
			{
				request.setAttribute("error", "1");				
				RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
				rd.forward(request, response);
			}
			
			
			
			if(employee_id != null){
				
				if(login_type.equalsIgnoreCase("Niall Login"))
				{
					response.sendRedirect(request.getContextPath() + "/Home2");
				}
				
				
			}
			
		} catch(Exception e){
			e.printStackTrace();
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
		
		finally {
			try {
				res.close();
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}
	protected void service(HttpServletRequest request, HttpServletResponse   response) throws ServletException, IOException {
        doPost(request, response);
}

}
