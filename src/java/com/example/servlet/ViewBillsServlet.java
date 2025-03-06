package com.example.servlet;

import com.example.model.Bill;
import com.example.servlet.DatabaseConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewBillsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM BILLS";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int billId = rs.getInt("BILL_ID");
                int customerId = rs.getInt("CUSTOMER_ID");
                double amount = rs.getDouble("BILL_AMOUNT");
                java.sql.Date billDate = rs.getDate("BILL_DATE");

                Bill bill = new Bill(billId, customerId, amount, billDate);
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("bills", bills);
        request.getRequestDispatcher("viewBills.jsp").forward(request, response);
    }
}
