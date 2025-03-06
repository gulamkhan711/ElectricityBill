package com.example.servlet;

import com.example.dao.CustomerDAO;
import com.example.model.Customer;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CustomerListServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers;
        try {
            customers = customerDAO.getAllCustomers();
        } catch (SQLException e) {
            e.printStackTrace();
            customers = null;
        }

        request.setAttribute("customers", customers);
        request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
    }
}
