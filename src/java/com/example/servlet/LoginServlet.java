package com.example.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String role = request.getParameter("role");

        if (role.equals("admin")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

           
            if (username.equals("admin") && password.equals("admin")) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } else if (role.equals("customer")) {
            
            response.sendRedirect("customer.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
