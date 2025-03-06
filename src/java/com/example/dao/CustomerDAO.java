package com.example.dao;

import com.example.model.Customer;
import com.example.servlet.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    private Connection getConnection() throws SQLException {
        return DatabaseConnection.getConnection();
    }

    public void createCustomer(Customer customer) throws SQLException {
        String sql = "INSERT INTO CUSTOMERS (CUSTOMER_ID, NAME, ADDRESS, CONTACT) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customer.getId());
            ps.setString(2, customer.getName());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getContact());
            ps.executeUpdate();
        }
    }

    public void updateCustomer(Customer customer) throws SQLException {
        String sql = "UPDATE CUSTOMERS SET NAME = ?, ADDRESS = ?, CONTACT = ? WHERE CUSTOMER_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getContact());
            ps.setInt(4, customer.getId());
            ps.executeUpdate();
        }
    }

    public void deleteCustomer(int id) throws SQLException {
        String sql = "DELETE FROM CUSTOMERS WHERE CUSTOMER_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("No customer found with ID: " + id);
            } else {
                System.out.println("Customer with ID: " + id + " deleted successfully.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error deleting customer with ID: " + id, e);
        }
    }

    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT CUSTOMER_ID, NAME, ADDRESS, CONTACT FROM CUSTOMERS";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt("CUSTOMER_ID"),
                        rs.getString("NAME"),
                        rs.getString("ADDRESS"),
                        rs.getString("CONTACT"));
                customers.add(customer);
            }
        }
        return customers;
    }

    public Customer getCustomerById(int id) throws SQLException {
        String sql = "SELECT CUSTOMER_ID, NAME, ADDRESS, CONTACT FROM CUSTOMERS WHERE CUSTOMER_ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                            rs.getInt("CUSTOMER_ID"),
                            rs.getString("NAME"),
                            rs.getString("ADDRESS"),
                            rs.getString("CONTACT"));
                }
            }
        }
        return null;
    }

    public Customer getCustomerByName(String customerName) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }
}
