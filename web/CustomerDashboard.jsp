<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.example.servlet.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('bg4.jpg');
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
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
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
        .result {
            margin-top: 20px;
            font-size: 1.2em;
            color: #333;
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
        .pay-button {
            display: inline-block;
            padding: 10px 20px;
            background-color: navy;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
        .pay-button:hover {
            background-color: #B8001F;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="customer.jsp" class="back-button">Back</a>
        <h1>Generate Bill</h1>
        <form action="CustomerDashboardServlet" method="post">
            <h2>View Bill</h2>
            <label for="customer_id">Customer ID:</label>
            <input type="text" id="customer_id" name="customer_id" required>
            <input type="submit" value="Generate Bill">
        </form>

        <%
            String customerId = request.getParameter("customer_id");
            if (customerId != null && !customerId.isEmpty()) {
                double totalAmount = 0.0;
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    conn = DatabaseConnection.getConnection();
                    String sql = "SELECT SUM(BILL_AMOUNT) AS total_amount FROM BILLS WHERE CUSTOMER_ID = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, Integer.parseInt(customerId));
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        totalAmount = rs.getDouble("total_amount");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
        %>
        <div class="result">
            <p><strong>Total Bill Amount for Customer ID <%= customerId %>: ₹<%= totalAmount %></strong></p>
            <a href="PaymentPage.jsp?customer_id=<%= customerId %>&amount=<%= totalAmount %>" class="pay-button">Pay Now</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>
