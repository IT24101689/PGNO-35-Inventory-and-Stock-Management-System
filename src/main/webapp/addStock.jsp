<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.*" %>

<%
  HttpSession sessionObj = request.getSession();
  String supplierUsername = (String) sessionObj.getAttribute("supplierUsername");

  if (supplierUsername == null) {
    response.sendRedirect("supplierLogin.jsp");
    return;
  }

  String companyName = "";
  String category = "";
  String errorMessage = (String) sessionObj.getAttribute("errorMessage");
  sessionObj.removeAttribute("errorMessage");

  String filePath = application.getRealPath("/SupplierLoginCredentials.txt");
  BufferedReader reader = new BufferedReader(new FileReader(filePath));
  String line;
  while ((line = reader.readLine()) != null) {
    if (line.startsWith("name:" + supplierUsername)) {
      reader.readLine(); // Skip password
      companyName = reader.readLine().replace("companyName:", "").trim();
      category = reader.readLine().replace("category:", "").trim();
      break;
    }
  }
  reader.close();
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Add Stock - Inventory Management System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet" />

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(to right, #0077b6, #00b4d8);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .container {
      background: #ffffff;
      padding: 40px 35px;
      border-radius: 20px;
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
      max-width: 480px;
      width: 100%;
      animation: fadeIn 1s ease-in-out;
    }

    h2 {
      font-size: 28px;
      color: #333;
      margin-bottom: 25px;
      font-weight: 600;
    }

    .info {
      margin-bottom: 20px;
      color: #0077b6;
      font-weight: 500;
    }

    .input-group {
      margin-bottom: 18px;
      text-align: left;
    }

    label {
      display: block;
      font-weight: 500;
      margin-bottom: 6px;
      color: #333;
    }

    input[type="text"],
    input[type="number"],
    input[type="date"] {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 10px;
      font-size: 15px;
      background-color: #f9f9f9;
      transition: 0.3s;
    }

    input:focus {
      border-color: #00b4d8;
      outline: none;
      background-color: #fff;
    }

    .button {
      width: 100%;
      padding: 14px;
      margin-top: 10px;
      border: none;
      border-radius: 12px;
      font-size: 16px;
      font-weight: 500;
      color: white;
      background: linear-gradient(90deg, #00b4d8, #0077b6);
      cursor: pointer;
      transition: transform 0.3s ease;
    }

    .button:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 25px rgba(0, 183, 255, 0.3);
    }

    .back-btn {
      display: block;
      margin-top: 20px;
      background: transparent;
      color: #0077b6;
      text-decoration: none;
      font-weight: 500;
      text-align: center;
      transition: color 0.3s ease;
    }

    .back-btn:hover {
      color: #023e8a;
    }

    .error-box {
      background-color: #ffe0e0;
      color: #b30000;
      padding: 10px;
      border-radius: 8px;
      margin-bottom: 20px;
      font-weight: 500;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: scale(0.9); }
      to { opacity: 1; transform: scale(1); }
    }
  </style>

  <script>
    function setPurchaseDate() {
      let today = new Date();
      let yyyy = today.getFullYear();
      let mm = String(today.getMonth() + 1).padStart(2, '0');
      let dd = String(today.getDate()).padStart(2, '0');
      let purchaseDate = yyyy + '-' + mm + '-' + dd;

      // Set the current date as the default for the purchase date
      document.getElementById("purchaseDate").value = purchaseDate;

      // Set the expiry date's minimum to the purchase date
      document.getElementById("expiryDate").setAttribute('min', purchaseDate);
    }

    function updateExpiryDateMin() {
      let purchaseDate = document.getElementById("purchaseDate").value;
      if (purchaseDate) {
        // Update the expiry date's minimum value whenever the purchase date is changed
        document.getElementById("expiryDate").setAttribute('min', purchaseDate);
      }
    }

    window.onload = setPurchaseDate;
  </script>
</head>
<body>

<div class="container">
  <div class="info">
    Welcome, <strong><%= supplierUsername %></strong>
  </div>
  <% if (errorMessage != null) { %>
  <div class="error-box"><%= errorMessage %></div>
  <% } %>

  <form action="AddStockServlet" method="post">
    <div class="input-group">
      <label for="companyName">Company Name</label>
      <input type="text" id="companyName" name="companyName" value="<%= companyName %>" readonly>
    </div>

    <div class="input-group">
      <label for="category">Category</label>
      <input type="text" id="category" name="category" value="<%= category %>" readonly>
    </div>

    <div class="input-group">
      <label for="itemName">Item Name</label>
      <input type="text" id="itemName" name="itemName" required placeholder="Enter item name">
    </div>

    <div class="input-group">
      <label for="quantity">Quantity</label>
      <input type="number" id="quantity" name="quantity" required placeholder="Enter quantity" min="1">
    </div>

    <div class="input-group">
      <label for="price">Price per Unit</label>
      <input type="number" id="price" name="price" required placeholder="Enter price per unit" min="0.01" step="0.01">
    </div>

    <div class="input-group">
      <label for="purchaseDate">Purchase Date</label>
      <input type="date" id="purchaseDate" name="purchaseDate" onchange="updateExpiryDateMin()">
    </div>

    <div class="input-group">
      <label for="expiryDate">Expiry Date (optional)</label>
      <input type="date" id="expiryDate" name="expiryDate">
    </div>

    <button type="submit" class="button">Add Stock</button>
  </form>

  <a href="supplierDashboard.jsp" class="back-btn">← Back to Dashboard</a>
</div>

</body>
</html>
