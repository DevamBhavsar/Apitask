import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DatabaseConnection;

@WebServlet("/CompanyRegistration")
public class CompanyRegistration extends HttpServlet {
    private static final long serialVersionUID = 1L;

    Connection con = null;
    Statement stmt = null;
    ResultSet res = null, res2 = null;
    DatabaseConnection dbconn;

    String employee_id, get_max, company_code, company_name, person_name, country, state, city, village, street1, street2, pincode,
            phone_no, mobile_no, fax_no, email, website, insert_query, gst_no, pan_no, country2, state2, city2, village2,
            street12, street22, pincode2, phone_no2, mobile_no2, query_duplicate, query_get_data,
            query_max, std_category, config_type, risk_type;

    int i, j, company_id, std_count, std_detail_id;

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

            company_code = request.getParameter("company_code");
            company_name = request.getParameter("company_name");
            person_name = request.getParameter("person_name");
            fax_no = request.getParameter("fax_no");
            email = request.getParameter("email");
            website = request.getParameter("website");
            gst_no = request.getParameter("gst_no");
            pan_no = request.getParameter("pan_no");
            config_type = request.getParameter("config_type");
            risk_type = request.getParameter("risk_type");

            country = request.getParameter("country");
            state = request.getParameter("state");
            city = request.getParameter("city");
            village = request.getParameter("village");
            street1 = request.getParameter("street1");
            street2 = request.getParameter("street2");
            pincode = request.getParameter("pincode");
            phone_no = request.getParameter("phone_no");
            mobile_no = request.getParameter("mobile_no");

            country2 = request.getParameter("country2");
            state2 = request.getParameter("state2");
            city2 = request.getParameter("city2");
            village2 = request.getParameter("village2");
            street12 = request.getParameter("street12");
            street22 = request.getParameter("street22");
            pincode2 = request.getParameter("pincode2");
            phone_no2 = request.getParameter("phone_no2");
            mobile_no2 = request.getParameter("mobile_no2");

            String[] std_name = request.getParameterValues("tbl_std_name");
            std_count = (std_name == null) ? 0 : std_name.length;

            stmt = con.createStatement();

            get_max = "select max(id) from company_registration";
            res = dbconn.getResult(get_max, con);
            if (res.next()) {
                company_id = res.getInt("max(id)");
            }

            get_max = "select max(id) from company_std_detail";
            res = dbconn.getResult(get_max, con);
            if (res.next()) {
                std_detail_id = res.getInt("max(id)");
            }

            boolean flag = true;
            query_duplicate = "select company_code from company_registration where id > 0";
            res = dbconn.getResult(query_duplicate, con);
            while (res.next()) {
                if (company_code.equalsIgnoreCase(res.getString("company_code"))) {
                    flag = false;
                    break;
                }
            }

            if (flag) {
                company_id++;

                insert_query = "INSERT INTO company_registration VALUES ('" + company_id + "','" + company_code + "','" + company_name + "','" + person_name + "','" + country + "', '" + state + "' ,'" + city + "','" + village + "','" + street1 + "','" + street2 + "','" + pincode + "','" + phone_no + "','" + mobile_no + "','" + fax_no + "','" + email + "','" + website + "','" + gst_no + "','" + pan_no + "','" + country2 + "','" + state2 + "','" + city2 + "','" + village2 + "','" + street12 + "','" + street22 + "','" + pincode2 + "','" + phone_no2 + "','" + mobile_no2 + "','" + config_type + "','" + risk_type + "','Active')";
                System.out.println("insert_query : " + insert_query);
                i = stmt.executeUpdate(insert_query);

                for (int j = 0; j < std_count; j++) {
                    query_get_data = "SELECT * FROM standard_master WHERE std_name = '" + std_name[j] + "'";
                    res2 = dbconn.getResult(query_get_data, con);
                    if (res2.next()) {
                        std_category = res2.getString("std_category");
                    }

                    std_detail_id++;

                    insert_query = "INSERT INTO company_std_detail VALUES ('" + std_detail_id + "', '" + company_id + "', '" + std_name[j] + "','" + std_category + "','Active')";
                    i = stmt.executeUpdate(insert_query);
                }
            }

            response.sendRedirect("/APITask/ViewCompany");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (res2 != null) res2.close();
                if (res != null) res.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
