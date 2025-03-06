<%@page import="com.example.model.Customer"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Customers</title>
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
            background-color:white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 70%;
            max-width: 800px;
        }
        h2 {
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
        form {
            display: flex;
            flex-direction: column;
            margin-bottom: 20px;
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
        .table-container {
            max-height: 250px;
            overflow-y: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
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
        .actions button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .actions button.edit {
            background-color: green;
            color: white;
        }
        .actions button.edit:hover {
            background-color: darkgreen;
        }
        .actions button.delete {
            background-color: red;
            color: white;
        }
        .actions button.delete:hover {
            background-color: darkred;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="adminDashboard.jsp" class="back-button">Back</a>
        <form action="CreateCustomerServlet" method="post">
            <h2>Add New Customer</h2>
            <label for="id">ID:</label>
            <input type="text" id="id" name="id" required>
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="address">Address:</label>
            <input type="text" id="address" name="address" required>
            <label for="contact">Contact:</label>
            <input type="text" id="contact" name="contact" required>
            <button type="submit">Add Customer</button>
        </form>
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Address</th>
                        <th>Contact</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                        if (customers != null && !customers.isEmpty()) {
                            for (Customer customer : customers) {
                    %>
                        <tr>
                            <td><%= customer.getId() %></td>
                            <td><%= customer.getName() %></td>
                            <td><%= customer.getAddress() %></td>
                            <td><%= customer.getContact() %></td>
                            <td class="actions">
                                <form action="editCustomer.jsp" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= customer.getId() %>">
                                    <button type="submit" class="edit">Edit</button>
                                </form>
                                
                                <form action="DeleteCustomerServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= customer.getId() %>">
                                    <button type="submit" class="delete">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <% 
                            }
                        } else {
                    %>
                        <tr><td colspan="5">No customers found.</td></tr>
                    <% 
                        } 
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
