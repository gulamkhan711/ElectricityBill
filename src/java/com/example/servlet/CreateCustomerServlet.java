package com.example.servlet;

import com.example.dao.CustomerDAO;
import com.example.model.Customer;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateCustomerServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String contact = request.getParameter("contact");
            Customer customer = new Customer(id, name, address, contact);
            customerDAO.createCustomer(customer);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("CustomerListServlet");
    }
}
