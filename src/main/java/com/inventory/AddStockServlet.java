package com.inventory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/AddStockServlet")
public class AddStockServlet extends HttpServlet {

    private static final String SUPPLIER_INVENTORY_FILE = "C:\\Users\\USER\\Desktop\\inventory\\Supplier_Management\\src\\main\\webapp\\suppliersInventory.txt";
    private static final String STOCK_INVENTORY_FILE = "C:\\Users\\USER\\Desktop\\inventory\\Supplier_Management\\src\\main\\webapp\\stockInventory.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String supplierUsername = (String) session.getAttribute("supplierUsername");

        if (supplierUsername == null) {
            response.sendRedirect("supplierLogin.jsp?message=You need to login first.");
            return;
        }

        try {
            String companyName = request.getParameter("companyName");
            String category = request.getParameter("category");
            String itemName = request.getParameter("itemName");
            String quantityStr = request.getParameter("quantity");
            String priceStr = request.getParameter("price");
            String expiryDate = request.getParameter("expiryDate");

            if (companyName == null || companyName.trim().isEmpty() ||
                    category == null || category.trim().isEmpty() ||
                    itemName == null || itemName.trim().isEmpty() ||
                    quantityStr == null || quantityStr.trim().isEmpty() ||
                    priceStr == null || priceStr.trim().isEmpty() ||
                    expiryDate == null || expiryDate.trim().isEmpty()) {

                session.setAttribute("errorMessage", "All fields including expiry date are required.");
                response.sendRedirect("addStock.jsp");
                return;
            }

            int quantity;
            double price;
            try {
                quantity = Integer.parseInt(quantityStr);
                price = Double.parseDouble(priceStr);
            } catch (NumberFormatException e) {
                session.setAttribute("errorMessage", "Quantity and price must be valid numbers.");
                response.sendRedirect("addStock.jsp");
                return;
            }

            if (quantity <= 0 || price <= 0) {
                session.setAttribute("errorMessage", "Quantity and price must be positive numbers.");
                response.sendRedirect("addStock.jsp");
                return;
            }

            String purchaseDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

            // Use OOP - Create a StockEntry object
            StockEntry stockEntry = new StockEntry(
                    companyName, category, itemName, quantity, price, purchaseDate, expiryDate
            );

            // Use OOP - Delegate to the SupplierInventoryManager
            SupplierInventoryManager manager = new SupplierInventoryManager(
                    SUPPLIER_INVENTORY_FILE, STOCK_INVENTORY_FILE

            );
            manager.addStock(supplierUsername, stockEntry);



            response.sendRedirect("supplierDashboard.jsp?message=Stock added successfully.");

        } catch (Exception e) {
            e.printStackTrace(); // for debugging
            session.setAttribute("errorMessage", "Error processing stock addition. Try again.");
            response.sendRedirect("addStock.jsp");
        }
    }
}
