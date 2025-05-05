<%@ page import="java.io.*, java.nio.file.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  HttpSession sessionObj = request.getSession();
  String supplierUsername = (String) sessionObj.getAttribute("supplierUsername");

  if (supplierUsername == null) {
    response.sendRedirect("supplierLogin.jsp");
    return;
  }

  String supplierInventoryFile = "C:\\Users\\paves\\OneDrive\\Pictures\\Inventory-Stock-Management-System-main\\src\\main\\webapp\\suppliersInventory.txt";
  List<String> lines = Files.readAllLines(Paths.get(supplierInventoryFile));
  Set<String> categories = new LinkedHashSet<>();
  boolean userFound = false;

  for (String line : lines) {
    if (line.trim().isEmpty()) continue;
    if (line.equals(supplierUsername)) {
      userFound = true;
      continue;
    }
    if (userFound && line.contains(",")) {
      String category = line.split(",")[0];
      categories.add(category);
    } else if (userFound) {
      break;
    }
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Remove Supplier Item</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #0077b6, #00b4d8);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .container {
      background-color: white;
      padding: 40px 35px;
      border-radius: 20px;
      box-shadow: 0 12px 25px rgba(0,0,0,0.15);
      width: 100%;
      max-width: 450px;
      animation: slideIn 0.7s ease;
    }

    @keyframes slideIn {
      from { transform: translateY(-20px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }

    .hero {
      text-align: center;
      margin-bottom: 30px;
    }

    .hero i {
      font-size: 50px;
      color: #00b4d8;
    }

    .hero h1 {
      font-size: 26px;
      color: #333;
      margin-top: 10px;
    }

    form .input-group {
      margin-bottom: 25px;
    }

    label {
      display: block;
      font-weight: 500;
      margin-bottom: 10px;
      color: #333;
    }

    select {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 12px;
      font-size: 15px;
      outline: none;
      background-color: #f9f9f9;
      transition: border-color 0.3s;
    }

    select:focus {
      border-color: #00b4d8;
    }

    .button {
      width: 100%;
      padding: 14px;
      background: linear-gradient(90deg, #00b4d8, #0077b6);
      color: white;
      border: none;
      border-radius: 12px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: background 0.3s ease, transform 0.2s;
    }

    .button:hover {
      background: linear-gradient(90deg, #0096c7, #0077b6);
      transform: translateY(-2px);
    }

    .footer {
      text-align: center;
      margin-top: 25px;
    }

    .footer a {
      color: #0077b6;
      font-weight: 500;
      text-decoration: none;
      font-size: 14px;
    }

    .footer a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="container">
  <div class="hero">
    <i class="bi bi-trash"></i>
    <h1>Remove Supplier Item</h1>
  </div>

  <form action="RemoveSupplierItemServlet" method="post">
    <div class="input-group">
      <label for="itemType">Select Category</label>
      <select name="itemType" id="itemType" required>
        <option value="">-- Choose Category --</option>
        <% for (String category : categories) { %>
        <option value="<%= category %>"><%= category %></option>
        <% } %>
      </select>
    </div>

    <button type="submit" class="button">Remove Last Item</button>
  </form>

  <div class="footer">
    <p><a href="supplierDashboard.jsp">← Back to Dashboard</a></p>
  </div>
</div>
</body>
</html>
