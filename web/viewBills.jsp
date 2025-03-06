<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.ResultSet, java.sql.SQLException, java.sql.Statement, java.util.Date" %>
<%@ page import="com.example.servlet.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Bills</title>
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
        h1, h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            background-color: navy;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
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
        tr:hover {
            background-color: #f5f5f5;
        }
        .table-container {
            max-height: 200px;
            overflow-y: auto;
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
    </style>
</head>
<body>
    <div class="container">
         <a href="adminDashboard.jsp" class="back-button">Back</a>
        <h1>View Bills</h1>

        <form action="CreateBillServlet" method="post">
            <h2>Create New Bill</h2>
            <label for="customer_id">Customer ID:</label>
            <input type="text" id="customer_id" name="customer_id" required>
            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" step="0.01" required>
            <input type="submit" value="Create Bill">
        </form>

        <h2>All Bills</h2>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Customer ID</th>
                        <th>Amount</th>
                        <th>Bill Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            conn = DatabaseConnection.getConnection();
                            stmt = conn.createStatement();
                            String sql = "SELECT * FROM BILLS";
                            rs = stmt.executeQuery(sql);

                            while (rs.next()) {
                                int billId = rs.getInt("BILL_ID");
                                int customerId = rs.getInt("CUSTOMER_ID");
                                double amount = rs.getDouble("BILL_AMOUNT");
                                Date billDate = rs.getDate("BILL_DATE");
                    %>
                    <tr>
                        <td><%= billId %></td>
                        <td><%= customerId %></td>
                        <td><%= amount %></td>
                        <td><%= billDate %></td>
                    </tr>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
