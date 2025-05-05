package com.inventory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;

@WebServlet("/EditSupplierServlet")
public class EditSupplierServlet extends HttpServlet {
    private static final String SUPPLIER_FILE_PATH = "C:\\Users\\paves\\OneDrive\\Pictures\\Inventory-Stock-Management-System-main\\src\\main\\webapp\\SupplierLoginCredentials.txt";
    private static final String SUPPLIER_INVENTORY_PATH = "C:\\Users\\paves\\OneDrive\\Pictures\\Inventory-Stock-Management-System-main\\src\\main\\webapp\\suppliersInventory.txt";
    private static final String STOCK_INVENTORY_PATH = "C:\\Users\\paves\\OneDrive\\Pictures\\Inventory-Stock-Management-System-main\\src\\main\\webapp\\stockInventory.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String supplierUsername = (String) session.getAttribute("supplierUsername");

        if (supplierUsername == null) {
            response.sendRedirect("supplierLogin.jsp?message=Please login first.");
            return;
        }

        String newPassword = request.getParameter("password");
        String selectedItem = request.getParameter("selectedItem");
        String newExpiry = request.getParameter("newExpiry");
        String originalCompanyName = request.getParameter("originalCompanyName");

        // === Update SupplierLoginCredentials.txt ===
        List<String> loginLines = Files.readAllLines(Paths.get(SUPPLIER_FILE_PATH));
        List<String> updatedLoginLines = new ArrayList<>();

        for (int i = 0; i < loginLines.size(); i++) {
            String line = loginLines.get(i);
            if (line.trim().equalsIgnoreCase("name:" + supplierUsername)) {
                updatedLoginLines.add("name:" + supplierUsername);
                updatedLoginLines.add("password:" + newPassword);
                updatedLoginLines.add(loginLines.get(i + 2)); // companyName
                updatedLoginLines.add(loginLines.get(i + 3)); // category
                updatedLoginLines.add("------------------------------------------------------");
                i += 4;
            } else {
                updatedLoginLines.add(line);
            }
        }
        Files.write(Paths.get(SUPPLIER_FILE_PATH), updatedLoginLines, StandardOpenOption.TRUNCATE_EXISTING);

        // === Update suppliersInventory.txt without adding extra blank lines ===
        List<String> inventoryLines = Files.readAllLines(Paths.get(SUPPLIER_INVENTORY_PATH));
        List<String> updatedInventoryLines = new ArrayList<>();
        for (int i = 0; i < inventoryLines.size(); i++) {
            String line = inventoryLines.get(i).trim();

            if (line.equalsIgnoreCase(supplierUsername)) {
                updatedInventoryLines.add(supplierUsername);
                i++;
                while (i < inventoryLines.size()) {
                    String itemLine = inventoryLines.get(i).trim();

                    if (itemLine.isEmpty()) break;

                    String[] parts = itemLine.split(",");
                    if (parts.length == 7 && parts[2].trim().equalsIgnoreCase(selectedItem)) {
                        parts[6] = newExpiry;
                        updatedInventoryLines.add(String.join(",", parts));
                    } else {
                        updatedInventoryLines.add(itemLine);
                    }
                    i++;
                }

                // Only add blank line if more suppliers exist after this block
                boolean moreSuppliersExist = false;
                for (int j = i + 1; j < inventoryLines.size(); j++) {
                    if (!inventoryLines.get(j).trim().isEmpty()) {
                        moreSuppliersExist = true;
                        break;
                    }
                }
                if (moreSuppliersExist) {
                    updatedInventoryLines.add("");
                }
            } else {
                updatedInventoryLines.add(inventoryLines.get(i));
            }
        }
        Files.write(Paths.get(SUPPLIER_INVENTORY_PATH), updatedInventoryLines, StandardOpenOption.TRUNCATE_EXISTING);

        // === Update stockInventory.txt ===
        List<String> stockLines = Files.readAllLines(Paths.get(STOCK_INVENTORY_PATH));
        List<String> updatedStockLines = new ArrayList<>();

        for (String stockLine : stockLines) {
            String[] parts = stockLine.split(",");
            if (parts.length == 7 && parts[0].equalsIgnoreCase(originalCompanyName) && parts[2].trim().equalsIgnoreCase(selectedItem)) {
                parts[6] = newExpiry;
                updatedStockLines.add(String.join(",", parts));
            } else {
                updatedStockLines.add(stockLine);
            }
        }
        Files.write(Paths.get(STOCK_INVENTORY_PATH), updatedStockLines, StandardOpenOption.TRUNCATE_EXISTING);

        response.sendRedirect("supplierDashboard.jsp?message=Details updated successfully.");
    }
}
