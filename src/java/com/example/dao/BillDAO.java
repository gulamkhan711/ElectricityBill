package com.example.dao;

import com.example.model.Bill;
import com.example.servlet.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class BillDAO {

    public void createBill(Bill bill) throws SQLException {
        String sql = "INSERT INTO BILLS (CUSTOMER_ID, BILL_AMOUNT, BILL_DATE) VALUES (?, ?, CURRENT_DATE)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bill.getCustomerId());
            ps.setDouble(2, bill.getAmount());
            ps.executeUpdate();
        }
    }

    public List<Bill> getBillsByCustomerId(int customerId) {
        throw new UnsupportedOperationException("Not supported yet."); 
    }
}
