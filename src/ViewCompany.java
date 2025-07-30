import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DatabaseConnection;

@WebServlet("/ViewCompany")
public class ViewCompany extends HttpServlet {
    private static final long serialVersionUID = 1L;

    Connection con;
    ResultSet res;
    DatabaseConnection dbconn;

    String query_get_company, company_code, employee_id;

    List<String> companydata = new ArrayList<>();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        employee_id = (String) session.getAttribute("emp_id");
        String login_type = (String) session.getAttribute("login_type");
        company_code = (String) session.getAttribute("company_code");

        if (employee_id == null || employee_id.isEmpty()) {
            response.sendRedirect("/APITest/index.jsp");
            return;
        }

        try {
            dbconn = new DatabaseConnection();
            con = dbconn.setConnection();

            if ("Niall Login".equalsIgnoreCase(login_type)) {
                query_get_company = "select * from company_registration where id>0 order by company_code";
            } else if ("client login".equalsIgnoreCase(login_type)) {
                query_get_company = "select * from company_registration where company_code='" + company_code + "'";
            }

            res = dbconn.getResult(query_get_company, con);
            while (res.next()) {
                companydata.add(res.getString("id"));
                companydata.add(res.getString("company_code"));
                companydata.add(res.getString("company_name"));
                companydata.add(res.getString("state"));
                companydata.add(res.getString("gst_no"));
                companydata.add(res.getString("company_status"));
            }

            request.setAttribute("companydata", companydata);
            RequestDispatcher rd = request.getRequestDispatcher("/viewcompany.jsp");
            rd.forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error occurred: " + e.getMessage());
        } finally {
            try {
                companydata.clear();
                if (res != null) res.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
