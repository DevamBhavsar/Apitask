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

@WebServlet("/DelCompany")
public class DelCompany extends HttpServlet {
    private static final long serialVersionUID = 1L;

    Connection con = null;
    ResultSet res = null;
    Statement stmt = null;
    DatabaseConnection dbconn;

    String employee_id, delete, query_delete;
    int i;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        employee_id = (String) session.getAttribute("emp_id");

        if (employee_id == null || employee_id.isEmpty()) {
            response.sendRedirect("/APITask/index.jsp");
            return;
        }

        delete = request.getParameter("id");

        try {
            dbconn = new DatabaseConnection();
            con = dbconn.setConnection();
            stmt = con.createStatement();

            // Delete from child table first
            query_delete = "DELETE FROM company_std_detail WHERE company_id='" + delete + "'";
            i = stmt.executeUpdate(query_delete);

            // Then delete from parent table
            query_delete = "DELETE FROM company_registration WHERE id='" + delete + "'";
            i = stmt.executeUpdate(query_delete);

            response.sendRedirect("/APITask/ViewCompany");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try {
                if (res != null) res.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
