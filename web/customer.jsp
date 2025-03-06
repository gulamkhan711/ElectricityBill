<%-- 
    Document   : customer
    Created on : 18 Sep, 2024, 11:43:58 PM
    Author     : MIHIR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <style>
body {
    font-family: Arial, sans-serif;
    background-image: url('bg3.jpg');
    background-repeat: no-repeat;
    background-size: cover; 
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin-bottom: 10px;
        }
        a {
            text-decoration: none;
            color: navy;
            display: block;
            padding: 10px;
            border: 1px solid  navy;
            border-radius: 4px;
            text-align: center;
        }
        a:hover {
            background-color:  #B8001F;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Customer Dashboard</h2>
        <ul>
            <li><a href="CustomerDashboard.jsp">View & Generate Bill</a></li>
             <li><a href="login.jsp">Back to Login page</a></li>
        </ul>
    </div>
</body>
</html>