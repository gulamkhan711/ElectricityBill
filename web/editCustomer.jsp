<%@page import="com.example.model.Customer"%>
<%@page import="com.example.dao.CustomerDAO"%>
<%@page import="java.sql.SQLException"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    CustomerDAO customerDAO = new CustomerDAO();
    Customer customer = null;
    try {
        customer = customerDAO.getCustomerById(id);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Customer</title>
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
            max-width: 600px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"] {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            padding: 10px;
            background-color: navy;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #B8001F;
        }
    </style>
</head>
<body>
    <div class="container">
        <form action="UpdateCustomerServlet" method="post">
            <input type="hidden" name="id" value="<%= customer.getId() %>">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= customer.getName() %>" required>
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" value="<%= customer.getAddress() %>" required>
            <label for="contact">Contact:</label>
            <input type="text" id="contact" name="contact" value="<%= customer.getContact() %>" required>
            <button type="submit">Update Customer</button>
        </form>
    </div>
</body>
</html>
