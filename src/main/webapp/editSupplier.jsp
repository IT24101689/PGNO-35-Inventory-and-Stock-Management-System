<%@ page import="javax.servlet.http.*, javax.servlet.*, java.io.*, java.nio.file.Files, java.nio.file.Paths, java.util.*" %>
<%@ page session="true" %>
<%
    String supplierName = (String) session.getAttribute("supplierUsername");
    String companyName = (String) session.getAttribute("companyName");

    String invFilePath = application.getRealPath("/suppliersInventory.txt");
    List<String> allLines = Files.readAllLines(Paths.get(invFilePath));
    List<String[]> supplierItems = new ArrayList<>();
    boolean foundSupplier = false;
    for (String line : allLines) {
        if (line.trim().equalsIgnoreCase(supplierName)) {
            foundSupplier = true;
            continue;
        }
        if (foundSupplier) {
            if (line.trim().isEmpty()) break;
            String[] parts = line.split(",");
            if (parts.length == 7) {
                supplierItems.add(parts);
            }
        }
    }

    Map<String, String> itemExpiryMap = new LinkedHashMap<>();
    for (String[] item : supplierItems) {
        String itemName = item[2].trim();
        String expiry = item[6].trim();
        itemExpiryMap.put(itemName, expiry);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Supplier Details</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to right, #0077b6, #00b4d8);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
            animation: fadeIn 1s ease-in-out;
        }

        h2 {
            font-size: 28px;
            color: #222;
            font-weight: 600;
            text-align: center;
            margin-bottom: 25px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        label {
            font-weight: 500;
            color: #333;
            margin-bottom: 6px;
        }

        input[type="password"],
        input[type="text"],
        input[type="date"],
        select {
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            width: 100%;
            outline: none;
            transition: border-color 0.3s;
        }

        input[type="password"]:focus,
        input[type="text"]:focus,
        input[type="date"]:focus,
        select:focus {
            border-color: #00b4d8;
        }

        input[type="submit"] {
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 17px;
            font-weight: 500;
            color: white;
            background: linear-gradient(90deg, #00b4d8, #0077b6);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 183, 255, 0.3);
        }

        .back-link {
            display: inline-block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            padding: 10px 20px;
            background-color: #008cba;
            color: white;
            border-radius: 6px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }

        .back-link:hover {
            background-color: #0077b6;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>

    <script>
        var itemExpiryMap = {};
        <% for (Map.Entry<String, String> entry : itemExpiryMap.entrySet()) { %>
        itemExpiryMap["<%= entry.getKey() %>"] = "<%= entry.getValue() %>";
        <% } %>

        function updateCurrentExpiry() {
            var select = document.getElementById("selectedItem");
            var currentExpiryField = document.getElementById("currentExpiry");
            var selectedItem = select.value;
            currentExpiryField.value = itemExpiryMap[selectedItem] || "";
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Edit Your Details</h2>
    <form action="EditSupplierServlet" method="post">
        <div>
            <label for="password">New Password</label>
            <input type="password" name="password" id="password" placeholder="Enter new password" required>
        </div>

        <input type="hidden" name="companyName" value="<%= companyName != null ? companyName : "" %>">
        <input type="hidden" name="originalCompanyName" value="<%= companyName != null ? companyName : "" %>">

        <div>
            <label for="selectedItem">Select Item to Update Expiry Date</label>
            <select id="selectedItem" name="selectedItem" onchange="updateCurrentExpiry()" required>
                <option value="">Select Item</option>
                <% for (String itemName : itemExpiryMap.keySet()) { %>
                <option value="<%= itemName %>"><%= itemName %></option>
                <% } %>
            </select>
        </div>

        <div>
            <label for="currentExpiry">Current Expiry Date</label>
            <input type="text" id="currentExpiry" name="currentExpiry" readonly placeholder="Current expiry will appear here">
        </div>

        <div>
            <label for="newExpiry">New Expiry Date</label>
            <input type="date" id="newExpiry" name="newExpiry" required>
        </div>

        <input type="submit" value="Update Details">
    </form>
    <a href="supplierDashboard.jsp" class="back-link">Back to Dashboard</a>
</div>
</body>
</html>
