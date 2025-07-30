package api;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.APIResponse;
import com.DatabaseConnection;

@WebServlet("/api/dashboard/*")
public class DashboardAPI extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DatabaseConnection dbconn;

    @Override
    public void init() {
        dbconn = new DatabaseConnection();
    }

    // GET /api/dashboard/info - Get dashboard information
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAuthenticated(request)) {
            sendErrorResponse(response, APIResponse.error("Unauthorized", "Please login first", 401));
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            sendErrorResponse(response, APIResponse.badRequest("Dashboard endpoint required"));
            return;
        }

        String[] pathParts = pathInfo.split("/");
        if (pathParts.length != 2) {
            sendErrorResponse(response, APIResponse.badRequest("Invalid URL format"));
            return;
        }

        String endpoint = pathParts[1];

        switch (endpoint.toLowerCase()) {
            case "info":
                handleDashboardInfo(request, response);
                break;
            case "stats":
                handleDashboardStats(request, response);
                break;
            default:
                sendErrorResponse(response, APIResponse.badRequest("Invalid dashboard endpoint: " + endpoint));
        }
    }

    private void handleDashboardInfo(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            HttpSession session = request.getSession();
            String employeeId = (String) session.getAttribute("emp_id");
            String employeeName = (String) session.getAttribute("emp_name");
            String companyCode = (String) session.getAttribute("company_code");
            String loginType = (String) session.getAttribute("login_type");

            JSONObject dashboardData = new JSONObject();
            dashboardData.put("employee_id", employeeId);
            dashboardData.put("employee_name", employeeName);
            dashboardData.put("company_code", companyCode);
            dashboardData.put("login_type", loginType);
            dashboardData.put("session_id", session.getId());
            dashboardData.put("last_access", System.currentTimeMillis());

            sendSuccessResponse(response, APIResponse.success("Dashboard info retrieved successfully", dashboardData));

        } catch (Exception e) {
            sendErrorResponse(response, APIResponse.internalServerError("Error retrieving dashboard info: " + e.getMessage()));
        }
    }

    private void handleDashboardStats(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Connection con = null;
        ResultSet res = null;

        try {
            con = dbconn.setConnection();

            // Get company statistics
            String companyCountQuery = "SELECT COUNT(*) as total_companies FROM company_registration WHERE company_code IS NOT NULL";
            res = dbconn.getResult(companyCountQuery, con);

            int totalCompanies = 0;
            if (res.next()) {
                totalCompanies = res.getInt("total_companies");
            }

            JSONObject statsData = new JSONObject();
            statsData.put("total_companies", totalCompanies);
            statsData.put("generated_at", System.currentTimeMillis());

            sendSuccessResponse(response, APIResponse.success("Dashboard stats retrieved successfully", statsData));

        } catch (Exception e) {
            sendErrorResponse(response, APIResponse.internalServerError("Error retrieving dashboard stats: " + e.getMessage()));
        } finally {
            try {
                if (res != null) res.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;

        String employeeId = (String) session.getAttribute("emp_id");
        return employeeId != null && !employeeId.isEmpty();
    }

    private void sendSuccessResponse(HttpServletResponse response, APIResponse apiResponse) throws IOException {
        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            PrintWriter out = response.getWriter();
            out.print(apiResponse.toJSON().toString());
            out.flush();
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    private void sendErrorResponse(HttpServletResponse response, APIResponse apiResponse) throws IOException {
        response.setStatus(apiResponse.getStatusCode());
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            PrintWriter out = response.getWriter();
            out.print(apiResponse.toJSON().toString());
            out.flush();
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}