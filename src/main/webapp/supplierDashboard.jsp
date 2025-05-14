<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.nio.file.Files, java.nio.file.Paths, java.util.*, utils.SupplierUtils" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter, java.time.temporal.ChronoUnit" %>

<%
    HttpSession sessionObj = request.getSession();
    String supplierUsername = (String) sessionObj.getAttribute("supplierUsername");

    if (supplierUsername == null) {
        response.sendRedirect("supplierLogin.jsp");
        return;
    }

    String filePath = application.getRealPath("/suppliersInventory.txt");
    List<String> lines = Files.readAllLines(Paths.get(filePath));

    boolean supplierFound = false;
    List<String[]> supplierItems = new ArrayList<>();
    Set<String> categories = new HashSet<>();

    for (String line : lines) {
        if (line.equals(supplierUsername)) {
            supplierFound = true;
            continue;
        }
        if (supplierFound) {
            if (line.trim().isEmpty()) break;
            String[] details = line.split(",");
            if (details.length == 7) {
                supplierItems.add(details);
                categories.add(details[1]); // Add category to the set
            }
        }
    }

    SupplierUtils.mergeSort(supplierItems, 0, supplierItems.size() - 1);

    int expiredCount = 0, soonExpireCount = 0;
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    LocalDate today = LocalDate.now();

    List<String> rowStatus = new ArrayList<>();

    for (String[] item : supplierItems) {
        LocalDate expiry = LocalDate.parse(item[6], formatter);
        long daysToExpire = ChronoUnit.DAYS.between(today, expiry);
        if (expiry.isBefore(today)) {
            expiredCount++;
            rowStatus.add("expired");
        } else if (daysToExpire <= 7) {
            soonExpireCount++;
            rowStatus.add("soon-expire");
        } else {
            rowStatus.add("normal");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Supplier Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
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
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            max-width: 950px;
            width: 100%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }
        h1 { font-size: 28px; font-weight: 500; color: #333; margin-bottom: 10px; }
        .table-container { margin-top: 20px; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #00bcd4;
            color: white;
            font-weight: bold;
        }
        .button {
            display: inline-block;
            text-decoration: none;
            padding: 10px 15px;
            background-color: #00bcd4;
            color: white;
            border-radius: 5px;
            font-weight: 500;
            margin-top: 15px;
            transition: background-color 0.3s ease;
        }
        .button:hover { background-color: #008cba; }
        select {
            padding: 10px;
            margin-top: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        .alert {
            padding: 10px;
            margin-bottom: 10px;
            text-align: left;
            border-left: 6px solid;
        }
        .expired { background-color: #ffdddd; border-color: #f44336; }
        .soon-expire { background-color: #fff3cd; border-color: #ffc107; }
        tr.expired-row { background-color: #ffe6e6; }
        tr.soon-expire-row { background-color: #fffbe6; }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
    <script>
        function filterItems() {
            var selectedCategory = document.getElementById("categoryFilter").value;
            var rows = document.querySelectorAll("#itemsTable tbody tr");

            rows.forEach(row => {
                var category = row.getAttribute("data-category");
                row.style.display = (selectedCategory === "all" || category === selectedCategory) ? "" : "none";
            });
        }
    </script>
</head>
<body>

<div class="container">
    <h1>Welcome, <%= supplierUsername %>!</h1>
    <p>Stock Overview (Sorted by Expiry Date)</p>

    <% if (expiredCount > 0) { %>
    <div class="alert expired">
        🔴 <strong><%= expiredCount %></strong> item(s) have <strong>expired</strong>. Please review them immediately.
    </div>
    <% } %>

    <% if (soonExpireCount > 0) { %>
    <div class="alert soon-expire">
        🟠 <strong><%= soonExpireCount %></strong> item(s) will <strong>expire within 7 days</strong>.
    </div>
    <% } %>

    <div class="table-container">
        <% if (!supplierItems.isEmpty()) { %>
        <table id="itemsTable">
            <thead>
            <tr>
                <th>Item Name</th>
                <th>Category</th>
                <th>Company</th>
                <th>Quantity</th>
                <th>Price per Item</th>
                <th>Total Price</th>
                <th>Supply Date</th>
                <th>Expiry Date</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < supplierItems.size(); i++) {
                String[] details = supplierItems.get(i);
                String rowType = rowStatus.get(i);
                String rowClass = rowType.equals("expired") ? "expired-row" :
                        rowType.equals("soon-expire") ? "soon-expire-row" : "";
            %>
            <tr data-category="<%= details[1] %>" class="<%= rowClass %>">
                <td><%= details[2] %></td>
                <td><%= details[1] %></td>
                <td><%= details[0] %></td>
                <td><%= details[3] %></td>
                <td><%= details[4] %>/=</td>
                <td><%= Double.parseDouble(details[3]) * Double.parseDouble(details[4]) %>/=</td>
                <td><%= details[5] %></td>
                <td><%= details[6] %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p style="color: #888;">No items found.</p>
        <% } %>
    </div>

    <a href="supplierInventory.jsp" class="button">Manage Inventory</a>
    <a href="LogoutServlet" class="button">Logout</a>
</div>

</body>
</html>
