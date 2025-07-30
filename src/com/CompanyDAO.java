package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.DatabaseConnection;

public class CompanyDAO {

    private Connection con;

    public CompanyDAO() {
        try {
            con = new DatabaseConnection().setConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Company addCompany(Company company) {
        PreparedStatement preparedStatement = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT MAX(id) as max_id FROM company_registration");
            int newId = 1;
            if (rs.next()) {
                newId = rs.getInt("max_id") + 1;
            }
            // Set the new ID on the object that will be returned
            company.setId(newId);

            String query = "INSERT INTO company_registration (id, company_code, company_name, person_name, country, state, city, village, street1, street2, pincode, phone_no, mobile_no, fax_no, email, website, gst_no, pan_no, country2, state2, city2, village2, street12, street22, pincode2, phone_no2, mobile_no2, config_type, risk_type, company_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = con.prepareStatement(query);

            preparedStatement.setInt(1, company.getId()); // Use the new ID from the company object
            preparedStatement.setString(2, company.getCompany_code());
            preparedStatement.setString(3, company.getCompany_name());
            preparedStatement.setString(4, company.getPerson_name());
            preparedStatement.setString(5, company.getCountry());
            preparedStatement.setString(6, company.getState());
            preparedStatement.setString(7, company.getCity());
            preparedStatement.setString(8, company.getVillage());
            preparedStatement.setString(9, company.getStreet1());
            preparedStatement.setString(10, company.getStreet2());
            preparedStatement.setString(11, company.getPincode());
            preparedStatement.setString(12, company.getPhone_no());
            preparedStatement.setString(13, company.getMobile_no());
            preparedStatement.setString(14, company.getFax_no());
            preparedStatement.setString(15, company.getEmail());
            preparedStatement.setString(16, company.getWebsite());
            preparedStatement.setString(17, company.getGst_no());
            preparedStatement.setString(18, company.getPan_no());
            preparedStatement.setString(19, company.getCountry2());
            preparedStatement.setString(20, company.getState2());
            preparedStatement.setString(21, company.getCity2());
            preparedStatement.setString(22, company.getVillage2());
            preparedStatement.setString(23, company.getStreet12());
            preparedStatement.setString(24, company.getStreet22());
            preparedStatement.setString(25, company.getPincode2());
            preparedStatement.setString(26, company.getPhone_no2());
            preparedStatement.setString(27, company.getMobile_no2());
            preparedStatement.setString(28, company.getConfig_type());
            preparedStatement.setString(29, company.getRisk_type());
            preparedStatement.setString(30, company.getStatus() != null ? company.getStatus() : "Active");

            int result = preparedStatement.executeUpdate();
            
            // If insertion was successful, return the company object with its new ID. Otherwise, return null.
            return result > 0 ? company : null;

        } catch (SQLException e) {
            System.err.println("Error adding company: " + e.getMessage());
            return null; // Return null on failure
        } finally {
            // Clean up all resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (preparedStatement != null) preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean deleteCompany(int companyId) {
        PreparedStatement preparedStatement = null;
        try {
            String query = "DELETE FROM company_registration WHERE id=?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setInt(1, companyId);
            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting company: " + e.getMessage());
            return false;
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    System.err.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }
    }

    public boolean updateCompany(Company company) {
        PreparedStatement preparedStatement = null;
        try {
            String query = "UPDATE company_registration SET company_code=?, company_name=?, person_name=?, country=?, state=?, city=?, village=?, street1=?, street2=?, pincode=?, phone_no=?, mobile_no=?, fax_no=?, email=?, website=?, gst_no=?, pan_no=?, country2=?, state2=?, city2=?, village2=?, street12=?, street22=?, pincode2=?, phone_no2=?, mobile_no2=?, config_type=?, risk_type=?, company_status=? WHERE id=?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setString(1, company.getCompany_code());
            preparedStatement.setString(2, company.getCompany_name());
            preparedStatement.setString(3, company.getPerson_name());
            preparedStatement.setString(4, company.getCountry());
            preparedStatement.setString(5, company.getState());
            preparedStatement.setString(6, company.getCity());
            preparedStatement.setString(7, company.getVillage());
            preparedStatement.setString(8, company.getStreet1());
            preparedStatement.setString(9, company.getStreet2());
            preparedStatement.setString(10, company.getPincode());
            preparedStatement.setString(11, company.getPhone_no());
            preparedStatement.setString(12, company.getMobile_no());
            preparedStatement.setString(13, company.getFax_no());
            preparedStatement.setString(14, company.getEmail());
            preparedStatement.setString(15, company.getWebsite());
            preparedStatement.setString(16, company.getGst_no());
            preparedStatement.setString(17, company.getPan_no());
            preparedStatement.setString(18, company.getCountry2());
            preparedStatement.setString(19, company.getState2());
            preparedStatement.setString(20, company.getCity2());
            preparedStatement.setString(21, company.getVillage2());
            preparedStatement.setString(22, company.getStreet12());
            preparedStatement.setString(23, company.getStreet22());
            preparedStatement.setString(24, company.getPincode2());
            preparedStatement.setString(25, company.getPhone_no2());
            preparedStatement.setString(26, company.getMobile_no2());
            preparedStatement.setString(27, company.getConfig_type());
            preparedStatement.setString(28, company.getRisk_type());
            preparedStatement.setString(29, company.getStatus());
            preparedStatement.setInt(30, company.getId());

            int result = preparedStatement.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error updating company: " + e.getMessage());
            return false;
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    System.err.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }
    }

    public List<Company> getAllCompanies() {
        List<Company> companies = new ArrayList<Company>();
        Statement statement = null;
        ResultSet rs = null;
        try {
            statement = con.createStatement();
            rs = statement.executeQuery("SELECT * FROM company_registration WHERE company_code IS NOT NULL");
            while (rs.next()) {
                Company company = mapResultSetToCompany(rs);
                companies.add(company);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all companies: " + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("Error closing ResultSet: " + e.getMessage());
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    System.err.println("Error closing Statement: " + e.getMessage());
                }
            }
        }
        return companies;
    }

    public Company getCompanyById(int companyId) {
        Company company = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {
            String query = "SELECT * FROM company_registration WHERE id=?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setInt(1, companyId);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                company = mapResultSetToCompany(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting company by ID: " + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("Error closing ResultSet: " + e.getMessage());
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    System.err.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }
        return company;
    }

    public boolean isCompanyCodeExists(String companyCode) {
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {
            String query = "SELECT COUNT(*) FROM company_registration WHERE company_code = ?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setString(1, companyCode);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking company code existence: " + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("Error closing ResultSet: " + e.getMessage());
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    System.err.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }
        return false;
    }

    public boolean isCompanyCodeExistsForUpdate(String companyCode, int companyId) {
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        try {
            String query = "SELECT COUNT(*) FROM company_registration WHERE company_code = ? AND id != ?";
            preparedStatement = con.prepareStatement(query);
            preparedStatement.setString(1, companyCode);
            preparedStatement.setInt(2, companyId);
            rs = preparedStatement.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error checking company code existence for update: " + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.err.println("Error closing ResultSet: " + e.getMessage());
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    System.err.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }
        return false;
    }

    private Company mapResultSetToCompany(ResultSet rs) throws SQLException {
        Company company = new Company();
        company.setId(rs.getInt("id"));
        company.setCompany_code(rs.getString("company_code"));
        company.setCompany_name(rs.getString("company_name"));
        company.setPerson_name(rs.getString("person_name"));
        company.setCountry(rs.getString("country"));
        company.setState(rs.getString("state"));
        company.setCity(rs.getString("city"));
        company.setVillage(rs.getString("village"));
        company.setStreet1(rs.getString("street1"));
        company.setStreet2(rs.getString("street2"));
        company.setPincode(rs.getString("pincode"));
        company.setPhone_no(rs.getString("phone_no"));
        company.setMobile_no(rs.getString("mobile_no"));
        company.setFax_no(rs.getString("fax_no"));
        company.setEmail(rs.getString("email"));
        company.setWebsite(rs.getString("website"));
        company.setGst_no(rs.getString("gst_no"));
        company.setPan_no(rs.getString("pan_no"));
        company.setCountry2(rs.getString("country2"));
        company.setState2(rs.getString("state2"));
        company.setCity2(rs.getString("city2"));
        company.setVillage2(rs.getString("village2"));
        company.setStreet12(rs.getString("street12"));
        company.setStreet22(rs.getString("street22"));
        company.setPincode2(rs.getString("pincode2"));
        company.setPhone_no2(rs.getString("phone_no2"));
        company.setMobile_no2(rs.getString("mobile_no2"));
        company.setConfig_type(rs.getString("config_type"));
        company.setRisk_type(rs.getString("risk_type"));
        company.setStatus(rs.getString("company_status"));
        return company;
    }

    public void closeConnection() {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
