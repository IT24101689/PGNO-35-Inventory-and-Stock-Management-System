<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to Inventory Management</title>
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
            background: linear-gradient(135deg, #00bcd4, #008cba);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .container {
            background: #fff;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
        }
        .hero {
            margin-bottom: 20px;
        }
        .hero i {
            font-size: 60px;
            color: #00bcd4;
        }
        h1 {
            font-size: 38px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        p {
            font-size: 18px;
            color: #555;
            margin-bottom: 30px;
        }
        .button {
            display: inline-block;
            padding: 15px 35px;
            background-color: #00bcd4;
            color: #fff;
            border-radius: 8px;
            font-size: 18px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button:hover {
            background-color: #008cba;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="hero">
        <i class="bi bi-box-seam"></i>
        <h1>Inventory Stock Management System </h1>
        <h2>(PGNO: 35)</h2>
    </div>

    <p>Your efficient solution for managing stock, tracking inventory, and ensuring smooth operations.</p>

    <a href="index.jsp" class="button">Get Started</a>
</div>

</body>
</html>
