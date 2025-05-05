<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supplier Registration - Inventory Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
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
        <i class="bi bi-person-plus"></i>
        <h2>Create a New Supplier Account</h2>
    </div>

    <!-- Display error message if passwords do not match -->
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
    <p class="error"><%= error %></p>
    <% } %>

    <form action="supplier-register-action.jsp" method="post">
        <div class="input-group">
            <label for="company-name">Company Name</label>
            <input type="text" id="company-name" name="company-name" required placeholder="Enter company name">
        </div>
        <div class="input-group">
            <label for="supplier-username">Username</label>
            <input type="text" id="supplier-username" name="supplier-username" required placeholder="Enter a username">
        </div>
        <div class="input-group">
            <label for="supplier-password">Password</label>
            <input type="password" id="supplier-password" name="supplier-password" required placeholder="Create a password">
        </div>
        <div class="input-group">
            <label for="confirm-supplier-password">Confirm Password</label>
            <input type="password" id="confirm-supplier-password" name="confirm-supplier-password" required placeholder="Confirm your password">
        </div>
        <div class="input-group">
            <label for="item-category">Item Category</label>
            <select id="item-category" name="item-category" required>
                <option value="" disabled selected> Select the category </option>
                <option value="Electronics">Electronics</option>
                <option value="Furniture">Furniture</option>
                <option value="Clothing">Clothing</option>
                <option value="Food">Food</option>
                <option value="Toys">Toys</option>
                <!-- You can add more categories as per your requirements -->
            </select>
        </div>
        <button type="submit" class="button">Register</button>
    </form>

    <div class="footer">
        <p>Already have an account? <a href="supplierLogin.jsp">Login</a></p>
    </div>
</div>

</body>
</html>
