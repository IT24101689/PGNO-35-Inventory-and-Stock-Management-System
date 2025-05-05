<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Retrieve error message from session
    HttpSession sessionObj = request.getSession();
    String error = (String) sessionObj.getAttribute("error");
    sessionObj.removeAttribute("error"); // Clear error after displaying
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Login - Inventory Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #0077b6, #00b4d8);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 50px 30px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            max-width: 420px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }

        .hero {
            text-align: center;
            margin-bottom: 30px;
        }

        .hero i {
            font-size: 48px;
            color: #00b4d8;
            margin-bottom: 10px;
        }

        h2 {
            font-size: 28px;
            color: #222;
            font-weight: 600;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            font-weight: 500;
            color: #333;
            margin-bottom: 5px;
            display: block;
        }

        .input-group input {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            outline: none;
            transition: border 0.3s ease;
        }

        .input-group input:focus {
            border-color: #00b4d8;
        }

        .button {
            width: 100%;
            padding: 14px;
            margin-top: 10px;
            border: none;
            border-radius: 10px;
            font-size: 17px;
            font-weight: 500;
            color: white;
            background: linear-gradient(90deg, #00b4d8, #0077b6);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 183, 255, 0.3);
        }

        .error-box {
            background: #ffe6e6;
            color: #cc0000;
            border-left: 5px solid #cc0000;
            padding: 10px;
            margin-bottom: 20px;
            font-size: 14px;
            border-radius: 5px;
        }

        .footer {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .footer a {
            color: #0077b6;
            text-decoration: none;
            font-weight: 500;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            color: #0077b6;
            font-weight: 500;
            text-decoration: none;
            font-size: 16px;
        }

        .back-btn:hover {
            color: #023e8a;
        }

        .back-btn {
            display: inline-block;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #008cba;
            color: white;
            border-radius: 5px;
            font-weight: 500;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        .back-btn:hover {
            background-color: #008cba;
        }

        .center-wrapper {
            text-align: center;
            width: 100%;
            margin-top: 30px;
        }


        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="hero">
        <i class="bi bi-shop"></i>
        <h2>Supplier Login</h2>
    </div>

    <!-- Display error message if exists -->
    <% if (error != null) { %>
    <div class="error-box"><%= error %></div>
    <% } %>

    <form action="SupplierLoginServlet" method="post">
        <div class="input-group">
            <label for="supplierUsername">Username</label>
            <input type="text" id="supplierUsername" name="username" required placeholder="Enter your username">
        </div>
        <div class="input-group">
            <label for="supplierPassword">Password</label>
            <input type="password" id="supplierPassword" name="password" required placeholder="Enter your password">
        </div>
        <button type="submit" class="button">Login</button>
    </form>

    <div class="footer">
        <p>Don't have an account? <a href="supplierRegister.jsp">Register</a></p>
    </div>
    <div class="center-wrapper">
        <a href="loginSelection.jsp" class="back-btn"><i class="bi bi-arrow-left"></i> Back to Login Selection</a>
    </div>

</div>

</body>
</html>
