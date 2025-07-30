package api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.Company;
import com.CompanyDAO;

@WebServlet("/api/companies")
public class CompanyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CompanyDAO companyDAO;

    public void init() {
        companyDAO = new CompanyDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Company> companies = companyDAO.getAllCompanies();
            JSONArray jsonArray = new JSONArray();

            for (Company company : companies) {
                JSONObject jsonObject = createCompanyJSON(company);
                jsonArray.put(jsonObject);
            }

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(jsonArray);
            out.flush();
        } catch (Exception e) {
            sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                            "Error retrieving companies", e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = null;

        try {
            reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            JSONObject jsonObject = new JSONObject(sb.toString());

            // Validate required fields
            if (!jsonObject.has("company_code") || jsonObject.getString("company_code").trim().isEmpty()) {
                sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                                "Validation Error", "Company code is required");
                return;
            }

            if (!jsonObject.has("company_name") || jsonObject.getString("company_name").trim().isEmpty()) {
                sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                                "Validation Error", "Company name is required");
                return;
            }

            String companyCode = jsonObject.getString("company_code").trim();

            // Check for duplicate company code
            if (companyDAO.isCompanyCodeExists(companyCode)) {
                sendErrorResponse(response, HttpServletResponse.SC_CONFLICT,
                                "Duplicate Error", "Company code already exists: " + companyCode);
                return;
            }

            Company company = mapJSONToCompany(jsonObject);
            company.setStatus(jsonObject.optString("status", "Active")); // Configurable status

            boolean success = companyDAO.addCompany(company);

            if (success) {
                // Return the created company with generated ID
                List<Company> companies = companyDAO.getAllCompanies();
                Company createdCompany = null;
                for (Company c : companies) {
                    if (c.getCompany_code().equals(companyCode)) {
                        createdCompany = c;
                        break;
                    }
                }

                if (createdCompany != null) {
                    response.setStatus(HttpServletResponse.SC_CREATED);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    out.print(createCompanyJSON(createdCompany));
                    out.flush();
                } else {
                    response.setStatus(HttpServletResponse.SC_CREATED);
                }
            } else {
                sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                                "Database Error", "Failed to create company");
            }

        } catch (org.json.JSONException e) {
            sendErrorResponse(response, HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid JSON", "Invalid JSON format: " + e.getMessage());
        } catch (Exception e) {
            sendErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                            "Server Error", "Unexpected error: " + e.getMessage());
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    System.err.println("Error closing reader: " + e.getMessage());
                }
            }
        }
    }

    private Company mapJSONToCompany(JSONObject jsonObject) {
        Company company = new Company();
        company.setCompany_code(jsonObject.optString("company_code", ""));
        company.setCompany_name(jsonObject.optString("company_name", ""));
        company.setPerson_name(jsonObject.optString("person_name", ""));
        company.setCountry(jsonObject.optString("country", ""));
        company.setState(jsonObject.optString("state", ""));
        company.setCity(jsonObject.optString("city", ""));
        company.setVillage(jsonObject.optString("village", ""));
        company.setStreet1(jsonObject.optString("street1", ""));
        company.setStreet2(jsonObject.optString("street2", ""));
        company.setPincode(jsonObject.optString("pincode", ""));
        company.setPhone_no(jsonObject.optString("phone_no", ""));
        company.setMobile_no(jsonObject.optString("mobile_no", ""));
        company.setFax_no(jsonObject.optString("fax_no", ""));
        company.setEmail(jsonObject.optString("email", ""));
        company.setWebsite(jsonObject.optString("website", ""));
        company.setGst_no(jsonObject.optString("gst_no", ""));
        company.setPan_no(jsonObject.optString("pan_no", ""));
        company.setCountry2(jsonObject.optString("country2", ""));
        company.setState2(jsonObject.optString("state2", ""));
        company.setCity2(jsonObject.optString("city2", ""));
        company.setVillage2(jsonObject.optString("village2", ""));
        company.setStreet12(jsonObject.optString("street12", ""));
        company.setStreet22(jsonObject.optString("street22", ""));
        company.setPincode2(jsonObject.optString("pincode2", ""));
        company.setPhone_no2(jsonObject.optString("phone_no2", ""));
        company.setMobile_no2(jsonObject.optString("mobile_no2", ""));
        company.setConfig_type(jsonObject.optString("config_type", ""));
        company.setRisk_type(jsonObject.optString("risk_type", ""));
        return company;
    }

    private JSONObject createCompanyJSON(Company company) throws org.json.JSONException {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("id", company.getId());
        jsonObject.put("company_code", company.getCompany_code());
        jsonObject.put("company_name", company.getCompany_name());
        jsonObject.put("person_name", company.getPerson_name());
        jsonObject.put("country", company.getCountry());
        jsonObject.put("state", company.getState());
        jsonObject.put("city", company.getCity());
        jsonObject.put("village", company.getVillage());
        jsonObject.put("street1", company.getStreet1());
        jsonObject.put("street2", company.getStreet2());
        jsonObject.put("pincode", company.getPincode());
        jsonObject.put("phone_no", company.getPhone_no());
        jsonObject.put("mobile_no", company.getMobile_no());
        jsonObject.put("fax_no", company.getFax_no());
        jsonObject.put("email", company.getEmail());
        jsonObject.put("website", company.getWebsite());
        jsonObject.put("gst_no", company.getGst_no());
        jsonObject.put("pan_no", company.getPan_no());
        jsonObject.put("country2", company.getCountry2());
        jsonObject.put("state2", company.getState2());
        jsonObject.put("city2", company.getCity2());
        jsonObject.put("village2", company.getVillage2());
        jsonObject.put("street12", company.getStreet12());
        jsonObject.put("street22", company.getStreet22());
        jsonObject.put("pincode2", company.getPincode2());
        jsonObject.put("phone_no2", company.getPhone_no2());
        jsonObject.put("mobile_no2", company.getMobile_no2());
        jsonObject.put("config_type", company.getConfig_type());
        jsonObject.put("risk_type", company.getRisk_type());
        jsonObject.put("status", company.getStatus());
        return jsonObject;
    }

    private void sendErrorResponse(HttpServletResponse response, int statusCode,
                                 String error, String message) throws IOException {
        response.setStatus(statusCode);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // FIXED: Wrapped the JSON operations in a try-catch block.
        try {
            JSONObject errorResponse = new JSONObject();
            errorResponse.put("error", error);
            errorResponse.put("message", message);
            errorResponse.put("timestamp", System.currentTimeMillis());

            PrintWriter out = response.getWriter();
            out.print(errorResponse);
            out.flush();
        } catch (JSONException e) {
            // If creating the JSON error response fails, log the error.
            // The client will still receive the HTTP status code set earlier.
            e.printStackTrace();
        }
    }

    @Override
    public void destroy() {
        if (companyDAO != null) {
            companyDAO.closeConnection();
        }
        super.destroy();
    }
}
