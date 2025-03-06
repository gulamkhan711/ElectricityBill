`package com.example.servlet;

import com.example.dao.BillDAO;
import com.example.model.Bill;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateBillServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            double amount = Double.parseDouble(request.getParameter("amount"));
           
            Bill bill = new Bill(customerId, amount);
            billDAO.createBill(bill);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("viewBills.jsp");
    }
}
