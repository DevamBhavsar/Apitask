import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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

@WebServlet("/EditCompany")
public class EditCompany extends HttpServlet {
    private static final long serialVersionUID = 1L;

    Connection con = null;
    ResultSet res = null;
    ResultSet res1 = null;
    Statement stmt = null;
    DatabaseConnection dbconn;

    String employee_id, company_id, query_getdata, company_code;

    List<String> companydata = new ArrayList<>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        employee_id = (String) session.getAttribute("emp_id");

        if (employee_id == null || employee_id.isEmpty()) {
            response.sendRedirect("/APITask/index.jsp");
            return;
        }

        try {
            dbconn = new DatabaseConnection();
            con = dbconn.setConnection();

            company_id = request.getParameter("id");

            query_getdata = "SELECT * FROM company_registration WHERE id = '" + company_id + "'";
            res = dbconn.getResult(query_getdata, con);
            if (res.next()) {
                company_code = res.getString("company_code");
                request.setAttribute("company_id", res.getString("id"));
                request.setAttribute("company_name", res.getString("company_name"));
                request.setAttribute("person_name", res.getString("person_name"));
                request.setAttribute("fax_no", res.getString("fax_no"));
                request.setAttribute("email", res.getString("email"));
                request.setAttribute("website", res.getString("website"));
                request.setAttribute("gst_no", res.getString("gst_no"));
                request.setAttribute("pan_no", res.getString("pan_no"));
                request.setAttribute("config_type", res.getString("config_type"));
                request.setAttribute("risk_type", res.getString("risk_type"));

                request.setAttribute("country", res.getString("country"));
                request.setAttribute("state", res.getString("state"));
                request.setAttribute("city", res.getString("city"));
                request.setAttribute("village", res.getString("village"));
                request.setAttribute("street1", res.getString("street1"));
                request.setAttribute("street2", res.getString("street2"));
                request.setAttribute("pincode", res.getString("pincode"));
                request.setAttribute("phone_no", res.getString("phone_no"));
                request.setAttribute("mobile_no", res.getString("mobile_no"));

                request.setAttribute("country2", res.getString("country2"));
                request.setAttribute("state2", res.getString("state2"));
                request.setAttribute("city2", res.getString("city2"));
                request.setAttribute("village2", res.getString("village2"));
                request.setAttribute("street12", res.getString("street12"));
                request.setAttribute("street22", res.getString("street22"));
                request.setAttribute("pincode2", res.getString("pincode2"));
                request.setAttribute("phone_no2", res.getString("phone_no2"));
                request.setAttribute("mobile_no2", res.getString("mobile_no2"));
            }

            query_getdata = "SELECT * FROM company_std_detail WHERE company_id='" + company_id + "'";
            res1 = dbconn.getResult(query_getdata, con);
            while (res1.next()) {
                companydata.add(res1.getString("id"));
                companydata.add(res1.getString("std_name"));
            }

            request.setAttribute("companydata", companydata);
            RequestDispatcher rd = request.getRequestDispatcher("/editcompany.jsp");
            rd.forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                companydata.clear();
                if (res1 != null) res1.close();
                if (res != null) res.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
