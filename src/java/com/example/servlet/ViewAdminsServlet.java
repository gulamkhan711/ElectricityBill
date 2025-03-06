package com.example.servlet;

import com.example.dao.AdminDAO;
import com.example.model.Admin;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewAdminsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminDAO adminDAO = new AdminDAO();
        List<Admin> admins = null;
        try {
            admins = adminDAO.getAllAdmins();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("admins", admins);
        request.getRequestDispatcher("viewAdmins.jsp").forward(request, response);
    }
}
