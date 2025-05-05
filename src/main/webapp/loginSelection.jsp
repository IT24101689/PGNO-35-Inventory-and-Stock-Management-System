<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Selection</title>
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
      text-align: center;
      animation: fadeIn 1s ease-in-out;
    }

    h2 {
      font-size: 26px;
      color: #222;
      margin-bottom: 30px;
      font-weight: 600;
    }

    .button {
      width: 100%;
      padding: 14px;
      margin: 12px 0;
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

    .back-btn {
      display: block;
      margin-top: 15px;
      background: transparent;
      color: #0077b6;
      text-decoration: none;
      font-weight: 500;
      font-size: 16px;
      transition: color 0.3s ease;
    }

    .back-btn:hover {
      color: #023e8a;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: scale(0.9); }
      to { opacity: 1; transform: scale(1); }
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Select Login Type</h2>
  <form action="LoginSelectionServlet" method="post">
    <button type="submit" name="role" value="user" class="button user-btn">User Login</button>
    <button type="submit" name="role" value="admin" class="button admin-btn">Admin Login</button>
    <button type="submit" name="role" value="supplier" class="button supplier-btn">Supplier Login</button>
    <a href="index.jsp" class="back-btn">← Back to Home</a>
  </form>
</div>
</body>
</html>
