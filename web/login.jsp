<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <style>
body {
    font-family: Arial, sans-serif;
    background-image: url('bg1.jpg');
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
            width: 300px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }
        input[type="text"], input[type="password"], select {
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
        .hidden {
            display: none;
        }
        select option:hover {
            background-color: blue;
        }
    </style>
    <script>
        function toggleFields() {
            var role = document.getElementById("role").value;
            var usernameField = document.getElementById("username");
            var passwordField = document.getElementById("password");
            var usernameLabel = document.getElementById("usernameLabel");
            var passwordLabel = document.getElementById("passwordLabel");
            if (role === "customer") {
                usernameField.classList.add("hidden");
                passwordField.classList.add("hidden");
                usernameLabel.classList.add("hidden");
                passwordLabel.classList.add("hidden");
                usernameField.removeAttribute("required");
                passwordField.removeAttribute("required");
            } else {
                usernameField.classList.remove("hidden");
                passwordField.classList.remove("hidden");
                usernameLabel.classList.remove("hidden");
                passwordLabel.classList.remove("hidden");
                usernameField.setAttribute("required", "required");
                passwordField.setAttribute("required", "required");
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Electricity Bill System</h2>
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <label for="role">Select Role:</label>
            <select name="role" id="role" onchange="toggleFields()">
                <option value="admin">Admin</option>
                <option value="customer">Customer</option>
            </select>
            <label for="username" id="usernameLabel">Username:</label>
            <input type="text" name="username" id="username" required>
            <label for="password" id="passwordLabel">Password:</label>
            <input type="password" name="password" id="password" required>
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>
