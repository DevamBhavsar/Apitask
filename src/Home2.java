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

@WebServlet("/Home2")
public class Home2 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    Connection con;
    ResultSet res;
    DatabaseConnection dbconn;

    String query_get_company, employee_id;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        employee_id = (String) session.getAttribute("emp_id");

        if (employee_id == null || employee_id.isEmpty()) {
            response.sendRedirect("/APITask/index.jsp");
            return;
        }

        try {
            dbconn = new DatabaseConnection();
            con = dbconn.setConnection();

            RequestDispatcher rd = request.getRequestDispatcher("/home2.jsp");
            rd.forward(request, response);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database connection failed: " + e.getMessage());
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
