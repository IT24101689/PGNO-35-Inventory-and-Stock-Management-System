package com.inventory;

import utils.CustomStack;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;

@WebServlet("/RemoveSupplierItemServlet")
public class RemoveSupplierItemServlet extends HttpServlet {
    private static final String INVENTORY_FILE = "C:\\Users\\USER\\Desktop\\inventory\\Supplier_Management\\src\\main\\webapp\\suppliersInventory.txt";
    private static final String REMOVED_ITEM_FILE = "C:\\Users\\USER\\Desktop\\inventory\\Supplier_Management\\src\\main\\webapp\\supplierRemovedItem.txt";
    private static final String STOCK_FILE = "C:\\Users\\USER\\Desktop\\inventory\\Supplier_Management\\src\\main\\webapp\\stock_log.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("supplierUsername");

        if (username == null) {
            response.sendRedirect("supplierLogin.jsp");
            return;
        }

        // Retrieve or reinitialize the inventoryManager
        ServletContext context = getServletContext();
        SupplierInventoryManager inventoryManager = (SupplierInventoryManager) context.getAttribute("inventoryManager");

        if (inventoryManager == null) {
            // Reinitialize if null (e.g., after server restart)
            inventoryManager = new SupplierInventoryManager(INVENTORY_FILE, STOCK_FILE);
            context.setAttribute("inventoryManager", inventoryManager);
        }

        try {
            // Get the supplier's stack
            CustomStack<StockEntry> supplierStack = inventoryManager.getSupplierStack(username);

            if (supplierStack == null || supplierStack.isEmpty()) {
                response.sendRedirect("supplierDashboard.jsp?message=No items to remove");
                return;
            }

            // Remove the top item (LIFO)
            StockEntry removedItem = supplierStack.pop();

            // Log the removal
            appendToRemovedFile(username, removedItem.toString());

            // Save the updated inventory
            inventoryManager.saveInventoryToFile();

            response.sendRedirect("supplierDashboard.jsp?message=Item removed successfully");

        } catch (EmptyStackException e) {
            response.sendRedirect("supplierDashboard.jsp?message=No items to remove");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("supplierDashboard.jsp?message=Error removing item");
        }
    }

    private void appendToRemovedFile(String username, String removedItem) throws IOException {
        try (BufferedWriter writer = Files.newBufferedWriter(
                Paths.get(REMOVED_ITEM_FILE),
                StandardOpenOption.CREATE,
                StandardOpenOption.APPEND)
        ) {
            writer.write(username);
            writer.newLine();
            writer.write(removedItem);
            writer.newLine();
            writer.newLine();
        }
    }
}
