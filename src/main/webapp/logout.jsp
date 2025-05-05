<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>
<%
  // Destroy the session
  HttpSession session1 = request.getSession(false);
  if (session1 != null) {
    session1.invalidate();
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Logout - Inventory Management System</title>
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
    }
    .container {
      background: #fff;
      padding: 40px;
      border-radius: 15px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      max-width: 400px;
      width: 100%;
      text-align: center;
    }
    .hero i {
      font-size: 50px;
      color: #00bcd4;
      margin-bottom: 20px;
    }
    h2 {
      font-size: 28px;
      font-weight: 500;
      color: #333;
      margin-bottom: 20px;
    }
    p {
      font-size: 16px;
      color: #555;
      margin-bottom: 20px;
    }
    .button {
      display: block;
      width: 100%;
      padding: 12px;
      background-color: #00bcd4;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-size: 18px;
      font-weight: 500;
      cursor: pointer;
      transition: background-color 0.3s ease;
      text-decoration: none;
    }
    .button:hover {
      background-color: #008cba;
    }
  </style>
  <script>
    // Redirect to index.jsp after 3 seconds
    setTimeout(function() {
      window.location.href = "index.jsp";
    }, 3000);
  </script>
</head>
<body>

<div class="container">
  <div class="hero">
    <i class="bi bi-person-circle"></i>
    <h2>You have logged out</h2>
  </div>
  <p>Redirecting to home page...</p>
  <a href="index.jsp" class="button">Go to Home</a>
</div>

</body>
</html>
