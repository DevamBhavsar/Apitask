package api;

import java.io.BufferedReader;
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

@WebServlet("/api/auth/*")
public class AuthenticationAPI extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private DatabaseConnection dbconn;

    @Override
    public void init() {
        dbconn = new DatabaseConnection();
    }

    // POST /api/auth/login
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            sendErrorResponse(response, APIResponse.badRequest("Invalid endpoint"));
            return;
        }

        String[] pathParts = pathInfo.split("/");
        if (pathParts.length != 2) {
            sendErrorResponse(response, APIResponse.badRequest("Invalid URL format"));
            return;
        }

        String action = pathParts[1];

        switch (action.toLowerCase()) {
            case "login":
                handleLogin(request, response);
                break;
            case "logout":
                handleLogout(request, response);
                break;
            default:
                sendErrorResponse(response, APIResponse.badRequest("Invalid action: " + action));
        }
    }

    // GET /api/auth/logout
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.equals("/logout")) {
            handleLogout(request, response);
        } else {
            sendErrorResponse(response, APIResponse.badRequest("Invalid endpoint"));
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        Connection con = null;
        ResultSet res = null;

        try {
            // Parse JSON request
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject loginData = new JSONObject(sb.toString());

            // Validate required fields
            String username = loginData.optString("username", "").trim();
            String password = loginData.optString("password", "").trim();
            String companyCode = loginData.optString("company_code", "").trim();
            String loginType = loginData.optString("login_type", "").trim();

            if (username.isEmpty() || password.isEmpty() || companyCode.isEmpty() || loginType.isEmpty()) {
                sendErrorResponse(response, APIResponse.badRequest("Username, password, company_code, and login_type are required"));
                return;
            }

            con = dbconn.setConnection();
            companyCode = companyCode.replaceAll(" ", "_");

            String query;
            if (loginType.equalsIgnoreCase("Niall Login")) {
                query = "SELECT * FROM niall_user_master WHERE username = '" + username + "' AND password = '" + password + "'";
            } else {
                query = "SELECT * FROM " + companyCode + "_user_master WHERE username = '" + username + "' AND password = '" + password + "'";
            }

            res = dbconn.getResult(query, con);

            if (res.next()) {
                // Login successful
                HttpSession session = request.getSession();
                String employeeId = res.getString("user_id");
                String employeeName = res.getString("username");
                String empId = res.getString("emp_id");

                session.setAttribute("emp_id", employeeId);
                session.setAttribute("emp_name", employeeName);
                session.setAttribute("company_code", companyCode);
                session.setAttribute("login_type", loginType);

                if (loginType.equalsIgnoreCase("Niall Login")) {
                    session.setAttribute("login_company_name", "Niall Services");
                }

                // Create response
                JSONObject responseData = new JSONObject();
                responseData.put("user_id", employeeId);
                responseData.put("username", employeeName);
                responseData.put("emp_id", empId);
                responseData.put("company_code", companyCode);
                responseData.put("login_type", loginType);
                responseData.put("session_id", session.getId());

                sendSuccessResponse(response, APIResponse.success("Login successful", responseData));

            } else {
                sendErrorResponse(response, APIResponse.badRequest("Invalid credentials"));
            }

        } catch (JSONException e) {
            sendErrorResponse(response, APIResponse.badRequest("Invalid JSON format: " + e.getMessage()));
        } catch (Exception e) {
            sendErrorResponse(response, APIResponse.internalServerError("Login failed: " + e.getMessage()));
        } finally {
            try {
                if (res != null) res.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            sendSuccessResponse(response, APIResponse.success("Logout successful"));

        } catch (Exception e) {
            sendErrorResponse(response, APIResponse.internalServerError("Logout failed: " + e.getMessage()));
        }
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