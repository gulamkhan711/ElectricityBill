<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.model.Admin" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Admins</title>
    <style>
body {
    font-family: Arial, sans-serif;
    background-image: url('bg2.jpg');
    background-repeat: no-repeat;
    background-size: cover; 
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 80%;
            max-width: 800px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .back-button {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 20px;
            background-color: navy;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .back-button:hover {
            background-color: #B8001F;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: navy;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9e9e9;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="adminDashboard.jsp" class="back-button">Back</a>
        <h1>Admin List</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Admin> admins = (List<Admin>) request.getAttribute("admins");

                   
                    boolean dummyAdminAdded = false;

                    if (admins != null && !admins.isEmpty()) {
                        for (Admin admin : admins) {
                %>
                <tr>
                    <td><%= admin.getId() %></td>
                    <td><%= admin.getName() %></td>
                </tr>
                <%
                        }
                    } else {
                        dummyAdminAdded = true;
                    }
                    
                    if (dummyAdminAdded) {
                %>
                <tr>
                    <td>1</td>
                    <td>admin</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
